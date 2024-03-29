import 'package:universal_html/html.dart' as html;
import '../src/prelude.dart';
import 'form.dart';

/// The type of check selector that should be rendered in [check]
enum CheckType {
  checkbox,
  radio,
  switch_,
}

extension CheckTypeExt on CheckType {
  String get htmlName => this == CheckType.switch_ ? 'checkbox' : name;
}

/// A single input checkbox, radio or switch to represent a boolean value.
/// For a collection of radios, you may want to use [RadiosInput].
///
/// https://getbootstrap.com/docs/5.2/forms/checks-radios/
DeactNode check({
  bool? checked,
  String? name,
  String? id,
  DeactNode? label,
  required Function(bool) onChange,
  bool disabled = false,
  CheckType type = CheckType.checkbox,
  bool inline = false,
  bool? isValid,
  InputFeedback? feedback,
  String? divClass,
  String? labelStyle,
}) {
  return div(
    className: 'form-check${type == CheckType.switch_ ? ' form-switch' : ''}'
        '${inline ? ' form-check-inline' : ''}${disabled ? ' disabled' : ''}'
        ' ${divClass ?? ''} position-relative',
    children: [
      fc((ctx) {
        return fragment([
          el(
            'input',
            attributes: {
              'class': 'form-check-input'
                  '${isValid == null ? '' : isValid ? ' is-valid' : ' is-invalid'}',
              'type': type.htmlName,
              if (type == CheckType.switch_) 'role': 'switch',
              if (name != null) 'name': name,
              if (id != null) 'id': id,
              if (disabled) 'disabled': '',
              if (checked == true) 'checked': '',
            },
            listeners: {
              'onchange': (e) {
                final _checked = (e.target as html.InputElement).checked;
                onChange(_checked == true);
              },
            },
          ),
          if (label != null)
            el(
              'label',
              attributes: {
                'class': 'form-check-label',
                if (labelStyle != null) 'style': labelStyle,
                if (id != null) 'for': id,
              },
              children: [label],
            ),
          ...feedback?.nodes() ?? const [],
        ]);
      }),
    ],
  );
}

/// Utility input for rendering a collection of radios.
/// [items] is a Map from the html id to the [check]'s label node.
/// [onChanged] will receive the id from [items].
/// The [selectedId] should represent the selected node in [items].
///
/// https://getbootstrap.com/docs/5.2/forms/checks-radios/#radios
// TODO: support class components
// ignore: non_constant_identifier_names
DeactNode RadiosInput({
  Object? key,
  required String? selectedId,
  required Map<String, DeactNode> items,
  required void Function(String) onChanged,
  required String name,
  bool inline = false,
}) {
  return fragment([
    ...items.entries.map(
      (e) => check(
        id: e.key,
        label: e.value,
        inline: inline,
        name: name,
        type: CheckType.radio,
        checked: selectedId == e.key,
        onChange: (_) => onChanged(e.key),
      ),
    ),
  ]);
}

// class RadiosInput extends ComponentNode {
//   RadiosInput({
//     Object? key,
//     required this.items,
//     required this.selectedId,
//     required this.onChanged,
//     required this.name,
//     this.inline = false,
//   }) : super(key: key);

//   final String? selectedId;
//   final Map<String, DeactNode> items;
//   final void Function(String) onChanged;
//   final bool inline;
//   final String name;

//   @override
//   DeactNode render(ComponentContext context) {
//     return fragment([
//       ...items.entries.map(
//         (e) => check(
//           id: e.key,
//           label: e.value,
//           inline: inline,
//           name: name,
//           type: CheckType.radio,
//           checked: selectedId == e.key,
//           onChange: (_) => onChanged(e.key),
//         ),
//       ),
//     ]);
//   }
// }
