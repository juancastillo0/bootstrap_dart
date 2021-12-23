import 'dart:async';

import 'package:bootstrap_dart/bootstrap/bootstrap_core.dart';
import 'package:bootstrap_dart/bootstrap/typography.dart';
import 'package:deact/deact.dart';
import 'package:bootstrap_dart/router.dart';
import 'package:deact/deact_html52.dart';

DRouter appRouter() => DRouter(routes: allRoutes(), fallback: notFound());

List<Route> allRoutes() {
  return const [
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

class TodosRoute extends Route<void, TodosData> with NoParamRoute<TodosData> {
  const TodosRoute();

  @override
  String get path => '/todos';
  @override
  FutureOr<TodosData> load(BaseRouteParams<void> input) {
    print('$this $input');
    return todosData;
  }

  @override
  DeactNode render(RouteParams<void, TodosData> value) {
    final todos = value.data!;
    return div(
      children: [
        ...todos.todos.map(
          (e) => div(
            children: [
              div(
                className: BTypography.display5 + ' m-5',
                children: [txt(e.id)],
              ),
              a(
                className: 'p-4',
                href: '/todos/${e.id}',
                children: [txt('view detail')],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TodosData {
  final List<TodoData> todos = [
    TodoData(id: 'dawd'),
    TodoData(id: 'one-todo'),
  ];
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

  TodoData({
    required this.id,
  });
}
