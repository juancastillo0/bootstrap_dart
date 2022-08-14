import 'dart:async';

import 'package:deact/deact_html52.dart';
import 'package:test/test.dart';
import 'package:deact/deact.dart';
import 'package:universal_html/html.dart' as html;

import 'package:deact_bootstrap/hooks.dart';

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

  late Ref<html.Element?> ref;
  late StreamController<String> controller;
  late var useValueChangedList = <String>[];
  late var useMemoList = <String>[];

  setUp(() {
    controller = StreamController<String>.broadcast();
    useValueChangedList = <String>[];
    useMemoList = <String>[];
  });

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

  test('useStream', () async {
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

  test('useStream dispose', () async {
    final renderer = deact(
      '#output',
      (_) => fc((ctx) {
        final show = ctx.hookState(() => true);
        return div(
          children: [
            button(
              id: 'toggle-button',
              onclick: (_) => show.value = !show.value,
              children: [
                txt('toggle'),
              ],
            ),
            if (show.value) _component(),
          ],
        );
      }),
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

    final buttonElem = html.querySelector('#toggle-button');
    buttonElem!.click();
    await renderer.waitScheduledRender();

    expect(controller.hasListener, false);
    expect(html.querySelectorAll('#div-id'), isEmpty);

    textContent = 'event2';
    controller.add(textContent);
    expect(ref.value!.text, 'event1');

    buttonElem.click();
    await renderer.waitScheduledRender();

    expect(controller.hasListener, true);
    expect(html.querySelectorAll('#div-id'), isNotEmpty);

    textContent = 'event2';
    controller.add(textContent);
    await renderer.waitScheduledRender();
    expect(ref.value!.text, textContent);

    expect(
      useValueChangedList,
      ['initial', 'initial'],
    );
    expect(
      useMemoList,
      ['default', 'initialr-memo', 'default', 'initialr-memo'],
    );
  });
}
