// ignore_for_file: constant_identifier_names

import 'package:universal_html/html.dart' as html;

import '../src/prelude.dart';
import 'user_selection.dart';

export '../bootstrap/user_selection.dart';
export '../src/js_bindings_interface.dart'
    if (dart.library.html) '../src/js_bindings.dart';

/// Bootstrap theme colors.
///
/// https://getbootstrap.com/docs/5.2/customize/color/
enum BColor {
  primary,
  secondary,
  success,
  danger,
  warning,
  info,
  light,
  dark,
  // body,
  // white,
  // transparent,
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

/// A sections that brings attention to the user.
/// The alert css class with the background [color].
///
/// Alerts https://getbootstrap.com/docs/5.1/components/alerts/
String alert({required BColor color}) => 'alert alert-${color.name}';

/// A small pill or tag.
/// The badge css class with the background [color].
///
/// Badge https://getbootstrap.com/docs/5.1/components/badge/
String badge({bool rounded = false, required BColor color}) =>
    'badge${rounded ? ' rounded-pill' : ''} bg-${color.name}';

/// The button ("btn") class.
///
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

/// Group a series of buttons together on a single line or stack them in a vertical column.
/// Returns the component with the multiple [values] as buttons.
///
/// https://getbootstrap.com/docs/5.2/components/button-group
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
        return el(
          'button',
          attributes: {
            'class': buttonClass + (selectedSet.contains(e) ? ' active' : ''),
            'type': 'button',
          },
          listeners: {
            'onclick': (_) => selection.onSelect(e),
          },
          children: renderItem(e),
        );
      }),
    ],
  );
}

enum Placement {
  top,
  bottom,
  start,
  end,
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

enum FlexWrap {
  wrap,
  wrap_reverse,
  nowrap,
}

extension FlexWrapExt on FlexWrap {
  String get nameHtml => toString().split('.').last.replaceAll('_', '-');
}

String flexStyle({
  bool column = false,
  AxisAlign main = AxisAlign.start,
  AxisAlign cross = AxisAlign.center,
  FlexWrap? wrap,
  bool expand = false,
}) {
  return 'display:flex;${column ? 'flex-direction:column;' : ''}'
      'justify-content:${main.nameHtml};align-items:${cross.nameHtml};'
      '${wrap == null ? '' : 'flex-wrap:${wrap.nameHtml};'}'
      '${column ? 'width:100%;' : 'height:100%;'}${expand ? column ? 'height:100%;' : 'width:100%;' : ''}';
}

String colStyle({
  AxisAlign main = AxisAlign.start,
  AxisAlign cross = AxisAlign.center,
  bool expand = false,
  FlexWrap? wrap,
}) {
  return flexStyle(
    column: true,
    main: main,
    cross: cross,
    expand: expand,
    wrap: wrap,
  );
}

/// An "X" button.
/// Returns the component button.
///
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

/// Show and hide a section.
/// The collapse css class.
///
/// Collapse https://getbootstrap.com/docs/5.1/components/collapse/
String collapse({
  bool horizontal = false,
  bool multi = false,
  bool show = false,
}) =>
    'collapse${horizontal ? ' collapse-horizontal' : ''}'
    '${multi ? ' multi-collapse' : ''}${show ? ' show' : ''}';

/// A button that collapses the element with id [collapseId].
/// Return the component that toggles the hide/show state.
/// You could also use the [toggleButtonAttributes] primitive.
///
/// Collapse https://getbootstrap.com/docs/5.1/components/collapse/
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

enum AutoClose {
  true_,
  false_,
  inside,
  outside,
}

extension AutoCloseExt on AutoClose {
  String get nameHtml => toString().split('.').last.replaceAll('_', '');
}

/// A collection of buttons that is shown when [buttonContent] is tapped.
/// Returns the component that shows a context menu with [children].
/// You may want to use [dropdownItem] and [dropdownDivider] for the [children].
///
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
  return el(
    'div',
    attributes: {
      'class': 'btn-group ${dropdownClass ?? ''}'
          '${direction != Direction.down ? ' drop${direction.name}' : ''}',
    },
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

/// A divider for buttons in a [dropdown]
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

// TODO: Breadcrumb (navigation hierarchy) https://getbootstrap.com/docs/5.1/components/breadcrumb/
// TODO: Carousel https://getbootstrap.com/docs/5.1/components/carousel/
// TODO: ListGroup https://getbootstrap.com/docs/5.1/components/list-group/
// TODO: Navs and tabs https://getbootstrap.com/docs/5.1/components/navs-tabs/
// https://getbootstrap.com/docs/5.1/components/pagination/
// https://getbootstrap.com/docs/5.1/components/placeholders/
// https://getbootstrap.com/docs/5.1/components/progress/
//

enum Space {
  s0,
  s1,
  s2,
  s3,
  s4,
  s5,
}

/// https://getbootstrap.com/docs/5.2/helpers/stacks
String stackClass({required Space gap, required bool vert}) =>
    '${vert ? 'v' : 'h'}stack gap-${gap.index}';

/// https://getbootstrap.com/docs/5.2/utilities/borders
String borderClass({
  BColor? color,
  Space? size,
  Set<Placement> sides = const {},
}) =>
    [
      if (color != null) 'border-${color.name}',
      if (sides.isEmpty)
        'border${size == null ? '' : '-${size.index}'}'
      else
        ...sides.map(
          (b) => 'border-${b.name}${size == null ? '' : '-${size.index}'}',
        )
    ].join(' ');

enum RoundedSize {
  s0,
  s1,
  s2,
  s3,
}

/// https://getbootstrap.com/docs/5.2/utilities/borders/#radius
String roundedClass({
  bool circle = false,
  bool pill = false,
  RoundedSize? size,
  Set<Placement> sides = const {},
}) =>
    sides.isEmpty
        ? 'rounded${pill ? '-pill' : circle ? '-circle' : ''}'
        : [if (size != null) 'rounded-${size.index}']
            .followedBy(sides.map((e) => 'rounded-${e.name}'))
            .join(' ');

/// The state of a ScrollSpy created with [useScrollSpy].
///
/// https://getbootstrap.com/docs/5.2/components/scrollspy/
class ScrollSpyHook {
  final Ref<ScrollSpy?> ref;
  final Map<String, String> attributes;

  ScrollSpyHook(this.ref, this.attributes);
}

/// A ScrollSpy is a list that shows the current section given by
/// the scroll position of an element with id [target].
/// This hook returns the state [ScrollSpyHook] that can be used to
/// retrieve the [ScrollSpy] and set the Bootstrap attributes in the list of sections.
///
/// https://getbootstrap.com/docs/5.2/components/scrollspy/
ScrollSpyHook useScrollSpy(
  BootstrapBuildContext ctx,
  Ref<html.Element?> ref, {
  required String target,
  int offset = 50,
}) {
  final scrollSpy = ctx.hookRef<ScrollSpy?>(() => null);

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
  }, [ref.value, target, offset]);

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

/// A list of components that can be toggled.
/// Used within [toggleButtonAttributes].
enum TogglableComponent {
  modal,
  offcanvas,
  collapse,
}

/// The html attributes to use for a button that toggles
/// an element with id [targetId] of type [component].
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

/// A section of content.
/// Returns a div with all the specified content.
///
/// Card https://getbootstrap.com/docs/5.1/components/card/
DeactNode card({
  Object? key,
  String? id,
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
    id: id,
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
        el(
          'img',
          key: 'image-top',
          attributes: {
            'class': 'card-img-top',
            'alt': imageAlt,
            'src': imageSrc,
          },
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
        el(
          'img',
          key: 'image-bottom',
          attributes: {
            'class': 'card-img-bottom',
            'alt': imageAlt,
            'src': imageSrc,
          },
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

/// An animated loading indicator.
/// Returns the component that renders the spinner.
/// You can also use the primitive [spinnerClass].
///
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
        el(
          'span',
          attributes: {'class': 'visually-hidden'},
          children: [txt('Loading...')],
        )
    ],
  );
}

/// An animated loading indicator.
/// Returns the css class.
///
/// Spinners https://getbootstrap.com/docs/5.1/components/spinners/
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

/// The size for [placeholder]
enum PlaceholderSize {
  xs,
  sm,
  lg,
}

/// A loading placeholder for text or content.
/// Returns the css class.
///
/// https://getbootstrap.com/docs/5.2/components/placeholders
String placeholder({
  bool glow = false,
  BColor? color,
  PlaceholderSize? size,
  bool wave = false,
  String? className,
}) {
  assert(!glow || glow != wave);
  return 'placeholder${glow ? '-glow' : wave ? '-wave' : ''}'
      '${size != null ? ' placeholder-${size.name}' : ''}'
      '${color != null ? ' bg-${color.name}' : ''} ${className ?? ''}';
}

DeactNode placeholderButton(String btnClass) => el(
      'a',
      attributes: {
        'class': 'placeholder disabled $btnClass',
        'tabindex': -1,
        'href': '#',
        'aria-hidden': 'true',
      },
    );

/// A list of items.
/// Returns the css class.
/// You may want to use [listGroupItem] for the items.
///
/// https://getbootstrap.com/docs/5.2/components/list-group/
String listGroup({
  bool numbered = false,
  bool flush = false,
  bool horizontal = false,
}) {
  return [
    'list-group',
    if (numbered) 'list-group-numbered',
    if (flush) 'list-group-flush',
    if (horizontal) 'list-group-horizontal',
  ].join(' ');
}

/// An item in a list.
/// Returns the css class.
/// You may want to use [listGroup] for the list wrapper for the items.
///
/// https://getbootstrap.com/docs/5.2/components/list-group/
String listGroupItem({
  BColor? color,
  bool action = false,
  bool active = false,
}) {
  return 'list-group-item${color == null ? '' : ' list-group-item-${color.name}'}'
      '${action ? ' list-group-item-action' : ''}${active ? ' active' : ''}';
}

/// The type of tab the [tabs] component.
enum TabType {
  tab,
  pill,
  list,
}

/// Returns the component that renders [items] tabs and their
/// contents in a separate element.
///
/// https://getbootstrap.com/docs/5.2/components/navs-tabs/
DeactNode tabs({
  required TabType type,
  required Iterable<TabItem> items,
  bool fade = true,
  String? selectedId,
  void Function(TabItem)? onSelected,
  String? tabListClass,
  String? tabContentClass,
}) {
  return fragment([
    el('nav', children: [
      el(
        'div',
        attributes: {
          'role': 'tablist',
          'class': const {
                TabType.list: 'list-group',
                TabType.pill: 'nav nav-pills',
                TabType.tab: 'nav nav-tabs',
              }[type]! +
              ' ${tabListClass ?? ''}',
        },
        children: [
          ...items.map(
            (e) => el(
              'button',
              attributes: {
                'class':
                    '${type == TabType.list ? listGroupItem(action: true) : ''}'
                        ' nav-link${selectedId == e.id ? ' active' : ''}${e.disabled ? ' disabled' : ''}',
                'data-bs-toggle': type.name,
                // 'href': '#${e.id}',
                'role': 'tab',
                'type': 'button',
                'data-bs-target': '#${e.id}',
                'aria-controls': e.id,
                'id': '${e.id}-tab',
                if (selectedId != null)
                  'aria-selected': '${selectedId == e.id}',
                if (e.disabled) 'disabled': '',
              },
              listeners: {
                if (onSelected != null) 'onclick': (_) => onSelected(e),
              },
              children: [e.tab],
            ),
          ),
        ],
      ),
    ]),
    el(
      'div',
      attributes: {
        'class': 'tab-content ${tabContentClass ?? ''}',
      },
      children: [
        ...items.map(
          (e) => el(
            'div',
            attributes: {
              'id': e.id,
              'class': 'tab-pane${selectedId == e.id ? ' active' : ''}',
              'role': 'tabpanel',
              'aria-labelledby': '${e.id}-tab',
            },
            children: [e.content],
          ),
        ),
      ],
    ),
  ]);
}

/// An item within [tabs].
/// The [tab] node will be the title or button for the tab
/// and the [content] will be displayed whe it is selected.
class TabItem {
  final String id;
  final DeactNode tab;
  final DeactNode content;
  final bool disabled;

  TabItem({
    required this.id,
    required this.tab,
    required this.content,
    this.disabled = false,
  });
}
