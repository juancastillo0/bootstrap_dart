import 'dart:async';
import 'dart:html' as html;
import 'package:deact/deact.dart';
import 'package:deact/deact_html52.dart';

enum BColor {
  primary,
  secondary,
  success,
  danger,
  warning,
  info,
  light,
  dark,
}

extension BtnTypeExt on BColor {
  String get name => toString().split('.').last;
  String get textColor =>
      const [BColor.warning, BColor.info, BColor.light].contains(this)
          ? ' text-dark'
          : '';
}

enum BSize {
  lg,
  sm,
}

extension BSizeExt on BSize {
  String get name => toString().split('.').last;
}

/// Alerts https://getbootstrap.com/docs/5.1/components/alerts/
String alert({required BColor color}) => 'alert alert-${color.name}';

/// Badge https://getbootstrap.com/docs/5.1/components/badge/
String badge({bool rounded = false, required BColor color}) =>
    'badge${rounded ? ' rounded-pill' : ''} bg-${color.name}';

/// Buttons https://getbootstrap.com/docs/5.1/components/buttons/
String btn({
  BColor color = BColor.primary,
  bool outlined = false,
  BSize? size,
  bool active = false,
}) {
  return 'btn btn-${outlined ? 'outline-' : ''}${color.name}'
      '${size != null ? ' btn-${size.name}' : ''}${active ? ' active' : ''}';
}

/// Close Button https://getbootstrap.com/docs/5.1/components/close-button/
DeactNode closeButton({
  void Function(html.Event)? onClick,
  bool disabled = false,
  bool white = false,
  Map<String, Object>? attributes,
}) {
  return el(
    'button',
    attributes: {
      'class': 'btn-close${white ? ' btn-close-white' : ''}',
      'aria-label': 'Close',
      if (disabled) 'disabled': true,
      if (attributes != null) ...attributes,
    },
    listeners: onClick != null ? {'onclick': onClick} : null,
  );
}

/// Collapse https://getbootstrap.com/docs/5.1/components/collapse/
String collapse({
  bool horizontal = false,
  bool multi = false,
  bool show = false,
}) =>
    'collapse${horizontal ? ' collapse-horizontal' : ''}'
    '${multi ? ' multi-collapse' : ''}${show ? ' show' : ''}';

DeactNode collapseButton({
  required String collapseId,
  required String buttonClass,
  Iterable<DeactNode>? children,
  Object? key,
}) {
  return el(
    'button',
    key: key,
    attributes: {
      'type': "button",
      'class': buttonClass,
      'data-bs-toggle': "collapse",
      'data-bs-target': "#$collapseId",
      'aria-expanded': "false",
      'aria-controls': collapseId,
    },
    children: children,
  );
}

DeactNode visuallyHidden(String text) {
  return el(
    'span',
    attributes: {'class': 'visually-hidden'},
    children: [txt(text)],
  );
}

enum Direction {
  up,
  down,
  start,
  end,
}

extension DirectionExt on Direction {
  String get name => toString().split('.').last;
}

enum AutoClose {
  true_,
  false_,
  inside,
  outside,
}

extension AutoCloseExt on AutoClose {
  String get nameHtml => toString().split('.').last.replaceAll('_', '');
}

/// DropDowns https://getbootstrap.com/docs/5.1/components/dropdowns/
DeactNode dropdown({
  required Iterable<DeactNode> children,
  required String buttonClass,
  String? dropdownClass,
  String? menuClass,
  String? buttonId,
  bool dark = false,
  Direction direction = Direction.down,
  bool menuOnEnd = false,
  String reference = 'toggle',
  String offset = '0,2',
  AutoClose autoClose = AutoClose.true_,
}) {
  return div(
    className: 'btn-group ${dropdownClass ?? ''}'
        '${direction != Direction.down ? ' drop${direction.name}' : ''}',
    children: [
      el(
        'button',
        attributes: {
          'class': '$buttonClass dropdown-toggle',
          'data-bs-toggle': "dropdown",
          'aria-expanded': "false",
          'type': 'button',
          if (buttonId != null) 'id': buttonId,
          'data-bs-reference': reference,
          'data-bs-offset': offset,
          'data-bs-auto-close': autoClose.nameHtml,
        },
        children: [],
      ),
      el(
        'ul',
        attributes: {
          'class': 'dropdown-menu${dark ? ' dropdown-menu-dark' : ''}'
              '${menuOnEnd ? ' dropdown-menu-end' : ''} ${menuClass ?? ''}',
          if (buttonId != null) 'aria-labelledby': buttonId,
        },
        children: children,
      ),
    ],
  );
}

DeactNode dropdownItem({
  Object? key,
  required String buttonClass,
  bool active = false,
  bool disabled = false,
  String? buttonId,
  bool useButton = false,
  Iterable<DeactNode>? children,
}) {
  return el(
    'li',
    key: key,
    children: [
      el(
        useButton ? 'button' : 'a',
        attributes: {
          'class':
              '$buttonClass dropdown-item${active ? ' active' : ''}${disabled ? ' disabled' : ''}',
          'type': 'button',
          if (buttonId != null) 'id': buttonId,
          if (active) 'aria-current': 'true',
        },
        children: children,
      ),
    ],
  );
}

/// TODO: Accordion https://getbootstrap.com/docs/5.1/components/accordion/
/// TODO: Breadcrumb (navigation hierarchy) https://getbootstrap.com/docs/5.1/components/breadcrumb/
/// TODO: ButtonGroup https://getbootstrap.com/docs/5.1/components/button-group/
/// TODO: Carousel https://getbootstrap.com/docs/5.1/components/carousel/
/// TODO: ListGroup https://getbootstrap.com/docs/5.1/components/list-group/
/// TODO: Navs and tabs https://getbootstrap.com/docs/5.1/components/navs-tabs/
/// TODO: Navbar https://getbootstrap.com/docs/5.1/components/navbar/
/// TODO: Offcanvas https://getbootstrap.com/docs/5.1/components/offcanvas/
/// https://getbootstrap.com/docs/5.1/components/pagination/
/// https://getbootstrap.com/docs/5.1/components/placeholders/
/// https://getbootstrap.com/docs/5.1/components/popovers/
/// https://getbootstrap.com/docs/5.1/components/progress/
/// https://getbootstrap.com/docs/5.1/components/scrollspy/

/// Tooltips https://getbootstrap.com/docs/5.1/components/tooltips/
DeactNode tooltipWrapper({
  required String title,
  Iterable<DeactNode>? children,
  Map<String, Object>? attributes,
}) {
  return el(
    'span',
    attributes: {
      if (attributes != null) ...attributes,
      'class': 'd-inline-block',
      'tabindex': '0',
      'data-bs-toggle': 'tooltip',
      'data-bs-title': title,
    },
    children: children,
  );
}

enum Placement {
  auto,
  top,
  bottom,
  left,
  right,
}

extension PlacementExt on Placement {
  String get name => toString().split('.').last;
}

enum TooltipTrigger {
  click,
  hover,
  focus,
  manual,
}

extension TooltipTriggerExt on TooltipTrigger {
  String get name => toString().split('.').last;
}

Map<String, Object> tooltipAttributes({
  String title = '',
  bool animation = true,
  Duration delay = Duration.zero,
  bool allowHtml = false,
  Placement placement = Placement.top,
  String? selector,
  String? template,
  String? customClass,
  String offset = '0,0',
  List<TooltipTrigger> triggers = const [
    TooltipTrigger.focus,
    TooltipTrigger.hover,
  ],
  // TODO: fallbackPlacements
}) {
  return {
    'data-bs-toggle': 'tooltip',
    if (!animation) 'data-bs-animation': 'false',
    'data-bs-delay': delay.inMilliseconds,
    if (allowHtml) 'data-bs-html': true,
    'data-bs-title': title,
    'data-bs-placement': placement.name,
    if (selector != null) 'data-bs-selector': selector,
    if (template != null) 'data-bs-template': template,
    if (customClass != null) 'data-bs-custom-class': customClass,
    'data-bs-offset': offset,
    'data-bs-trigger': triggers.map((e) => e.name).join(' '),
  };
}

/// Card https://getbootstrap.com/docs/5.1/components/card/
DeactNode card({
  Object? key,
  void Function(html.MouseEvent)? onClick,
  String? imageSrc,
  String? imageAlt,
  bool imageBottom = false,
  String? cardClasses,
  String? cardStyle,
  DeactNode? content,
  DeactNode? header,
  DeactNode? footer,
  DeactNode? title,
  DeactNode? text,
}) {
  return div(
    key: key,
    className: 'card ${cardClasses ?? ''}',
    style: cardStyle,
    onclick: onClick,
    children: [
      if (header != null)
        div(
          key: 'header',
          className: 'card-header',
          children: [header],
        ),
      if (imageSrc != null && !imageBottom)
        img(
          key: 'image-top',
          className: 'card-img-top',
          alt: imageAlt,
          src: imageSrc,
        ),
      div(
        key: 'body',
        className: 'card-body',
        children: [
          if (title != null)
            el(
              'h5',
              key: 'title',
              attributes: {'class': 'card-title'},
              children: [title],
            ),
          if (text != null)
            el(
              'p',
              key: 'text',
              attributes: {'class': 'card-text'},
              children: [text],
            ),
          if (content != null) content,
        ],
      ),
      if (imageSrc != null && imageBottom)
        img(
          key: 'image-bottom',
          className: 'card-img-bottom',
          alt: imageAlt,
          src: imageSrc,
        ),
      if (footer != null)
        div(
          key: 'footer',
          className: 'card-footer',
          children: [footer],
        ),
    ],
  );
}

/// Spinners https://getbootstrap.com/docs/5.1/components/spinners/
DeactNode spinner({
  String? className,
  bool grow = false,
  BSize? size,
  bool useSpan = false,
  BColor color = BColor.primary,
  bool ariaHidden = false,
}) {
  return el(
    useSpan ? 'span' : 'div',
    attributes: {
      'class': spinnerClass(size: size, grow: grow, color: color) +
          ' ${className ?? ''}',
      'role': 'status',
      if (ariaHidden) 'aria-hidden': 'true',
    },
    children: [
      span(
        className: 'visually-hidden',
        children: [txt('Loading...')],
      )
    ],
  );
}

String spinnerClass({
  bool grow = false,
  BSize? size,
  BColor color = BColor.primary,
}) {
  final _type = grow ? 'grow' : 'border';
  return 'spinner-$_type${size != null ? ' spinner-$_type-${size.name}' : ''}'
      ' text=${color.name}';
}

enum Alignment { start, center, end }

extension AlignmentExt on Alignment {
  String horizontalStyle() {
    switch (this) {
      case Alignment.center:
        return 'left:50%;transform:translateX(-50%);';
      case Alignment.start:
        return 'left:0%;';
      case Alignment.end:
        return 'right:0%;';
    }
  }

  String verticalStyle() {
    switch (this) {
      case Alignment.center:
        return 'top:50%;transform:translateY(-50%);';
      case Alignment.start:
        return 'top:0%;';
      case Alignment.end:
        return 'bottom:0%;';
    }
  }
}

Ref<html.Element?> useSetUpElement(
  ComponentContext ctx, {
  void Function(html.Element)? onSetUp,
  void Function()? onDispose,
}) {
  final elemRef = ctx.ref<html.Element?>('useSetUpElement.elemRef', null);
  bool disposed = false;

  ctx.effect(
    'useSetUpElement.setUpElem',
    () {
      Future(() {
        if (!disposed && elemRef.value != null) {
          onSetUp?.call(elemRef.value!);
        }
      });
      return () {
        disposed = true;
        onDispose?.call();
      };
    },
    dependsOn: const [],
  );
  return elemRef;
}
