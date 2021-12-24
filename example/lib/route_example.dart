import 'dart:async';

import 'package:bootstrap_dart/bootstrap/bootstrap_core.dart';
import 'package:bootstrap_dart/bootstrap/typography.dart';
import 'package:bootstrap_dart_example/todo_store.dart';
import 'package:bootstrap_dart_example/todo_view.dart';
import 'package:deact/deact.dart';
import 'package:bootstrap_dart/router.dart';
import 'package:deact/deact_html52.dart';

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
        CreateTodoSection(),
        h3(
          className: 'mb-3 mt-4',
          children: [txt('Todos')],
        ),
        TodoList(),
      ],
    );
  }
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
