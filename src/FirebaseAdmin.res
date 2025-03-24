module App = {
  type app

  type appConfig = {
    apiKey: string,
    authDomain: string,
    projectId: string,
    storageBucket: string,
    messagingSenderId: string,
    appId: string,
  }

  @module("firebase-admin/app")
  external initializeApp: appConfig => app = "initializeApp"

  type serviceAccountPathOrObject

  type credential

  /// https://firebase.google.com/docs/reference/admin/node/firebase-admin.app.md#cert_13d5f11
  @module("firebase-admin/app")
  external cert: serviceAccountPathOrObject => credential = "cert"

  type serviceAccountConfig = {credential: credential}

  @module("firebase-admin/app")
  external initializeAppWithServiceAccount: serviceAccountConfig => app = "initializeApp"
}

/// https://firebase.google.com/docs/reference/admin/node/firebase-admin.firestore
module Firestore = {
  type firestore
  type opString = | @as("==") Equal

  /// https://cloud.google.com/nodejs/docs/reference/firestore/latest/firestore/query
  type query<'documentdata>

  /// https://cloud.google.com/nodejs/docs/reference/firestore/latest/firestore/collectionreference
  type collectionReference<'documentdata>

  /// https://cloud.google.com/nodejs/docs/reference/firestore/latest/firestore/documentreference
  type documentReference<'documentdata>

  /// https://cloud.google.com/nodejs/docs/reference/firestore/latest/firestore/documentsnapshot
  type documentSnapshot<'documentdata>

  /// https://cloud.google.com/nodejs/docs/reference/firestore/latest/firestore/querydocumentsnapshot
  type queryDocumentSnapshot<'documentdata>

  /// https://cloud.google.com/nodejs/docs/reference/firestore/latest/firestore/querysnapshot
  type querySnapshot<'documentdata>

  @module("firebase-admin/firestore")
  external getFirestore: App.app => firestore = "getFirestore"

  @send
  external collection: (firestore, string) => collectionReference<'documentdata> = "collection"

  module CollectionReference = {
    external asQuery: collectionReference<'documentdata> => query<'documentdata> = "%identity"

    @send
    external add: (
      collectionReference<'documentdata>,
      'documentdata,
    ) => Promise.t<documentReference<'documentdata>> = "add"

    @send
    external doc: (collectionReference<'documentdata>, string) => documentReference<'documentdata> =
      "doc"
  }

  module QuerySnapshot = {
    @get
    external size: querySnapshot<'documentdata> => int = "size"

    @get
    external empty: querySnapshot<'documentdata> => bool = "empty"

    @get
    external docs: querySnapshot<'documentdata> => array<queryDocumentSnapshot<'documentdata>> =
      "docs"
  }

  module QueryDocumentSnapshot = {
    @get
    external ref: queryDocumentSnapshot<'documentdata> => documentReference<'documentdata> = "ref"

    @send
    external data: queryDocumentSnapshot<'documentdata> => 'documentdata = "data"

    @get
    external exists: queryDocumentSnapshot<'documentdata> => bool = "exists"

    external asDocumentSnapshot: queryDocumentSnapshot<'documentdata> => documentSnapshot<
      'documentdata,
    > = "%identity"
  }

  module Query = {
    /// https://cloud.google.com/nodejs/docs/reference/firestore/latest/firestore/query#_google_cloud_firestore_Query_get_member_1_
    @send
    external get: query<'documentdata> => Promise.t<querySnapshot<'documentdata>> = "get"

    @send
    external where: (query<'documentdata>, string, opString, string) => query<'documentdata> =
      "where"
  }

  module DocumentSnapshot = {
    @get
    external id: documentSnapshot<'documentdata> => string = "id"

    @get
    external ref: documentSnapshot<'documentdata> => documentReference<'documentdata> = "ref"

    @get
    external exists: documentSnapshot<'documentdata> => bool = "exists"

    /// https://cloud.google.com/nodejs/docs/reference/firestore/latest/firestore/documentsnapshot
    @send
    external data: documentSnapshot<'documentdata> => 'documentdata = "data"
  }

  module DocumentReference = {
    @get
    external id: documentReference<'documentdata> => string = "id"

    /// https://cloud.google.com/nodejs/docs/reference/firestore/latest/firestore/documentreference#_google_cloud_firestore_DocumentReference_get_member_1_
    @send
    external get: (
      documentReference<'documentdata>,
      unit,
    ) => Promise.t<documentSnapshot<'documentdata>> = "get"

    /// https://cloud.google.com/nodejs/docs/reference/firestore/latest/firestore/documentreference#_google_cloud_firestore_DocumentReference_update_member_1_
    @send
    external update: (documentReference<'documentdata>, 'partialdocumentdata) => Promise.t<unit> =
      "update"

    /// https://cloud.google.com/nodejs/docs/reference/firestore/latest/firestore/documentreference#_google_cloud_firestore_DocumentReference_update_member_1_
    @send
    external update_field: (documentReference<'documentdata>, string, 't) => Promise.t<unit> =
      "update"
  }

  // https://googleapis.dev/nodejs/firestore/latest/Timestamp.html
  module Timestamp = {
    type t

    @module("firebase-admin/firestore") @new
    external make: (~seconds: int, ~nanoseconds: int) => t = "Timestamp"

    @module("firebase-admin/firestore") @scope("Timestamp")
    external now: unit => t = "now"

    @send
    external toMillis: t => int = "toMillis"

    @module("firebase-admin/firestore") @scope("Timestamp")
    external fromDate: Js.Date.t => t = "fromDate"
  }

  module FieldValue = {
    type t

    /// https://cloud.google.com/nodejs/docs/reference/firestore/latest/firestore/fieldvalue#_google_cloud_firestore_FieldValue_delete_member_1_
    @module("firebase-admin/firestore") @scope("FieldValue")
    external delete: unit => t = "delete"
  }
}

module Auth = {
  /// Auth service bound to the provided app. The claims are used in the userRecord.
  /// Specify them here once, so they work on all operations.
  /// https://firebase.google.com/docs/reference/admin/node/firebase-admin.auth.auth
  type auth<'claims>

  /// https://firebase.google.com/docs/reference/admin/node/firebase-admin.auth.md#getauth
  @module("firebase-admin/auth")
  external getAuth: App.app => auth<'claims> = "getAuth"

  type uid = string

  /// https://firebase.google.com/docs/reference/admin/node/firebase-admin.auth.userrecord.md#userrecord_class
  type userRecord<'claims> = {
    uid: uid,
    displayName: string,
    email: string,
    customClaims?: 'claims,
  }

  /// https://firebase.google.com/docs/reference/admin/node/firebase-admin.auth.listusersresult.md#listusersresult_interface
  type listUsersResult<'claims> = {
    pageToken: string,
    users: array<userRecord<'claims>>,
  }

  /// https://firebase.google.com/docs/reference/admin/node/firebase-admin.auth.baseauth.md#baseauthlistusers
  @send
  external listUsers: (
    auth<'claims>,
    ~maxResults: int=?,
    ~pageToken: string=?,
  ) => Promise.t<listUsersResult<'claims>> = "listUsers"

  /// https://firebase.google.com/docs/reference/admin/node/firebase-admin.auth.baseauth.md#baseauthgetuserbyemail
  @send
  external getUserByEmail: (auth<'claims>, string) => Promise.t<userRecord<'claims>> =
    "getUserByEmail"

  /// https://firebase.google.com/docs/reference/admin/node/firebase-admin.auth.baseauth.md#baseauthsetcustomuserclaims
  @send
  external setCustomUserClaims: (auth<'claims>, uid, 'claims) => Promise.t<unit> =
    "setCustomUserClaims"

  type createRequest = {
    email: string,
    displayName: string,
    password: string,
  }

  /// https://firebase.google.com/docs/reference/admin/node/firebase-admin.auth.baseauth.md#baseauthcreateuser
  @send
  external createUser: (auth<'claims>, createRequest) => Promise.t<userRecord<'claims>> =
    "createUser"
}
