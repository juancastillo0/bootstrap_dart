import 'dart:math' as math;
import 'package:bootstrap_dart/dark_mode/dark_mode.dart';
import 'package:collection/collection.dart';
import 'package:deact/deact.dart';
import 'package:deact/deact_html52.dart';
import 'package:deact_bootstrap/hooks.dart';
import 'package:universal_html/html.dart' as html;
import 'package:highlight/highlight_core.dart' show highlight;
import 'package:highlight/languages/dart.dart';
import 'package:deact_bootstrap/deact_bootstrap.dart';

import 'package:bootstrap_dart/bootstrap/accordion.dart';
import 'package:bootstrap_dart/bootstrap/bootstrap_core.dart';
import 'package:bootstrap_dart/bootstrap/checks_radios.dart';
import 'package:bootstrap_dart/bootstrap/form.dart';
import 'package:bootstrap_dart/bootstrap/icons.dart';
import 'package:bootstrap_dart/bootstrap/modal.dart';
import 'package:bootstrap_dart/bootstrap/navbar.dart';
import 'package:bootstrap_dart/bootstrap/offcanvas.dart';
import 'package:bootstrap_dart/bootstrap/table.dart';
import 'package:bootstrap_dart/bootstrap/toast.dart';
import 'package:bootstrap_dart/bootstrap/tooltip_popover.dart';
import 'package:bootstrap_dart/bootstrap/typography.dart';

import 'generated_example_snippets.dart';

DeactNode codeSection(String dartCode) {
  const _maxLength = 999999999999;
  final int prefixSpaces = dartCode.split('\n').where((e) => e.isNotEmpty).fold(
        _maxLength,
        (c, element) => math.min(
            c, RegExp(r'^(\s+)').firstMatch(element)?.group(1)?.length ?? 0),
      );
  if (prefixSpaces != _maxLength) {
    dartCode = dartCode
        .split('\n')
        .map((e) => e.isEmpty ? '' : e.substring(prefixSpaces))
        .join('\n');
  }
  highlight.registerLanguage('dart', dart);
  final highlighted = highlight.parse(dartCode, language: 'dart');
  DeactNode _copyCode(String className) {
    return button(
      className: className,
      onclick: (_) => html.window.navigator.clipboard?.writeText(dartCode),
      children: [
        icon(BIcon.clipboard),
        el('span', attributes: {
          'style': 'padding-left:10px;'
        }, children: [
          txt('Copy code'),
        ]),
      ],
    );
  }

  return div(
    children: [
      div(
        className: 'mt-3 mb-2 d-flex justify-content-center align-items-center',
        children: [
          // txt('Example Code'),
          // el('span', attributes: {'style': 'width:40px;'}),
          _copyCode(btn(color: BColor.dark, size: BSize.sm) + ' me-2'),
          fc((ctx) {
            final showModal = ctx.hookState(() => false);
            final modalRef = ctx.hookRef<Modal?>(() => null);
            ctx.hookEffect(() {
              if (showModal.value) {
                modalRef.value!.show();
                final subs = modalRef.value!.events.listen((event) {
                  if (event.type == ModalEventType.hidden) {
                    showModal.value = false;
                  }
                });
                return subs.cancel;
              }
            }, [showModal.value]);
            return fragment([
              button(
                className: btn(color: BColor.dark, size: BSize.sm),
                onclick: (_) => showModal.value = !showModal.value,
                children: [
                  icon(BIcon.clipboard),
                  el('span', attributes: {
                    'style': 'padding-left:10px;'
                  }, children: [
                    txt('FullScreen code'),
                  ]),
                ],
              ),
              if (showModal.value)
                modal(
                  id: 'example-code-modal',
                  modalRef: modalRef.bootstrapRef,
                  dialog: modalDialog(
                    dialogClass: modalDialogClass(
                      scrollable: true,
                      fullScreen: ResponsiveBreakPoint.always,
                    ),
                    // header: [
                    //   h5(
                    //     className: 'm-0 ${BText.userSelectNone}',
                    //     children: [txt('Example code')],
                    //   ),
                    //   closeButton(attributes: {'data-bs-dismiss': 'modal'}),
                    // ],
                    body: [
                      ElementNode.fromHtml(
                        html.Element.tag('code')
                          ..className = 'codebox'
                          ..setInnerHtml(highlighted.toHtml()),
                      ),
                    ],
                    footer: [
                      _copyCode(btn(color: BColor.dark) + ' me-2'),
                      el(
                        'button',
                        attributes: {
                          'class': btn(),
                          'type': "button",
                          'data-bs-dismiss': "modal",
                        },
                        children: [txt('Close')],
                      ),
                    ],
                  ),
                )
            ]);
          }),
        ],
      ),
      ElementNode.fromHtml(
        html.Element.tag('code')
          ..className = 'codebox'
          ..style.maxHeight = '300px'
          ..style.maxWidth = '90%'
          ..setInnerHtml(highlighted.toHtml()),
      )
    ],
  );
}

DeactNode bootstrapExamples() {
  return fc((ctx) => _allExamples(ctx));
}

DeactNode examplesNavbar() {
  return fc(
    (ctx) {
      final inDarkMode = useStream(
        ctx,
        darkMode.inDarkModeChanges,
        initialValue: () => darkMode.inDarkMode,
      ).asValue!.value;
      return nav(
        id: 'navbar-example',
        className:
            'navbar ${inDarkMode ? 'navbar-dark bg-dark' : 'navbar-light bg-light'}'
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
                  img(
                    src: 'https://pub.dev/favicon.ico',
                    style: 'width:1.25rem;',
                  )
                ],
              ),
            ],
          ),
          check(
            label: txt('Dark Mode'),
            id: 'darkModeSwitch',
            divClass: 'mb-2 mx-auto',
            type: CheckType.switch_,
            checked: inDarkMode,
            inline: true,
            onChange: (_) {
              darkMode.toggleDarkMode();
            },
          ),
          nav(
            className: 'nav nav-pills flex-column',
            style: 'overflow-y:auto;flex:1;flex-wrap:nowrap;',
            children: [
              ...const [
                'Accordion',
                'Buttons',
                'Button Group',
                'Icons',
                'Alerts',
                'Badge',
                'Close Button',
                'Collapse',
                'Dropdowns',
                'Table',
                'Tooltip',
                'Popover',
                'Spinners',
                'Toasts',
                'Forms',
                'Navs Tabs',
                'Navbar',
                'Modal',
                'Offcanvas',
                'Placeholder',
                'ScrollSpy',
              ].map(
                (e) => a(
                  className: 'nav-link',
                  style: 'padding-top:5px;padding-bottom:5px;',
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
    },
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
        'Accordion',
        example: codeSection(bootstrap_accordion_example),
        content: div(
          children: [
            fc((ctx) {
              final flush = ctx.hookState(() => false);
              final multipleOpened = ctx.hookState(() => false);

              return div(
                className: 'd-flex flex-column mx-3',
                style: '',
                children: [
                  div(
                    className: 'mb-2',
                    style: flexCenter(),
                    children: [
                      check(
                        label: txt('flush'),
                        inline: true,
                        name: 'flush',
                        checked: flush.value,
                        type: CheckType.switch_,
                        onChange: (checked) => flush.value = checked,
                      ),
                      check(
                        label: txt('multipleOpened'),
                        inline: true,
                        name: 'multipleOpened',
                        checked: multipleOpened.value,
                        type: CheckType.switch_,
                        onChange: (checked) => multipleOpened.value = checked,
                      ),
                    ],
                  ),
// @example-start{bootstrap-accordion-example}
                  accordion(
                    id: 'accordion-example',
                    flush: flush.value,
                    multipleOpened: multipleOpened.value,
                    items: {
                      'item1': AccordionItem(
                        header: [txt('Header 1')],
                        body: [txt('Body 1')],
                      ),
                      'item2': AccordionItem(
                        header: [txt('Header 2')],
                        body: [txt('Body 2')],
                      ),
                      'item3': AccordionItem(
                        header: [txt('Header 3')],
                        body: [txt('Body 3')],
                      ),
                    },
                  ),
// @example-end{bootstrap-accordion-example}
                ],
              );
            })
          ],
        ),
      ),

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
        example: codeSection(bootstrap_button_group_example),
// @example-start{bootstrap-button-group-example}
        content: fc(
          (ctx) {
            final value1 = ctx.hookState(() => 'Left');
            final value2 = ctx.hookState(() => {'B', 'C'});
            final value3 = ctx.hookState<String?>(() => null);

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
// @example-end{bootstrap-button-group-example}
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
        example: codeSection(bootstrap_close_button_example),
// @example-start{bootstrap-close-button-example}
        content: div(
          className: 'd-flex justify-content-evenly',
          children: [
            closeButton(),
            div(
              className: 'bg-success rounded-3 p-2 text-white d-flex',
              children: [
                span(className: 'pe-2', children: [txt('White close button')]),
                closeButton(white: true)
              ],
            ),
            closeButton(disabled: true),
          ],
        ),
// @example-end{bootstrap-close-button-example}
      ),

      /// Collapse
      collapseExample(),

      /// TODO: Split button,
      bootstrapExample(
        'Dropdowns',
        example: codeSection(bootstrap_dropdown_example),
// @example-start{bootstrap-dropdown-example}
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
              final selected = ctx.hookState<String>(() => 'Option A');
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
// @example-end{bootstrap-dropdown-example}
      ),

      bootstrapExample(
        'Table',
        example: codeSection(bootstrap_table_example),
        content: div(
          children: [
            fc((ctx) {
              final hover = ctx.hookState(() => false);
              final bordered = ctx.hookState(() => false);
              final borderless = ctx.hookState(() => false);
              final captionTop = ctx.hookState(() => false);
              final showCaption = ctx.hookState(() => false);
              final showFooter = ctx.hookState(() => false);
              final striped = ctx.hookState(() => false);
              final small = ctx.hookState(() => false);
              final color = ctx.hookState<BColor?>(() => null);
              final headerColor = ctx.hookState<BColor?>(() => null);
              final align = ctx.hookState<VerticalAlign?>(() => null);
              final scrollHorizontal =
                  ctx.hookState<ResponsiveBreakPoint?>(() => null);

              final items = [
                {'first': 'Mark', 'last': 'Otto', 'handle': '@mdo'},
                {'first': 'Jacob', 'last': 'Thornton', 'handle': '@fat'},
                {'first': 'Larry the Bird', 'last': null, 'handle': '@twitter'},
              ];

              return div(
                className: 'd-flex flex-column mx-3',
                children: [
                  div(
                    className: 'mb-2 d-flex flex-wrap',
                    style: flexCenter(),
                    children: [
                      _simpleCheck('hover', hover),
                      _simpleCheck('bordered', bordered),
                      _simpleCheck('borderless', borderless),
                      _simpleCheck('striped', striped),
                      _simpleCheck('small', small),
                      _simpleCheck('showCaption', showCaption),
                      _simpleCheck('captionTop', captionTop),
                      _simpleCheck('showFooter', showFooter),
                      _simpleSelect<BColor?>(
                        [null, ...BColor.values],
                        (color) => color?.name ?? 'color',
                        color,
                      ),
                      _simpleSelect<VerticalAlign?>(
                        [null, ...VerticalAlign.values],
                        (align) => align?.nameHtml ?? 'align',
                        align,
                      ),
                      _simpleSelect<BColor?>(
                        [null, ...BColor.values],
                        (color) => color?.name ?? 'header color',
                        headerColor,
                      ),
                      _simpleSelect<ResponsiveBreakPoint?>(
                        [null, ...ResponsiveBreakPoint.values],
                        (color) => color?.name ?? 'scroll breakpoint',
                        scrollHorizontal,
                      ),
                    ],
                  ),
// @example-start{bootstrap-table-example}
                  table(
                    className: tableClass(
                      hover: hover.value,
                      bordered: bordered.value,
                      borderless: borderless.value,
                      captionTop: captionTop.value,
                      striped: striped.value,
                      small: small.value,
                      color: color.value,
                      align: align.value,
                      scrollHorizontal: scrollHorizontal.value,
                    ),
                    children: [
                      if (showCaption.value)
                        caption(children: [txt('List of users')]),
                      thead(
                        className: headerColor.value == null
                            ? null
                            : tableClass(color: headerColor.value),
                        children: [
                          tr(
                            children: [
                              th(scope: 'col', children: [txt('#')]),
                              th(scope: 'col', children: [txt('First')]),
                              th(scope: 'col', children: [txt('Last')]),
                              th(scope: 'col', children: [txt('Handle')]),
                            ],
                          ),
                        ],
                      ),
                      tbody(
                        children: [
                          ...items.mapIndexed(
                            (index, item) => tr(
                              children: [
                                th(
                                    scope: 'row',
                                    children: [txt('${index + 1}')]),
                                td(
                                  colspan:
                                      (item['last'] != null ? 1 : 2).toString(),
                                  children: [txt(item['first'] as String)],
                                ),
                                if (item['last'] != null)
                                  td(children: [txt(item['last'] as String)]),
                                td(children: [txt(item['handle'] as String)]),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (showFooter.value)
                        tfoot(
                          children: [
                            tr(
                              children: Iterable.generate(
                                4,
                                (index) => td(
                                  children: [txt('Footer $index')],
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
// @example-end{bootstrap-table-example}
                ],
              );
            })
          ],
        ),
      ),

      bootstrapExample(
        'Tooltip',
        example: codeSection(bootstrap_tooltip_example),
        // TODO: tooltip in text
// @example-start{bootstrap-tooltip-example}
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
                placement: TooltipPlacement.right,
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
// @example-end{bootstrap-tooltip-example}
      ),
      bootstrapExample(
        'Popover',
        example: codeSection(bootstrap_popover_example),
// @example-start{bootstrap-popover-example}
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
                placement: TooltipPlacement.bottom,
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
// @example-end{bootstrap-popover-example}
      ),
      bootstrapExample(
        'Spinners',
        example: codeSection(bootstrap_spinners_example),
// @example-start{bootstrap-spinners-example}
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
// @example-end{bootstrap-spinners-example}
      ),

      /// TODO: Card
      ///
      bootstrapExample(
        'Toasts',
        example: codeSection(bootstrap_toasts_example),
// @example-start{bootstrap-toasts-example}
        content: div(
          style: 'height:300px',
          children: [
            fc((ctx) {
              final withHeader = ctx.hookRef(() => true);
              final controller = ctx.hookRef(() => ToastsController()).value;
              final text = ctx.hookState(() => 'A message');

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
                        onclick: (_) => controller.add(
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
                  div(
                    className: 'bg-light flex-grow-1',
                    children: [
                      controller.render(),
                    ],
                  )
                ],
              );
            })
          ],
        ),
// @example-end{bootstrap-toasts-example}
      ),

      bootstrapExample(
        'Forms',
        example: codeSection(bootstrap_forms_example),
        url: 'https://getbootstrap.com/docs/5.1/forms/overview/',
// @example-start{bootstrap-forms-example}
        content: fc((ctx) {
          final size = ctx.hookState<BSize?>(() => null);
          final floating = ctx.hookState(() => true);
          final tooltipValidation = ctx.hookState(() => false);
          final switchState = ctx.hookState(() => false);
          final radioState = ctx.hookState<String?>(() => null);
          final checkState = ctx.hookState(() => false);
          final selectState = ctx.hookState(() => 'A');
          const divClass = ' col-md-4 py-2';

          return div(
            className: 'd-flex flex-column',
            children: [
              div(
                style: flexCenter(),
                children: [
                  _simpleCheck('floating', floating),
                  _simpleCheck('tooltipValidation', tooltipValidation),
                  _simpleSelect<BSize?>(
                    [null, ...BSize.values],
                    (v) => v?.name ?? 'default size',
                    size,
                  ),
                ],
              ),
              form(
                className: 'p-3 ${BText.start}',
                children: [
                  div(
                    className: 'row',
                    children: [
                      if (floating.value)
                        div(
                          className: divClass,
                          children: [
                            div(
                              className: inputGroupClass(size: size.value) +
                                  ' flex-nowrap',
                              children: [
                                span(
                                  className: inputGroupTextClass,
                                  children: [txt('@')],
                                ),
                                labeledInput(
                                  divClass: 'flex-grow-1',
                                  label: txt('Label'),
                                  id: 'labeled-input',
                                  floating: floating.value,
                                  input: input(
                                    className:
                                        formControlClass(size: size.value),
                                    type: 'text',
                                    placeholder: 'Placeholder',
                                    id: 'labeled-input',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      else
                        labeledInput(
                          wrapperDivClass: divClass,
                          label: txt('Label'),
                          id: 'labeled-input',
                          floating: floating.value,
                          input: div(
                            className: inputGroupClass(size: size.value),
                            children: [
                              span(
                                className: inputGroupTextClass,
                                children: [txt('@')],
                              ),
                              input(
                                className: formControlClass(size: size.value),
                                type: 'text',
                                placeholder: 'Placeholder',
                                id: 'labeled-input',
                              ),
                            ],
                          ),
                        ),
                      labeledInput(
                        wrapperDivClass: divClass,
                        label: txt('Label Invalid'),
                        id: 'labeled-input-invalid',
                        floating: floating.value,
                        feedback: InputFeedback(
                          tooltip: tooltipValidation.value,
                          invalid: 'Bad job :(',
                        ),
                        input: input(
                          className: formControlClass(
                              size: size.value, isValid: false),
                          type: 'text',
                          placeholder: 'Placeholder Invalid',
                          id: 'labeled-input-invalid',
                        ),
                      ),
                      labeledInput(
                        wrapperDivClass: divClass,
                        label: txt('Label Valid'),
                        id: 'labeled-input-valid',
                        floating: floating.value,
                        feedback: InputFeedback(
                          tooltip: tooltipValidation.value,
                          valid: 'Good job!',
                        ),
                        input: input(
                          className:
                              formControlClass(size: size.value, isValid: true),
                          type: 'text',
                          placeholder: 'Placeholder Valid',
                          id: 'labeled-input-valid',
                        ),
                      ),
                    ],
                  ),
                  fc((ctx) {
                    final colClasses = ColInputClasses(
                      label: 'col-sm-4 col-lg-3'
                          '${size.value != null ? ' col-form-label-${size.value!.name}' : ''}',
                      input: 'col-sm-8 col-lg-9',
                    );
                    return div(
                      children: [
                        h5(
                          className: 'mt-3',
                          children: [txt('Horizontal labels')],
                        ),
                        labeledInput(
                          wrapperDivClass: 'my-2',
                          label: txt('Label TextArea'),
                          id: 'labeled-textarea',
                          divClass: 'row',
                          colClasses: colClasses,
                          input: textarea(
                            className: formControlClass(size: size.value),
                            placeholder: 'Placeholder',
                            style: 'height:100px;',
                            id: 'labeled-textarea',
                          ),
                        ),
                        labeledInput(
                          wrapperDivClass: 'my-2',
                          label: txt('Label Select'),
                          id: 'labeled-select',
                          divClass: 'row',
                          colClasses: colClasses,
                          input: _simpleSelect<String>(
                            ['A', 'B', 'C'],
                            (d) => d,
                            selectState,
                            id: 'labeled-select',
                          ),
                        ),
                        fieldset(
                          id: 'labeled-switch',
                          className: 'row my-2',
                          children: [
                            legend(
                              className:
                                  'col-form-label ${colClasses.label} pt-0',
                              children: [txt('Checks')],
                            ),
                            div(
                              className: colClasses.input,
                              children: [
                                // check(
                                //   checked: switchState.value,
                                //   onChange: (v) => switchState.value = v,
                                //   id: 'labeled-switch',
                                //   label: txt('Switch Label'),
                                //   type: CheckType.switch_,
                                // ),

                                RadiosInput(
                                  name: 'labeled-radio-name',
                                  onChanged: (v) => radioState.value = v,
                                  items: Map.fromIterable(
                                    const ['A', 'B', 'C'],
                                    value: (v) => txt(v as String),
                                  ),
                                  selectedId: radioState.value,
                                ),
                                check(
                                  divClass: 'mt-2',
                                  checked: checkState.value,
                                  onChange: (v) => checkState.value = v,
                                  id: 'labeled-check',
                                  label: txt('Switch Label'),
                                  type: CheckType.checkbox,
                                  isValid: false,
                                  feedback: InputFeedback(
                                    tooltip: tooltipValidation.value,
                                    invalid: 'Invalid feedback',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ],
          );
        }),
// @example-end{bootstrap-forms-example}
      ),

      bootstrapExample(
        'Navs Tabs',
        example: codeSection(bootstrap_navs_tabs_example),
// @example-start{bootstrap-navs-tabs-example}
        content: fc((ctx) {
          final tabType = ctx.hookState(() => TabType.tab);
          final fade = ctx.hookState(() => true);
          final selectedId = ctx.hookState(() => 'tab-item-home');

          return div(
            className: 'd-flex flex-column',
            children: [
              div(
                style: flexCenter(),
                children: [
                  _simpleCheck('fade', fade),
                  _simpleSelect<TabType>(
                    TabType.values,
                    (v) => v.name,
                    tabType,
                  ),
                ],
              ),
              div(
                className: 'm-3',
                children: [
                  tabs(
                    tabContentClass: 'p-4',
                    // tabListClass: 'col-4',
                    type: tabType.value,
                    fade: fade.value,
                    selectedId: selectedId.value,
                    onSelected: (item) => selectedId.value = item.id,
                    items: [
                      TabItem(
                        id: 'tab-item-home',
                        tab: txt('Home'),
                        content: txt('Home content'),
                      ),
                      TabItem(
                        id: 'tab-item-profile',
                        tab: txt('Profile'),
                        content: txt('Profile content'),
                      ),
                      TabItem(
                        id: 'tab-item-contact',
                        tab: txt('Contact'),
                        content: txt('Contact content'),
                      ),
                      TabItem(
                        id: 'tab-item-disabled',
                        tab: txt('Disabled'),
                        content: txt('Disabled content'),
                        disabled: true,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        }),
// @example-end{bootstrap-navs-tabs-example}
      ),

      bootstrapExample(
        'Navbar',
        example: codeSection(bootstrap_navbar_example),
// @example-start{bootstrap-navbar-example}
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
                    expand: ResponsiveBreakPoint.lg,
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
// @example-end{bootstrap-navbar-example}
      ),

      bootstrapExample(
        'Modal',
        example: codeSection(bootstrap_modal_example),
        content: div(
          children: [
            fc((ctx) {
              final fade = ctx.hookState(() => true);
              final focus = ctx.hookState(() => true);
              final closeOnClick = ctx.hookState(() => true);
              final closeOnEscKey = ctx.hookState(() => true);
              final backdrop = ctx.hookState(() => true);
              //
              final center = ctx.hookState(() => true);
              final fullscreen = ctx.hookState(() => false);
              final scrollable = ctx.hookState(() => false);
              final size = ctx.hookState<DialogSize?>(() => null);

              final ref = ctx.hookRef<Modal?>(() => null);

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
// @example-start{bootstrap-modal-example}
                  modal(
                    id: modalId,
                    closeOnClick: closeOnClick.value,
                    closeOnEscKey: closeOnEscKey.value,
                    fade: fade.value,
                    focus: focus.value,
                    modalRef: ref.bootstrapRef,
                    backdrop: backdrop.value,
                    dialog: modalDialog(
                      dialogClass: modalDialogClass(
                        center: center.value,
                        fullScreen: fullscreen.value
                            ? ResponsiveBreakPoint.always
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
                  ),
// @example-end{bootstrap-modal-example}
                ],
              );
            })
          ],
        ),
      ),

      bootstrapExample(
        'Offcanvas',
        example: codeSection(bootstrap_offcanvas_example),
// @example-start{bootstrap-offcanvas-example}
        content: div(
          children: [
            fc((ctx) {
              final backdrop = ctx.hookState(() => true);
              final keyboard = ctx.hookState(() => true);
              final scroll = ctx.hookState(() => false);
              final offcanvasRef = ctx.hookRef<Offcanvas?>(() => null);

              final placement = ctx.hookState<Placement>(() => Placement.end);
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
                    ...Placement.values.map(
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
                  offcanvasRef: offcanvasRef.bootstrapRef,
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
// @example-end{bootstrap-offcanvas-example}
      ),

      bootstrapExample(
        'Placeholder',
        example: codeSection(bootstrap_placeholder_example),
// @example-start{bootstrap-placeholder-example}
        content: div(
          children: [
            fc((ctx) {
              final wave = ctx.hookState(() => false);

              return fragment([
                _simpleCheck('wave', wave),
                div(style: flexCenter(), children: [
                  div(
                    className: placeholder(
                      glow: !wave.value,
                      wave: wave.value,
                      className: 'text-start m-4',
                    ),
                    style: 'width:500px;',
                    children: [
                      span(
                        className: placeholder(
                          size: PlaceholderSize.lg,
                          color: BColor.info,
                          className: 'col-9 mb-1',
                        ),
                      ),
                      span(className: placeholder(className: 'col-7')),
                      span(className: placeholder(className: 'col-4')),
                      span(className: placeholder(className: 'col-4')),
                      span(className: placeholder(className: 'col-6')),
                      span(
                        className: placeholder(
                          size: PlaceholderSize.xs,
                          className: 'col-9 mt-1',
                        ),
                      ),
                      placeholderButton('col-4 ${btn()} mt-2'),
                    ],
                  ),
                ])
                // ElementNode.fromHtml(
                //  html.DivElement()
                //    ..innerHtml = '''
                // <p class="placeholder-glow card-text">
                //   <span class="placeholder col-7"></span>
                //   <span class="placeholder col-4"></span>
                //   <span class="placeholder col-4"></span>
                //   <span class="placeholder col-6"></span>
                //   <span class="placeholder col-8"></span>
                // </p>'''),
              ]);
            }),
          ],
        ),
// @example-end{bootstrap-placeholder-example}
      ),

      bootstrapExample(
        'ScrollSpy',
        example: codeSection(bootstrap_scrollspy_example),
// @example-start{bootstrap-scrollspy-example}
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
                  final ref = ctx.hookRef<html.Element?>(() => null);
                  final scrollSpy = useScrollSpy(
                    ctx.bootstrapCtx,
                    ref.bootstrapRef,
                    target: '#list-example',
                  );
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
// @example-end{bootstrap-scrollspy-example}
      ),
    ],
  );
}

DeactNode _simpleCheck(String label, State<bool> refCheck) {
  return check(
    id: '$label${refCheck.hashCode}-input-check',
    name: label,
    checked: refCheck.value,
    inline: true,
    onChange: (checked) => refCheck.value = checked,
    label: txt(label),
  );
}

DeactNode _simpleSelect<T>(
  List<T> values,
  String Function(T) toString,
  State<T> state, {
  String? id,
}) {
  return select(
    id: id,
    className: 'form-select mx-1',
    style: 'width:170px;',
    onchange: (e) {
      final value = (e.target! as html.SelectElement).value;
      state.value = values.firstWhere((v) => toString(v) == value);
    },
    children: [
      ...values.map(
        (e) => option(
          value: toString(e),
          selected: state.value == e ? '' : null,
          children: [txt(toString(e))],
        ),
      )
    ],
  );
}

DeactNode collapseExample() {
  return bootstrapExample(
    'Collapse',
    example: codeSection(bootstrap_collapse_example),
// @example-start{bootstrap-collapse-example}
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
// @example-end{bootstrap-collapse-example}
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
