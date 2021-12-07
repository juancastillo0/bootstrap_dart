// ignore_for_file: constant_identifier_names

import 'package:deact/deact.dart';
import 'package:deact/deact_html52.dart';

import 'bootstrap_core.dart';
import 'modal.dart';
export 'user_selection.dart';

enum NavbarPosition {
  fixed_top,
  fixed_bottom,
  sticky_top,
}

extension NavbarPositionExt on NavbarPosition {
  String get nameHtml => toString().split('.').last.replaceAll('_', '-');
}

DeactNode navbar({
  String? navbarClass,
  required ModalFullScreenBellow? expand,
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
      : expand == ModalFullScreenBellow.always
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
          a(
            className: 'navbar-brand',
            href: brandHref,
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
