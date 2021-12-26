import 'package:bootstrap_dart/bootstrap/bootstrap_core.dart';
import 'package:bootstrap_dart/bootstrap/checks_radios.dart';
import 'package:bootstrap_dart/bootstrap/icons.dart';
import 'package:bootstrap_dart/bootstrap/offcanvas.dart';
import 'package:bootstrap_dart/bootstrap/typography.dart';
import 'package:bootstrap_dart_example/todo_form.dart';
import 'package:bootstrap_dart_example/todo_store.dart';
import 'package:bootstrap_dart_example/utils.dart';
import 'package:deact/deact.dart';
import 'package:deact/deact_html52.dart';

class CreateTodoSection extends ComponentNode {
  CreateTodoSection({Object? key}) : super(key: key);

  @override
  DeactNode render(ComponentContext ctx) {
    final todos = ctx.scoped(TodosData.scoped);

    return form(
      className:
          '${BText.start} m-2 p-3 ${roundedClass(size: RoundedSize.s2)} ${borderClass()}',
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
                CreateTodoForm(),
                div(
                  className: BText.end,
                  children: [
                    button(
                      className: btn(),
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
                ),
              ]);
            }),
          ],
        ),
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

class TodoList extends ComponentNode {
  TodoList({Object? key}) : super(key: key);

  @override
  DeactNode render(ComponentContext ctx) {
    final todos = ctx.scoped(TodosData.scoped);

    return fragment([
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
    ]);
  }
}
