import 'package:universal_html/html.dart' as html;
import 'package:universal_io/io.dart' as io;

import 'package:deact/deact.dart';
import 'package:deact/deact_html52.dart';
import 'package:mobx/mobx.dart';
import 'package:logging/logging.dart';
import 'package:deact_bootstrap/mobx_deact.dart';
import 'package:deact_bootstrap/server_renderer.dart';
import 'package:deact_bootstrap/deact_bootstrap.dart';

import 'package:bootstrap_dart/bootstrap/bootstrap_core.dart';
import 'bootstrap_examples.dart';
import 'package:bootstrap_dart/bootstrap/toast.dart';

final logger = Logger('virtual_web');

void main() async {
  DeactBootstrapRenderer.setUp();
  mainContext.config = ReactiveConfig(
    writePolicy: ReactiveWritePolicy.never,
  );

  final serverRendered = await renderIsomorphic(
    'output',
    rootComponent,
    wrappers: const [mobxWrapper],
  );

  if (!kIsWeb) {
    final indexFile = io.File('./build/index.html');

    final htmlStr =
        serverRendered.renderInTemplate(await indexFile.readAsString());
    await indexFile.writeAsString(htmlStr);
  }
}

DeactNode rootComponent() {
  return fragment([
    div(
      className: 'd-flex ',
      style: 'overflow:hidden;height: 100%;',
      children: [
        examplesNavbar(),
        fc((ctx) {
          final ref = ctx.hookRef<html.Element?>(() => null);
          final scrollSpy = useScrollSpy(
            ctx.bootstrapCtx,
            ref.bootstrapRef,
            target: '#navbar-example',
            offset: 10,
          );
          return el(
            'div',
            ref: ref,
            attributes: {
              'style': 'overflow:auto;flex:1;',
              ...scrollSpy.attributes,
            },
            children: [
              div(style: 'max-width:650px;margin:auto;', children: [
                h1(
                  className: 'mt-3',
                  children: [txt('Bootstrap Dart')],
                ),
                p(children: [
                  txt(
                    'Bootstrap 5 components, assets (scss, js) and framework bindings for Dart on the web.'
                    ' Support for theming with scss, Bootstrap Icons and dark mode with Bootstrap Dark. ',
                  ),
                  br(),
                  txt('You can find more information in the '),
                  a(
                    href: 'https://github.com/juancastillo0/bootstrap_dart',
                    children: [txt('Github Repo and README.')],
                  ),
                ]),
                h3(
                  className: 'mt-3',
                  children: [txt('Examples Showcase')],
                ),
                p(children: [
                  txt('Some examples of deployed pages using Bootstrap Dart.'),
                ]),
                div(
                  className: 'd-flex flex-wrap justify-content-center',
                  children: [
                    card(
                      title: txt('Cacho'),
                      text: txt(
                          'Multiplayer board game with probabilities and bluffing.'),
                      footer: div(
                        className: 'd-flex justify-content-between',
                        children: [
                          a(
                            href:
                                'http://github.com/juancatillo0/bootstrap_dart',
                            target: '_black',
                            children: [txt('Github Repository')],
                          ),
                          a(
                            href:
                                'https://juancastillo0.github.io/bootstrap_dart/cacho/cacho',
                            target: '_black',
                            children: [txt('Deployed Page')],
                          ),
                        ],
                      ),
                    ),
                    card(
                      title: txt('Todos'),
                      text: txt(
                          'Todo lists with tags, filtering, duration and priority.'),
                      footer: div(
                        className: 'd-flex justify-content-between',
                        children: [
                          a(
                            href:
                                'http://github.com/juancatillo0/bootstrap_dart',
                            target: '_black',
                            children: [txt('Github Repository')],
                          ),
                          a(
                            href:
                                'https://juancastillo0.github.io/bootstrap_dart/cacho/todos',
                            target: '_black',
                            children: [txt('Deployed Page')],
                          ),
                        ],
                      ),
                    ),
                    card(
                      title: txt('CIDart'),
                      text: txt(
                          'Continuous integration and deployment Leto GraphQL Dart server.'),
                      footer: div(
                        className: 'd-flex justify-content-between',
                        children: [
                          a(
                            href: 'http://github.com/juancatillo0/cidart',
                            target: '_black',
                            children: [txt('Github Repository')],
                          ),
                          a(
                            href: 'https://juancastillo0.github.io/cidart/',
                            target: '_black',
                            children: [txt('Deployed Page')],
                          ),
                        ],
                      ),
                    ),
                  ].map(
                    (e) => div(
                        style: 'width:300px;', className: 'm-2', children: [e]),
                  ),
                ),
                h2(
                  className: 'mt-3',
                  children: [txt('Components Gallery')],
                ),
                p(children: [
                  txt(
                    'Most of the components and some utilities supported in this library are'
                    ' presented in the following sections along with the necessary Dart code to represent them.',
                  ),
                ]),
              ]),
              bootstrapExamples(),
            ],
          );
        }),
      ],
    ),
    toastsContainer(
      verticalPosition: Alignment.end,
      children: [
        toast(
          key: 'd',
          content: toastContent(
            header: [txt('header')],
            body: [txt('body')],
          ),
        )
      ],
    ),
  ]);
}
