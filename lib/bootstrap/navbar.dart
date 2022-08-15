// ignore_for_file: constant_identifier_names

import '../src/prelude.dart';
import 'bootstrap_core.dart';
export 'user_selection.dart';


/// The placement of the navigation header
/// 
/// https://getbootstrap.com/docs/5.2/components/navbar/#placement
enum NavbarPosition {
  fixed_top,
  fixed_bottom,
  sticky_top,
}

extension NavbarPositionExt on NavbarPosition {
  String get nameHtml => toString().split('.').last.replaceAll('_', '-');
}

/// A navigation header component.
/// Usually present at the top of the page with a [brand] and multiple [itemList].
/// [expand] sets the breakpoint when the navbar should expand for big screens.
/// https://getbootstrap.com/docs/5.2/components/navbar/#responsive-behaviors
///
/// https://getbootstrap.com/docs/5.2/components/navbar/
DeactNode navbar({
  String? navbarClass,
  required ResponsiveBreakPoint? expand,
  bool dark = false,
  BColor? background,
  NavbarPosition? position,
  Map<String, Object>? attributes,
  // content
  String? collapseId,
  String containerClass = 'container-fluid',
  String brandHref = '#',
  required Iterable<DeactNode> brand,
  required Iterable<DeactNode> itemList,
}) {
  final _expand = expand == null
      ? ''
      : expand == ResponsiveBreakPoint.always
          ? 'navbar-expand'
          : 'navbar-expand-${expand.name}';

  return el(
    'nav',
    attributes: {
      if (attributes != null) ...attributes,
      'class': 'navbar ${dark ? ' navbar-dark' : ' navbar-light'}'
          ' ${position?.nameHtml ?? ''} ${navbarClass ?? ''} $_expand'
          ' ${background == null ? '' : 'bg-${background.name}'}',
    },
    children: [
      div(
        className: containerClass,
        children: [
          el(
            'a',
            attributes: {'class': 'navbar-brand', 'href': brandHref},
            children: brand,
          ),
          if (collapseId != null)
            el(
              'button',
              attributes: {
                'class': 'navbar-toggler',
                'aria-expanded': false,
                ...toggleButtonAttributes(
                  component: TogglableComponent.collapse,
                  targetId: collapseId,
                ),
              },
              children: [
                el('span', attributes: {'class': 'navbar-toggler-icon'})
              ],
            ),
          div(
            id: collapseId,
            className: 'collapse navbar-collapse',
            children: itemList,
          )
        ],
      )
    ],
  );
}
