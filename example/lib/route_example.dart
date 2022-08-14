import 'dart:async';

import 'package:bootstrap_dart/bootstrap/bootstrap.dart';
import 'package:bootstrap_dart/bootstrap/navbar.dart';
import 'package:bootstrap_dart/bootstrap/typography.dart';
import 'package:bootstrap_dart_example/cacho/cacho_view.dart';
import 'package:bootstrap_dart_example/continental/continental_view.dart';
import 'package:bootstrap_dart_example/todo_store.dart';
import 'package:bootstrap_dart_example/todo_view.dart';
import 'package:deact/deact.dart';
import 'package:deact_bootstrap/deact_bootstrap.dart';
import 'package:deact_bootstrap/router.dart';
import 'package:deact/deact_html52.dart';

DRouter appRouter() {
  DeactBootstrapRenderer.setUp();
  return DRouter(
    routes: allRoutes(),
    fallback: notFound(),
    wrapper: appBarWrapper,
  );
}

List<Route> allRoutes() {
  return [
    HomeRoute.instance,
    AboutRoute.instance,
    TodosRoute.instance,
    TodoRoute.instance,
    CachoRoute.instance,
    ContinentalRoute.instance,
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

DeactNode appBarWrapper(RenderedRoute rendered) {
  return div(
    style: colStyle(),
    children: [
      navbar(
        expand: ResponsiveBreakPoint.always,
        background: BColor.light,
        collapseId: 'app-nav-bar',
        brand: [txt('Tasks')],
        attributes: {'style': 'width:100%;'},
        position: NavbarPosition.sticky_top,
        itemList: [
          fc((ctx) {
            final route = useSelectedRoute(ctx);
            print(
              'ctx.hashCode ${ctx.hashCode} route ${route.hashCode}'
              ' router ${ctx.scoped(DRouter.scope).hashCode}',
            );

            print(route.route?.path);

            ctx.hookEffect(
              () => () => print('DISPOSED ${ctx.hashCode}'),
              const [],
            );
            return div(
              className: 'navbar-nav me-auto',
              children: [
                ...const [
                  '/',
                  '/todos',
                  '/cacho',
                  '/continental',
                  '/about',
                ].map(
                  (e) {
                    final isActive = route.route?.path == e;

                    return el(
                      'a',
                      attributes: {
                        'class': 'nav-link${isActive ? ' active' : ''}',
                        'href': e,
                        if (isActive) 'aria-current': 'page',
                      },
                      children: [
                        txt(
                          e == '/'
                              ? 'Home'
                              : '${e.substring(1, 2).toUpperCase()}${e.substring(2)}',
                        )
                      ],
                    );
                  },
                ),
              ],
            );
          })
        ],
      ),
      // form(
      //   className: 'd-flex',
      //   children: [
      //     input(
      //       className: 'form-control me-2',
      //       type: 'search',
      //       placeholder: 'Search',
      //     ),
      //     button(
      //       className: btn(),
      //       type: 'submit',
      //       children: [txt('Search')],
      //     )
      //   ],
      // ),
      //   ],
      // ),
      div(
        style: 'flex:1;width:100%;',
        children: [
          rendered.node,
        ],
      )
    ],
  );
}

class HomeRoute extends StaticRoute {
  const HomeRoute._() : super('/');
  static HomeRoute get instance => const HomeRoute._();

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
  const AboutRoute._() : super('/about');
  static AboutRoute get instance => const AboutRoute._();

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
  const TodosRoute._();
  static TodosRoute get instance => const TodosRoute._();

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
        const CreateTodoSection(),
        h3(
          className: 'mb-3 mt-4',
          children: [txt('Todos')],
        ),
        const TodoList(),
      ],
    );
  }
}

class TodoRoute extends Route<String, TodoData?> {
  const TodoRoute._();
  static TodoRoute get instance => const TodoRoute._();

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
