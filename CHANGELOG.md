# Changelog

## [0.6.0] - 2026-02-19

### Added

- Added `Firebase.Storage.uploadMetadata` type with optional fields (`cacheControl`, `contentDisposition`, `contentEncoding`, `contentLanguage`, `contentType`, `md5Hash`).
- Added `~metadata: uploadMetadata=?` parameter to `Firebase.Storage.uploadString`, `uploadBytes`, and `uploadBytesResumable`.
- Added `cacheControl`, `contentDisposition`, `contentEncoding`, `contentLanguage`, `contentType`, `customMetadata`, `md5Hash` optional fields to `Firebase.Storage.fullMetadata`.

### Changed

- **Breaking:** `FirebaseAdmin.App.appConfig` renamed to `appOptions` with correct admin SDK fields (`credential?`, `projectId?`, `storageBucket?`, `databaseURL?`, `serviceAccountId?`).
- **Breaking:** `FirebaseAdmin.App.serviceAccountPathOrObject` replaced with typed `serviceAccount` record (`projectId?`, `clientEmail?`, `privateKey?`).
- **Breaking:** `FirebaseAdmin.Auth.userRecord` fields `email` and `displayName` are now optional; added `emailVerified`, `photoURL`, `phoneNumber`, `disabled` fields.
- **Breaking:** `FirebaseAdmin.Auth.createRequest` fields are now all optional; added `uid?`, `emailVerified?`, `phoneNumber?`, `photoURL?`, `disabled?`.
- **Breaking:** `FirebaseAdmin.Auth.listUsersResult.pageToken` is now optional.
- **Breaking:** `FirebaseAdmin.Firestore.opString` replaced with `whereFilterOp` (full set of operators).
- **Breaking:** `FirebaseAdmin.Firestore.DocumentReference.update` and `update_field` now return `Promise.t<WriteResult.t>` instead of `Promise.t<unit>`.
- **Breaking:** `FirebaseAdmin.Firestore.DocumentReference.get` no longer takes a `unit` parameter.
- **Breaking:** `FirebaseAdmin.Firestore.DocumentSnapshot.data` now returns `option<'documentdata>`.
- `FirebaseAdmin.Storage.getDownloadURL` return type fixed from `promise<string>` to `Promise.t<string>`.

### Added

- `FirebaseAdmin.App`: `getApp`, `deleteApp`.
- `FirebaseAdmin.Firestore`: `whereFilterOp`, `orderByDirection`, `setOptions`, `WriteResult`, `WriteBatch`, `Transaction` modules.
- `FirebaseAdmin.Firestore`: `doc`, `collectionGroup`, `batch`, `runTransaction` on `firestore` instance.
- `FirebaseAdmin.Firestore.Query`: `orderBy`, `limit`, `limitToLast`, `offset`, `startAt`, `startAfter`, `endBefore`, `endAt`, `select`, `onSnapshot`.
- `FirebaseAdmin.Firestore.DocumentReference`: `path`, `set`, `setWithOptions`, `create`, `delete`, `collection`, `onSnapshot`.
- `FirebaseAdmin.Firestore.CollectionReference`: `id`, `path`.
- `FirebaseAdmin.Firestore.QueryDocumentSnapshot`: `id`.
- `FirebaseAdmin.Firestore.QuerySnapshot`: `readTime`.
- `FirebaseAdmin.Firestore.DocumentSnapshot`: `readTime`.
- `FirebaseAdmin.Firestore.FieldValue`: `serverTimestamp`, `increment`, `arrayUnion`, `arrayRemove`.
- `FirebaseAdmin.Firestore.Timestamp`: `fromMillis`, `seconds`, `nanoseconds`.
- `FirebaseAdmin.Auth`: `updateRequest`, `decodedIdToken`, `deleteUsersResult` types.
- `FirebaseAdmin.Auth`: `getUser`, `getUserByPhoneNumber`, `updateUser`, `deleteUser`, `deleteUsers`, `verifyIdToken`, `createCustomToken`, `revokeRefreshTokens`.
- `FirebaseAdmin.Storage`: `bucketDefault`, `fileName`, `save`, `deleteFile`, `exists`, `getMetadata`, `setMetadata`.

## [0.5.0] - 2026-02-17

### Added

- Added `Firebase.Storage.listResult`, `Firebase.Storage.listOptions`, `Firebase.Storage.taskState` types.
- Added `Firebase.Storage.UploadTask` module with `snapshot` type, `cancel`, `pause`, `resume`, `on`, `then`.
- Added `Firebase.Storage` functions: `uploadBytes`, `uploadBytesResumable`, `getBlob`, `getBytes`, `getStream`, `getMetadata`, `updateMetadata`, `list`, `listAll`.

### Changed

- `Firebase.Storage.uploadResult` now includes `metadata` field.

## [0.4.0] - 2026-02-17

### Added

- Added `ReactFirehooks.Firestore` bindings: `useDocument`, `useDocumentData`, `useDocumentOnce`, `useDocumentDataOnce`, `useQueryOnce`, `useQueryDataOnce`, `useQueriesData`, `useQueriesOnce`, `useQueriesDataOnce`.
- Added `ReactFirehooks.Storage` module with bindings: `useDownloadURL`, `useMetadata`, `useBlob`, `useBytes`.
- Added `Firebase.firebaseError` base record type.
- Added `Firebase.Storage.storageErrorCode` variant and `Firebase.Storage.storageError` type (spreads `firebaseError`).
- Added `Firebase.Storage.fullMetadata` type.
- Added `Firebase.Auth.authError` type (spreads `firebaseError`).

### Changed

- `Firebase.Firestore.firestoreError` now spreads `firebaseError` (adds `name` field).

### Fixed

- Fixed `ReactFirehooks.Auth.useAuthState` error type from `firestoreError` to `authError`.

## [0.3.0] - 2026-02-16

### Added

- Added `Storage` module with bindings for `firebase/storage`: `getStorage`, `ref`, `uploadString`, `getDownloadURL`, `deleteObject`, and `connectStorageEmulator`.

## [0.2.1] - 2026-02-16

### Changed

- Widened `firebase` peer dependency to `>=11.0.0 <13`.

## [0.2.0] - 2026-02-16

### Changed

- Updated bindings for Firebase JS SDK v12.9.
- Fixed `Auth.config` type to use the actual Firebase `Config` interface instead of reusing `FirebaseOptions`.
- Fixed `User.displayName` and `User.email` to be `Null.t<string>` (nullable).
- Fixed `DocumentSnapshot.data` return type from `Nullable.t` to `option` (returns `undefined`, not `null`).

### Added

- Added missing `WhereFilterOp` variants: `ArrayContains`, `In`, `ArrayContainsAny`, `NotIn`.

## [0.1.6] - 2025-11-27

### Changed

- Bump to ReScript 12 stable.

## [0.1.5] - 2025-11-19

### Changed

- Bump to ReScript 12 rc.

## [0.1.4] - 2025-09-24

### Added

- `@editor.completeFrom` to Firebase and FirebaseAdmin types.

## [0.1.3] - 2025-09-18

### Fixed

- Correct `"type": "dev"` in rescript.json

## [0.1.2] - 2025-09-18

### Fixed

- Add missing rescript.json to package.

## [0.1.1] - 2025-09-18

### Fixed

- Add missing fields to package.json

## [0.1.0] - 2025-09-18

### Added

- First release
