// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'package:universal_html/html.dart' as html;
import 'package:deact/deact.dart';
import 'package:deact/deact_html52.dart';

import 'user_selection.dart';
export 'user_selection.dart';

import 'js_bindings_interface.dart' if (dart.library.html) 'js_bindings.dart';
export 'js_bindings_interface.dart' if (dart.library.html) 'js_bindings.dart';

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
      '${size != null ? ' btn-${size.name}' : ''}${active ? ' active' : ''} ';
}

DeactNode buttonGroup<T>({
  required String buttonClass,
  required List<T> values,
  required Iterable<DeactNode> Function(T) renderItem,
  required UserSelection<T> selection,
  String? ariaLabel,
  BSize? size,
  bool vertical = false,
}) {
  final selectedSet = selection.selectedSet();
  return el(
    'div',
    attributes: {
      'class': 'btn-group${vertical ? '-vertical' : ''}'
          '${size == null ? '' : ' btn-group-${size.name}'}',
      'role': 'group',
      if (ariaLabel != null) 'aria-label': ariaLabel,
    },
    children: [
      ...values.map((e) {
        return button(
          className: buttonClass + (selectedSet.contains(e) ? ' active' : ''),
          type: 'button',
          onclick: (_) => selection.onSelect(e),
          children: renderItem(e),
        );
      }),
    ],
  );
}

enum AxisAlign {
  start,
  end,
  center,
  stretch,
  space_around,
  space_between,
  space_evenly,
  baseline,
}

extension MainAxisAlignExt on AxisAlign {
  String get nameHtml => toString().split('.').last.replaceAll('_', '-');
}

String flexCenter({bool column = false}) {
  return flexStyle(
    main: AxisAlign.center,
    cross: AxisAlign.center,
    column: column,
  );
}

String flexStyle({
  bool column = false,
  AxisAlign main = AxisAlign.start,
  AxisAlign cross = AxisAlign.start,
}) {
  return 'display:flex;${column ? 'flex-direction:column;' : ''}'
      'justify-content:${main.nameHtml};align-items:${cross.nameHtml};';
}

String colStyle({
  AxisAlign main = AxisAlign.start,
  AxisAlign cross = AxisAlign.start,
}) {
  return flexStyle(column: true, main: main, cross: cross);
}

/// Close Button https://getbootstrap.com/docs/5.1/components/close-button/
DeactNode closeButton({
  Object? key,
  void Function(html.Event)? onClick,
  bool disabled = false,
  bool white = false,
  Map<String, Object>? attributes,
}) {
  return el(
    'button',
    key: key,
    attributes: {
      'class': 'btn-close${white ? ' btn-close-white' : ''}',
      'aria-label': 'Close',
      'type': 'button',
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
      'class': buttonClass,
      ...toggleButtonAttributes(
        component: TogglableComponent.collapse,
        targetId: collapseId,
      ),
      'aria-expanded': 'false',
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
  required Iterable<DeactNode> buttonContent,
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
          'data-bs-toggle': 'dropdown',
          'aria-expanded': 'false',
          'type': 'button',
          if (buttonId != null) 'id': buttonId,
          'data-bs-reference': reference,
          'data-bs-offset': offset,
          'data-bs-auto-close': autoClose.nameHtml,
        },
        children: buttonContent,
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

final DeactNode dropdownDivider = el('li', children: [
  el('hr', attributes: {'class': 'dropdown-divider'})
]);

DeactNode dropdownItem({
  Object? key,
  String? buttonId,
  String? buttonClass,
  bool active = false,
  bool disabled = false,
  bool useButton = false,
  required Iterable<DeactNode>? children,
  required void Function(html.Event)? onClick,
}) {
  return el(
    'li',
    key: key,
    children: [
      el(
        useButton ? 'button' : 'a',
        attributes: {
          'class': '${buttonClass ?? ''}'
              ' dropdown-item${active ? ' active' : ''}${disabled ? ' disabled' : ''}',
          'type': 'button',
          if (buttonId != null) 'id': buttonId,
          if (active) 'aria-current': 'true',
        },
        listeners: {
          if (onClick != null) 'onclick': onClick,
        },
        children: children,
      ),
    ],
  );
}

// TODO: Accordion https://getbootstrap.com/docs/5.1/components/accordion/
// TODO: Breadcrumb (navigation hierarchy) https://getbootstrap.com/docs/5.1/components/breadcrumb/
// TODO: Carousel https://getbootstrap.com/docs/5.1/components/carousel/
// TODO: ListGroup https://getbootstrap.com/docs/5.1/components/list-group/
// TODO: Navs and tabs https://getbootstrap.com/docs/5.1/components/navs-tabs/
// TODO: Navbar https://getbootstrap.com/docs/5.1/components/navbar/
// https://getbootstrap.com/docs/5.1/components/pagination/
// https://getbootstrap.com/docs/5.1/components/placeholders/
// https://getbootstrap.com/docs/5.1/components/progress/

class ScrollSpyHook {
  final Ref<ScrollSpy?> ref;
  final Map<String, Object> attributes;

  ScrollSpyHook(this.ref, this.attributes);
}

ScrollSpyHook useScrollSpy(
  ComponentContext ctx,
  Ref<html.Element?> ref, {
  required String target,
  int offset = 50,
}) {
  final scrollSpy = ctx.ref<ScrollSpy?>('scrollSpy', null);

  ctx.hookEffect(() {
    final _scrollSpy = ScrollSpy(
      ref.value!,
      ScrollSpyConfig(target: target),
    );
    scrollSpy.value = _scrollSpy;
    return () {
      scrollSpy.value = null;
      _scrollSpy.dispose();
    };
  }, [ref, target, offset]);

  ctx.hookEffect(() {
    scrollSpy.value?.refresh();
  });

  return ScrollSpyHook(scrollSpy, {
    'data-bs-spy': 'scroll',
    'data-bs-target': target,
    'data-bs-offset': offset.toString(),
    'tabindex': '0',
  });
}

enum TogglableComponent {
  modal,
  offcanvas,
  collapse,
}

extension TogglableComponentExt on TogglableComponent {
  String get name => toString().split('.').last;
}

Map<String, Object> toggleButtonAttributes({
  required TogglableComponent component,
  required String targetId,
}) {
  return {
    'type': 'button',
    'data-bs-toggle': component.name,
    'data-bs-target': '#$targetId',
    'aria-controls': targetId,
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
      if (!ariaHidden)
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
      ' text-${color.name}';
}

enum ResponsiveBreakPoint {
  sm,
  md,
  lg,
  xl,
  xxl,
  always,
}

extension ModalFullScreenBellowExt on ResponsiveBreakPoint {
  String get name => toString().split('.').last;
}

enum VerticalAlign {
  baseline,
  top,
  middle,
  bottom,
  text_bottom,
  text_top,
}

extension VerticalAlignExt on VerticalAlign {
  String get nameHtml =>
      'align-${toString().split('.').last.replaceAll('_', '-')}';
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
