import 'package:deact/deact_html52.dart';
import 'package:test/test.dart';
import 'package:deact/deact.dart';
import 'package:universal_html/html.dart' as html;

import 'package:virtual_web/server_renderer.dart';

void main() {
  test('server render', () async {
    final rootElem = html.Element.tag('div');
    late State<int> count;

    final instance = deactInNode(
      rootElem,
      (p0) => fragment(
        [
          el(
            'div',
            attributes: {'style': 'height:100px;'},
            children: [
              span(
                style: 'font-size:12px;',
                children: [txt('span text')],
              ),
              ul(
                children: [
                  el('li', children: [txt('li text')])
                ],
              ),
              fc((ctx) {
                count = ctx.hookState(() => 0);

                return div(
                  children: [
                    el('span', children: [count.value.toString().txt]),
                    button(
                      id: 'increment-button',
                      className: 'btn',
                      children: [
                        a(
                          href: 'https://getbootstrap.com/docs/5.1/components/',
                          target: '_blank',
                        ),
                        img(src: 'http://localhost:3000/favicon.ico'),
                        txt('span text'),
                      ],
                    ),
                  ],
                );
              }),
            ],
          )
        ],
      ),
      renderer: ServerRenderer(),
    );
    await instance.waitScheduledRender();

    expect(
      rootElem.innerHtml,
      '<div style="height:100px;"><span style="font-size:12px;">span text</span><ul><li>li text</li></ul><div><span>0</span><button class="btn" id="increment-button"><a href="https://getbootstrap.com/docs/5.1/components/" target="_blank"></a><img src="http://localhost:3000/favicon.ico">span text</button></div></div>',
    );

    count.value++;
    await instance.waitScheduledRender();

    expect(
      rootElem.innerHtml,
      '<div style="height:100px;"><span style="font-size:12px;">span text</span><ul><li>li text</li></ul><div><span>1</span><button class="btn" id="increment-button"><a href="https://getbootstrap.com/docs/5.1/components/" target="_blank"></a><img src="http://localhost:3000/favicon.ico">span text</button></div></div>',
    );
  });
}
