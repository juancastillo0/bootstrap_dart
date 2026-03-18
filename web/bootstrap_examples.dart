import 'dart:math' as math;
import 'package:bootstrap_dart/dark_mode/dark_mode.dart';
import 'package:bootstrap_dart/mobx_hooks/hooks.dart';
import 'package:bootstrap_dart/src/prelude.dart';
import 'package:collection/collection.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:mobx/mobx.dart';
import 'package:universal_web/web.dart' as web;
import 'package:highlight/highlight_core.dart' show highlight;
import 'package:highlight/languages/dart.dart';

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

typedef DeactNode = Component;

DeactNode codeSection(String dartCode) {
  const _maxLength = 999999999999;
  final int prefixSpaces = dartCode
      .split('\n')
      .where((e) => e.isNotEmpty)
      .fold(
        _maxLength,
        (c, element) => math.min(
          c,
          RegExp(r'^(\s+)').firstMatch(element)?.group(1)?.length ?? 0,
        ),
      );
  if (prefixSpaces != _maxLength) {
    dartCode = dartCode
        .split('\n')
        .map((e) => e.isEmpty ? '' : e.substring(prefixSpaces))
        .join('\n');
  }
  highlight.registerLanguage('dart', dart);
  final highlighted = highlight.parse(dartCode, language: 'dart');
  DeactNode _copyCode(String classes) {
    return button(
      classes: classes,
      onClick: () => web.window.navigator.clipboard.writeText(dartCode),
      [
        icon(BIcon.clipboard),
        el(
          'span',
          attributes: {'style': 'padding-left:10px;'},
          children: [txt('Copy code')],
        ),
      ],
    );
  }

  return div([
    div(classes: 'mt-3 mb-2 d-flex justify-content-center align-items-center', [
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
        return Component.fragment([
          button(
            classes: btn(color: BColor.dark, size: BSize.sm),
            onClick: () => showModal.value = !showModal.value,
            [
              icon(BIcon.clipboard),
              el(
                'span',
                attributes: {'style': 'padding-left:10px;'},
                children: [txt('FullScreen code')],
              ),
            ],
          ),
          if (showModal.value)
            modal(
              id: 'example-code-modal',
              modalRef: modalRef,
              dialog: modalDialog(
                dialogClass: modalDialogClass(
                  scrollable: true,
                  fullScreen: ResponsiveBreakPoint.always,
                ),
                // header: [
                //   h5(
                //     classes: 'm-0 ${BText.userSelectNone}',
                //     [txt('Example code')],
                //   ),
                //   closeButton(attributes: {'data-bs-dismiss': 'modal'}),
                // ],
                body: [
                  el(
                    'code',
                    attributes: {'class': 'codebox'},
                    children: [RawText(highlighted.toHtml())],
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
            ),
        ]);
      }),
    ]),
    el(
      'code',
      attributes: {'class': 'codebox', 'maxHeight': '300px', 'maxWidth': '90%'},
      children: [RawText(highlighted.toHtml())],
    ),
  ]);
}

DeactNode bootstrapExamples() {
  return fc((ctx) => _allExamples());
}

final darkMode = DarkMode(
  inDarkModeValue: (inDarkMode) {
    final obs = Observable(inDarkMode);
    return SavedValue(
      get: () => obs.value,
      set: (newValue) => obs.value = newValue,
    );
  },
);

DeactNode examplesNavbar() {
  return fc((ctx) {
    final inDarkMode = useStream(
      darkMode.inDarkModeChanges,
      initialValue: () => darkMode.inDarkMode,
    ).asValue!.value;
    return nav(
      id: 'navbar-example',
      classes:
          'navbar ${inDarkMode ? 'navbar-dark bg-dark' : 'navbar-light bg-light'}'
          ' flex-column align-items-stretch p-3 justify-content-start',
      styles: parseStyles('overflow:hidden;height: 100%;'),
      [
        a(classes: 'navbar-brand m-1 d-flex flex-column', href: '', [
          txt('Bootstrap Dart'),
          div(styles: parseStyles(flexCenter()), [
            icon(BIcon.bootstrap_fill, color: '#7a10f7'),
            span(const [], styles: parseStyles('width:10px;')),
            img(
              src: 'https://pub.dev/favicon.ico',
              styles: parseStyles('width:1.25rem;'),
              width: 20,
              height: 20,
              alt: 'Dart Icon',
            ),
          ]),
        ]),
        a(
          classes: 'd-flex justify-content-center',
          href: 'https://github.com/juancastillo0/bootstrap_dart',
          target: Target.blank,
          [
            div(styles: parseStyles(flexCenter()), [
              icon(BIcon.github, style: 'margin-right:5px;'),
              txt('Github Repo'),
            ]),
          ],
        ),
        check(
          label: txt('Dark Mode'),
          id: 'darkModeSwitch',
          divClass: 'my-2 mx-auto',
          type: CheckType.switch_,
          checked: inDarkMode,
          inline: true,
          onChange: (_) {
            darkMode.toggleDarkMode();
          },
        ),
        nav(
          classes: 'nav nav-pills flex-column',
          styles: parseStyles('overflow-y:auto;flex:1;flex-wrap:nowrap;'),
          [
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
                classes: 'nav-link',
                styles: parseStyles('padding-top:5px;padding-bottom:5px;'),
                href: '#${e.replaceAll(' ', '-')}',
                [txt(e)],
              ),
            ),
          ],
        ),
      ],
    );
  });
}

DeactNode _allExamples() {
  return el(
    'div',
    attributes: {
      'style':
          'display:flex;flex-direction: column;align-items: center;'
          'width:100%;position:relative;',
    },
    children: [
      bootstrapExample(
        'Accordion',
        example: codeSection(bootstrap_accordion_example),
        content: div([
          fc((ctx) {
            final flush = ctx.hookState(() => false);
            final multipleOpened = ctx.hookState(() => false);

            return div(classes: 'd-flex flex-column mx-3', [
              div(classes: 'mb-2', styles: parseStyles(flexCenter()), [
                check(
                  label: txt('flush'),
                  id: 'accordion-flush',
                  inline: true,
                  name: 'flush',
                  checked: flush.value,
                  type: CheckType.switch_,
                  onChange: (checked) => flush.value = checked,
                ),
                check(
                  label: txt('multipleOpened'),
                  id: 'accordion-multipleOpened',
                  inline: true,
                  name: 'multipleOpened',
                  checked: multipleOpened.value,
                  type: CheckType.switch_,
                  onChange: (checked) => multipleOpened.value = checked,
                ),
              ]),
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
            ]);
          }),
        ]),
      ),

      bootstrapExample(
        'Buttons',
        content: div(classes: 'hstack gap-3 align-self-center', [
          button(classes: btn(), [txt('primary')]),
          button(classes: btn(outlined: true, color: BColor.danger), [
            txt('danger-outlined'),
          ]),
          button(classes: btn(size: BSize.lg, color: BColor.secondary), [
            txt('secondary-lg'),
          ]),
          button(classes: btn(size: BSize.sm, color: BColor.dark), [
            txt('dark-sm'),
          ]),
          button(classes: btn(active: true), [txt('primary-active')]),
        ]),
        example: codeSection('''
button(
  classes: btn(),
  [txt('primary')],
),
button(
  classes: btn(outlined: true, color: BColor.danger),
  [txt('danger-outlined')],
),
button(
  classes: btn(size: BSize.lg, color: BColor.secondary),
  [txt('secondary-lg')],
),
button(
  classes: btn(size: BSize.sm, color: BColor.dark),
  [txt('dark-sm')],
),
button(
  classes: btn(active: true),
  [txt('primary-active')],
),
'''),
      ),
      bootstrapExample(
        'Button Group',
        example: codeSection(bootstrap_button_group_example),
        // @example-start{bootstrap-button-group-example}
        content: fc((ctx) {
          final value1 = ctx.hookState(() => 'Left');
          final value2 = ctx.hookState(() => {'B', 'C'});
          final value3 = ctx.hookState<String?>(() => null);

          return div(classes: 'hstack gap-3 align-self-center', [
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
              selection: UserSelection.indeterminate(value3.value, (selected) {
                value3.value = selected;
              }),
              values: const ['Top', 'Bottom'],
            ),
          ]);
        }),
        // @example-end{bootstrap-button-group-example}
      ),
      bootstrapExample(
        'Icons',
        url: 'https://icons.getbootstrap.com/',
        content: div(
          classes: 'd-flex justify-content-evenly',
          styles: parseStyles(
            'width:200px;align-self:center;align-items:center;',
          ),
          [
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
        content: div(classes: 'd-flex flex-column align-items-center', [
          div(classes: alert(color: BColor.info), [txt('Info Alert')]),
          div(classes: alert(color: BColor.success), [
            el(
              'h4',
              attributes: {'class': 'alert-heading'},
              children: [txt('Alert heading')],
            ),
            txt('Success message for Alert with heading'),
          ]),
        ]),
        example: codeSection('''
div(
  classes: alert(color: BColor.info),
  [txt('Info Alert')],
),
div(
  classes: alert(color: BColor.success),
  [
    el(
      'h4',
      attributes: {'class': 'alert-heading'},
      [txt('Alert heading')],
    ),
    txt('Success message for Alert with heading'),
  ],
),
'''),
      ),
      bootstrapExample(
        'Badge',
        content: div(classes: 'd-flex justify-content-evenly', [
          div(classes: badge(color: BColor.info), [txt('Info Alert')]),
          div(classes: badge(color: BColor.success, rounded: true), [
            txt('Success rounded'),
          ]),
          div(classes: badge(color: BColor.primary, rounded: true), [
            txt('49'),
          ]),
        ]),
        example: codeSection('''
div(
  classes: badge(color: BColor.info),
  [txt('Info Alert')],
),
div(
  classes: badge(color: BColor.success, rounded: true),
  [txt('Success rounded')],
),
div(
  classes: badge(color: BColor.primary, rounded: true),
  [txt('49')],
),
'''),
      ),
      bootstrapExample(
        'Close Button',
        example: codeSection(bootstrap_close_button_example),
        // @example-start{bootstrap-close-button-example}
        content: div(classes: 'd-flex justify-content-evenly', [
          closeButton(),
          div(classes: 'bg-success rounded-3 p-2 text-white d-flex', [
            span(classes: 'pe-2', [txt('White close button')]),
            closeButton(white: true),
          ]),
          closeButton(disabled: true),
        ]),
        // @example-end{bootstrap-close-button-example}
      ),

      /// Collapse
      collapseExample(),

      /// TODO: Split button,
      bootstrapExample(
        'Dropdowns',
        example: codeSection(bootstrap_dropdown_example),
        // @example-start{bootstrap-dropdown-example}
        content: div(classes: 'd-flex justify-content-evenly', [
          dropdown(
            buttonClass: btn(),
            buttonContent: [txt('Dropdown Button')],
            children: [
              ...['Option A', 'Option B', null, 'More Options'].map((e) {
                if (e == null) {
                  return dropdownDivider;
                } else {
                  return dropdownItem(children: [txt(e)], onClick: (_) {});
                }
              }),
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
                ...['Option A', 'Option B', null, 'More Options'].map((e) {
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
                }),
              ],
            );
          }),
        ]),
        // @example-end{bootstrap-dropdown-example}
      ),

      bootstrapExample(
        'Table',
        example: codeSection(bootstrap_table_example),
        content: div([
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
            final scrollHorizontal = ctx.hookState<ResponsiveBreakPoint?>(
              () => null,
            );

            final items = [
              {'first': 'Mark', 'last': 'Otto', 'handle': '@mdo'},
              {'first': 'Jacob', 'last': 'Thornton', 'handle': '@fat'},
              {'first': 'Larry the Bird', 'last': null, 'handle': '@twitter'},
            ];

            return div(classes: 'd-flex flex-column mx-3', [
              div(
                classes: 'mb-2 d-flex flex-wrap',
                styles: parseStyles(flexCenter()),
                [
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
                classes: tableClass(
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
                [
                  if (showCaption.value) caption([txt('List of users')]),
                  thead(
                    classes: headerColor.value == null
                        ? null
                        : tableClass(color: headerColor.value),
                    [
                      tr([
                        th(scope: 'col', [txt('#')]),
                        th(scope: 'col', [txt('First')]),
                        th(scope: 'col', [txt('Last')]),
                        th(scope: 'col', [txt('Handle')]),
                      ]),
                    ],
                  ),
                  tbody([
                    ...items.mapIndexed(
                      (index, item) => tr([
                        th(scope: 'row', [txt('${index + 1}')]),
                        td(colspan: (item['last'] != null ? 1 : 2), [
                          txt(item['first'] as String),
                        ]),
                        if (item['last'] != null)
                          td([txt(item['last'] as String)]),
                        td([txt(item['handle'] as String)]),
                      ]),
                    ),
                  ]),
                  if (showFooter.value)
                    tfoot([
                      tr(
                        List.generate(4, (index) => td([txt('Footer $index')])),
                      ),
                    ]),
                ],
              ),
              // @example-end{bootstrap-table-example}
            ]);
          }),
        ]),
      ),

      bootstrapExample(
        'Tooltip',
        example: codeSection(bootstrap_tooltip_example),
        // TODO: tooltip in text
        // @example-start{bootstrap-tooltip-example}
        content: div(classes: 'd-flex justify-content-evenly', [
          tooltipWrapper(
            title: 'Tooltip title',
            children: [
              button(classes: btn(), [txt('Button')]),
            ],
          ),
          tooltipWrapper(
            title:
                '<em>Tooltip</em> <u>with</u> <b>HTML</b>'
                '<br>placed right<br>with "5,5" offset',
            attributes: tooltipAttributes(
              allowHtml: true,
              placement: TooltipPlacement.right,
              offset: '5,5',
            ),
            children: [
              button(classes: btn(), [txt('Custom HTML Tooltip')]),
            ],
          ),
        ]),
        // @example-end{bootstrap-tooltip-example}
      ),
      bootstrapExample(
        'Popover',
        example: codeSection(bootstrap_popover_example),
        // @example-start{bootstrap-popover-example}
        content: div(
          styles: parseStyles(
            flexStyle(main: AxisAlign.space_evenly, cross: AxisAlign.center),
          ),
          [
            popoverWrapper(
              attributes: popoverAttributes(title: 'popover title'),
              content: 'popover content',
              children: [
                button(classes: btn(), [txt('Button')]),
              ],
            ),
            popoverWrapper(
              attributes: popoverAttributes(
                triggers: [TooltipTrigger.focus, TooltipTrigger.hover],
              ),
              content: 'popover content',
              children: [
                a(href: '#', [txt('Link hover and focus trigger')]),
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
            //   [txt('Link hover and focus trigger')],
            // ),
            popoverWrapper(
              content:
                  '<em>popover</em> <u>with</u> <b>HTML</b>'
                  '<br>placed bottom<br>with "25,8" offset',
              attributes: popoverAttributes(
                allowHtml: true,
                placement: TooltipPlacement.bottom,
                offset: '25,8',
              ),
              children: [
                button(classes: btn(), [txt('Custom HTML popover')]),
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
          classes: 'd-flex justify-content-evenly align-items-center',
          [
            spinner(),
            spinner(grow: true, color: BColor.success),
            spinner(color: BColor.dark, size: BSize.sm),
            spinner(grow: true, size: BSize.sm),
            button(classes: btn(), [
              spinner(
                size: BSize.sm,
                ariaHidden: true,
                color: BColor.light,
                className: 'me-2',
              ),
              txt('Loading'),
            ]),
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
        content: div(styles: parseStyles('height:300px'), [
          fc((ctx) {
            final withHeader = ctx.hookRef(() => true);
            final controller = ctx.hookRef(() => ToastsController()).value;
            final text = ctx.hookState(() => 'A message');

            return div(
              classes: 'd-flex flex-column',
              styles: parseStyles('position:relative;height:100%;'),
              [
                div(
                  classes: 'm-2',
                  styles: parseStyles(
                    'width:400px;display:flex;align-items:center;',
                  ),
                  [
                    input<String>(
                      classes: 'form-control px-2',
                      value: text.value,
                      onInput: (e) => text.value = e,
                    ),
                    el('span', attributes: {'style': 'width:10px'}),
                    button(
                      classes: btn(),
                      onClick: () => controller.add(
                        toastContent(
                          showCloseButton: true,
                          header: withHeader.value ? [txt('A Header')] : null,
                          body: [txt(text.value)],
                        ),
                      ),
                      [txt('Show')],
                    ),
                    el('span', attributes: {'style': 'width:10px'}),
                    check(
                      checked: withHeader.value,
                      onChange: (checked) {
                        withHeader.value = checked;
                      },
                      label: span(styles: parseStyles('white-space: nowrap;'), [
                        txt('With Header'),
                      ]),
                    ),
                  ],
                ),
                div(classes: 'bg-light flex-grow-1', [controller.render()]),
              ],
            );
          }),
        ]),
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

          return div(classes: 'd-flex flex-column', [
            div(styles: parseStyles(flexCenter()), [
              _simpleCheck('floating', floating),
              _simpleCheck('tooltipValidation', tooltipValidation),
              _simpleSelect<BSize?>(
                [null, ...BSize.values],
                (v) => v?.name ?? 'default size',
                size,
              ),
            ]),
            form(classes: 'p-3 ${BText.start}', [
              div(classes: 'row', [
                if (floating.value)
                  div(classes: divClass, [
                    div(
                      classes:
                          '${inputGroupClass(size: size.value)} flex-nowrap',
                      [
                        span(classes: inputGroupTextClass, [txt('@')]),
                        labeledInput(
                          divClass: 'flex-grow-1',
                          label: txt('Label'),
                          id: 'labeled-input',
                          floating: floating.value,
                          input: input(
                            classes: formControlClass(size: size.value),
                            type: InputType.text,
                            attributes: {'placeholder': 'Placeholder'},
                            id: 'labeled-input',
                          ),
                        ),
                      ],
                    ),
                  ])
                else
                  labeledInput(
                    wrapperDivClass: divClass,
                    label: txt('Label'),
                    id: 'labeled-input',
                    floating: floating.value,
                    input: div(classes: inputGroupClass(size: size.value), [
                      span(classes: inputGroupTextClass, [txt('@')]),
                      input(
                        classes: formControlClass(size: size.value),
                        type: InputType.text,
                        id: 'labeled-input',
                        attributes: {'placeholder': 'Placeholder'},
                      ),
                    ]),
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
                    classes: formControlClass(size: size.value, isValid: false),
                    type: InputType.text,
                    attributes: {'placeholder': 'Placeholder Invalid'},
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
                    classes: formControlClass(size: size.value, isValid: true),
                    type: InputType.text,
                    attributes: {'placeholder': 'Placeholder Valid'},
                    id: 'labeled-input-valid',
                  ),
                ),
              ]),
              fc((ctx) {
                final colClasses = ColInputClasses(
                  label:
                      'col-sm-4 col-lg-3'
                      '${size.value != null ? ' col-form-label-${size.value!.name}' : ''}',
                  input: 'col-sm-8 col-lg-9',
                );
                return div([
                  h5(classes: 'mt-3', [txt('Horizontal labels')]),
                  labeledInput(
                    wrapperDivClass: 'my-2',
                    label: txt('Label TextArea'),
                    id: 'labeled-textarea',
                    divClass: 'row',
                    colClasses: colClasses,
                    input: textarea(
                      const [],
                      classes: formControlClass(size: size.value),
                      placeholder: 'Placeholder',
                      styles: parseStyles('height:100px;'),
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
                  fieldset(id: 'labeled-switch', classes: 'row my-2', [
                    legend(classes: 'col-form-label ${colClasses.label} pt-0', [
                      txt('Checks'),
                    ]),
                    div(classes: colClasses.input, [
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
                        items: Map.fromIterable(const [
                          'A',
                          'B',
                          'C',
                        ], value: (v) => txt(v as String)),
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
                    ]),
                  ]),
                ]);
              }),
            ]),
          ]);
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

          return div(classes: 'd-flex flex-column', [
            div(styles: parseStyles(flexCenter()), [
              _simpleCheck('fade', fade),
              _simpleSelect<TabType>(TabType.values, (v) => v.name, tabType),
            ]),
            div(classes: 'm-3', [
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
            ]),
          ]);
        }),
        // @example-end{bootstrap-navs-tabs-example}
      ),

      bootstrapExample(
        'Navbar',
        example: codeSection(bootstrap_navbar_example),
        // @example-start{bootstrap-navbar-example}
        content: div(classes: 'd-flex flex-column', [
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
                attributes: {'class': 'nav-link', 'href': '#'},
                children: [txt('Documentation')],
              ),
              el(
                'a',
                attributes: {'class': 'nav-link', 'href': '#'},
                children: [txt('Demo')],
              ),
              el(
                'a',
                attributes: {
                  'class': 'nav-link disabled',
                  'href': '#',
                  'tabindex': '-1',
                  'aria-disabled': 'true',
                },
                children: [txt('Disabled')],
              ),
            ];

            return Component.fragment([
              navbar(
                expand: ResponsiveBreakPoint.lg,
                background: BColor.light,
                collapseId: 'nav-bar-example-collapse',
                // position: NavbarPosition.fixed_bottom,
                brand: [txt('Navbar Brand')],
                itemList: [
                  div(classes: 'navbar-nav me-auto', _navLinks),
                  form(classes: 'd-flex', [
                    input(
                      classes: 'form-control me-2',
                      type: InputType.search,
                      attributes: {'placeholder': 'Search'},
                    ),
                    button(classes: btn(), type: ButtonType.submit, [
                      txt('Search'),
                    ]),
                  ]),
                ],
              ),
              navbar(
                expand: null,
                background: BColor.dark,
                dark: true,
                collapseId: 'nav-bar-example-collapse-dark',
                attributes: {'style': 'margin-top:20px;'},
                // position: NavbarPosition.fixed_bottom,
                brand: [txt('Collapsed Dark Brand')],
                itemList: [
                  div(classes: 'navbar-nav me-auto', _navLinks),
                  form(classes: 'd-flex', [
                    input(
                      classes: 'form-control me-2',
                      type: InputType.search,
                      attributes: {'placeholder': 'Search'},
                    ),
                    button(classes: btn(), type: ButtonType.submit, [
                      txt('Search'),
                    ]),
                  ]),
                ],
              ),
            ]);
          }),
        ]),
        // @example-end{bootstrap-navbar-example}
      ),

      bootstrapExample(
        'Modal',
        example: codeSection(bootstrap_modal_example),
        content: div([
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
              classes: 'd-flex flex-column',
              styles: parseStyles('position:relative;height:100%;'),
              [
                div(
                  classes: 'm-2',
                  styles: parseStyles(
                    'display:flex;align-items:center;justify-content: center;',
                  ),
                  [
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
                    button(classes: btn(), onClick: () => ref.value!.toggle(), [
                      txt('Toggle with ref'),
                    ]),
                    el('span', attributes: {'style': 'width:10px'}),
                  ],
                ),
                div([
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
                ]),
                div(
                  classes: 'd-flex justify-content-center align-items-center',
                  [
                    div([
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
                    ]),
                    select(
                      classes: 'form-select',
                      styles: parseStyles('width:150px;'),
                      onChange: (e) {
                        final value = e.first;
                        if (value == '') {
                          size.value = null;
                        } else {
                          size.value = DialogSize.values.firstWhere(
                            (v) => v.name == value,
                          );
                        }
                      },
                      [
                        option(value: '', selected: size.value == null, [
                          txt('default size'),
                        ]),
                        ...DialogSize.values.map(
                          (e) => option(
                            value: e.name,
                            selected: size.value == e,
                            [txt(e.name)],
                          ),
                        ),
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
                  modalRef: ref,
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
                          ? el(
                              'div',
                              attributes: {
                                'style':
                                    'height: 2000px;'
                                    'background-image:linear-gradient(white, #8fb6ff);',
                              },
                            )
                          : txt('Body'),
                    ],
                    header: [txt('Header')],
                    footer: [
                      span(classes: 'me-5', [txt('Footer')]),
                      el(
                        'button',
                        attributes: {
                          'class': btn(),
                          'type': "button",
                          'data-bs-dismiss': "modal",
                        },
                        children: [txt('Dismiss with attributes')],
                      ),
                      button(classes: btn(), onClick: () => ref.value!.hide(), [
                        txt('Hide with ref'),
                      ]),
                    ],
                  ),
                ),
                // @example-end{bootstrap-modal-example}
              ],
            );
          }),
        ]),
      ),

      bootstrapExample(
        'Offcanvas',
        example: codeSection(bootstrap_offcanvas_example),
        // @example-start{bootstrap-offcanvas-example}
        content: div([
          fc((ctx) {
            final backdrop = ctx.hookState(() => true);
            final keyboard = ctx.hookState(() => true);
            final scroll = ctx.hookState(() => false);
            final offcanvasRef = ctx.hookRef<Offcanvas?>(() => null);

            final placement = ctx.hookState<Placement>(() => Placement.end);
            const labelId = 'offcanvas-example-label';

            return Component.fragment([
              el(
                'button',
                attributes: {
                  'class': '${btn()}m-2',
                  ...toggleButtonAttributes(
                    component: TogglableComponent.offcanvas,
                    targetId: 'offcanvas-example',
                  ),
                },
                children: [txt('Toggle by attributes')],
              ),
              button(
                classes: '${btn()}m-2',
                onClick: () => offcanvasRef.value!.toggle(),
                [txt('Toggle by ref')],
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
                  ),
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
                  txt(
                    'Laudantium ex tempora ratione illo velit sed asperiores.',
                  ),
                ],
              ),
            ]);
          }),
        ]),
        // @example-end{bootstrap-offcanvas-example}
      ),

      bootstrapExample(
        'Placeholder',
        example: codeSection(bootstrap_placeholder_example),
        // @example-start{bootstrap-placeholder-example}
        content: div([
          fc((ctx) {
            final wave = ctx.hookState(() => false);

            return Component.fragment([
              _simpleCheck('wave', wave),
              div(styles: parseStyles(flexCenter()), [
                div(
                  classes: placeholder(
                    glow: !wave.value,
                    wave: wave.value,
                    className: 'text-start m-4',
                  ),
                  styles: parseStyles('width:500px;'),
                  [
                    span(
                      const [],
                      classes: placeholder(
                        size: PlaceholderSize.lg,
                        color: BColor.info,
                        className: 'col-9 mb-1',
                      ),
                    ),
                    span(const [], classes: placeholder(className: 'col-7')),
                    span(const [], classes: placeholder(className: 'col-4')),
                    span(const [], classes: placeholder(className: 'col-4')),
                    span(const [], classes: placeholder(className: 'col-6')),
                    span(
                      const [],
                      classes: placeholder(
                        size: PlaceholderSize.xs,
                        className: 'col-9 mt-1',
                      ),
                    ),
                    placeholderButton('col-4 ${btn()} mt-2'),
                  ],
                ),
              ]),
              // ElementNode.fromHtml(
              //  web.DivElement()
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
        ]),
        // @example-end{bootstrap-placeholder-example}
      ),

      bootstrapExample(
        'ScrollSpy',
        example: codeSection(bootstrap_scrollspy_example),
        // @example-start{bootstrap-scrollspy-example}
        content: div(classes: 'row mx-1', [
          div(classes: 'col-4', [
            div(classes: 'nav list-group', id: 'list-example', [
              a(
                classes: 'list-group-item list-group-item-action nav-link',
                href: '#list-item-1',
                [txt('Item 1')],
              ),
              a(
                classes: 'list-group-item list-group-item-action nav-link',
                href: '#list-item-2',
                [txt('Item 2')],
              ),
              a(
                classes: 'list-group-item list-group-item-action nav-link',
                href: '#list-item-3',
                [txt('Item 3')],
              ),
              a(
                classes: 'list-group-item list-group-item-action nav-link',
                href: '#list-item-4',
                [txt('Item 4')],
              ),
            ]),
          ]),
          div(classes: 'col-8', [
            fc((ctx) {
              final ref = ctx.hookRef<web.Element?>(() => null);
              final scrollSpy = useScrollSpy(ctx, ref, target: '#list-example');
              return el(
                'div',
                ref: ref,
                attributes: {
                  'style': 'position:relative;height:200px;overflow-y:scroll;',
                  ...scrollSpy.attributes,
                },
                children: [
                  h4(id: 'list-item-1', [txt('Item 1')]),
                  p([
                    txt(
                      'Esse sapiente non ullam nihil qui quisquam. Molestiae nihil debitis eaque sint neque nisi. Quia a minima veritatis aut distinctio officiis ratione. Culpa explicabo tempore tenetur. Qui rem voluptatem iusto minima ad aut dolores est velit.',
                    ),
                  ]),
                  h4(id: 'list-item-2', [txt('Item 2')]),
                  p([
                    txt(
                      'Esse sapiente non ullam nihil qui quisquam. Molestiae nihil debitis eaque sint neque nisi. Quia a minima veritatis aut distinctio officiis ratione. Culpa explicabo tempore tenetur. Qui rem voluptatem iusto minima ad aut dolores est velit.',
                    ),
                  ]),
                  h4(id: 'list-item-3', [txt('Item 3')]),
                  p([
                    txt(
                      'Esse sapiente non ullam nihil qui quisquam. Molestiae nihil debitis eaque sint neque nisi. Quia a minima veritatis aut distinctio officiis ratione. Culpa explicabo tempore tenetur. Qui rem voluptatem iusto minima ad aut dolores est velit.',
                    ),
                  ]),
                  h4(id: 'list-item-4', [txt('Item 4')]),
                  p([
                    txt(
                      'Esse sapiente non ullam nihil qui quisquam. Molestiae nihil debitis eaque sint neque nisi. Quia a minima veritatis aut distinctio officiis ratione. Culpa explicabo tempore tenetur. Qui rem voluptatem iusto minima ad aut dolores est velit.',
                    ),
                  ]),
                ],
              );
            }),
          ]),
        ]),
        // @example-end{bootstrap-scrollspy-example}
      ),
    ],
  );
}

DeactNode _simpleCheck(String label, Ref<bool> refCheck) {
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
  Ref<T> state, {
  String? id,
}) {
  return select(
    id: id,
    classes: 'form-select mx-1',
    styles: parseStyles('width:170px;'),
    onChange: (e) {
      final value = e.first;
      state.value = values.firstWhere((v) => toString(v) == value);
    },
    [
      ...values.map(
        (e) => option(value: toString(e), selected: state.value == e, [
          txt(toString(e)),
        ]),
      ),
    ],
  );
}

DeactNode collapseExample() {
  return bootstrapExample(
    'Collapse',
    example: codeSection(bootstrap_collapse_example),
    // @example-start{bootstrap-collapse-example}
    content: div(classes: 'col', [
      div(classes: 'm-3', [
        collapseButton(
          collapseId: 'collapseExample',
          buttonClass: btn(size: BSize.sm, color: BColor.dark),
          children: [txt('More Info')],
        ),
        div(classes: '${collapse()} m-2', id: 'collapseExample', [
          div(classes: 'card card-body', [
            txt(
              'This is some placeholder content for a horizontal collapse.'
              " It's hidden by default and shown when triggered.",
            ),
          ]),
        ]),
      ]),
      div(classes: 'm-3', [
        collapseButton(
          collapseId: 'collapseHorizontalExample',
          buttonClass: btn(),
          children: [txt('More Info Horizontal')],
        ),
        div(styles: parseStyles('height:100px;padding:10px;'), [
          div(
            classes: collapse(horizontal: true, show: true),
            id: 'collapseHorizontalExample',
            [
              div(
                classes: 'card card-body',
                styles: parseStyles("width: 300px;"),
                [
                  txt(
                    'This is some placeholder content for a horizontal collapse.'
                    " It's hidden by default and shown when triggered.",
                  ),
                ],
              ),
            ],
          ),
        ]),
      ]),
    ]),
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
    key: Key(title),
    id: title.replaceAll(' ', '-'),
    classes: 'm-4 w-100 d-flex flex-column',
    styles: parseStyles('position:relative;'),
    [
      hr(),
      div([
        el('h3', attributes: {'class': 'mt-1'}, children: [txt(title)]),
        a(
          href:
              url ??
              'https://getbootstrap.com/docs/5.1/components/'
                  '${title.toLowerCase().replaceAll(' ', '-')}',
          target: Target.blank,
          [txt('Documentation')],
        ),
      ]),
      hr(),
      content,
      ?example,
    ],
  );
}
