import 'package:bootstrap_dart/bootstrap/bootstrap_core.dart';
import 'package:bootstrap_dart/bootstrap/form.dart';
import 'package:deact/deact.dart';
import 'package:deact/deact_html52.dart';
import 'package:universal_html/html.dart' as html;

class IntInput extends ComponentNode {
  const IntInput({
    Object? key,
    required this.value,
    required this.onChanged,
    required this.minimum,
    required this.maximum,
    required this.label,
  }) : super(key: key);

  final int value;
  final void Function(int p1) onChanged;
  final int minimum;
  final int maximum;
  final DeactNode label;

  @override
  DeactNode render(ComponentContext ctx) {
    return div(
      style: colStyle(),
      children: [
        div(
          style: flexStyle(
            main: AxisAlign.space_between,
            expand: true,
          ),
          children: [
            label,
            span(
              className: 'px-2',
              children: [
                txt(value.toString()),
              ],
            ),
            div(
              children: [
                button(
                  type: 'button',
                  className: btn(size: BSize.sm, color: BColor.light),
                  disabled: value == minimum ? '' : null,
                  onclick: (_) => onChanged(value - 1),
                  children: [txt('DEC')],
                ),
                button(
                  type: 'button',
                  className: btn(size: BSize.sm, color: BColor.light),
                  disabled: value == maximum ? '' : null,
                  onclick: (_) => onChanged(value + 1),
                  children: [txt('INC')],
                ),
              ],
            ),
          ],
        ),
        input(
          type: 'range',
          value: value.toString(),
          min: '$minimum',
          max: '$maximum',
          step: '1',
          className: formRangeClass,
          oninput: (e) {
            final value = int.parse((e.target as html.InputElement).value!);
            onChanged(value);
          },
        ),
      ],
    );
  }
}
