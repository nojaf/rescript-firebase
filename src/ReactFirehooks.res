module Firestore = {
  type queryResult<'documentdata> = (
    option<Firebase.Firestore.querySnapshot<'documentdata>>,
    bool,
    option<Firebase.Firestore.firestoreError>,
  )

  // Document hooks

  /// https://github.com/andipaetzold/react-firehooks/blob/main/docs/firestore.md#usedocument
  @module("react-firehooks/firestore")
  external useDocument: Firebase.Firestore.documentReference<'documentdata> => (
    option<Firebase.Firestore.documentSnapshot<'documentdata>>,
    bool,
    option<Firebase.Firestore.firestoreError>,
  ) = "useDocument"

  /// https://github.com/andipaetzold/react-firehooks/blob/main/docs/firestore.md#usedocumentdata
  @module("react-firehooks/firestore")
  external useDocumentData: Firebase.Firestore.documentReference<'documentdata> => (
    option<'documentdata>,
    bool,
    option<Firebase.Firestore.firestoreError>,
  ) = "useDocumentData"

  /// https://github.com/andipaetzold/react-firehooks/blob/main/docs/firestore.md#usedocumentonce
  @module("react-firehooks/firestore")
  external useDocumentOnce: Firebase.Firestore.documentReference<'documentdata> => (
    option<Firebase.Firestore.documentSnapshot<'documentdata>>,
    bool,
    option<Firebase.Firestore.firestoreError>,
  ) = "useDocumentOnce"

  /// https://github.com/andipaetzold/react-firehooks/blob/main/docs/firestore.md#usedocumentdataonce
  @module("react-firehooks/firestore")
  external useDocumentDataOnce: Firebase.Firestore.documentReference<'documentdata> => (
    option<'documentdata>,
    bool,
    option<Firebase.Firestore.firestoreError>,
  ) = "useDocumentDataOnce"

  // Query hooks

  /// https://github.com/andipaetzold/react-firehooks/blob/main/docs/firestore.md#usequery
  @module("react-firehooks/firestore")
  external useQuery: Firebase.Firestore.query<'kind, 'documentdata> => queryResult<'documentdata> =
    "useQuery"

  /// https://github.com/andipaetzold/react-firehooks/blob/main/docs/firestore.md#usequerydata
  @module("react-firehooks/firestore")
  external useQueryData: Firebase.Firestore.query<'kind, 'documentdata> => (
    option<array<'documentdata>>,
    bool,
    option<Firebase.Firestore.firestoreError>,
  ) = "useQueryData"

  /// https://github.com/andipaetzold/react-firehooks/blob/main/docs/firestore.md#usequeryonce
  @module("react-firehooks/firestore")
  external useQueryOnce: Firebase.Firestore.query<'kind, 'documentdata> => queryResult<
    'documentdata,
  > = "useQueryOnce"

  /// https://github.com/andipaetzold/react-firehooks/blob/main/docs/firestore.md#usequerydataonce
  @module("react-firehooks/firestore")
  external useQueryDataOnce: Firebase.Firestore.query<'kind, 'documentdata> => (
    option<array<'documentdata>>,
    bool,
    option<Firebase.Firestore.firestoreError>,
  ) = "useQueryDataOnce"

  // Multiple query hooks

  /// https://github.com/andipaetzold/react-firehooks/blob/main/docs/firestore.md#usequeries
  @module("react-firehooks/firestore")
  external useQueries: array<Firebase.Firestore.query<'kind, 'documentdata>> => array<
    queryResult<'documentdata>,
  > = "useQueries"

  /// https://github.com/andipaetzold/react-firehooks/blob/main/docs/firestore.md#usequeriesdata
  @module("react-firehooks/firestore")
  external useQueriesData: array<Firebase.Firestore.query<'kind, 'documentdata>> => array<(
    option<array<'documentdata>>,
    bool,
    option<Firebase.Firestore.firestoreError>,
  )> = "useQueriesData"

  /// https://github.com/andipaetzold/react-firehooks/blob/main/docs/firestore.md#usequeriesonce
  @module("react-firehooks/firestore")
  external useQueriesOnce: array<Firebase.Firestore.query<'kind, 'documentdata>> => array<
    queryResult<'documentdata>,
  > = "useQueriesOnce"

  /// https://github.com/andipaetzold/react-firehooks/blob/main/docs/firestore.md#usequeriesdataonce
  @module("react-firehooks/firestore")
  external useQueriesDataOnce: array<Firebase.Firestore.query<'kind, 'documentdata>> => array<(
    option<array<'documentdata>>,
    bool,
    option<Firebase.Firestore.firestoreError>,
  )> = "useQueriesDataOnce"
}

module Storage = {
  /// https://github.com/andipaetzold/react-firehooks/blob/main/docs/storage.md#usedownloadurl
  @module("react-firehooks/storage")
  external useDownloadURL: Firebase.Storage.storageReference => (
    option<string>,
    bool,
    option<Firebase.Storage.storageError>,
  ) = "useDownloadURL"

  /// https://github.com/andipaetzold/react-firehooks/blob/main/docs/storage.md#usemetadata
  @module("react-firehooks/storage")
  external useMetadata: Firebase.Storage.storageReference => (
    option<Firebase.Storage.fullMetadata>,
    bool,
    option<Firebase.Storage.storageError>,
  ) = "useMetadata"

  /// https://github.com/andipaetzold/react-firehooks/blob/main/docs/storage.md#useblob
  @module("react-firehooks/storage")
  external useBlob: Firebase.Storage.storageReference => (
    option<'blob>,
    bool,
    option<Firebase.Storage.storageError>,
  ) = "useBlob"

  /// https://github.com/andipaetzold/react-firehooks/blob/main/docs/storage.md#usebytes
  @module("react-firehooks/storage")
  external useBytes: Firebase.Storage.storageReference => (
    option<'bytes>,
    bool,
    option<Firebase.Storage.storageError>,
  ) = "useBytes"
}

module Auth = {
  /// https://github.com/andipaetzold/react-firehooks/blob/main/docs/auth.md#useauthstate
  @module("react-firehooks/auth")
  external useAuthState: Firebase.Auth.auth => (
    Nullable.t<Firebase.Auth.user>,
    bool,
    option<Firebase.Auth.authError>,
  ) = "useAuthState"
}
