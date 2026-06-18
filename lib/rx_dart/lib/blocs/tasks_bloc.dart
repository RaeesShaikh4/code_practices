// ============================================================
//  File 3 of 6 — lib/blocs/task_bloc.dart
//  RxDart concepts used:
//    PublishSubject  — fire-and-forget events (no cache needed)
//    BehaviorSubject — stateful values (search query, filter)
//    combineLatest3  — merge 3 streams into 1 output
//    debounceTime    — wait for typing to pause before searching
//    switchMap       — cancel stale work, only latest matters
//    map             — transform stream values
//    distinct        — skip emissions when value didn't change
// ============================================================

import 'package:inetrview_code_practices/rx_dart/lib/repository/task_repository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/task_model.dart';


// ── Output data class ──────────────────────────────────────
// combineLatest3 produces one of these every time any of the
// three input streams (tasks, search, filter) changes.

class TaskViewState {
  final List<Task> filteredTasks;
  final int totalCount;
  final int doneCount;
  final int pendingCount;
  final double completionPercentage;

  const TaskViewState({
    required this.filteredTasks,
    required this.totalCount,
    required this.doneCount,
    required this.pendingCount,
    required this.completionPercentage,
  });
}

class TaskBloc {
  final TaskRepository _repo;
  TaskBloc(this._repo){
    _init();
  }

   // ── INPUTS (Sinks) ─────────────────────────────────────────
  // These are PublishSubject because they are pure events —
  // "add a task", "delete a task". We don't need to cache the
  // last event. New subscribers don't need to know what the
  // last button press was.
  final _addTaskController = PublishSubject<Task>();
  final _deleteTaskController = PublishSubject<String>();
  final _toggleDoneController = PublishSubject<String>();
  final _updateTaskController = PublishSubject<Task>();
  final _undoController = PublishSubject<void>();

   // ── STATEFUL INPUTS ────────────────────────────────────────
  // These ARE BehaviorSubject because they hold current STATE,
  // not just events. If a widget rebuilds, it should get the
  // current search query immediately — not wait for next type.
}
