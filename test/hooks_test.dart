import 'dart:async';

import 'package:deact/deact_html52.dart';
import 'package:test/test.dart';
import 'package:deact/deact.dart';
import 'dart:html' as html;

import 'package:virtual_web/hooks.dart';

void main() {
  test('ctx.ref', () async {
    late Ref<html.Element?> ref;
    final renderer = deact(
      '#output',
      (_) {
        return fc((ctx) {
          ref = ctx.hookRef(() => null);

          return div(
            ref: ref,
            id: 'div-id',
            children: [],
          );
        });
      },
    );

    await renderer.waitScheduledRender();
    final divElem = html.querySelectorAll('#div-id');
    expect(divElem, [ref.value]);
  });

  test('useStream', () async {
    late Ref<html.Element?> ref;

    final controller = StreamController<String>();
    final useValueChangedList = <String>[];
    final useMemoList = <String>[];

    DeactNode _component() {
      return fc((ctx) {
        ref = ctx.hookRef<html.Element?>(() => null);

        final value = useStream(
          ctx,
          controller.stream,
          initialValue: () => 'initial',
        );

        final changeResult = useValueChanged<String, String>(
          ctx,
          value.asValue!.value,
          (previous, oldResult) {
            useValueChangedList.add(previous);
            return previous + 'r';
          },
        );

        final memoValue = useMemo(
          ctx,
          () => changeResult == null ? 'default' : '$changeResult-memo',
          [changeResult],
        );
        useMemoList.add(memoValue);

        return div(
          ref: ref,
          id: 'div-id',
          children: [
            txt(value.asValue!.value),
          ],
        );
      });
    }

    final renderer = deact(
      '#output',
      (_) => _component(),
    );

    await renderer.waitScheduledRender();
    final divElements = html.querySelectorAll('#div-id');
    expect(divElements, [ref.value]);
    final elem = divElements.first;
    expect(elem.text, 'initial');
    expect(ref.value!.text, 'initial');

    String textContent = 'event1';
    controller.add(textContent);
    await renderer.waitScheduledRender();
    expect(ref.value!.text, textContent);

    textContent = 'event2';
    controller.add(textContent);
    await renderer.waitScheduledRender();
    expect(ref.value!.text, textContent);

    expect(
      useValueChangedList,
      ['initial', 'event1'],
    );
    expect(
      useMemoList,
      ['default', 'initialr-memo', 'event1r-memo'],
    );
  });
}
