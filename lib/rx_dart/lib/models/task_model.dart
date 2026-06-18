enum Priority { low, medium, high }

enum FlterType { all, active, completed }

class Task {
  final String id;
  final String title;
  final String? note;
  final bool isDone;
  final Priority priority;
  final DateTime createdAt;

  Task ({
    required this.id,
    required this.title,
    this.note,
    required this.isDone,
    required this.priority,
    required this.createdAt,
  });

  Task copyWith({
    String? title,
    String? note,
    bool? isDone,
    Priority? priority,
  }) {
    return Task(
      id: id,
      title: title ?? this.title,
      note: note ?? this.note,
      isDone: isDone ?? this.isDone,
      priority: priority ?? this.priority,
      createdAt: createdAt,
    );
  }
  // Two tasks are equal if their ids match.
  // Used by combineLatest and distinct() to detect real changes.

  @override
  bool operator ==(Object other) =>
      other is Task &&
      other.id == id &&
      other.title == title &&
      other.note == note &&
      other.isDone == isDone &&
      other.priority == priority;

  @override
  int get hashCode =>
      id.hashCode ^ title.hashCode ^ isDone.hashCode ^ priority.hashCode;
  
  @override
  String toString() => 
      'Task(id: $id, title: $title, note: $note, isDone: $isDone, priority: $priority, createdAt: $createdAt)';

}