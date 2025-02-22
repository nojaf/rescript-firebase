open Firebase
open Firebase.Firestore

@scope("process.env")
external apiKey: string = "APIKEY"

@scope("process.env")
external appId: string = "APPID"

@scope("process.env")
external projectId: string = "PROJECTID"

let firebaseConfig = {
  apiKey,
  authDomain: "",
  projectId,
  storageBucket: "rescript-sample.appspot.com",
  messagingSenderId: "",
  appId,
}

// Initialize Firebase
let app = App.initializeApp(firebaseConfig)

// Create a store
let store = getFirestore(app)

type todo = {
  description: string,
  completed: bool,
}

let todoCollectionName = "todos"

let todoCollection = collection(store, [todoCollectionName])

let x = todoCollection->Firestore.query([])->Firestore.getDocs

// Create a new table entry
let r = store->Firestore.doc(todoCollectionName, [])
let es = store->Firestore.doc("", [])

addDoc(
  todoCollection,
  {
    description: "Initial todo",
    completed: false,
  },
)
->Promise.thenResolve((ref: Firestore.documentReference<todo>) => {
  let _ = ref
  // ref.
  //     ^com
  Console.log(`Created ${ref.id} at ${ref.path}`)
})
->Promise.done

// Query all todos, the empty array represents no query constraints
let allTodosQuery = query(todoCollection, [])

getDocs(allTodosQuery)
->Promise.thenResolve(querySnapshot => {
  // The query snapshot contains the found todos, all these documents are guanteed to exist.
  Console.log(`Found ${Int.toString(querySnapshot.size)} todos`)

  querySnapshot.docs->Array.forEach(queryDocumentSnapshot => {
    let todo = queryDocumentSnapshot->data_qds
    Console.log2(queryDocumentSnapshot.id, todo)
  })
})
->Promise.done

// Create a todo with specific id
@scope("crypto")
external uuid: unit => string = "randomUUID"

/// Create the reference first
let specificTodoRef = doc(store, todoCollectionName, [`todo-${uuid()}`])

setDoc(
  specificTodoRef,
  {
    description: "specific todo",
    completed: false,
  },
)
->Promise.then(() => {
  Console.log(`Created specific todo ${specificTodoRef.id}`)
  // Update a single field in a document
  updateFieldInDoc(specificTodoRef, "completed", true)
})
->Promise.thenResolve(() => {
  Console.log(`Completed ${specificTodoRef.id}`)
  ()
})
->Promise.done

// Query 1 todo via the limit constraint
query(todoCollection, [limit(1)])
->Firestore.getDocs
->Promise.then(querySnapshot => {
  switch querySnapshot.docs->Array.get(0) {
  | None => Promise.resolve()
  | Some(qds) =>
    // Delete the first document via the reference, assuming the query had results
    deleteDoc(qds.ref)
  }
})
->Promise.thenResolve(() => Console.log("Removed a todo"))
->Promise.done
