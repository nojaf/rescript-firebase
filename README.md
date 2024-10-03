# ReScript Firebase

Firebase bindings for 

- https://www.npmjs.com/package/firebase (v10+)
- https://www.npmjs.com/package/firebase-functions (v6+)
- https://www.npmjs.com/package/firebase-admin (v12+)
- https://www.npmjs.com/package/react-firehooks (v4+)

## Installation

This project is not complete so I would recommend to just copy the `src/Firebase.res` bindings into your own project and take it from there. I do accept contributions if you've used something in your project which is currently missing.

If you like, you can install all bindings via

```bash
bun install -D git+https://github.com/nojaf/rescript-firebase.git#5a3a80e670cfe6c8fbada6e51a8660b0d8dbcdaf
```

Include them in your `rescript.json`:

```json
{
  "bs-dependencies": ["@rescript/core", "rescript-firebase"]
}
```

## Sample

Create a new Firebase project in the [console](https://console.firebase.google.com).
Register your web app and copy over the firebaseConfig in `Sample.res`.
Make the default Cloud Firestore instance.

