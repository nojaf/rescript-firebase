module App = {
  @editor.completeFrom([Firestore, Auth, Storage])
  type app

  type credential

  /// https://firebase.google.com/docs/reference/admin/node/firebase-admin.app.appoptions
  type appOptions = {
    credential?: credential,
    projectId?: string,
    storageBucket?: string,
    databaseURL?: string,
    serviceAccountId?: string,
  }

  /// https://firebase.google.com/docs/reference/admin/node/firebase-admin.app.md#initializeapp
  @module("firebase-admin/app")
  external initializeApp: appOptions => app = "initializeApp"

  /// https://firebase.google.com/docs/reference/admin/node/firebase-admin.app.serviceaccount
  type serviceAccount = {
    projectId?: string,
    clientEmail?: string,
    privateKey?: string,
  }

  /// https://firebase.google.com/docs/reference/admin/node/firebase-admin.app.md#cert_13d5f11
  @module("firebase-admin/app")
  external cert: serviceAccount => credential = "cert"

  type serviceAccountConfig = {credential: credential}

  @module("firebase-admin/app")
  external initializeAppWithServiceAccount: serviceAccountConfig => app = "initializeApp"

  /// https://firebase.google.com/docs/reference/admin/node/firebase-admin.app.md#getapp
  @module("firebase-admin/app")
  external getApp: (~appName: string=?) => app = "getApp"

  /// https://firebase.google.com/docs/reference/admin/node/firebase-admin.app.md#deleteapp
  @module("firebase-admin/app")
  external deleteApp: app => Promise.t<unit> = "deleteApp"
}

/// https://firebase.google.com/docs/reference/admin/node/firebase-admin.firestore
module Firestore = {
  type firestore

  @unboxed
  type whereFilterOp =
    | @as("==") Equals
    | @as("!=") NotEquals
    | @as("<") LessThan
    | @as("<=") LessThanOrEqual
    | @as(">") GreaterThan
    | @as(">=") GreaterThanOrEqual
    | @as("array-contains") ArrayContains
    | @as("in") In
    | @as("not-in") NotIn
    | @as("array-contains-any") ArrayContainsAny

  @unboxed
  type orderByDirection = | @as("asc") Asc | @as("desc") Desc

  /// https://cloud.google.com/nodejs/docs/reference/firestore/latest/firestore/setoptions
  type setOptions = {
    merge?: bool,
    mergeFields?: array<string>,
  }

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

  /// https://cloud.google.com/nodejs/docs/reference/firestore/latest/firestore/writeresult
  module WriteResult = {
    type t
  }

  /// https://cloud.google.com/nodejs/docs/reference/firestore/latest/firestore/writebatch
  module WriteBatch = {
    type t

    @send
    external set: (t, documentReference<'a>, 'a) => t = "set"

    @send
    external update: (t, documentReference<'a>, 'a) => t = "update"

    @send
    external delete: (t, documentReference<'a>) => t = "delete"

    @send
    external commit: t => Promise.t<array<WriteResult.t>> = "commit"
  }

  /// https://cloud.google.com/nodejs/docs/reference/firestore/latest/firestore/transaction
  module Transaction = {
    type t

    @send
    external get: (t, documentReference<'a>) => Promise.t<documentSnapshot<'a>> = "get"

    @send
    external set: (t, documentReference<'a>, 'a) => t = "set"

    @send
    external update: (t, documentReference<'a>, 'a) => t = "update"

    @send
    external delete: (t, documentReference<'a>) => t = "delete"
  }

  @module("firebase-admin/firestore")
  external getFirestore: App.app => firestore = "getFirestore"

  @send
  external collection: (firestore, string) => collectionReference<'documentdata> = "collection"

  @send
  external doc: (firestore, string) => documentReference<'documentdata> = "doc"

  @send
  external collectionGroup: (firestore, string) => query<'documentdata> = "collectionGroup"

  @send
  external batch: firestore => WriteBatch.t = "batch"

  @send
  external runTransaction: (firestore, Transaction.t => Promise.t<'a>) => Promise.t<'a> =
    "runTransaction"

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
    external fromMillis: int => t = "fromMillis"

    @module("firebase-admin/firestore") @scope("Timestamp")
    external fromDate: Date.t => t = "fromDate"

    @send
    external toDate: t => Date.t = "toDate"

    @get external seconds: t => int = "seconds"
    @get external nanoseconds: t => int = "nanoseconds"
  }

  module CollectionReference = {
    external asQuery: collectionReference<'documentdata> => query<'documentdata> = "%identity"

    @get external id: collectionReference<'documentdata> => string = "id"
    @get external path: collectionReference<'documentdata> => string = "path"

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

    @get
    external readTime: querySnapshot<'documentdata> => Timestamp.t = "readTime"
  }

  module QueryDocumentSnapshot = {
    @get external id: queryDocumentSnapshot<'documentdata> => string = "id"

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
    external where: (query<'documentdata>, string, whereFilterOp, 'value) => query<'documentdata> =
      "where"

    @send
    external orderBy: (
      query<'documentdata>,
      string,
      ~directionStr: orderByDirection=?,
    ) => query<'documentdata> = "orderBy"

    @send
    external limit: (query<'documentdata>, int) => query<'documentdata> = "limit"

    @send
    external limitToLast: (query<'documentdata>, int) => query<'documentdata> = "limitToLast"

    @send
    external offset: (query<'documentdata>, int) => query<'documentdata> = "offset"

    @send
    external startAt: (query<'documentdata>, 'value) => query<'documentdata> = "startAt"

    @send
    external startAfter: (query<'documentdata>, 'value) => query<'documentdata> = "startAfter"

    @send
    external endBefore: (query<'documentdata>, 'value) => query<'documentdata> = "endBefore"

    @send
    external endAt: (query<'documentdata>, 'value) => query<'documentdata> = "endAt"

    @send @variadic
    external select: (query<'documentdata>, array<string>) => query<'documentdata> = "select"

    @send
    external onSnapshot: (
      query<'documentdata>,
      ~onNext: querySnapshot<'documentdata> => unit,
      ~onError: JsExn.t => unit=?,
    ) => unit => unit = "onSnapshot"
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
    external data: documentSnapshot<'documentdata> => option<'documentdata> = "data"

    @get
    external createTime: documentSnapshot<'data> => Timestamp.t = "createTime"

    @get
    external updateTime: documentSnapshot<'data> => Timestamp.t = "updateTime"

    @get
    external readTime: documentSnapshot<'data> => Timestamp.t = "readTime"
  }

  module DocumentReference = {
    @get
    external id: documentReference<'documentdata> => string = "id"

    @get
    external path: documentReference<'documentdata> => string = "path"

    /// https://cloud.google.com/nodejs/docs/reference/firestore/latest/firestore/documentreference#_google_cloud_firestore_DocumentReference_get_member_1_
    @send
    external get: documentReference<'documentdata> => Promise.t<documentSnapshot<'documentdata>> =
      "get"

    @send
    external set: (documentReference<'documentdata>, 'documentdata) => Promise.t<WriteResult.t> =
      "set"

    @send
    external setWithOptions: (
      documentReference<'documentdata>,
      'documentdata,
      setOptions,
    ) => Promise.t<WriteResult.t> = "set"

    @send
    external create: (documentReference<'documentdata>, 'documentdata) => Promise.t<WriteResult.t> =
      "create"

    @send
    external update: (
      documentReference<'documentdata>,
      'partialdocumentdata,
    ) => Promise.t<WriteResult.t> = "update"

    @send
    external update_field: (
      documentReference<'documentdata>,
      string,
      't,
    ) => Promise.t<WriteResult.t> = "update"

    @send
    external delete: documentReference<'documentdata> => Promise.t<WriteResult.t> = "delete"

    @send
    external collection: (documentReference<'documentdata>, string) => collectionReference<'b> =
      "collection"

    @send
    external onSnapshot: (
      documentReference<'documentdata>,
      ~onNext: documentSnapshot<'documentdata> => unit,
      ~onError: JsExn.t => unit=?,
    ) => unit => unit = "onSnapshot"
  }

  module FieldValue = {
    type t

    /// https://cloud.google.com/nodejs/docs/reference/firestore/latest/firestore/fieldvalue#_google_cloud_firestore_FieldValue_delete_member_1_
    @module("firebase-admin/firestore") @scope("FieldValue")
    external delete: unit => t = "delete"

    @module("firebase-admin/firestore") @scope("FieldValue")
    external serverTimestamp: unit => t = "serverTimestamp"

    @module("firebase-admin/firestore") @scope("FieldValue")
    external increment: float => t = "increment"

    @module("firebase-admin/firestore") @scope("FieldValue") @variadic
    external arrayUnion: array<'a> => t = "arrayUnion"

    @module("firebase-admin/firestore") @scope("FieldValue") @variadic
    external arrayRemove: array<'a> => t = "arrayRemove"
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
    email?: string,
    emailVerified: bool,
    displayName?: string,
    photoURL?: string,
    phoneNumber?: string,
    disabled: bool,
    customClaims?: 'claims,
  }

  /// https://firebase.google.com/docs/reference/admin/node/firebase-admin.auth.listusersresult.md#listusersresult_interface
  type listUsersResult<'claims> = {
    pageToken?: string,
    users: array<userRecord<'claims>>,
  }

  /// https://firebase.google.com/docs/reference/admin/node/firebase-admin.auth.deleteusersresult
  type deleteUsersResult = {
    failureCount: int,
    successCount: int,
  }

  /// https://firebase.google.com/docs/reference/admin/node/firebase-admin.auth.decodedidtoken
  type decodedIdToken = {
    uid: string,
    aud: string,
    iss: string,
    iat: float,
    exp: float,
    auth_time: float,
    sub: string,
    email?: string,
    email_verified?: bool,
    phone_number?: string,
  }

  /// https://firebase.google.com/docs/reference/admin/node/firebase-admin.auth.createrequest
  type createRequest = {
    uid?: string,
    email?: string,
    displayName?: string,
    password?: string,
    emailVerified?: bool,
    phoneNumber?: string,
    photoURL?: string,
    disabled?: bool,
  }

  /// https://firebase.google.com/docs/reference/admin/node/firebase-admin.auth.updaterequest
  type updateRequest = {
    disabled?: bool,
    displayName?: string,
    email?: string,
    emailVerified?: bool,
    password?: string,
    phoneNumber?: string,
    photoURL?: string,
  }

  /// https://firebase.google.com/docs/reference/admin/node/firebase-admin.auth.baseauth.md#baseauthlistusers
  @send
  external listUsers: (
    auth<'claims>,
    ~maxResults: int=?,
    ~pageToken: string=?,
  ) => Promise.t<listUsersResult<'claims>> = "listUsers"

  /// https://firebase.google.com/docs/reference/admin/node/firebase-admin.auth.baseauth.md#baseauthgetuser
  @send
  external getUser: (auth<'claims>, string) => Promise.t<userRecord<'claims>> = "getUser"

  /// https://firebase.google.com/docs/reference/admin/node/firebase-admin.auth.baseauth.md#baseauthgetuserbyemail
  @send
  external getUserByEmail: (auth<'claims>, string) => Promise.t<userRecord<'claims>> =
    "getUserByEmail"

  /// https://firebase.google.com/docs/reference/admin/node/firebase-admin.auth.baseauth.md#baseauthgetuserbyphonenumber
  @send
  external getUserByPhoneNumber: (auth<'claims>, string) => Promise.t<userRecord<'claims>> =
    "getUserByPhoneNumber"

  /// https://firebase.google.com/docs/reference/admin/node/firebase-admin.auth.baseauth.md#baseauthcreateuser
  @send
  external createUser: (auth<'claims>, createRequest) => Promise.t<userRecord<'claims>> =
    "createUser"

  /// https://firebase.google.com/docs/reference/admin/node/firebase-admin.auth.baseauth.md#baseauthupdateuser
  @send
  external updateUser: (auth<'claims>, string, updateRequest) => Promise.t<userRecord<'claims>> =
    "updateUser"

  /// https://firebase.google.com/docs/reference/admin/node/firebase-admin.auth.baseauth.md#baseauthdeleteuser
  @send
  external deleteUser: (auth<'claims>, string) => Promise.t<unit> = "deleteUser"

  /// https://firebase.google.com/docs/reference/admin/node/firebase-admin.auth.baseauth.md#baseauthdeleteusers
  @send
  external deleteUsers: (auth<'claims>, array<string>) => Promise.t<deleteUsersResult> =
    "deleteUsers"

  /// https://firebase.google.com/docs/reference/admin/node/firebase-admin.auth.baseauth.md#baseauthsetcustomuserclaims
  @send
  external setCustomUserClaims: (auth<'claims>, uid, 'claims) => Promise.t<unit> =
    "setCustomUserClaims"

  /// https://firebase.google.com/docs/reference/admin/node/firebase-admin.auth.baseauth.md#baseauthverifyidtoken
  @send
  external verifyIdToken: (
    auth<'claims>,
    string,
    ~checkRevoked: bool=?,
  ) => Promise.t<decodedIdToken> = "verifyIdToken"

  /// https://firebase.google.com/docs/reference/admin/node/firebase-admin.auth.baseauth.md#baseauthcreatecustomtoken
  @send
  external createCustomToken: (
    auth<'claims>,
    string,
    ~developerClaims: {..}=?,
  ) => Promise.t<string> = "createCustomToken"

  /// https://firebase.google.com/docs/reference/admin/node/firebase-admin.auth.baseauth.md#baseauthrevokerefreshtoken
  @send
  external revokeRefreshTokens: (auth<'claims>, string) => Promise.t<unit> = "revokeRefreshTokens"
}

/// https://firebase.google.com/docs/reference/admin/node/firebase-admin.storage
module Storage = {
  type storage

  @module("firebase-admin/storage")
  external getStorage: App.app => storage = "getStorage"

  /// https://cloud.google.com/nodejs/docs/reference/storage/latest/storage/bucket
  type bucket

  /// https://firebase.google.com/docs/reference/admin/node/firebase-admin.storage.storage.md#storagebucket
  @send
  external bucket: (storage, string) => bucket = "bucket"

  @send
  external bucketDefault: storage => bucket = "bucket"

  /// https://cloud.google.com/nodejs/docs/reference/storage/latest/storage/file
  type file

  /// https://cloud.google.com/nodejs/docs/reference/storage/latest/storage/bucket#_google_cloud_storage_Bucket_file_member_1_
  @send
  external file: (bucket, string) => file = "file"

  @get external fileName: file => string = "name"

  @module("firebase-admin/storage")
  external getDownloadURL: file => Promise.t<string> = "getDownloadURL"

  @send
  external save: (file, 'data) => Promise.t<unit> = "save"

  @send
  external deleteFile: file => Promise.t<unit> = "delete"

  @send
  external exists: file => Promise.t<array<bool>> = "exists"

  @send
  external getMetadata: file => Promise.t<'metadata> = "getMetadata"

  /// https://cloud.google.com/nodejs/docs/reference/storage/latest/storage/file#_google_cloud_storage_File_setMetadata_member_1_
  @send
  external setMetadata: (file, 'metadata) => Promise.t<'metadata> = "setMetadata"
}
