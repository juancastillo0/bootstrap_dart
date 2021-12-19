final bootstrap_accordion_example = r'''
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
                  ),'''; 

final bootstrap_button_group_example = r'''
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
        ),'''; 

final bootstrap_close_button_example = r'''
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
        ),'''; 

final bootstrap_dropdown_example = r'''
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
        ),'''; 

final bootstrap_table_example = r'''
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
                  ),'''; 

final bootstrap_tooltip_example = r'''
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
        ),'''; 

final bootstrap_popover_example = r'''
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
        ),'''; 

final bootstrap_spinners_example = r'''
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
        ),'''; 

final bootstrap_toasts_example = r'''
        content: div(
          style: 'height:300px',
          children: [
            fc((ctx) {
              final withHeader = ctx.ref('withHeader', true);
              final controller = useMemo(
                ctx,
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
        ),'''; 

final bootstrap_forms_example = r'''
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
        }),'''; 

final bootstrap_navs_tabs_example = r'''
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
        }),'''; 

final bootstrap_navbar_example = r'''
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
        ),'''; 

final bootstrap_modal_example = r'''
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
                  ),'''; 

final bootstrap_offcanvas_example = r'''
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
        ),'''; 

final bootstrap_placeholder_example = r'''
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
//                 ElementNode.fromHtml(html.DivElement()
//                   ..innerHtml = """
// <p class="placeholder-glow card-text">
//   <span class="placeholder col-7"></span>
//   <span class="placeholder col-4"></span>
//   <span class="placeholder col-4"></span>
//   <span class="placeholder col-6"></span>
//   <span class="placeholder col-8"></span>
// </p>"""),
              ]);
            }),
          ],
        ),'''; 

final bootstrap_scrollspy_example = r'''
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
        ),'''; 

final bootstrap_collapse_example = r'''
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
    ),'''; 