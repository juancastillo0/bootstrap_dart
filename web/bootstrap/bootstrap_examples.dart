import 'package:deact/deact.dart';
import 'package:deact/deact_html52.dart';
import 'dart:html' as html;
import 'package:highlight/highlight.dart' show highlight;

import 'bootstrap_core.dart';
import 'checks_radios.dart';
import 'icons.dart';
import 'modal.dart';
import 'navbar.dart';
import 'offcanvas.dart';
import 'toast.dart';
import 'tooltip_popover.dart';

DeactNode codeSection(String dartCode) {
  final highlighted = highlight.parse(dartCode, language: 'dart');
  return div(
    children: [
      div(
        className: 'mt-3 mb-2 d-flex justify-content-center align-items-center',
        children: [
          // txt('Example Code'),
          // el('span', attributes: {'style': 'width:40px;'}),
          button(
            className: btn(color: BColor.dark, size: BSize.sm),
            onclick: (_) =>
                html.window.navigator.clipboard?.writeText(dartCode),
            children: [
              icon(BIcon.clipboard),
              el('span', attributes: {
                'style': 'padding-left:10px;'
              }, children: [
                txt('Copy code'),
              ]),
            ],
          )
        ],
      ),
      ElementNode.fromHtml(
        html.Element.tag('code')
          ..className = 'codebox'
          ..setInnerHtml(highlighted.toHtml()),
      )
    ],
  );
}

DeactNode bootstrapExamples() {
  return fc((ctx) => _allExamples(ctx));
}

DeactNode examplesNavbar() {
  return nav(
    id: 'navbar-example',
    className: 'navbar navbar-light bg-light'
        ' flex-column align-items-stretch p-3 justify-content-start',
    style: 'overflow:hidden;height: 100%;',
    children: [
      a(
        className: 'navbar-brand m-1 d-flex flex-column',
        href: '#',
        children: [
          txt('Bootstrap Dart'),
          div(
            style: flexCenter(),
            children: [
              icon(BIcon.bootstrap_fill, color: '#7a10f7'),
              span(style: 'width:10px;'),
              img(src: 'https://pub.dev/favicon.ico', style: 'width:1.25rem;')
            ],
          ),
        ],
      ),
      nav(
        className: 'nav nav-pills flex-column',
        children: [
          ...const [
            'Buttons',
            'Button Group',
            'Icons',
            'Alerts',
            'Badge',
            'Close Button',
            'Collapse',
            'Dropdown',
            'Tooltip',
            'Popover',
            'Spinners',
            'Toasts',
            'Navbar',
            'Modal',
            'Offcanvas',
            'ScrollSpy',
          ].map(
            (e) => a(
              className: 'nav-link',
              href: '#${e.replaceAll(' ', '-')}',
              children: [
                txt(e),
              ],
            ),
          ),
        ],
      )
    ],
  );
}

DeactNode _allExamples(ComponentContext ctx) {
  return el(
    'div',
    attributes: {
      'style': 'display:flex;flex-direction: column;align-items: center;'
          'width:100%;position:relative;',
    },
    children: [
      bootstrapExample(
        'Buttons',
        content: div(
          className: 'hstack gap-3 align-self-center',
          children: [
            button(
              className: btn(),
              children: [txt('primary')],
            ),
            button(
              className: btn(outlined: true, color: BColor.danger),
              children: [txt('danger-outlined')],
            ),
            button(
              className: btn(size: BSize.lg, color: BColor.secondary),
              children: [txt('secondary-lg')],
            ),
            button(
              className: btn(size: BSize.sm, color: BColor.dark),
              children: [txt('dark-sm')],
            ),
            button(
              className: btn(active: true),
              children: [txt('primary-active')],
            ),
          ],
        ),
        example: codeSection('''
button(
  className: btn(),
  children: [txt('primary')],
),
button(
  className: btn(outlined: true, color: BColor.danger),
  children: [txt('danger-outlined')],
),
button(
  className: btn(size: BSize.lg, color: BColor.secondary),
  children: [txt('secondary-lg')],
),
button(
  className: btn(size: BSize.sm, color: BColor.dark),
  children: [txt('dark-sm')],
),
button(
  className: btn(active: true),
  children: [txt('primary-active')],
),
'''),
      ),
      bootstrapExample(
        'Button Group',
        content: fc(
          (ctx) {
            final value1 = ctx.state('value1', 'Left');
            final value2 = ctx.state('value2', {'B', 'C'});
            final value3 = ctx.state<String?>('value3', null);

            return div(
              className: 'hstack gap-3 align-self-center',
              children: [
                buttonGroup<String>(
                  buttonClass: btn(outlined: true),
                  renderItem: (str) => [txt(str)],
                  selection: UserSelection.single(value1.value, (selected) {
                    value1.value = selected;
                  }),
                  values: const ['Left', 'Middle', 'Right'],
                ),
                buttonGroup<String>(
                  size: BSize.sm,
                  buttonClass: btn(outlined: true, color: BColor.dark),
                  renderItem: (str) => [txt(str)],
                  selection: UserSelection.many(value2.value, (selected) {
                    value2.value = selected;
                  }),
                  values: const ['A', 'B', 'C', 'D', 'E'],
                ),
                buttonGroup<String>(
                  size: BSize.lg,
                  vertical: true,
                  buttonClass: btn(outlined: true),
                  renderItem: (str) => [txt(str)],
                  selection:
                      UserSelection.indeterminate(value3.value, (selected) {
                    value3.value = selected;
                  }),
                  values: const ['Top', 'Bottom'],
                ),
              ],
            );
          },
        ),
      ),
      bootstrapExample(
        'Icons',
        url: 'https://icons.getbootstrap.com/',
        content: div(
          className: 'd-flex justify-content-evenly',
          style: 'width:200px;align-self:center;align-items:center;',
          children: [
            icon(BIcon.alarm, ariaLabel: 'Alarm'),
            icon(BIcon.alarm, color: 'blue'),
            icon(BIcon.alarm, color: 'blue', fontSize: '2rem'),
            icon(BIcon.lightning, color: 'grey'),
          ],
        ),
        example: codeSection('''
icon(BIcon.alarm, ariaLabel: 'Alarm'),
icon(BIcon.alarm, color: 'blue'),
icon(BIcon.alarm, color: 'blue', fontSize: '2rem'),
icon(BIcon.lightning, color: 'grey'),
'''),
      ),
      bootstrapExample(
        'Alerts',
        content: div(
          className: 'd-flex flex-column align-items-center',
          children: [
            div(
              className: alert(color: BColor.info),
              children: [txt('Info Alert')],
            ),
            div(
              className: alert(color: BColor.success),
              children: [
                el(
                  'h4',
                  attributes: {'class': 'alert-heading'},
                  children: [txt('Alert heading')],
                ),
                txt('Success message for Alert with heading'),
              ],
            ),
          ],
        ),
        example: codeSection('''
div(
  className: alert(color: BColor.info),
  children: [txt('Info Alert')],
),
div(
  className: alert(color: BColor.success),
  children: [
    el(
      'h4',
      attributes: {'class': 'alert-heading'},
      children: [txt('Alert heading')],
    ),
    txt('Success message for Alert with heading'),
  ],
),
'''),
      ),
      bootstrapExample(
        'Badge',
        content: div(
          className: 'd-flex justify-content-evenly',
          children: [
            div(
              className: badge(color: BColor.info),
              children: [txt('Info Alert')],
            ),
            div(
              className: badge(color: BColor.success, rounded: true),
              children: [txt('Success rounded')],
            ),
            div(
              className: badge(color: BColor.primary, rounded: true),
              children: [txt('49')],
            ),
          ],
        ),
        example: codeSection('''
div(
  className: badge(color: BColor.info),
  children: [txt('Info Alert')],
),
div(
  className: badge(color: BColor.success, rounded: true),
  children: [txt('Success rounded')],
),
div(
  className: badge(color: BColor.primary, rounded: true),
  children: [txt('49')],
),
'''),
      ),
      bootstrapExample(
        'Close Button',
        content: div(
          className: 'd-flex justify-content-evenly',
          children: [
            closeButton(),
            div(
              className: 'bg-success rounded-3 p-2 text-light d-flex',
              children: [
                span(className: 'pe-2', children: [txt('White close button')]),
                closeButton(white: true)
              ],
            ),
            closeButton(disabled: true),
          ],
        ),
      ),

      /// Collapse
      collapseExample(),

      /// TODO: Split button,
      bootstrapExample(
        'Dropdown',
        content: div(
          className: 'd-flex justify-content-evenly',
          children: [
            dropdown(
              buttonClass: btn(),
              buttonContent: [txt('Dropdown Button')],
              children: [
                ...['Option A', 'Option B', null, 'More Options'].map(
                  (e) {
                    if (e == null) {
                      return dropdownDivider;
                    } else {
                      return dropdownItem(
                        children: [txt(e)],
                        onClick: (_) {},
                      );
                    }
                  },
                )
              ],
            ),
            fc((ctx) {
              final selected = ctx.state<String>('selected', 'Option A');
              return dropdown(
                buttonClass: btn(outlined: true),
                buttonContent: [txt(selected.value)],
                menuOnEnd: true,
                direction: Direction.end,
                children: [
                  ...['Option A', 'Option B', null, 'More Options'].map(
                    (e) {
                      if (e == null) {
                        return dropdownDivider;
                      } else {
                        return dropdownItem(
                          active: selected.value == e,
                          onClick: (_) {
                            selected.value = e;
                          },
                          children: [txt(e)],
                        );
                      }
                    },
                  )
                ],
              );
            })
          ],
        ),
      ),
      bootstrapExample(
        'Tooltip',
        // TODO: tooltip in text
        content: div(
          className: 'd-flex justify-content-evenly',
          children: [
            tooltipWrapper(
              title: 'Tooltip title',
              children: [
                button(
                  className: btn(),
                  children: [txt('Button')],
                ),
              ],
            ),
            tooltipWrapper(
              title: '<em>Tooltip</em> <u>with</u> <b>HTML</b>'
                  '<br>placed right<br>with "5,5" offset',
              attributes: tooltipAttributes(
                allowHtml: true,
                placement: Placement.right,
                offset: '5,5',
              ),
              children: [
                button(
                  className: btn(),
                  children: [txt('Custom HTML Tooltip')],
                ),
              ],
            ),
          ],
        ),
      ),
      bootstrapExample(
        'Popover',
        content: div(
          style:
              flexStyle(main: AxisAlign.space_evenly, cross: AxisAlign.center),
          children: [
            popoverWrapper(
              attributes: popoverAttributes(title: 'popover title'),
              content: 'popover content',
              children: [
                button(
                  className: btn(),
                  children: [txt('Button')],
                ),
              ],
            ),
            popoverWrapper(
              attributes: popoverAttributes(
                triggers: [TooltipTrigger.focus, TooltipTrigger.hover],
              ),
              content: 'popover content',
              children: [
                a(
                  href: '#',
                  children: [txt('Link hover and focus trigger')],
                ),
              ],
            ),
            // el(
            //   'a',
            //   attributes: {
            //     ...popoverAttributes(
            //       content: 'popover content',
            //       triggers: [TooltipTrigger.focus, TooltipTrigger.hover],
            //     ),
            //     'href': '#',
            //   },
            //   children: [txt('Link hover and focus trigger')],
            // ),
            popoverWrapper(
              content: '<em>popover</em> <u>with</u> <b>HTML</b>'
                  '<br>placed bottom<br>with "25,8" offset',
              attributes: popoverAttributes(
                allowHtml: true,
                placement: Placement.bottom,
                offset: '25,8',
              ),
              children: [
                button(
                  className: btn(),
                  children: [txt('Custom HTML popover')],
                ),
              ],
            ),
          ],
        ),
      ),
      bootstrapExample(
        'Spinners',
        content: div(
          className: 'd-flex justify-content-evenly align-items-center',
          children: [
            spinner(),
            spinner(grow: true, color: BColor.success),
            spinner(color: BColor.dark, size: BSize.sm),
            spinner(grow: true, size: BSize.sm),
            button(
              className: btn(),
              children: [
                spinner(
                  size: BSize.sm,
                  ariaHidden: true,
                  color: BColor.light,
                  className: 'me-2',
                ),
                txt('Loading'),
              ],
            ),
          ],
        ),
      ),

      /// TODO: Card
      ///
      bootstrapExample(
        'Toasts',
        content: div(
          style: 'height:300px',
          children: [
            fc((ctx) {
              final withHeader = ctx.ref('withHeader', true);
              final ref = ctx.refProvided(
                'controller',
                () => ToastsController(),
              );
              final text = ctx.state('text', 'A message');

              return div(
                className: 'd-flex flex-column',
                style: 'position:relative;height:100%;',
                children: [
                  div(
                    className: 'm-2',
                    style: 'width:400px;display:flex;align-items:center;',
                    children: [
                      input(
                        className: 'form-control px-2',
                        value: text.value,
                        oninput: (e) => text.value =
                            (e.target! as html.InputElement).value!,
                      ),
                      el('span', attributes: {'style': 'width:10px'}),
                      button(
                        className: btn(),
                        onclick: (_) => ref.value.add(
                          toastContent(
                            showCloseButton: true,
                            header: withHeader.value ? [txt('A Header')] : null,
                            body: [txt(text.value)],
                          ),
                        ),
                        children: [txt('Show')],
                      ),
                      el('span', attributes: {'style': 'width:10px'}),
                      check(
                        checked: withHeader.value,
                        onChange: (checked) {
                          withHeader.value = checked;
                        },
                        label: span(
                          style: 'white-space: nowrap;',
                          children: [
                            txt('With Header'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  ref.value.render(),
                ],
              );
            })
          ],
        ),
      ),

      bootstrapExample(
        'Navbar',
        content: div(
          className: 'd-flex flex-column',
          children: [
            fc((ctx) {
              final _navLinks = [
                el(
                  'a',
                  attributes: {
                    'class': 'nav-link active',
                    'href': '#',
                    'aria-current': 'page',
                  },
                  children: [txt('Home')],
                ),
                el(
                  'a',
                  attributes: {
                    'class': 'nav-link',
                    'href': '#',
                  },
                  children: [txt('Documentation')],
                ),
                el(
                  'a',
                  attributes: {
                    'class': 'nav-link',
                    'href': '#',
                  },
                  children: [txt('Demo')],
                ),
                el(
                  'a',
                  attributes: {
                    'class': 'nav-link disabled',
                    'href': '#',
                    'tabindex': '-1',
                    'aria-disabled': true,
                  },
                  children: [txt('Disabled')],
                ),
              ];

              return fragment(
                [
                  navbar(
                    expand: ModalFullScreenBellow.lg,
                    background: BColor.light,
                    collapseId: 'nav-bar-example-collapse',
                    // position: NavbarPosition.fixed_bottom,
                    brand: [
                      txt('Navbar Brand'),
                    ],
                    itemList: [
                      div(
                        className: 'navbar-nav me-auto',
                        children: _navLinks,
                      ),
                      form(
                        className: 'd-flex',
                        children: [
                          input(
                            className: 'form-control me-2',
                            type: 'search',
                            placeholder: 'Search',
                          ),
                          button(
                            className: btn(),
                            type: 'submit',
                            children: [txt('Search')],
                          )
                        ],
                      ),
                    ],
                  ),
                  navbar(
                    expand: null,
                    background: BColor.dark,
                    dark: true,
                    collapseId: 'nav-bar-example-collapse-dark',
                    attributes: {'style': 'margin-top:20px;'},
                    // position: NavbarPosition.fixed_bottom,
                    brand: [
                      txt('Collapsed Dark Brand'),
                    ],
                    itemList: [
                      div(
                        className: 'navbar-nav me-auto',
                        children: _navLinks,
                      ),
                      form(
                        className: 'd-flex',
                        children: [
                          input(
                            className: 'form-control me-2',
                            type: 'search',
                            placeholder: 'Search',
                          ),
                          button(
                            className: btn(),
                            type: 'submit',
                            children: [txt('Search')],
                          )
                        ],
                      ),
                    ],
                  )
                ],
              );
            }),
          ],
        ),
      ),

      bootstrapExample(
        'Modal',
        content: div(
          children: [
            fc((ctx) {
              final fade = ctx.state('fade', true);
              final focus = ctx.state('focus', true);
              final closeOnClick = ctx.state('closeOnClick', true);
              final closeOnEscKey = ctx.state('closeOnEscKey', true);
              final backdrop = ctx.state('backdrop', true);
              //
              final center = ctx.state('center', true);
              final fullscreen = ctx.state('fullscreen', false);
              final scrollable = ctx.state('scrollable', false);
              final size = ctx.state<DialogSize?>('size', null);

              final ref = ctx.ref<Modal?>('modal', null);

              const modalId = 'example-modal-id';

              return div(
                className: 'd-flex flex-column',
                style: 'position:relative;height:100%;',
                children: [
                  div(
                    className: 'm-2',
                    style:
                        'display:flex;align-items:center;justify-content: center;',
                    children: [
                      el(
                        'button',
                        attributes: {
                          'class': btn(),
                          ...toggleButtonAttributes(
                            component: TogglableComponent.modal,
                            targetId: modalId,
                          ),
                        },
                        children: [txt('Toggle with attributes')],
                      ),
                      el('span', attributes: {'style': 'width:10px'}),
                      button(
                        className: btn(),
                        onclick: (_) => ref.value!.toggle(),
                        children: [txt('Toggle with ref')],
                      ),
                      el('span', attributes: {'style': 'width:10px'}),
                    ],
                  ),
                  div(
                    children: [
                      check(
                        checked: fade.value,
                        inline: true,
                        onChange: (checked) => fade.value = checked,
                        label: txt('fade'),
                      ),
                      check(
                        checked: focus.value,
                        inline: true,
                        onChange: (checked) => focus.value = checked,
                        label: txt('focus'),
                      ),
                      check(
                        checked: closeOnClick.value,
                        inline: true,
                        onChange: (checked) => closeOnClick.value = checked,
                        label: txt('closeOnClick'),
                      ),
                      check(
                        checked: closeOnEscKey.value,
                        inline: true,
                        onChange: (checked) => closeOnEscKey.value = checked,
                        label: txt('closeOnEscKey'),
                      ),
                      check(
                        checked: backdrop.value,
                        inline: true,
                        onChange: (checked) => backdrop.value = checked,
                        label: txt('backdrop'),
                      ),
                    ],
                  ),
                  div(
                    className:
                        'd-flex justify-content-center align-items-center',
                    children: [
                      div(
                        children: [
                          check(
                            checked: center.value,
                            inline: true,
                            onChange: (checked) => center.value = checked,
                            label: txt('center'),
                          ),
                          check(
                            checked: fullscreen.value,
                            inline: true,
                            onChange: (checked) => fullscreen.value = checked,
                            label: txt('fullscreen'),
                          ),
                          check(
                            checked: scrollable.value,
                            inline: true,
                            onChange: (checked) => scrollable.value = checked,
                            label: txt('scrollable'),
                          ),
                        ],
                      ),
                      select(
                        className: 'form-select',
                        style: 'width:150px;',
                        onchange: (e) {
                          final value = (e.target! as html.SelectElement).value;
                          if (value == '') {
                            size.value = null;
                          } else {
                            size.value = DialogSize.values
                                .firstWhere((v) => v.name == value);
                          }
                        },
                        children: [
                          option(
                            value: '',
                            selected: size.value == null ? '' : null,
                            children: [txt('default size')],
                          ),
                          ...DialogSize.values.map(
                            (e) => option(
                              value: e.name,
                              selected: size.value == e ? '' : null,
                              children: [txt(e.name)],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  modal(
                    id: modalId,
                    closeOnClick: closeOnClick.value,
                    closeOnEscKey: closeOnEscKey.value,
                    fade: fade.value,
                    focus: focus.value,
                    modalRef: ref,
                    backdrop: backdrop.value,
                    dialog: modalDialog(
                      dialogClass: modalDialogClass(
                        center: center.value,
                        fullScreen: fullscreen.value
                            ? ModalFullScreenBellow.always
                            : null,
                        scrollable: scrollable.value,
                        size: size.value,
                      ),
                      body: [
                        scrollable.value
                            ? el('div', attributes: {
                                'style': 'height: 2000px;'
                                    'background-image:linear-gradient(white, #8fb6ff);'
                              })
                            : txt('Body'),
                      ],
                      header: [txt('Header')],
                      footer: [
                        span(className: 'me-5', children: [txt('Footer')]),
                        el(
                          'button',
                          attributes: {
                            'class': btn(),
                            'type': "button",
                            'data-bs-dismiss': "modal",
                          },
                          children: [txt('Dismiss with attributes')],
                        ),
                        button(
                          className: btn(),
                          onclick: (_) => ref.value!.hide(),
                          children: [txt('Hide with ref')],
                        ),
                      ],
                    ),
                  )
                ],
              );
            })
          ],
        ),
      ),

      bootstrapExample(
        'Offcanvas',
        content: div(
          children: [
            fc((ctx) {
              final backdrop = ctx.state('backdrop', true);
              final keyboard = ctx.state('keyboard', true);
              final scroll = ctx.state('scroll', false);
              final offcanvasRef = ctx.ref<Offcanvas?>('offcanvasRef', null);

              final placement = ctx.state<OffcanvasPlacement>(
                  'placement', OffcanvasPlacement.end);
              const labelId = 'offcanvas-example-label';

              return fragment([
                el(
                  'button',
                  attributes: {
                    'class': btn() + 'm-2',
                    ...toggleButtonAttributes(
                      component: TogglableComponent.offcanvas,
                      targetId: 'offcanvas-example',
                    ),
                  },
                  children: [txt('Toggle by attributes')],
                ),
                button(
                  className: btn() + 'm-2',
                  onclick: (_) => offcanvasRef.value!.toggle(),
                  children: [txt('Toggle by ref')],
                ),
                _simpleCheck('backdrop', backdrop),
                _simpleCheck('keyboard', keyboard),
                _simpleCheck('scroll', scroll),
                dropdown(
                  buttonClass: btn(outlined: true),
                  buttonContent: [txt('Placement: ${placement.value.name}')],
                  children: [
                    ...OffcanvasPlacement.values.map(
                      (e) => dropdownItem(
                        onClick: (_) => placement.value = e,
                        active: placement.value == e,
                        children: [txt(e.name)],
                      ),
                    )
                  ],
                ),
                offcanvas(
                  attributes: offcanvasAttributes(
                    placement: placement.value,
                    id: 'offcanvas-example',
                    backdrop: backdrop.value,
                    keyboard: keyboard.value,
                    scroll: scroll.value,
                    labelledBy: labelId,
                  ),
                  offcanvasRef: offcanvasRef,
                  labelId: labelId,
                  title: [txt('Title')],
                  body: [
                    txt('Laudantium ex tempora ratione illo velit sed asperiores.'),
                  ],
                ),
              ]);
            }),
          ],
        ),
      ),

      bootstrapExample(
        'ScrollSpy',
        content: div(
          className: 'row mx-1',
          children: [
            div(
              className: 'col-4',
              children: [
                div(
                  className: 'nav list-group',
                  id: 'list-example',
                  children: [
                    a(
                      className:
                          'list-group-item list-group-item-action nav-link',
                      href: '#list-item-1',
                      children: [txt('Item 1')],
                    ),
                    a(
                      className:
                          'list-group-item list-group-item-action nav-link',
                      href: '#list-item-2',
                      children: [txt('Item 2')],
                    ),
                    a(
                      className:
                          'list-group-item list-group-item-action nav-link',
                      href: '#list-item-3',
                      children: [txt('Item 3')],
                    ),
                    a(
                      className:
                          'list-group-item list-group-item-action nav-link',
                      href: '#list-item-4',
                      children: [txt('Item 4')],
                    ),
                  ],
                )
              ],
            ),
            div(
              className: 'col-8',
              children: [
                fc((ctx) {
                  final ref = ctx.ref<html.Element?>('element', null);
                  final scrollSpy =
                      useScrollSpy(ctx, ref, target: '#list-example');

                  return el(
                    'div',
                    ref: ref,
                    attributes: {
                      'style':
                          'position:relative;height:200px;overflow-y:scroll;',
                      ...scrollSpy.attributes,
                    },
                    children: [
                      h4(id: 'list-item-1', children: [txt('Item 1')]),
                      p(children: [
                        txt('Esse sapiente non ullam nihil qui quisquam. Molestiae nihil debitis eaque sint neque nisi. Quia a minima veritatis aut distinctio officiis ratione. Culpa explicabo tempore tenetur. Qui rem voluptatem iusto minima ad aut dolores est velit.')
                      ]),
                      h4(id: 'list-item-2', children: [txt('Item 2')]),
                      p(children: [
                        txt('Esse sapiente non ullam nihil qui quisquam. Molestiae nihil debitis eaque sint neque nisi. Quia a minima veritatis aut distinctio officiis ratione. Culpa explicabo tempore tenetur. Qui rem voluptatem iusto minima ad aut dolores est velit.')
                      ]),
                      h4(id: 'list-item-3', children: [txt('Item 3')]),
                      p(children: [
                        txt('Esse sapiente non ullam nihil qui quisquam. Molestiae nihil debitis eaque sint neque nisi. Quia a minima veritatis aut distinctio officiis ratione. Culpa explicabo tempore tenetur. Qui rem voluptatem iusto minima ad aut dolores est velit.')
                      ]),
                      h4(id: 'list-item-4', children: [txt('Item 4')]),
                      p(children: [
                        txt('Esse sapiente non ullam nihil qui quisquam. Molestiae nihil debitis eaque sint neque nisi. Quia a minima veritatis aut distinctio officiis ratione. Culpa explicabo tempore tenetur. Qui rem voluptatem iusto minima ad aut dolores est velit.')
                      ]),
                    ],
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

DeactNode _simpleCheck(String label, State<bool> refCheck) {
  return check(
    checked: refCheck.value,
    inline: true,
    onChange: (checked) => refCheck.value = checked,
    label: txt(label),
  );
}

DeactNode collapseExample() {
  return bootstrapExample(
    'Collapse',
    content: div(
      className: 'col',
      children: [
        div(
          className: 'm-3',
          children: [
            collapseButton(
              collapseId: 'collapseExample',
              buttonClass: btn(
                size: BSize.sm,
                color: BColor.dark,
              ),
              children: [txt('More Info')],
            ),
            div(
              className: '${collapse()} m-2',
              id: 'collapseExample',
              children: [
                div(
                  className: 'card card-body',
                  children: [
                    txt('This is some placeholder content for a horizontal collapse.'
                        " It's hidden by default and shown when triggered."),
                  ],
                ),
              ],
            )
          ],
        ),
        div(
          className: 'm-3',
          children: [
            collapseButton(
              collapseId: 'collapseHorizontalExample',
              buttonClass: btn(),
              children: [txt('More Info Horizontal')],
            ),
            div(
              style: 'height:100px;padding:10px;',
              children: [
                div(
                  className: collapse(horizontal: true, show: true),
                  id: 'collapseHorizontalExample',
                  children: [
                    div(
                      className: 'card card-body',
                      style: "width: 300px;",
                      children: [
                        txt('This is some placeholder content for a horizontal collapse.'
                            " It's hidden by default and shown when triggered.")
                      ],
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

DeactNode bootstrapExample(
  String title, {
  required DeactNode content,
  String? url,
  DeactNode? example,
}) {
  return div(
    key: title,
    id: title.replaceAll(' ', '-'),
    className: 'm-4 w-100 d-flex flex-column',
    style: 'position:relative;',
    children: [
      div(
        children: [
          el('h3', children: [txt(title)]),
          a(
            href: url ??
                'https://getbootstrap.com/docs/5.1/components/'
                    '${title.toLowerCase().replaceAll(' ', '-')}',
            target: '_blank',
            children: [
              txt('Documentation'),
            ],
          )
        ],
      ),
      hr(),
      content,
      if (example != null) example,
    ],
  );
}
