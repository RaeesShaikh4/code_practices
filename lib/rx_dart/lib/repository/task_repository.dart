import 'package:rxdart/rxdart.dart';

import '../models/task_model.dart';

class TaskRepository {
   // ── BehaviorSubject ────────────────────────────────────────
  // Think of this as a "reactive variable".
  // It holds the CURRENT list of all tasks AND broadcasts
  // every change to anyone listening.
  //
  // .seeded([]) means the starting value is an empty list.
  // Any new subscriber immediately gets that current list —
  // they don't have to wait for the next add() call.
  //
  // Private (_) because outsiders should use the stream getter,
  // not push directly into the subject.
  final _tasks = BehaviorSubject<List<Task>>.seeded([]);

  // ── ReplaySubject ──────────────────────────────────────────
  // Stores the last 10 snapshots of the task list.
  // New subscribers get all 10 replayed instantly.
  // We use this for UNDO — when the user undoes, we grab the
  // previous snapshot from this history buffer.
  final _history = ReplaySubject<List<Task>>(maxSize: 10);

   // ── Public stream (read-only) ──────────────────────────────
  // Widgets and the BLoC listen to this.
  // Exposing .stream instead of the subject itself means
  // nobody outside can call .add() and corrupt the state.
  Stream<List<Task>> get tasks$ => _tasks.stream;

  // Quick synchronous read — useful when you need the current
  // value without subscribing to the stream.
  List<Task> get currentTasks => _tasks.value;

  // Add Task -----------------------
  void addTask(Task task) {
   // 1. Save current state to history BEFORE changing it
   _history.add(List.from(_tasks.value));

    // 2. Create a new list with the task appended.
    //    Never mutate _tasks.value directly — always create
    //    a fresh list so listeners see a genuine new emission.
    _tasks.add([..._tasks.value, task]);
  }

  //Toggle Done-----------------------
  void toggleDone(String id) {
    _history.add(List.from(_tasks.value));

     // Map over every task. If the id matches, flip isDone using copyWith (model). All other tasks unchanged.
     final updated = _tasks.value.map((task) {
      return task.id == id ? task.copyWith(isDone: !task.isDone) : task;
     }).toList();

     _tasks.add(updated);
  }

  //Delete Task-----------------------
  void deleteTask(String id){
    _history.add(List.from(_tasks.value));
    _tasks.add(_tasks.value.where((t) => t.id != id).toList());
  }


 //Update Task------------------------
  void updateTask(Task updatedTask){
    _history.add(List.from(_tasks.value));
    _tasks.add(_tasks.value.map((t) => t.id == updatedTask.id ? updatedTask : t).toList());
  }

  // ── Undo ─────────────────────────────────────────────────
  // ReplaySubject keeps the last 10 snapshots. We take the most recent one and restore it.
  void undo() {
    _history.stream.bufferCount(10).first.then((snapshots) {
      if (snapshots.isEmpty) return;
      final previous = snapshots.last;  
      _tasks.add(previous);
    });
  }

  //Dispose----------------------------------
  // ALWAYS close subjects when done.
  // Forgetting this = memory leak.
  // Called from main.dart when the app closes.
  void dispose() {
    _tasks.close();
    _history.close();
  }
}