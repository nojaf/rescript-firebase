type cloudFunction
type callableFunction<'trequest, 'tresponse>

module Logger = {
  type logger

  @module("firebase-functions") external logger: logger = "logger"

  @send
  external info: (logger, string, ~data: {..}=?) => unit = "info"

  @send
  external error: (logger, string, ~data: {..}=?) => unit = "error"
}

module Https = {
  /// https://firebase.google.com/docs/reference/functions/2nd-gen/node/firebase-functions.https.callableoptions.md#httpscallableoptions_interface
  type callableOptions = {region: string, allowedCors?: string, invoker?: string}

  /// https://firebase.google.com/docs/reference/functions/2nd-gen/node/firebase-functions.https.callablerequest.md#httpscallablerequest_interface
  type callableRequest<'t> = {data: 't}

  /// https://firebase.google.com/docs/reference/functions/2nd-gen/node/firebase-functions.https.md#httpsoncall
  @module("firebase-functions/v2/https")
  external onCall: (
    ~opts: callableOptions,
    ~handler: callableRequest<'trequest> => Promise.t<'tresponse>,
  ) => callableFunction<'trequest, 'tresponse> = "onCall"

  // https://github.com/bloodyowl/rescript-express/blob/main/src/Express.res
  // Express request & response
  type method = [#GET | #POST | #PUT | #DELETE | #PATCH]
  type request
  @get external method: request => method = "method"
  @get external headers: request => dict<string> = "headers"
  @get external rawBody: request => string = "rawBody"

  type response
  @send external send: (response, 'a) => response = "send"
  @send external sendStatus: (response, int) => response = "sendStatus"
  @send external status: (response, int) => response = "status"

  type httpsFunction

  /// https://firebase.google.com/docs/reference/functions/2nd-gen/node/firebase-functions.https.md#httpsonrequest
  @module("firebase-functions/v2/https")
  external onRequest: (
    ~opts: callableOptions,
    ~handler: (request, response) => Promise.t<unit>,
  ) => httpsFunction = "onRequest"

  /// https://firebase.google.com/docs/reference/functions/2nd-gen/node/firebase-functions.https.httpserror
  module HttpsError = {
    /// https://firebase.google.com/docs/reference/functions/2nd-gen/node/firebase-functions.https.md#httpsfunctionserrorcode
    type functionsErrorCode =
      | @as("ok") Ok
      | @as("cancelled") Cancelled
      | @as("unknown") Unknown
      | @as("invalid-argument") InvalidArgument
      | @as("deadline-exceeded") DeadlineExceeded
      | @as("not-found") NotFound
      | @as("already-exists") AlreadyExists
      | @as("permission-denied") PermissionDenied
      | @as("resource-exhausted") ResourceExhausted
      | @as("failed-precondition") FailedPrecondition
      | @as("aborted") Aborted
      | @as("out-of-range") OutOfRange
      | @as("unimplemented") Unimplemented
      | @as("internal") Internal
      | @as("unavailable") Unavailable
      | @as("data-loss") DataLoss
      | @as("unauthenticated") Unauthenticated

    type t

    @module("firebase-functions/v2/https") @new
    external make: (~code: functionsErrorCode, ~message: string, ~data: 'data=?) => t = "HttpsError"

    external asException: t => Error.t = "%identity"

    let raiseFirebaseHttpError = (~code: functionsErrorCode, ~message: string, ~data: 'data=?) => {
      make(~code, ~message, ~data)
      ->asException
      ->Error.raise
    }
  }
}

module Firestore = {
  type queryDocumentSnapshot<'documentdata> = {
    id: string,
    exists: bool,
  }

  @send
  external data: queryDocumentSnapshot<'documentdata> => 'documentdata = "data"

  type firestoreEvent<'t> = {data: option<'t>}

  type documentOptions = {
    document: string,
    region: string,
  }

  /// https://firebase.google.com/docs/reference/functions/2nd-gen/node/firebase-functions.firestore.md#firestoreondocumentcreated
  @module("firebase-functions/v2/firestore")
  external onDocumentCreated: (
    ~opts: documentOptions,
    ~handler: firestoreEvent<queryDocumentSnapshot<'documentdata>> => Promise.t<unit>,
  ) => cloudFunction = "onDocumentCreated"
}
