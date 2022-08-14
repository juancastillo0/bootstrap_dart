import 'package:bootstrap_dart/bootstrap/bootstrap.dart';
import 'package:bootstrap_dart/bootstrap/form.dart';
import 'package:bootstrap_dart/bootstrap/icons.dart';
import 'package:bootstrap_dart/bootstrap/typography.dart';
import 'package:deact_bootstrap/hooks.dart';
import 'package:bootstrap_dart_example/duration_input.dart';
import 'package:bootstrap_dart_example/int_input.dart';
import 'package:bootstrap_dart_example/todo_store.dart';
import 'package:bootstrap_dart_example/todo_view.dart';
import 'package:deact/deact.dart';
import 'package:deact/deact_html52.dart';
import 'package:universal_html/html.dart' as html;

class CreateTodoForm extends ComponentNode {
  const CreateTodoForm({Object? key}) : super(key: key);

  @override
  DeactNode render(ComponentContext ctx) {
    final todo = ctx.scoped(TodoData.scoped);

    return div(
      className: 'row ${BText.start}',
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
            oninput: (e) =>
                todo.title.value = (e.target as html.InputElement).value!,
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
          className: 'col-md-6 py-2',
          children: const [TodoTagsInput()],
        ),
        div(
          className: 'col-sm-6 col-md-5 py-2',
          children: [
            DurationInput(
              duration: todo.duration.value ?? const Duration(),
              onChanged: (dur) => todo.duration.value = dur,
            ),
          ],
        ),
        div(
          className: 'col-sm-6 col-md-4 py-2',
          children: [
            fc(
              (ctx) => IntInput(
                value: todo.importance.value,
                onChanged: (v) => todo.importance.value = v,
                minimum: 1,
                maximum: 10,
                label: label(
                  forId: 'todo-importance-${todo.id}',
                  children: [txt('Importance')],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TodoTagsInput extends ComponentNode {
  const TodoTagsInput({Object? key}) : super(key: key);

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
