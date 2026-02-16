# Changelog

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
