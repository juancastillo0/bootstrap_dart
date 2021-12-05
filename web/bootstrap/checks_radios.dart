import 'dart:html' as html;
import 'package:deact/deact.dart';
import 'package:deact/deact_html52.dart';

enum CheckType {
  checkbox,
  radio,
  switch_,
}

extension CheckTypeExt on CheckType {
  String get htmlName =>
      this == CheckType.switch_ ? 'checkbox' : toString().split('.').last;
}

DeactNode check({
  bool? checked,
  String? name,
  String? id,
  DeactNode? label,
  required Function(bool) onChange,
  bool disabled = false,
  CheckType type = CheckType.checkbox,
  bool inline = false,
}) {
  return div(
    className: 'form-check${type == CheckType.switch_ ? ' form-switch' : ''}'
        '${inline ? ' form-check-inline' : ''}',
    children: [
      fc((ctx) {
        return fragment([
          el(
            'input',
            attributes: {
              'class': 'form-check-input',
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
                if (id != null) 'for': id,
              },
              children: [label],
            ),
        ]);
      }),
    ],
  );
}
