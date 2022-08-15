import 'dart:async';

import 'package:bootstrap_dart/bootstrap/bootstrap_core.dart';
import 'package:bootstrap_dart/bootstrap/typography.dart';
import 'package:deact_bootstrap/router.dart';
import 'package:bootstrap_dart_example/cacho/cacho_command.dart';
import 'package:bootstrap_dart_example/cacho/cacho_store.dart';
import 'package:bootstrap_dart_example/int_input.dart';
import 'package:bootstrap_dart_example/sql_db/database.dart';
import 'package:deact/deact.dart';
import 'package:deact/deact_html52.dart';

class CachoParamsParser implements ReqParser<CachoParams> {
  const CachoParamsParser();

  @override
  CachoParams fromReq(Uri uri, RouteReq? req) {
    return CachoParams(id: uri.queryParameters['id']);
  }

  @override
  PartialUri toUri(CachoParams value) {
    return PartialUri(const [], {if (value.id != null) 'id': value.id!});
  }
}

class CachoParams {
  final String? id;

  const CachoParams({this.id});
}

final _cachoStore = () {
  final s = CachoStore(db: constructDb(), key: 'cacho-test');
  s.addPlayer('player 1');
  s.addPlayer('player 2');
  return s;
}();

class CachoRoute extends Route<CachoParams, CachoData?> {
  const CachoRoute._();
  static CachoRoute get instance => const CachoRoute._();

  @override
  String get path => '/cacho';
  @override
  ReqParser<CachoParams> get parser => const CachoParamsParser();
  @override
  FutureOr<CachoData?> load(BaseRouteParams<CachoParams> input) {
    return null;
  }

  @override
  DeactNode render(RouteParams<CachoParams, CachoData?> value) {
    final cachoData = value.data;

    return div(
      className: 'container',
      style: colStyle(),
      children: [
        fc((ctx) {
          // final data = ctx.hookState(() => cachoData);
          // if (data.value == null) {
          //   return fc((ctx) {
          //     final loading = ctx.hookState(() => false);
          //     return div(
          //       children: [
          //         button(
          //           type: 'button',
          //           className: btn(),
          //           onclick: (_) {
          //             loading.value = true;
          //             data.value = _cachoStore.data('player 1');
          //           },
          //           children: [txt('Create')],
          //         ),
          //       ],
          //     );
          //   });
          // }

          return div(
            children: [
              CachoView(data: _cachoStore.data('player 1'), player: 'player 1'),
              CachoView(data: _cachoStore.data('player 2'), player: 'player 2'),
            ],
          );
        }),
      ],
    );
  }
}

class CachoView extends ComponentNode {
  const CachoView({
    String? key,
    required this.data,
    required this.player,
  }) : super(key: key);
  final CachoData data;
  final String player;

  @override
  DeactNode render(ComponentContext ctx) {
    return div(
      className: 'p-2',
      children: [
        h4(
          children: [
            txt(
              'Players (total: ${data.players.length}, active: ${data.playerNumber})',
            )
          ],
        ),
        div(
          className: 'p-2',
          style: flexStyle(),
          children: [
            ...data.players.map((pId) {
              return span(
                className: badge(
                      color: data.currentPlayer == pId
                          ? BColor.success
                          : BColor.secondary,
                    ) +
                    ' mx-1',
                children: [txt(pId)],
              );
            })
          ],
        ),
        h4(children: [txt('Dices (total: ${data.totalDices})')]),
        div(
          className: 'p-2',
          style: flexStyle(main: AxisAlign.center),
          children: [
            if (data.dices.isEmpty)
              txt('No dices')
            else
              ...data.dices.map(
                (pId) => div(
                  className: 'mx-1 px-3 py-2 bg-white'
                      ' ${roundedClass(size: RoundedSize.s2)} ${borderClass()}',
                  children: [txt(pId.toString())],
                ),
              ),
          ],
        ),
        if (!data.isPlaying)
          button(
            type: 'button',
            className: btn(),
            onclick: (_) {
              _cachoStore.consume(CachoCommandStart());
            },
            children: [txt('Start')],
          )
        else if (data.currentSuggestion != null || data.currentPlayer == player)
          h4(children: [txt('Suggestion')]),
        if (data.currentSuggestion != null)
          _suggestionView(data.currentSuggestion!, data.currentDiceSuggestion),
        if (data.currentPlayer == player)
          div(
            key: 'cacho-choices',
            className: 'p-2',
            style: flexStyle(),
            children: [
              button(
                disabled: data.currentSuggestion != null ? null : '',
                type: 'button',
                className: btn(color: BColor.warning),
                onclick: (_) {
                  _cachoStore.consume(CachoCommandDudar());
                },
                children: [txt('Doubt')],
              ),
              span(style: 'width:5px;'),
              button(
                disabled: data.canCazar ? null : '',
                type: 'button',
                className: btn(color: BColor.dark),
                onclick: (_) {
                  _cachoStore.consume(CachoCommandCazar());
                },
                children: [txt('Cazar')],
              ),
              span(style: 'width:5px;'),
              button(
                disabled: data.dices.length == 5 &&
                        !data.salpiconedPlayers.contains(player)
                    ? null
                    : '',
                type: 'button',
                className: btn(color: BColor.dark),
                onclick: (_) {
                  _cachoStore.consume(CachoCommandSuggest(
                    const Suggestion.salpicon(),
                  ));
                },
                children: [txt('Salpicon')],
              ),
              div(
                className: 'p-2',
                children: [
                  fc((ctx) {
                    final dice = ctx.hookState(() => 2);
                    final amount =
                        ctx.hookState(() => (data.minOther ?? 0) + 1);
                    final minAs = data.minAs;

                    return fragment([
                      IntInput(
                        value: dice.value,
                        onChanged: (v) {
                          dice.value = v;
                          if (v == 1 && minAs != null && amount.value > minAs) {
                            amount.value = minAs;
                          }
                        },
                        minimum: 1,
                        maximum: 6,
                        label: label(
                          forId: 'suggestion-dice',
                          children: [txt('Dice')],
                        ),
                      ),
                      IntInput(
                        value: amount.value,
                        onChanged: (v) => amount.value = v,
                        minimum: (dice.value == 1 ? minAs : data.minOther) ?? 1,
                        maximum: data.totalDices,
                        label: label(
                          forId: 'suggestion-amount',
                          children: [txt('Amount')],
                        ),
                      ),
                      button(
                        type: 'button',
                        className: btn(),
                        onclick: (_) {
                          _cachoStore
                              .consume(CachoCommandSuggest(Suggestion.dices(
                            amount: amount.value,
                            dice: dice.value,
                          )));
                        },
                        children: [txt('Suggest')],
                      ),
                    ]);
                  }),
                ],
              ),
            ],
          ),
      ],
    );
  }
}

DeactNode _suggestionView(
  Suggestion suggestion,
  SuggestionDices? currentDiceSuggestion,
) {
  if (suggestion is SuggestionDices) {
    return div(
      style: flexStyle(),
      children: [
        div(children: [
          span(children: [txt('Dice:')]),
          span(
            className: 'p-1 ${BText.fwBold}',
            children: [txt('${suggestion.dice}')],
          ),
        ]),
        span(style: 'width:10px;'),
        div(children: [
          span(children: [txt('Amount:')]),
          span(
            className: 'p-1 ${BText.fwBold}',
            children: [txt('${suggestion.amount}')],
          ),
        ]),
      ],
    );
  } else {
    return div(
      children: [
        if (currentDiceSuggestion != null)
          _suggestionView(currentDiceSuggestion, null),
        span(children: [txt('Salpicón')]),
      ],
    );
  }
}

// final int totalDices;
// final bool canCazar;
// final int? minAs;
// final int? minOther;
// final bool isPlaying;
// final int playerNumber;
// final List<String> players;
// final String? currentPlayer;
// final String? previousPlayer;
// final Suggestion? currentSuggestion;
// final SuggestionDices? currentDiceSuggestion;
// final List<int> dices;