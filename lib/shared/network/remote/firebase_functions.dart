import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/models/task_model.dart';

class FirebaseFunctions {
  static CollectionReference<TaskModel> getTaskCollection() {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<TaskModel>(fromFirestore: (snapshot, _) {
      return TaskModel.fromJSON(snapshot.data()!);
    }, toFirestore: (task, _) {
      return task.toJSON();
    });
  }

  static Future<void> addTask(TaskModel task) {
    var collection = getTaskCollection();
    var docRef = collection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Stream<QuerySnapshot<TaskModel>> getTasks(int date) {
    return getTaskCollection()
        .where("date", isEqualTo: date)
        .snapshots(); // real-time read
    //return getTaskCollection().where("date",isEqualTo: date).get(); //one-time read
  }

  static Future<void> deleteTask(String id) {
    return getTaskCollection().doc(id).delete();
  }

  static Future<void> updateTask(TaskModel task) {
    print("object id: ${task.id}");
    return getTaskCollection().doc(task.id).update(task.toJSON());
  }
}
