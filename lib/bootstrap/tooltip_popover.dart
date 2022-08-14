import 'package:universal_html/html.dart' as html;
import 'package:collection/collection.dart';

import '../src/prelude.dart';

/// For [attributes] use [popoverAttributes]
DeactNode popoverWrapper({
  required String content,
  Iterable<DeactNode>? children,
  Map<String, Object>? attributes,
  Ref<Popover?>? popoverRef,
}) {
  return fc((ctx) {
    final ref = ctx.hookRef<html.Element?>(() => null);
    ctx.hookEffect(
      () {
        final _popover = Popover(ref.value!);
        if (popoverRef != null) popoverRef.value = _popover;
        return _popover.dispose;
      },
      [popoverRef, content, attributes],
      const DeepCollectionEquality().equals,
    );
    return el(
      'span',
      ref: ref,
      attributes: {
        if (attributes != null) ...attributes,
        'class': 'd-inline-block',
        'data-bs-toggle': 'popover',
        'data-bs-content': content,
      },
      children: children,
    );
  });
}

Map<String, Object> popoverAttributes({
  String? title,
  String? className,
  String? content,
  TooltipPlacement placement = TooltipPlacement.right,
  bool animation = true,
  String? container,
  Duration? delay, // default: Duration.zero. TODO: support object
  bool allowHtml = false,
  String? selector,
  String? template,
  String? offset, // default: '0,8'
  List<TooltipTrigger> triggers = const [TooltipTrigger.click],
  String? customClass,
  // TODO: fallbackPlacements
}) {
  return {
    'role': 'button',
    if (className != null) 'class': className,
    'data-bs-toggle': 'popover',
    if (title != null) 'title': title,
    if (content != null) 'data-bs-content': content,
    'data-bs-placement': placement.name,
    // if (triggers.contains(TooltipTrigger.focus)) 'tabindex': '0',
    'data-bs-animation': animation,
    if (container != null) 'data-bs-container': container,
    if (delay != null) 'data-bs-delay': delay.inMilliseconds,
    if (allowHtml) 'data-bs-html': true,
    if (selector != null) 'data-bs-selector': selector,
    if (template != null) 'data-bs-template': template,
    if (offset != null) 'data-bs-offset': offset,
    'data-bs-trigger': triggers.map((e) => e.name).join(' '),
    if (customClass != null) 'data-bs-custom-class': customClass,
  };
}

/// Tooltips https://getbootstrap.com/docs/5.1/components/tooltips/
///
/// [attributes] can be constructed using [tooltipAttributes].
DeactNode tooltipWrapper({
  required String title,
  Iterable<DeactNode>? children,
  Map<String, Object>? attributes,
}) {
  return fc((ctx) {
    final tooltip = ctx.hookRef<Tooltip?>(() => null);
    final ref = useSetUpElement(
      ctx,
      onSetUp: (elem) => tooltip.value = Tooltip(elem),
      onDispose: () => tooltip.value?.dispose(),
    );
    return el(
      'span',
      ref: ref,
      attributes: {
        if (attributes != null) ...attributes,
        'class': 'd-inline-block',
        'tabindex': '0',
        'data-bs-toggle': 'tooltip',
        'data-bs-title': title,
      },
      children: children,
    );
  });
}

class Tooltip {
  final TooltipJS _inner;
  final html.Element element;
  Tooltip(this.element) : _inner = TooltipJS(element);

  void dispose() => _inner.dispose();
}

enum TooltipPlacement {
  auto,
  top,
  bottom,
  left,
  right,
}

enum TooltipTrigger {
  click,
  hover,
  focus,
  manual,
}

/// You need to enable the tooltip by instantiating a [Tooltip]
/// similar to the usage in [tooltipWrapper].
///
/// The returned attributes can be used in the `attributes`
/// parameter of [tooltipWrapper]
Map<String, Object> tooltipAttributes({
  String title = '',
  bool animation = true,
  Duration delay = Duration.zero,
  bool allowHtml = false,
  TooltipPlacement placement = TooltipPlacement.top,
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
