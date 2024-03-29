import 'package:universal_html/html.dart' as html;

import 'package:deact/deact.dart';
import 'package:deact/deact_html52.dart';

import 'package:bootstrap_dart/bootstrap/bootstrap_core.dart';
import 'package:bootstrap_dart/bootstrap/modal.dart';
import 'store.dart';

DeactNode mainView() {
  return globalRef(
    name: 'RootValue',
    initialValue: RootStore(),
    children: [
      globalState<int>(
        name: 'counter',
        initialValue: 0,
        children: [
          div(
            className: 'd-flex ',
            style: 'overflow:hidden;height: 100%;',
            children: [
              fc((ctx) {
                return col(
                  style: 'overflow:auto;flex:1;',
                  children: [
                    tabs(),
                    incrementor(),
                    display(),
                    textInput(),
                    div(children: [
                      fc((ctx) {
                        final tab = RootStore.fromCtx(ctx).tab.value;
                        switch (tab) {
                          case Tab.profile:
                            return txt('Profile');
                          case Tab.message:
                            return messagesView();
                        }
                      }),
                    ]),
                  ],
                );
              }),
            ],
          ),
        ],
      ),
    ],
  );
}

DeactNode messagesView() {
  return fc((ctx) {
    // final counter = ctx.globalState<int>('counter');
    final root = RootStore.fromCtx(ctx);
    return col(
      children: [
        div(
          style: 'flex:1;',
          children: [
            fc((ctx) {
              final messages = root.messageStore.messages;
              return fragment([...messages.map(messageView)]);
            })
          ],
        ),
        div(
          style: 'display:flex;',
          children: [
            fc(
              (ctx) => textInputWrap(
                root.messageStore.message.value,
                (value) => root.messageStore.message.value = value,
              ),
            ),
            button(
              onclick: (_) => root.messageStore.sendMessage(),
              children: [
                txt('Send'),
              ],
            ),
          ],
        ),
      ],
    );
  });
}

DeactNode messageView(Message m) {
  return div(
    key: m.createdAt.toIso8601String(),
    style: 'position:relative;',
    children: [
      fc((ctx) {
        final show = ctx.state('show', false);
        return fragment([
          div(
            style: show.value
                ? 'position:absolute;top:0;right:0;'
                : 'display:none;',
            children: [
              button(
                onclick: (_) => MessageStore.fromCtx(ctx).messages.remove(m),
                children: [txt('Delete')],
              )
            ],
          ),
          div(
            className: 'message',
            onclick: (_) {
              show.value = !show.value;
            },
            children: [
              span(children: [txt(m.content)]),
              span(
                style: 'font-size:10px;padding-left:10px;white-space: pre;',
                children: [
                  txt(
                    m.createdAt.toIso8601String().replaceFirst('T', '\n'),
                  ),
                ],
              ),
            ],
          )
        ]);
      })
    ],
  );
}

DeactNode col({
  Ref<html.Element?>? ref,
  required Iterable<DeactNode> children,
  String? style,
  Map<String, Object> attributes = const {},
}) {
  return el(
    'div',
    ref: ref,
    attributes: {
      'style':
          'display:flex;flex-direction: column;align-items: center;position:relative;'
              '${style ?? ''}',
      ...attributes,
    },
    children: children,
  );
}

DeactNode divfc(
  DeactNode Function(ComponentContext) builder, {
  Object? key,
  String? style,
  String? className,
}) {
  return div(
    key: key,
    style: style,
    className: className,
    children: [fc(builder)],
  );
}

DeactNode tabs() {
  return divfc((ctx) {
    final root = RootStore.fromCtx(ctx);
    return fragment([
      ...Tab.values.map((tab) {
        final selected = root.tab.value == tab;
        return button(
          onclick: (_) => root.tab.value = tab,
          disabled: selected ? '' : null,
          children: [txt(tab.name)],
        );
      })
    ]);
  }, style: 'display:flex;');
}

DeactNode incrementor() {
  return fc((ctx) {
    // final counter = ctx.globalState<int>('counter');
    final root = RootStore.fromCtx(ctx);
    final showModal = ctx.state('modal', false);
    return div(
      children: [
        button(
          // onclick: (_) => counter.set((c) => c + 1),
          onclick: (_) => root.increment(),
          className: btn(size: BSize.sm),
          children: [
            txt('Click me to increment to counter'),
          ],
        ),
        button(
          onclick: (_) => showModal.value = !showModal.value,
          className:
              btn(size: BSize.sm, outlined: true, color: BColor.secondary),
          children: [txt('Show Modal')],
        ),
        if (showModal.value)
          modal(
            id: 'modal-id',
            dialog: modalDialog(
              dialogClass: modalDialogClass(),
              body: [txt('Body')],
              header: [txt('Header')],
              footer: [txt('Footer')],
            ),
          )
      ],
    );
  });
}

DeactNode display() {
  return divfc((ctx) {
    print('ded');
    final root = RootStore.fromCtx(ctx);
    // final counter = ctx.globalState<int>('counter');
    return txt('Counter: ${root.count}');
  });
}

DeactNode counter() {
  return fc((ctx) {
    // as an alternative, it is possible to make a
    // state of a component global to its children
    // by setting the global parameter to true.
    ctx.state<int>('counter', 0, global: true);
    return fragment([
      incrementor(),
      display(),
    ]);
  });
}

DeactNode textInput() {
  return div(
    style: 'display:flex;',
    children: [
      txt('Title'),
      span(style: 'width:10px;'),
      fc((ctx) {
        final value = ctx.state<String>('text', 'aa');
        print('text "${value.value}"');

        return input(
          oninput: (e) => value.value = (e.target as html.InputElement).value!,
          value: value.value,
        );
      })
    ],
  );
}

DeactNode textInputWrap(String text, void Function(String) onChange) {
  return div(
    style: 'display:flex;',
    children: [
      // txt('Title'),
      // span(style: 'width:10px;'),
      fc((ctx) {
        final inputRef = ctx.hookRef<html.Element?>(() => null);
        html.InputElement? elem() => inputRef.value as html.InputElement?;

        ctx.hookEffect(() {
          final _elem = elem();
          if (_elem != null && _elem.value != text) {
            _elem.value = text;
          }
        });
        return input(
          oninput: (e) => onChange(elem()!.value!),
          value: text.isEmpty ? null : text,
          ref: inputRef,
        );
      }),
    ],
  );
}
