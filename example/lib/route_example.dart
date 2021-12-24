import 'dart:async';

import 'package:bootstrap_dart/bootstrap/bootstrap_core.dart';
import 'package:bootstrap_dart/bootstrap/checks_radios.dart';
import 'package:bootstrap_dart/bootstrap/form.dart';
import 'package:bootstrap_dart/bootstrap/icons.dart';
import 'package:bootstrap_dart/bootstrap/offcanvas.dart';
import 'package:bootstrap_dart/bootstrap/typography.dart';
import 'package:bootstrap_dart/hooks.dart';
import 'package:deact/deact.dart';
import 'package:bootstrap_dart/router.dart';
import 'package:deact/deact_html52.dart';
import 'package:nanoid/nanoid.dart' show customAlphabet;
import 'package:universal_html/html.dart' as html;
import 'package:mobx/mobx.dart';

const _urlAlphabet =
    'ModuleSymbhasOwnPr0123456789ABCDEFGHNRVfgctiUvzKqYTJkLxpZXIjQW';

String customId() => customAlphabet(_urlAlphabet, 22);

DRouter appRouter() => DRouter(routes: allRoutes(), fallback: notFound());

List<Route> allRoutes() {
  return [
    HomeRoute(),
    AboutRoute(),
    TodosRoute(),
    TodoRoute(),
  ];
}

DeactNode notFound() {
  return div(
    style: flexCenter(),
    children: [
      h3(children: [txt('404: Not found')]),
      routeList(),
    ],
  );
}

DeactNode routeList() {
  return ul(
    className: 'm-5',
    children: [
      li(children: [
        a(
          href: '/',
          children: [txt('/')],
        )
      ]),
      li(children: [
        a(
          href: '/todos',
          children: [txt('/todos')],
        )
      ]),
      li(children: [
        a(
          href: '/about',
          children: [txt('/about')],
        )
      ]),
    ],
  );
}

class HomeRoute extends StaticRoute {
  const HomeRoute() : super('/');

  @override
  DeactNode render(RouteParams value) {
    return div(
      children: [
        h3(children: [txt('Home')]),
        p(
          className: 'p-5',
          children: [txt('''Welcome''')],
        ),
        routeList(),
      ],
    );
  }
}

class AboutRoute extends StaticRoute {
  const AboutRoute() : super('/about');

  @override
  DeactNode render(RouteParams value) {
    return div(
      children: [
        h3(children: [txt('About')]),
        p(className: 'p-5', children: [
          txt('''Eos reprehenderit pariatur. Quia et illo illum. Excepturi quibusdam placeat non autem sed quo. Neque totam aut quas possimus et. Deserunt minima voluptas recusandae quod ut.
 
Fugit suscipit a voluptate ipsam. Perspiciatis eligendi consequuntur qui temporibus. Odit dolores aut dicta.
 
Maiores ut id. Fugit culpa necessitatibus temporibus error magnam. Enim aut nostrum ratione at corporis qui fugit. Quaerat eos voluptate id.'''),
        ])
      ],
    );
  }
}

final todosData = TodosData();

class TodosParams {
  final bool? create;

  TodosParams({required this.create});
}

class TodosParamsParser implements ReqParser<TodosParams> {
  const TodosParamsParser();
  @override
  TodosParams fromReq(Uri uri, RouteReq? req) {
    final create = uri.queryParameters['create'];
    return TodosParams(
      create: create == 'true' || create == 'false' ? create == 'true' : null,
    );
  }

  @override
  PartialUri toUri(TodosParams value) {
    return PartialUri([], {
      if (value.create != null) 'create': value.create!.toString(),
    });
  }
}

class TodosRoute extends Route<TodosParams, TodosData> {
  const TodosRoute();

  @override
  String get path => '/todos';
  @override
  ReqParser<TodosParams> get parser => const TodosParamsParser();
  @override
  FutureOr<TodosData> load(BaseRouteParams<TodosParams> input) {
    if (input.param.create != null) {
      todosData.showCreate.value = input.param.create!;
    }
    return todosData;
  }

  @override
  DeactNode render(RouteParams<TodosParams, TodosData> value) {
    final todos = value.data!;
    value.ctx.setUpScoped(TodosData.scoped, todos);
    return div(
      className: 'container',
      style: colStyle(),
      children: [
        CreateTodoTags(),
        h3(
          className: 'mb-3 mt-4',
          children: [txt('Todos')],
        ),
        div(
          className: stackClass(gap: Space.s1, vert: false),
          style: flexStyle(main: AxisAlign.center, wrap: FlexWrap.wrap),
          children: [
            check(
              checked: todos.filterDone.value,
              onChange: (v) => todos.filterDone.value = v,
              label: txt('Hide Done'),
              id: 'filter-done',
              inline: true,
              divClass: ' m-0',
            ),
            div(
              className: 'mx-2',
              style: 'overflow-x:auto;max-width:300px;',
              children: [
                tagsList(
                  todos.filterTags,
                  todos.filterTags.remove,
                  onEmpty: txt('Filter Tags:'),
                ),
                tagsList(
                  todos.tags.difference(todos.filterTags),
                  todos.filterTags.add,
                  color: BColor.secondary,
                ),
              ],
            ),
            button(
              className: btn(outlined: true),
              type: 'button',
              disabled: todos.isFiltered.value ? null : '',
              onclick: (_) {
                todos.clearFilter();
              },
              children: [
                icon(BIcon.filter),
                el(
                  'span',
                  attributes: {'style': 'padding-left:10px;'},
                  children: [txt('Clear Filter')],
                ),
              ],
            ),
          ],
        ),
        if (todos.filtered.value.isEmpty)
          div(
            className: 'm-3',
            children: [txt('No todos found')],
          ),
        ...todos.filtered.value.map(
          (e) => card(
            key: e.id,
            id: e.id,
            cardClasses: 'm-2',
            cardStyle: 'width:100%;',
            title: span(
              className: e.done.value ? BTypography.s : null,
              children: [txt(e.title.value)],
            ),
            content: div(
              children: [
                div(children: [txt(e.id)]),
                div(
                  className: BTypography.textMuted,
                  style: 'font-size:0.7em;',
                  children: [txt(e.createdAt.toString())],
                ),
                tagsList(
                  e.tags,
                  (_) {},
                ),
              ],
            ),
            footer: div(
              style: flexStyle(main: AxisAlign.space_between),
              children: [
                a(
                  href: '/todos/${e.id}',
                  children: [txt('view detail')],
                ),
                check(
                  checked: e.done.value,
                  onChange: (v) => e.done.value = v,
                  label: txt('Done'),
                  id: '${e.id}-done',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CreateTodoTags extends ComponentNode {
  CreateTodoTags({Object? key}) : super(key: key);

  @override
  DeactNode render(ComponentContext ctx) {
    final todos = ctx.scoped(TodosData.scoped);

    return form(
      className:
          '${BText.start} p-3 ${roundedClass(size: RoundedSize.s2)} ${borderClass()}',
      style: colStyle(cross: AxisAlign.stretch) + 'width:100%;',
      children: [
        div(
          style: flexStyle(main: AxisAlign.space_between),
          children: [
            h3(
              className: 'me-auto mb-0',
              children: [txt('Create Todo')],
            ),
            button(
              className: btn(outlined: true),
              type: 'button',
              onclick: (_) {
                todos.showCreate.value = !todos.showCreate.value;
              },
              children: [
                icon(BIcon.caret_down_fill),
                el(
                  'span',
                  attributes: {'style': 'padding-left:10px;'},
                  children: [txt('Collapse')],
                ),
              ],
            ),
          ],
        ),
        div(
          id: 'collapse-create',
          className: collapse(show: todos.showCreate.value) +
              ' mt-3 ${borderClass(sides: {OffcanvasPlacement.top})}',
          children: [
            fc((ctx) {
              final todoState = ctx.hookState(
                () => TodoData(
                  title: '',
                  id: customId(),
                ),
              );
              final todo = todoState.value;
              ctx.setUpScoped(TodoData.scoped, todo);

              return fragment([
                div(
                  className: 'row',
                  children: [
                    labeledInput(
                      label: txt('Title'),
                      id: 'todo-title',
                      divClass: 'col-md-4 py-2',
                      input: input(
                        value: todo.title.value,
                        className: formControlClass(),
                        type: 'text',
                        placeholder: '',
                        id: 'todo-title',
                        required: '',
                        oninput: (e) => todo.title.value =
                            (e.target as html.InputElement).value!,
                      ),
                    ),
                    labeledInput(
                      label: txt('Due Date'),
                      id: 'todo-duedate',
                      divClass: 'col-7 col-md-4 py-2',
                      input: input(
                        value: todo.dueDate.value?.toString().split(' ').first,
                        className: formControlClass(),
                        type: 'date',
                        id: 'todo-duedate',
                        oninput: (e) {
                          final date = (e.target as html.InputElement).value!;
                          todo.dueDate.value = DateTime.tryParse(date);
                        },
                      ),
                    ),
                    labeledInput(
                      label: txt('Color (${todo.color.value})'),
                      id: 'todo-color',
                      divClass: 'col-5 col-md-3 py-2',
                      input: input(
                        value: todo.color.value,
                        className: formControlClass(color: true),
                        type: 'color',
                        id: 'todo-color',
                        oninput: (e) {
                          final color = (e.target as html.InputElement).value!;
                          todo.color.value = color;
                        },
                      ),
                    ),
                    div(
                      className: 'col-md-7 py-2',
                      children: [TodoTags()],
                    )
                  ],
                ),
                div(
                  className: BText.end,
                  children: [
                    button(
                      className: btn() + ' align-self-end',
                      type: 'button',
                      onclick: (_) {
                        todos.todos.add(todo);
                        todoState.value = TodoData(title: '', id: customId());
                      },
                      children: [
                        icon(BIcon.plus_lg),
                        el(
                          'span',
                          attributes: {'style': 'padding-left:10px;'},
                          children: [txt('Add Todo')],
                        ),
                      ],
                    ),
                  ],
                )
              ]);
            }),
          ],
        ),
      ],
    );
  }
}

class TodoTags extends ComponentNode {
  TodoTags({Object? key}) : super(key: key);

  @override
  DeactNode render(ComponentContext ctx) {
    return div(
      style: colStyle(cross: AxisAlign.start),
      children: [
        fc((ctx) {
          final todo = ctx.scoped(TodoData.scoped);
          final tag = ctx.hookState(() => '');
          final todos = ctx.scoped(TodosData.scoped);
          final ref = ctx.hookRef<html.Element?>(() => null);

          final addTag = useCallback(
            ctx,
            () {
              todos.tags.add(tag.value);
              todo.tags.add(tag.value);
              tag.value = '';
              (ref.value as html.InputElement).value = '';
            },
            [todos, todo, tag],
          );

          return fragment([
            div(
              style: flexStyle(cross: AxisAlign.end, main: AxisAlign.start),
              children: [
                el(
                  'div',
                  attributes: {'style': 'flex:1;'},
                  children: [
                    labeledInput(
                      label: txt('Tags'),
                      id: 'todo-tag',
                      input: input(
                        ref: ref,
                        value: tag.value,
                        className: formControlClass(),
                        type: 'text',
                        placeholder: '',
                        id: 'todo-tag',
                        list: 'todo-tag-list',
                        onkeyup: (e) {
                          e.preventDefault();
                          if (e.keyCode == 13) addTag();
                        },
                        oninput: (e) =>
                            tag.value = (e.target as html.InputElement).value!,
                      ),
                    ),
                  ],
                ),
                datalist(
                  id: 'todo-tag-list',
                  children: [
                    ...todos.tags.map((t) => option(key: t, value: t))
                  ],
                ),
                button(
                  className: btn() + ' ms-2',
                  style: 'width:120px;',
                  type: 'button',
                  onclick: (_) {
                    addTag();
                  },
                  children: [
                    icon(BIcon.plus_lg),
                    el(
                      'span',
                      attributes: {'style': 'padding-left:10px;'},
                      children: [txt('Add Tag')],
                    ),
                  ],
                ),
              ],
            ),
            div(
              className: 'p-2',
              children: [
                tagsList(
                  todo.tags,
                  (e) => todo.tags.remove(e),
                ),
              ],
            )
          ]);
        })
      ],
    );
  }
}

DeactNode tagsList(
  Iterable<String> tags,
  void Function(String) onClick, {
  BColor color = BColor.primary,
  DeactNode? onEmpty,
}) {
  return div(
    className: 'flex-grow-1 mx-2',
    style: 'overflow-x:auto;',
    children: [
      if (tags.isEmpty) onEmpty ?? txt('No tags selected'),
      ...tags.map(
        (element) => button(
          key: element,
          type: 'button',
          onclick: (_) {
            onClick(element);
          },
          className: badge(color: color, rounded: true) + ' m-1 border-0',
          children: [txt(element)],
        ),
      )
    ],
  );
}

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

class TodoRoute extends Route<String, TodoData?> {
  const TodoRoute();

  @override
  String get path => '/todos/:id';
  @override
  ReqParser<String> get parser => const SingleIdParser();
  @override
  FutureOr<TodoData?> load(BaseRouteParams<String> input) {
    final index = todosData.todos.indexWhere((t) => t.id == input.param);
    return index == -1 ? null : todosData.todos[index];
  }

  @override
  DeactNode render(RouteParams<String, TodoData?> value) {
    if (!value.isLoaded) {
      return div(
        style: flexCenter(),
        children: [spinner()],
      );
    }
    final todo = value.data;
    return div(
      style: flexCenter(),
      children: [
        div(
          className: BTypography.display3 + ' m-5',
          children: [
            txt(todo == null ? 'Not Found' : todo.id),
          ],
        ),
        a(
          className: 'p-4',
          href: '/todos',
          children: [txt('All Todos')],
        ),
      ],
    );
  }
}

class TodoData {
  final String id;
  final Observable<String> title;

  final done = Observable(false);
  final category = Observable<String?>(null);
  final tags = ObservableList<String>();
  final dueDate = Observable<DateTime?>(null);
  final color = Observable<String>('#ffffff');

  final DateTime createdAt;

  static final scoped = Scoped<TodoData>((_) => throw Error());

  TodoData({
    required this.id,
    required String title,
  })  : title = Observable(title),
        createdAt = DateTime.now();
}
