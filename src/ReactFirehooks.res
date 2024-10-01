module Firestore = {
  type queryResult<'documentdata> = (
    option<Firebase.Firestore.querySnapshot<'documentdata>>,
    bool,
    option<Firebase.Firestore.firestoreError>,
  )

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

  /// https://github.com/andipaetzold/react-firehooks/blob/main/docs/firestore.md#usequeriesnapshot
  @module("react-firehooks/firestore")
  external useQueries: array<Firebase.Firestore.query<'kind, 'documentdata>> => array<
    queryResult<'documentdata>,
  > = "useQueries"
}

module Auth = {
  /// https://github.com/andipaetzold/react-firehooks/blob/main/docs/auth.md#useauthstate
  @module("react-firehooks/auth")
  external useAuthState: Firebase.Auth.auth => (
    Nullable.t<Firebase.Auth.user>,
    bool,
    option<Firebase.Firestore.firestoreError>,
  ) = "useAuthState"
}
