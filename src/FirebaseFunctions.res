type cloudFunction
type callableFunction<'trequest, 'tresponse>

module Logger = {
  type logger

  @module("firebase-functions") external logger: logger = "logger"

  @send
  external debug: (logger, string, ~data: {..}=?) => unit = "debug"

  @send
  external log: (logger, string, ~data: {..}=?) => unit = "log"

  @send
  external info: (logger, string, ~data: {..}=?) => unit = "info"

  @send
  external warn: (logger, string, ~data: {..}=?) => unit = "warn"

  @send
  external error: (logger, string, ~data: {..}=?) => unit = "error"
}

module Https = {
  type httpsOptions = {
    region?: string,
    cors?: string,
    memory?: string,
    timeoutSeconds?: int,
    minInstances?: int,
    maxInstances?: int,
    concurrency?: int,
    invoker?: string,
  }

  type callableOptions = {
    ...httpsOptions,
    enforceAppCheck?: bool,
    consumeAppCheckToken?: bool,
  }

  type authData = {uid: string, rawToken: string}

  /// https://firebase.google.com/docs/reference/functions/2nd-gen/node/firebase-functions.https.callablerequest.md#httpscallablerequest_interface
  type callableRequest<'t> = {
    data: 't,
    auth: option<authData>,
    acceptsStreaming: bool,
  }

  /// https://firebase.google.com/docs/reference/functions/2nd-gen/node/firebase-functions.https.md#httpsoncall
  @module("firebase-functions/https")
  external onCall: (
    ~opts: callableOptions,
    ~handler: callableRequest<'trequest> => Promise.t<'tresponse>,
  ) => callableFunction<'trequest, 'tresponse> = "onCall"

  type httpsFunction

  /// https://firebase.google.com/docs/reference/functions/2nd-gen/node/firebase-functions.https.md#httpsonrequest
  @module("firebase-functions/https")
  external onRequest: (~opts: httpsOptions, ~handler: Express.handler) => httpsFunction =
    "onRequest"

  @module("firebase-functions/https")
  external onRequestApi: (~opts: httpsOptions, ~handler: Express.express) => httpsFunction =
    "onRequest"

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

    @module("firebase-functions/https") @new
    external make: (~code: functionsErrorCode, ~message: string, ~data: 'data=?) => t = "HttpsError"

    external asException: t => JsError.t = "%identity"

    let raiseFirebaseHttpError = (~code: functionsErrorCode, ~message: string, ~data: 'data=?) => {
      make(~code, ~message, ~data)
      ->asException
      ->JsError.throw
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

  type firestoreEvent<'t> = {
    data: option<'t>,
    id: string,
    location: string,
    project: string,
    database: string,
    namespace: string,
    document: string,
  }

  type change<'t> = {
    before: queryDocumentSnapshot<'t>,
    after: queryDocumentSnapshot<'t>,
  }

  type documentOptions = {
    document: string,
    region?: string,
    database?: string,
    namespace?: string,
  }

  /// https://firebase.google.com/docs/reference/functions/2nd-gen/node/firebase-functions.firestore.md#firestoreondocumentcreated
  @module("firebase-functions/firestore")
  external onDocumentCreated: (
    ~opts: documentOptions,
    ~handler: firestoreEvent<queryDocumentSnapshot<'documentdata>> => Promise.t<unit>,
  ) => cloudFunction = "onDocumentCreated"

  @module("firebase-functions/firestore")
  external onDocumentUpdated: (
    ~opts: documentOptions,
    ~handler: firestoreEvent<change<'documentdata>> => Promise.t<unit>,
  ) => cloudFunction = "onDocumentUpdated"

  @module("firebase-functions/firestore")
  external onDocumentDeleted: (
    ~opts: documentOptions,
    ~handler: firestoreEvent<queryDocumentSnapshot<'documentdata>> => Promise.t<unit>,
  ) => cloudFunction = "onDocumentDeleted"

  @module("firebase-functions/firestore")
  external onDocumentWritten: (
    ~opts: documentOptions,
    ~handler: firestoreEvent<change<'documentdata>> => Promise.t<unit>,
  ) => cloudFunction = "onDocumentWritten"
}
