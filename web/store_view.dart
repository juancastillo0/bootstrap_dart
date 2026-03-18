import 'package:bootstrap_dart/src/prelude.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' as web;

import 'package:bootstrap_dart/bootstrap/bootstrap_core.dart';
import 'package:bootstrap_dart/bootstrap/modal.dart';
import 'store.dart';
import 'global_ref.dart';

Component mainView() {
  return GlobalRef(
    value: RootStore(),
    child: divEl(
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
              div([
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
  );
}

Component messagesView() {
  return fc((ctx) {
    final root = RootStore.fromCtx(ctx);
    return col(
      children: [
        divEl(
          style: 'flex:1;',
          children: [
            fc((ctx) {
              final messages = root.messageStore.messages;
              return DeactNode.fragment([...messages.map(messageView)]);
            }),
          ],
        ),
        divEl(
          style: 'display:flex;',
          children: [
            fc(
              (ctx) => textInputWrap(
                root.messageStore.message.value,
                (value) => root.messageStore.message.value = value,
              ),
            ),
            button(onClick: () => root.messageStore.sendMessage(), [
              txt('Send'),
            ]),
          ],
        ),
      ],
    );
  });
}

Component messageView(Message m) {
  return div(
    key: Key(m.createdAt.toIso8601String()),
    styles: parseStyles('position:relative;'),
    [
      fc((ctx) {
        final show = ctx.hookState(() => false);
        return Component.fragment([
          divEl(
            style: show.value
                ? 'position:absolute;top:0;right:0;'
                : 'display:none;',
            children: [
              button(
                onClick: () => MessageStore.fromCtx(ctx).messages.remove(m),
                [txt('Delete')],
              ),
            ],
          ),
          divEl(
            className: 'message',
            onclick: (_) {
              show.value = !show.value;
            },
            children: [
              span([txt(m.content)]),
              span(
                styles: parseStyles(
                  'font-size:10px;padding-left:10px;white-space: pre;',
                ),
                [txt(m.createdAt.toIso8601String().replaceFirst('T', '\n'))],
              ),
            ],
          ),
        ]);
      }),
    ],
  );
}

Component col({
  Ref<web.Element?>? ref,
  required Iterable<Component> children,
  String? style,
  Map<String, String> attributes = const {},
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

Component divfc(
  Component Function(BootstrapBuildContext) builder, {
  Object? key,
  String? style,
  String? className,
}) {
  return divEl(
    key: key,
    style: style,
    className: className,
    children: [fc(builder)],
  );
}

Component tabs() {
  return divfc((ctx) {
    final root = RootStore.fromCtx(ctx);
    return Component.fragment([
      ...Tab.values.map((tab) {
        final selected = root.tab.value == tab;
        return button(onClick: () => root.tab.value = tab, disabled: selected, [
          txt(tab.name),
        ]);
      }),
    ]);
  }, style: 'display:flex;');
}

Component incrementor() {
  return fc((ctx) {
    final root = RootStore.fromCtx(ctx);
    final showModal = ctx.hookState(() => false);
    return div([
      button(onClick: () => root.increment(), classes: btn(size: BSize.sm), [
        txt('Click me to increment to counter'),
      ]),
      button(
        onClick: () => showModal.value = !showModal.value,
        classes: btn(size: BSize.sm, outlined: true, color: BColor.secondary),
        [txt('Show Modal')],
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
        ),
    ]);
  });
}

Component display() {
  return divfc((ctx) {
    print('ded');
    final root = RootStore.fromCtx(ctx);
    return txt('Counter: ${root.count}');
  });
}

Component textInput() {
  return divEl(
    style: 'display:flex;',
    children: [
      txt('Title'),
      span(const [], styles: parseStyles('width:10px;')),
      fc((ctx) {
        final value = ctx.hookState<String>(() => 'aa');
        print('text "${value.value}"');

        return input<String>(
          onInput: (v) => value.value = v,
          value: value.value,
          type: InputType.text,
        );
      }),
    ],
  );
}

Component textInputWrap(String text, void Function(String) onChange) {
  return divEl(
    style: 'display:flex;',
    children: [
      // txt('Title'),
      // span(style: 'width:10px;'),
      input<String>(onInput: onChange, value: text.isEmpty ? null : text),
    ],
  );
}
