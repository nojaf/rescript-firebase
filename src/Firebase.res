type config = {
  apiKey: string,
  authDomain: string,
  projectId: string,
  storageBucket: string,
  messagingSenderId: string,
  appId: string,
}

module App = {
  type app

  @module("firebase/app")
  external initializeApp: config => app = "initializeApp"
}

module Firestore = {
  @unboxed
  type firestoreErrorCode =
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

  type firestoreError = {
    code: firestoreErrorCode,
    message: string,
    stack: string,
  }

  type firestore

  @module("firebase/firestore")
  external getFirestore: App.app => firestore = "getFirestore"

  @module("firebase/firestore")
  external connectFirestoreEmulator: (firestore, string, int) => unit = "connectFirestoreEmulator"

  /// https://firebase.google.com/docs/reference/js/firestore_.querydocumentsnapshot.md#querydocumentsnapshot_class
  type query<'kind, 'documentdata>

  type collectionReference<'documentdata> = query<[#collectionReference], 'documentdata>

  @module("firebase/firestore") @variadic
  external collection: (firestore, array<string>) => collectionReference<'documentdata> =
    "collection"

  /// https://firebase.google.com/docs/reference/js/firestore_.documentreference.md#documentreference_class
  type documentReference<'documentdata> = {
    id: string,
    path: string,
  }

  @module("firebase/firestore") @variadic
  external doc: (firestore, string, array<string>) => documentReference<'documentdata> = "doc"

  /// https://firebase.google.com/docs/reference/js/firestore_.documentsnapshot.md#documentsnapshot_class
  type documentSnapshot<'documentdata> = {
    id: string,
    ref: documentReference<'documentdata>,
  }

  /// https://firebase.google.com/docs/reference/js/firestore_.md#getdoc_4569087
  @module("firebase/firestore")
  external getDoc: documentReference<'documentdata> => Promise.t<documentSnapshot<'documentdata>> =
    "getDoc"

  /// https://firebase.google.com/docs/reference/js/firestore_.documentsnapshot.md#documentsnapshotdata
  @send
  external data_ds: documentSnapshot<'documentdata> => Nullable.t<'documentdata> = "data"

  ///https://firebase.google.com/docs/reference/js/firestore_.querydocumentsnapshot.md#querydocumentsnapshot_class
  type queryDocumentSnapshot<'documentdata> = {
    id: string,
    ref: documentReference<'documentdata>,
  }

  /// https://firebase.google.com/docs/reference/js/firestore_.querysnapshot
  type querySnapshot<'documentdata> = {
    docs: array<queryDocumentSnapshot<'documentdata>>,
    empty: bool,
    size: int,
  }

  type documentChangeType =
    | @as("added") Added
    | @as("removed") Removed
    | @as("modified") Modified

  /// https://firebase.google.com/docs/reference/js/firestore_.documentchange.md#documentchange_interface
  type documentChange<'documentdata> = {
    @as("type") type_: documentChangeType,
    doc: queryDocumentSnapshot<'documentdata>,
  }

  /// https://firebase.google.com/docs/reference/js/firestore_.querysnapshot.md#querysnapshotdocchanges
  @send
  external docChanges: querySnapshot<'documentdata> => array<documentChange<'documentdata>> =
    "docChanges"

  /// https://firebase.google.com/docs/reference/js/firestore_.md#getdocs_4e56953
  @module("firebase/firestore")
  external getDocs: query<'kind, 'documentdata> => Promise.t<querySnapshot<'documentdata>> =
    "getDocs"

  @send
  external data_qds: queryDocumentSnapshot<'documentdata> => 'documentdata = "data"

  type queryContraint

  type orderByDirection = | @as("desc") Desc | @as("asc") Asc

  @module("firebase/firestore")
  external orderBy: (string, orderByDirection) => queryContraint = "orderBy"

  @module("firebase/firestore")
  external limit: int => queryContraint = "limit"

  @module("firebase/firestore") @variadic
  external query: (
    query<'kind, 'documentdata>,
    array<queryContraint>,
  ) => query<'kind, 'documentdata> = "query"

  type whereFilterOp =
    | @as("==") Equals
    | @as("!=") NotEquals
    | @as("<") LessThan
    | @as("<=") LessThanOrEqual
    | @as(">") GreaterThan
    | @as(">=") GreaterThanOrEqual

  /// https://firebase.google.com/docs/reference/js/firestore_.md#where_0fae4bf
  @module("firebase/firestore")
  external where: (string, whereFilterOp, 'value) => queryContraint = "where"

  /**
    Adds a new document to a collection.
    https://firebase.google.com/docs/reference/js/firestore_#adddoc_6e783ff 
 */
  @module("firebase/firestore")
  external addDoc: (
    collectionReference<'documentdata>,
    'documentdata,
  ) => Promise.t<documentReference<'documentdata>> = "addDoc"

  /// https://firebase.google.com/docs/reference/js/firestore_#setdoc_ee215ad
  @module("firebase/firestore")
  external setDoc: (documentReference<'documentdata>, 'documentdata) => Promise.t<unit> = "setDoc"

  /// https://firebase.google.com/docs/reference/js/firestore_.md#updatedoc_7c28659
  @module("firebase/firestore")
  external updateDoc: (documentReference<'documentdata>, 'documentdata) => Promise.t<unit> =
    "updateDoc"

  /// https://firebase.google.com/docs/reference/js/firestore_.md#updatedoc_7c28659
  @module("firebase/firestore")
  external updateFieldInDoc: (documentReference<'documentdata>, string, 'value) => Promise.t<unit> =
    "updateDoc"

  /// https://firebase.google.com/docs/reference/js/firestore_.md#deletedoc_4569087
  @module("firebase/firestore")
  external deleteDoc: documentReference<'documentdata> => Promise.t<unit> = "deleteDoc"

  type snapShotObserver<'documentdata> = {
    next?: querySnapshot<'documentdata> => unit,
    error?: firestoreError => unit,
    complete?: unit => unit,
  }

  type unsubscribe = unit => unit

  /// https://firebase.google.com/docs/reference/js/firestore_.md#onsnapshot_8d14049
  @module("firebase/firestore")
  external onSnapshot: (
    query<'kind, 'documentdata>,
    snapShotObserver<'documentdata>,
  ) => unsubscribe = "onSnapshot"

  // https://googleapis.dev/nodejs/firestore/latest/Timestamp.html
  module Timestamp = {
    type t

    @module("firebase/firestore") @new
    external make: (~seconds: int, ~nanoseconds: int) => t = "Timestamp"

    @module("firebase/firestore") @scope("Timestamp")
    external now: unit => t = "now"

    @send
    external toMillis: t => int = "toMillis"

    @module("firebase/firestore") @scope("Timestamp")
    external fromMillis: int => t = "fromMillis"

    @get("seconds")
    external seconds: t => int = "seconds"

    @send
    external toString: t => string = "toString"

    /// https://firebase.google.com/docs/reference/js/firestore_.timestamp.md#timestamptodate
    @send
    external toDate: t => Date.t = "toDate"

    @module("firebase/firestore") @scope("Timestamp")
    external fromDate: Date.t => t = "fromDate"
  }
}

module Functions = {
  /// https://firebase.google.com/docs/reference/js/functions.functions
  type functions

  /// https://firebase.google.com/docs/reference/js/functions.md#getfunctions_60f2095
  @module("firebase/functions")
  external getFunctions: (App.app, ~regionOrCustomDomain: string) => functions = "getFunctions"

  /// https://firebase.google.com/docs/reference/js/functions.md#connectfunctionsemulator_505c08d
  @module("firebase/functions")
  external connectFunctionsEmulator: (functions, string, int) => unit = "connectFunctionsEmulator"

  type httpsCallableResult<'t> = {data: 't}

  type httpsCallable<'requestData, 'responseData> = (
    ~data: 'requestData,
  ) => Promise.t<httpsCallableResult<'responseData>>

  @module("firebase/functions")
  external httpsCallable: (functions, ~name: string) => httpsCallable<'requestData, 'responseData> =
    "httpsCallable"
}

module Auth = {
  /// https://firebase.google.com/docs/reference/js/auth.user.md#user_interface
  type user = {displayName: string, email: string, uid: string}

  /// https://firebase.google.com/docs/reference/js/auth.auth
  type auth = {app: App.app, config: config, currentUser: Null.t<user>}

  /// https://firebase.google.com/docs/reference/js/auth.md#getauth_cf608e1
  @module("firebase/auth")
  external getAuth: App.app => auth = "getAuth"

  @module("firebase/auth")
  external connectAuthEmulator: (auth, string) => unit = "connectAuthEmulator"

  /// /// https://firebase.google.com/docs/reference/js/auth.usercredential
  type userCredential = {user: user}

  /// https://firebase.google.com/docs/reference/js/auth.md#signinwithemailandpassword_21ad33b
  @module("firebase/auth")
  external signInWithEmailAndPassword: (
    auth,
    ~email: string,
    ~password: string,
  ) => Promise.t<userCredential> = "signInWithEmailAndPassword"
}
