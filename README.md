![NPM Version](https://img.shields.io/npm/v/%40nojaf%2Frescript-firebase)

# ReScript Firebase

Firebase bindings for

- https://www.npmjs.com/package/firebase (v10+)
- https://www.npmjs.com/package/firebase-functions (v6+)
- https://www.npmjs.com/package/firebase-admin (v12+)
- https://www.npmjs.com/package/react-firehooks (v4+)

## Installation

This project is not complete so I do accept contributions if you've used something in your project which is currently missing.

If you like, you can install all bindings via

```bash
bun install @nojaf/rescript-firebase
```

Include them in your `rescript.json`:

```json
{
  "dependencies": ["rescript-firebase"]
}
```

## Sample

Create a new Firebase project in the [console](https://console.firebase.google.com).
Register your web app and copy over the firebaseConfig in `Sample.res`.
Make the default Cloud Firestore instance.
