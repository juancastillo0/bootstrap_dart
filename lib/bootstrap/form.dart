import '../src/prelude.dart';

/// https://getbootstrap.com/docs/5.2/forms/form-control/
String formControlClass({
  BSize? size,
  bool color = false,
  bool? isValid,
}) =>
    'form-control${size != null ? ' form-control-${size.name}' : ''}'
    '${color ? ' form-control-color' : ''} ${isValid == null ? '' : isValid ? 'is-valid' : 'is-invalid'}';

/// https://getbootstrap.com/docs/5.2/forms/form-control/
const String formControlPlainText = 'form-control-plaintext';

/// https://getbootstrap.com/docs/5.2/forms/select/
String formSelectClass({BSize? size}) =>
    'form-select${size != null ? ' form-select-${size.name}' : ''}';

/// https://getbootstrap.com/docs/5.2/forms/range/
const String formRangeClass = 'form-range';

/// A representation of the feedback that should be given to de user.
/// If [invalid] is non null, an error will be presented.
/// If [valid] is non null, a success will be presented.
/// If [tooltip] is true, it will be shown as a tooltip.
///
/// https://getbootstrap.com/docs/5.2/forms/validation/
class InputFeedback {
  /// If [tooltip] is true, it will be shown as a tooltip.
  final bool tooltip;

  /// If [invalid] is non null, an error will be presented.
  final String? invalid;

  /// If [valid] is non null, a success will be presented.
  final String? valid;

  /// A representation of the feedback that should be given to de user.
  /// If [invalid] is non null, an error will be presented.
  /// If [valid] is non null, a success will be presented.
  /// If [tooltip] is true, it will be shown as a tooltip.
  ///
  /// https://getbootstrap.com/docs/5.2/forms/validation/
  InputFeedback({
    this.tooltip = false,
    this.invalid,
    this.valid,
  });

  /// The nodes to be used next to a label and input html elements
  /// to show the feedback to the user.
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

/// Useful for setting the layout of multiple [labeledInput].
class ColInputClasses {
  final String label;
  final String input;

  const ColInputClasses({
    required this.label,
    required this.input,
  });
}

/// An input component with a label and some utilities for rendering.
///
/// https://getbootstrap.com/docs/5.2/forms/form-control/
/// https://getbootstrap.com/docs/5.2/forms/floating-labels/
DeactNode labeledInput({
  required DeactNode label,
  required DeactNode input,
  required String id,
  // div
  bool floating = false,
  String? divClass,
  String? wrapperDivClass,
  ColInputClasses? colClasses,
  ElementAttributes? attributes,
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

/// https://getbootstrap.com/docs/5.2/forms/input-group/
String inputGroupClass({BSize? size}) =>
    'input-group${size != null ? ' input-group-${size.name}' : ''}';

/// https://getbootstrap.com/docs/5.2/forms/input-group/
const String inputGroupTextClass = 'input-group-text';

/// https://getbootstrap.com/docs/5.2/forms/floating-labels/
const String formFloating = 'form-floating';

/// https://getbootstrap.com/docs/5.2/forms/form-control/
const String formLabel = 'form-label';

/// https://getbootstrap.com/docs/5.2/forms/layout/#horizontal-form
String colFormLabel({BSize? size}) =>
    'col-form-label${size == null ? '' : ' col-form-label-${size.name}'}';
