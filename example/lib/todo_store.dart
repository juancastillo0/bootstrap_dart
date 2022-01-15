import 'package:deact/deact.dart';
import 'package:mobx/mobx.dart';

class TodosData {
  final todos = ObservableList.of([
    TodoData(id: 'dawd', title: 'Daw title')..tags.add('P1'),
    TodoData(id: 'one-todo', title: 'One'),
  ]);

  final tags = ObservableSet.of([
    'P1',
    'P2',
    'P3',
    'Job',
    'Relax',
  ]);

  final filterTags = ObservableSet<String>();
  final filterDone = Observable(false);
  final filterDueDate = Observable<DateTime?>(null);
  final showCreate = Observable(true);
  final showList = Observable(true);

  late final filtered = Computed(
    () => isFiltered.value
        ? todos
            .where((t) =>
                (!filterDone.value || !t.done.value) &&
                (filterTags.isEmpty || t.tags.any(filterTags.contains)))
            .toList()
        : todos,
  );

  late final isFiltered = Computed(
    () => filterDone.value || filterTags.isNotEmpty,
  );

  late final clearFilter = Action(() {
    filterDone.value = false;
    filterTags.clear();
  });

  static final scoped = Scoped<TodosData>((_) => throw Error());
}

class TodoData {
  final String id;
  final Observable<String> title;

  final done = Observable(false);
  final category = Observable<String?>(null);
  final tags = ObservableList<String>();
  final dueDate = Observable<DateTime?>(null);
  final color = Observable<String>('#ffffff');
  final duration = Observable<Duration?>(null);

  final importance = Observable<int>(1);
  final parentTodoId = Observable<String?>(null);

  final DateTime createdAt;

  static final scoped = Scoped<TodoData>((_) => throw Error());

  TodoData({
    required this.id,
    required String title,
  })  : title = Observable(title),
        createdAt = DateTime.now();
}
