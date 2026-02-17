@editor.completeFrom(App)
type config = {
  apiKey: string,
  authDomain: string,
  projectId: string,
  storageBucket: string,
  messagingSenderId: string,
  appId: string,
}

/// https://firebase.google.com/docs/reference/js/app.firebaseerror
type firebaseError = {
  message: string,
  name: string,
}

module App = {
  @editor.completeFrom([Firestore, Functions, Auth, Storage])
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
    ...firebaseError,
    code: firestoreErrorCode,
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
  external data_ds: documentSnapshot<'documentdata> => option<'documentdata> = "data"

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
    | @as("array-contains") ArrayContains
    | @as("in") In
    | @as("array-contains-any") ArrayContainsAny
    | @as("not-in") NotIn

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

module Storage = {
  /// https://firebase.google.com/docs/reference/js/storage.firebasestorage
  type storage

  /// https://firebase.google.com/docs/reference/js/storage.storagereference
  type storageReference

  @unboxed
  type stringFormat =
    | @as("raw") Raw
    | @as("base64") Base64
    | @as("base64url") Base64url
    | @as("data_url") DataUrl

  @unboxed
  type storageErrorCode =
    | @as("storage/unknown") Unknown
    | @as("storage/object-not-found") ObjectNotFound
    | @as("storage/bucket-not-found") BucketNotFound
    | @as("storage/project-not-found") ProjectNotFound
    | @as("storage/quota-exceeded") QuotaExceeded
    | @as("storage/unauthenticated") Unauthenticated
    | @as("storage/unauthorized") Unauthorized
    | @as("storage/unauthorized-app") UnauthorizedApp
    | @as("storage/retry-limit-exceeded") RetryLimitExceeded
    | @as("storage/invalid-checksum") InvalidChecksum
    | @as("storage/canceled") Canceled
    | @as("storage/invalid-event-name") InvalidEventName
    | @as("storage/invalid-url") InvalidUrl
    | @as("storage/invalid-default-bucket") InvalidDefaultBucket
    | @as("storage/no-default-bucket") NoDefaultBucket
    | @as("storage/cannot-slice-blob") CannotSliceBlob
    | @as("storage/server-file-wrong-size") ServerFileWrongSize
    | @as("storage/no-download-url") NoDownloadUrl
    | @as("storage/invalid-argument") InvalidArgument
    | @as("storage/invalid-argument-count") InvalidArgumentCount
    | @as("storage/app-deleted") AppDeleted
    | @as("storage/invalid-root-operation") InvalidRootOperation
    | @as("storage/invalid-format") InvalidFormat
    | @as("storage/internal-error") InternalError
    | @as("storage/unsupported-environment") UnsupportedEnvironment

  /// https://firebase.google.com/docs/reference/js/storage.storageerror
  type storageError = {
    ...firebaseError,
    code: storageErrorCode,
  }

  /// https://firebase.google.com/docs/reference/js/storage.fullmetadata
  type fullMetadata = {
    bucket: string,
    fullPath: string,
    generation: string,
    metageneration: string,
    name: string,
    size: int,
    timeCreated: string,
    updated: string,
  }

  /// https://firebase.google.com/docs/reference/js/storage.uploadresult
  type uploadResult = {metadata: fullMetadata, ref: storageReference}

  /// https://firebase.google.com/docs/reference/js/storage.listresult
  type listResult = {
    prefixes: array<storageReference>,
    items: array<storageReference>,
    nextPageToken?: string,
  }

  /// https://firebase.google.com/docs/reference/js/storage.listoptions
  type listOptions = {
    maxResults?: int,
    pageToken?: string,
  }

  @unboxed
  type taskState =
    | @as("running") Running
    | @as("paused") Paused
    | @as("success") Success
    | @as("canceled") Canceled
    | @as("error") Error

  /// https://firebase.google.com/docs/reference/js/storage.uploadtask
  module UploadTask = {
    type t

    /// https://firebase.google.com/docs/reference/js/storage.uploadtasksnapshot
    type snapshot = {
      bytesTransferred: int,
      metadata: fullMetadata,
      ref: storageReference,
      state: taskState,
      task: t,
      totalBytes: int,
    }

    @send external cancel: t => bool = "cancel"
    @send external pause: t => bool = "pause"
    @send external resume: t => bool = "resume"
    @get external snapshot: t => snapshot = "snapshot"

    @send
    external on: (
      t,
      @as("state_changed") _,
      ~next: snapshot => unit=?,
      ~error: storageError => unit=?,
      ~complete: unit => unit=?,
    ) => unit => unit = "on"

    @send
    external then: (
      t,
      ~onFulfilled: snapshot => 'a=?,
      ~onRejected: storageError => 'b=?,
    ) => Promise.t<'a> = "then"
  }

  /// https://firebase.google.com/docs/reference/js/storage.md#getstorage
  @module("firebase/storage")
  external getStorage: App.app => storage = "getStorage"

  /// https://firebase.google.com/docs/reference/js/storage.md#connectstorageemulator
  @module("firebase/storage")
  external connectStorageEmulator: (storage, string, int) => unit = "connectStorageEmulator"

  /// https://firebase.google.com/docs/reference/js/storage.md#ref
  @module("firebase/storage")
  external ref: (storage, string) => storageReference = "ref"

  /// https://firebase.google.com/docs/reference/js/storage.md#uploadstring
  @module("firebase/storage")
  external uploadString: (
    storageReference,
    string,
    ~format: stringFormat=?,
  ) => Promise.t<uploadResult> = "uploadString"

  /// https://firebase.google.com/docs/reference/js/storage.md#uploadbytes
  @module("firebase/storage")
  external uploadBytes: (storageReference, 'data) => Promise.t<uploadResult> = "uploadBytes"

  /// https://firebase.google.com/docs/reference/js/storage.md#uploadbytesresumable
  @module("firebase/storage")
  external uploadBytesResumable: (storageReference, 'data) => UploadTask.t = "uploadBytesResumable"

  /// https://firebase.google.com/docs/reference/js/storage.md#getdownloadurl
  @module("firebase/storage")
  external getDownloadURL: storageReference => Promise.t<string> = "getDownloadURL"

  /// https://firebase.google.com/docs/reference/js/storage.md#getblob
  @module("firebase/storage")
  external getBlob: (storageReference, ~maxDownloadSizeBytes: int=?) => Promise.t<'blob> = "getBlob"

  /// https://firebase.google.com/docs/reference/js/storage.md#getbytes
  @module("firebase/storage")
  external getBytes: (storageReference, ~maxDownloadSizeBytes: int=?) => Promise.t<'bytes> =
    "getBytes"

  /// https://firebase.google.com/docs/reference/js/storage.md#getstream
  @module("firebase/storage")
  external getStream: (storageReference, ~maxDownloadSizeBytes: int=?) => 'stream = "getStream"

  /// https://firebase.google.com/docs/reference/js/storage.md#getmetadata
  @module("firebase/storage")
  external getMetadata: storageReference => Promise.t<fullMetadata> = "getMetadata"

  /// https://firebase.google.com/docs/reference/js/storage.md#updatemetadata
  @module("firebase/storage")
  external updateMetadata: (storageReference, fullMetadata) => Promise.t<fullMetadata> =
    "updateMetadata"

  /// https://firebase.google.com/docs/reference/js/storage.md#list
  @module("firebase/storage")
  external list: (storageReference, ~options: listOptions=?) => Promise.t<listResult> = "list"

  /// https://firebase.google.com/docs/reference/js/storage.md#listall
  @module("firebase/storage")
  external listAll: storageReference => Promise.t<listResult> = "listAll"

  /// https://firebase.google.com/docs/reference/js/storage.md#deleteobject
  @module("firebase/storage")
  external deleteObject: storageReference => Promise.t<unit> = "deleteObject"
}

module Auth = {
  /// https://firebase.google.com/docs/reference/js/auth.user.md#user_interface
  type user = {displayName: Null.t<string>, email: Null.t<string>, uid: string}

  /// https://firebase.google.com/docs/reference/js/auth.config
  type authConfig = {
    apiKey: string,
    apiHost: string,
    apiScheme: string,
    tokenApiHost: string,
    sdkClientVersion: string,
    authDomain?: string,
  }

  /// https://firebase.google.com/docs/reference/js/auth.autherror
  type authError = {
    ...firebaseError,
    code: string,
  }

  /// https://firebase.google.com/docs/reference/js/auth.auth
  type auth = {app: App.app, config: authConfig, currentUser: Null.t<user>}

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
