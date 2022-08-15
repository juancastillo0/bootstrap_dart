import '../src/prelude.dart';

String formControlClass({
  BSize? size,
  bool color = false,
  bool? isValid,
}) =>
    'form-control${size != null ? ' form-control-${size.name}' : ''}'
    '${color ? ' form-control-color' : ''} ${isValid == null ? '' : isValid ? 'is-valid' : 'is-invalid'}';

const String formControlPlainText = 'form-control-plaintext';

String formSelectClass({BSize? size}) =>
    'form-select${size != null ? ' form-select-${size.name}' : ''}';

const String formRangeClass = 'form-range';

class ColInputClasses {
  final String label;
  final String input;

  const ColInputClasses({
    required this.label,
    required this.input,
  });
}

class InputFeedback {
  final bool tooltip;
  final String? invalid;
  final String? valid;

  InputFeedback({
    this.tooltip = false,
    this.invalid,
    this.valid,
  });

  Iterable<DeactNode> nodes() {
    return [
      if (invalid != null)
        el(
          'div',
          attributes: {'class': 'invalid-${tooltip ? 'tooltip' : 'feedback'}'},
          children: [txt(invalid!)],
        ),
      if (valid != null)
        el(
          'div',
          attributes: {'class': 'valid-${tooltip ? 'tooltip' : 'feedback'}'},
          children: [txt(valid!)],
        ),
    ];
  }
}

DeactNode labeledInput({
  required DeactNode label,
  required DeactNode input,
  required String id,
  // div
  bool floating = false,
  String? divClass,
  String? wrapperDivClass,
  ColInputClasses? colClasses,
  Map<String, Object>? attributes,
  // validation
  InputFeedback? feedback,
}) {
  final children = [
    el(
      'label',
      attributes: {
        'class': colClasses == null
            ? 'form-label'
            : 'col-form-label ${colClasses.label}',
        'for': id,
      },
      children: [label],
    ),
    if (colClasses == null)
      input
    else
      el(
        'div',
        attributes: {'class': colClasses.input},
        children: [input],
      )
  ];

  final inner = el(
    'div',
    attributes: {
      'class':
          '${floating ? 'form-floating ' : 'position-relative '}${divClass ?? ''}',
      if (attributes != null) ...attributes,
    },
    children: [
      ...floating ? children.reversed : children,
      ...feedback?.nodes() ?? const [],
    ],
  );
  if (wrapperDivClass != null) {
    return el(
      'div',
      attributes: {'class': wrapperDivClass},
      children: [inner],
    );
  }
  return inner;
}

/// Layout

String inputGroupClass({BSize? size}) =>
    'input-group${size != null ? ' input-group-${size.name}' : ''}';

const String inputGroupTextClass = 'input-group-text';

const String formFloating = 'form-floating';

const String formLabel = 'form-label';

String colFormLabel({BSize? size}) =>
    'col-form-label${size == null ? '' : ' col-form-label-${size.name}'}';
