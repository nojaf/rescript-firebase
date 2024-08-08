// Generated by ReScript, PLEASE EDIT WITH CARE

import * as App from "firebase/app";
import * as Firestore from "firebase/firestore";

var firebaseConfig_apiKey = process.env.APIKEY;

var firebaseConfig_projectId = process.env.PROJECTID;

var firebaseConfig_appId = process.env.APPID;

var firebaseConfig = {
  apiKey: firebaseConfig_apiKey,
  authDomain: "",
  projectId: firebaseConfig_projectId,
  storageBucket: "rescript-sample.appspot.com",
  messagingSenderId: "",
  appId: firebaseConfig_appId
};

var app = App.initializeApp(firebaseConfig);

var store = Firestore.getFirestore(app);

var todoCollectionName = "todos";

var todoCollection = Firestore.collection(store, todoCollectionName);

Firestore.addDoc(todoCollection, {
        description: "Initial todo",
        completed: false
      }).then(function (ref) {
      console.log("Created " + ref.id + " at " + ref.path);
    });

var allTodosQuery = Firestore.query(todoCollection);

Firestore.getDocs(allTodosQuery).then(function (querySnapshot) {
      console.log("Found " + querySnapshot.size.toString() + " todos");
      querySnapshot.docs.forEach(function (queryDocumentSnapshot) {
            var todo = queryDocumentSnapshot.data();
            console.log(queryDocumentSnapshot.id, todo);
          });
    });

var specificTodoRef = Firestore.doc(store, todoCollectionName, "todo-" + crypto.randomUUID());

Firestore.setDoc(specificTodoRef, {
          description: "specific todo",
          completed: false
        }).then(function () {
        console.log("Created specific todo " + specificTodoRef.id);
        return Firestore.updateDoc(specificTodoRef, "completed", true);
      }).then(function () {
      console.log("Completed " + specificTodoRef.id);
    });

export {
  firebaseConfig ,
  app ,
  store ,
  todoCollectionName ,
  todoCollection ,
  allTodosQuery ,
  specificTodoRef ,
}
/* firebaseConfig Not a pure module */