import 'package:deact/deact.dart';
import 'package:deact/deact_html52.dart';
import 'dart:html' as html;

import 'bootstrap_core.dart';
import 'checks_radios.dart';
import 'icons.dart';
import 'toast.dart';

DeactNode bootstrapExamples() {
  return div(
    style: 'display:flex;flex-direction: column;align-items: center;',
    className: 'w-100',
    children: [
      bootstrapExample(
        'Buttons',
        div(
          className: 'hstack gap-3 align-self-center',
          children: [
            button(className: btn(), children: [txt('primary')]),
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
      ),
      bootstrapExample(
        'Icons',
        div(
          className: 'd-flex justify-content-evenly',
          style: 'width:200px;align-self:center;align-items:center;',
          children: [
            icon(BIcon.alarm, ariaLabel: 'Alarm'),
            icon(BIcon.alarm, color: 'blue'),
            icon(BIcon.alarm, color: 'blue', fontSize: '2rem'),
            icon(BIcon.lightning, color: 'grey'),
          ],
        ),
      ),
      bootstrapExample(
        'Alerts',
        div(
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
      ),
      bootstrapExample(
        'Badge',
        div(
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
      ),
      bootstrapExample(
        'Close Button',
        div(
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
        div(
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
                      return dropdownItem(children: [txt(e)]);
                    }
                  },
                )
              ],
            ),
            fc((ctx) {
              final selected = ctx.state<String>('selected', 'Option A');
              return dropdown(
                buttonClass: btn(),
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
        div(
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
        'Spinners',
        div(
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
        div(
          style: 'height:300px',
          children: [
            fc((ctx) {
              final withHeader = ctx.ref('withHeader', true);
              final ref = ctx.refProvided(
                'controller',
                () => ToastsController(),
              );
              final text = ctx.state('text', 'a message');

              return div(
                className: 'd-flex flex-column',
                style: 'position:relative;height:100%;',
                children: [
                  div(
                    className: 'm-2',
                    style: 'width:400px;display:flex;align-items:center;',
                    children: [
                      input(
                        className: 'px-2',
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
                            header: withHeader.value ? txt('A Header') : null,
                            body: txt(text.value),
                          ),
                        ),
                        children: [txt('Send')],
                      ),
                      el('span', attributes: {'style': 'width:10px'}),
                      div(
                        children: [
                          check(
                            checked: withHeader.value,
                            inline: true,
                            onChange: (checked) {
                              withHeader.value = checked;
                            },
                            label: txt('With Header'),
                          ),
                        ],
                      )
                    ],
                  ),
                  ref.value.render(),
                ],
              );
            })
          ],
        ),
      ),
    ],
  );
}

DeactNode collapseExample() {
  return bootstrapExample(
    'Collapse',
    div(
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

DeactNode bootstrapExample(String title, DeactNode content) {
  return div(
    key: title,
    id: title,
    className: 'm-4 w-100 d-flex flex-column',
    children: [
      div(
        children: [
          el('h3', children: [txt(title)]),
          a(
            href: 'https://getbootstrap.com/docs/5.1/components/'
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
    ],
  );
}
