import 'dart:async';

import 'package:collection/collection.dart';
import 'package:deact/deact.dart';
import 'package:deact/deact_html52.dart';
import 'package:deact_bootstrap/deact_bootstrap.dart';
import 'package:deact_bootstrap/hooks.dart';
import 'package:deact_bootstrap/router.dart';
import 'package:mobx/mobx.dart';
import 'package:universal_html/html.dart' as html;

import 'package:bootstrap_dart/bootstrap/bootstrap_core.dart';
import 'package:bootstrap_dart/bootstrap/modal.dart';
import 'package:bootstrap_dart/bootstrap/table.dart';
import 'package:bootstrap_dart_example/continental/continental_command.dart';
import 'package:bootstrap_dart_example/continental/continental_store.dart';
import 'package:bootstrap_dart_example/database.dart';

class UrlValue {
  final bool fromQuery;
  final String name;

  UrlValue({
    required this.fromQuery,
    required this.name,
  });
}

class ContinentalParamsParser implements ReqParser<ContinentalParams> {
  const ContinentalParamsParser();

  @override
  ContinentalParams fromReq(Uri uri, RouteReq? req) {
    return ContinentalParams(id: uri.queryParameters['id']);
  }

  @override
  PartialUri toUri(ContinentalParams value) {
    return PartialUri(const [], {if (value.id != null) 'id': value.id!});
  }
}

class ContinentalParams {
  final String? id;

  const ContinentalParams({this.id});
}

final _continentalStore = () {
  final s = ContinentalStore(key: 'test-continental-store');
  s.db().then((value) {
    if (s.players.isEmpty) {
      s.consume(ContinentalComm.addPlayer(playerId: 'player 1'));
      s.consume(ContinentalComm.addPlayer(playerId: 'player 2'));
    }
  });
  return s;
}();

class ContinentalRoute extends Route<ContinentalParams, ContinentalData?> {
  const ContinentalRoute._();
  static ContinentalRoute get instance => const ContinentalRoute._();

  @override
  String get path => '/continental';
  @override
  ReqParser<ContinentalParams> get parser => const ContinentalParamsParser();
  @override
  FutureOr<ContinentalData?> load(BaseRouteParams<ContinentalParams> input) {
    return null;
  }

  @override
  DeactNode render(RouteParams<ContinentalParams, ContinentalData?> value) {
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
          if (_continentalStore.players.isEmpty) {
            return div();
          }

          return div(
            children: [
              ContinentalView(
                key: 'player1',
                data: _continentalStore.dataForPlayer('player 1'),
                player: 'player 1',
              ),
              ContinentalView(
                key: 'player2',
                data: _continentalStore.dataForPlayer('player 2'),
                player: 'player 2',
              ),
            ],
          );
        }),
      ],
    );
  }
}

class ContinentalClientStore {
  late ContinentalData data;
  ContinentalClientStore({
    required ContinentalData data,
  }) {
    setData(data);
    _setUp();
  }
  ReactionDisposer? _disposer;

  void _setUp() async {
    final json = await ClientDB.getStore(
      storeKey: data.key,
      playerId: data.playerId,
    );
    if (json != null) {
      fromJson(json);
    }

    _disposer = autorun((_) {
      ClientDB.saveStore(this);
    }, delay: 2000);
  }

  void fromJson(Map<String, Object?> json) {
    runInAction(() {
      cards.clear();
      cards.addAll((json['cards'] as List).map((e) => Card.fromJson(e)));
      cardSet.clear();
      cardSet.addAll((json['cardSet'] as Map).map(
        (key, value) {
          final ids = (key as String).split('-').map(int.parse).toList();
          return MapEntry(
            CardSetIndex(groupId: ids[0], innerId: ids[1]),
            value,
          );
        },
      ));

      setData(data);
    });
  }

  Map<String, Object?> toJson() {
    return {
      'cards': cards.sublist(0).map((e) => e.toJson()).toList(),
      'cardSet': cardSet.map(
        (key, value) => MapEntry('${key.groupId}-${key.innerId}', value),
      ),
    };
  }

  final cards = ObservableList<Card>();
  final cardSet = ObservableMap<CardSetIndex, int>();

  void bajar(int index) {
    final step = data.step;
    if (data.tableCards.isEmpty && step.index + 6 > cardSet.length) {
      _continentalStore.consume(ContinentalComm.bajar(
        cardSet: CardSet(toDrop: cards[index]),
      ));
      return;
    }

    final List<List<Card?>> stairs = [];
    final List<List<Card?>> threesomes = [];
    for (final groupIndex
        in Iterable<int>.generate(step.threesomes + step.stairs)) {
      final isThreesome = step.threesomes > groupIndex;
      for (final index in Iterable<int>.generate(isThreesome ? 3 : 4)) {
        final _index = CardSetIndex(
          groupId: groupIndex,
          innerId: index,
        );
        final _innerGroup =
            isThreesome ? groupIndex : groupIndex - step.threesomes;
        final cardIndex = cardSet[_index];
        final l = (isThreesome ? threesomes : stairs);
        if (l.length == _innerGroup) l.add([]);
        l[_innerGroup].add(cardIndex == null ? null : cards[cardIndex]);
      }
    }
    _continentalStore.consume(ContinentalComm.bajar(
      cardSet: CardSet(
        toDrop: cards[index],
        stairs: stairs
            .map((e) => e.whereType<Card>().toList())
            .where((e) => e.length == 4)
            .toList(),
        threesomes: threesomes
            .map((e) => e.whereType<Card>().toList())
            .where((e) => e.length == 3)
            .toList(),
      ),
    ));
  }

  late final usedCards = Computed(
    () => cardSet.values.toSet(),
    equals: const DeepCollectionEquality().equals,
  );

  Card? cardForIndex(CardSetIndex index) {
    final _index = cardSet[index];
    return _index == null ? null : cards[_index];
  }

  void swap(int i1, int i2) {
    runInAction(() {
      final temp = cards[i1];
      cards[i1] = cards[i2];
      cards[i2] = temp;
      print('swap $i1, $i2');
      cardSet.updateAll(
        (key, value) => value == i1
            ? i2
            : value == i2
                ? i1
                : value,
      );
    });
  }

  void setCard(CardSetIndex i1, int i2) {
    runInAction(() {
      cardSet.removeWhere(
        (key, value) => value == i2,
      );
      cardSet[i1] = i2;
    });
  }

  void setData(ContinentalData data) {
    runInAction(() {
      if (_disposer != null && this.data == data) return;
      this.data = data;
      final copy = data.cards.sublist(0);
      final newCards = <Card>[];
      final deleted = <int>[];
      int i = 0;
      for (final c in cards) {
        if (copy.remove(c)) {
          newCards.add(c);
        } else {
          deleted.add(i);
        }
        i++;
      }
      newCards.addAll(copy);
      if (!const DeepCollectionEquality().equals(newCards, cards)) {
        cardSet.updateAll((key, value) {
          if (deleted.contains(value)) return -1;
          final index = deleted.indexWhere((e) => e > value);
          return index == -1 ? value - deleted.length : value - index;
        });
        cardSet.removeWhere((key, value) => value == -1);

        cards.clear();
        cards.addAll(newCards);
      }
    });
  }
}

class CardSetIndex {
  final int groupId;
  final int innerId;

  CardSetIndex({
    required this.groupId,
    required this.innerId,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CardSetIndex &&
        other.groupId == groupId &&
        other.innerId == innerId;
  }

  @override
  int get hashCode => groupId.hashCode ^ innerId.hashCode;

  @override
  String toString() => 'CardSetIndex(groupId: $groupId, innerId: $innerId)';
}

class ContinentalView extends ComponentNode {
  const ContinentalView({
    String? key,
    required this.data,
    required this.player,
  }) : super(key: key);
  final ContinentalData data;
  final String player;

  @override
  DeactNode render(ComponentContext ctx) {
    final store = useMemo(ctx, () => ContinentalClientStore(data: data));
    store.setData(data);

    DeactNode _cardsView({
      void Function(int)? onClick,
    }) {
      return div(
        style: flexStyle(),
        children: [
          fc((ctx) {
            final usedCards = store.usedCards.value;
            return fragment([
              ...store.cards.mapIndexed(
                (index, card) => div(
                  key: index.toString() + card.toString(),
                  className: 'mx-1',
                  children: [
                    onClick != null
                        ? CardView(
                            card: card,
                            used: usedCards.contains(index),
                            onClick: (_) => onClick(index),
                          )
                        : CardView(
                            card: card,
                            dragId: '$index',
                            used: usedCards.contains(index),
                            onDrop: (id) {
                              store.swap(index, int.parse(id));
                            },
                          ),
                  ],
                ),
              )
            ]);
          })
        ],
      );
    }

    return div(
      children: [
        if (data.currentPlayerIndex == null)
          button(
            id: 'start-btn',
            type: 'button',
            className: btn(),
            onclick: (_) {
              _continentalStore.consume(ContinentalCommStart());
            },
            children: [txt('Start')],
          ),
        div(
          key: 'eat-section',
          children: [
            div(
              className: 'p-2',
              children: [
                span(children: [txt('Step:')]),
                span(className: 'p-1', children: [txt(data.step.name)]),
              ],
            ),
            div(
              children: [
                span(children: [txt('Dropped Card:')]),
                if (data.topCard == null)
                  span(className: 'p-1', children: [txt('No card')])
                else
                  CardView(card: data.topCard!),
              ],
            ),
            if (data.currentPlayer != player ||
                data.playerStep == ContinentalPlayStep.eating)
              div(
                key: 'eat-buttons',
                className: 'p-1',
                style: flexStyle(main: AxisAlign.center),
                children: [
                  if (data.currentPlayer != player)
                    button(
                      id: 'castigarse',
                      type: 'button',
                      disabled: data.canPunish ? null : '',
                      className: btn(color: BColor.warning),
                      onclick: (_) {
                        _continentalStore.consume(
                            ContinentalComm.castigarse(playerId: player));
                      },
                      children: [txt('Castigarse')],
                    )
                  else ...[
                    button(
                      id: 'eat-top',
                      type: 'button',
                      disabled: data.topCard == null ? '' : null,
                      className: btn(),
                      onclick: (_) {
                        _continentalStore.consume(
                          ContinentalComm.comer(fromDropped: true),
                        );
                      },
                      children: [txt('Eat Dropped')],
                    ),
                    span(style: 'width:5px;'),
                    button(
                      id: 'eat-random',
                      type: 'button',
                      className: btn(),
                      onclick: (_) {
                        _continentalStore.consume(
                          ContinentalComm.comer(fromDropped: false),
                        );
                      },
                      children: [txt('Eat Random')],
                    ),
                  ]
                ],
              ),
          ],
        ),
        if (data.currentPlayer != null)
          div(
            key: 'bajar-cards',
            children: [
              div(
                style: flexStyle(main: AxisAlign.space_between),
                children: [
                  h3(children: [txt('Bajar')]),
                  fc((ctx) {
                    final modalHook = useModal(ctx.bootstrapCtx);
                    return div(
                      children: [
                        button(
                          id: 'bajar-btn',
                          type: 'button',
                          className: btn(),
                          disabled: data.currentPlayer == player &&
                                  data.playerStep ==
                                      ContinentalPlayStep.dropping
                              ? null
                              : '',
                          onclick: (_) {
                            if (store.cards.length - store.cardSet.length ==
                                1) {
                              final _index =
                                  Iterable<int>.generate(store.cards.length)
                                      .firstWhere(
                                (d) => !store.usedCards.value.contains(d),
                              );
                              store.bajar(_index);
                            } else {
                              modalHook.toggle();
                            }
                          },
                          children: [txt('Bajar')],
                        ),
                        if (!modalHook.show.value)
                          el('div')
                        else
                          modal(
                            id: 'bajar-modal',
                            modalRef: modalHook.ref,
                            dialog: modalDialog(
                              dialogClass: modalDialogClass(),
                              header: [txt('Drop Card')],
                              body: [
                                div(
                                  style: colStyle(),
                                  children: [
                                    div(
                                      className: 'p-2',
                                      children: [txt('Select a card to drop')],
                                    ),
                                    _cardsView(
                                      onClick: (index) {
                                        if (!store.usedCards.value
                                            .contains(index)) {
                                          store.bajar(index);
                                          modalHook.toggle();
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                      ],
                    );
                  }),
                ],
              ),
              ...Iterable.generate(
                data.step.threesomes + data.step.stairs,
                (groupIndex) {
                  final isThreesome = data.step.threesomes > groupIndex;
                  return div(
                    id: 'bajar-carta-$groupIndex',
                    className: 'p-1',
                    style: flexStyle(),
                    children: [
                      fc((ctx) {
                        return fragment([
                          ...Iterable.generate(
                            isThreesome ? 3 : 4,
                            (index) {
                              final _index = CardSetIndex(
                                groupId: groupIndex,
                                innerId: index,
                              );
                              final cardIndex = store.cardSet[_index];
                              return div(
                                id: 'bajar-carta-$groupIndex-$index',
                                className: cardIndex != null
                                    ? 'mx-1 d-inline-block '
                                    : 'p-2 mx-1 bg-secondary ${roundedClass()}',
                                style: cardIndex != null
                                    ? null
                                    : 'width:40px;height:50px;',
                                ondrop: (e) {
                                  e.stopPropagation();
                                  final cardId =
                                      e.dataTransfer.getData('text/plain');
                                  store.setCard(_index, int.parse(cardId));
                                },
                                ondragover: (e) => e.preventDefault(),
                                onclick: cardIndex != null
                                    ? (_) => store.cardSet.remove(_index)
                                    : null,
                                children: [
                                  if (cardIndex != null)
                                    CardView(
                                      card: store.cards[cardIndex],
                                      dragId: cardIndex.toString(),
                                    ),
                                ],
                              );
                            },
                          ),
                        ]);
                      }),
                    ],
                  );
                },
              ),
            ],
          ),
        h3(children: [txt('Cards')]),
        _cardsView(),
        div(
          children: [
            ...data.otherTableCards.entries.map(
              (e) => div(
                key: e.key,
                style: colStyle(cross: AxisAlign.start),
                className: 'p-1',
                children: [
                  span(children: [txt(e.key)]),
                  if (e.value.isEmpty)
                    div(children: [txt('No table cards.')])
                  else
                    div(
                      children: [
                        ...e.value.mapIndexed(
                          (i, cards) => div(
                            key: '$i',
                            className: 'mx-2',
                            children: [
                              ...cards.map(
                                (e) => CardView(
                                  card: e,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                ],
              ),
            ),
          ],
        ),
        table(
          className: tableClass(
            bordered: true,
            captionTop: true,
            striped: true,
            small: true,
            // color: color.value,
            // align: align.value,
            // scrollHorizontal: scrollHorizontal.value,
          ),
          children: [
            caption(children: [txt('Points per Player')]),
            thead(
              // className: headerColor.value == null
              //     ? null
              //     : tableClass(color: headerColor.value),
              children: [
                tr(
                  children: [
                    th(scope: 'col', children: [txt('Game')]),
                    ...data.otherTableCards.keys.map(
                      (playerId) => th(scope: 'col', children: [txt(playerId)]),
                    ),
                  ],
                ),
              ],
            ),
            tbody(
              children: [
                ...data.counts.mapIndexed(
                  (index, item) {
                    final step = ContinentalStep.values[index].name;
                    return tr(
                      key: step,
                      children: [
                        th(
                          scope: 'row',
                          children: [txt('$step (${index + 1})')],
                        ),
                        ...data.otherTableCards.keys.map(
                          (playerId) => td(children: [
                            txt(item[playerId].toString()),
                          ]),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
            tfoot(
              children: [
                tr(children: [
                  th(
                    scope: 'row',
                    children: [txt('Sum')],
                  ),
                  ...data.otherTableCards.keys.map(
                    (playerId) => td(
                      children: [
                        txt(
                          data.counts
                              .fold<int>(0, (v, item) => v + item[playerId]!)
                              .toString(),
                        ),
                      ],
                    ),
                  ),
                ]),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class CardView extends ComponentNode {
  const CardView({
    String? key,
    required this.card,
    this.dragId,
    this.onDrop,
    this.onClick,
    this.used = false,
  }) : super(key: key);

  final Card card;
  final String? dragId;
  final bool used;
  final void Function(String)? onDrop;
  final void Function(html.MouseEvent)? onClick;

  @override
  DeactNode render(ComponentContext ctx) {
    return div(
      className: 'px-2 py-1 bg-white'
          ' ${roundedClass(size: RoundedSize.s2)} ${borderClass()} ${used ? 'opacity-50' : ''}',
      style: colStyle() +
          (dragId != null
              ? 'cursor:move;'
              : onClick != null
                  ? 'cursor:pointer;'
                  : ''),
      draggable: dragId != null ? 'true' : null,
      ondragstart: dragId != null
          ? (e) {
              e.dataTransfer.effectAllowed = 'move';
              e.dataTransfer.dropEffect = 'move';
              e.dataTransfer.setData('text/plain', dragId!);
            }
          : null,
      ondrop: onDrop != null
          ? (e) {
              e.stopPropagation();
              final cardId = e.dataTransfer.getData('text/plain');
              print(cardId);
              onDrop!(cardId);
            }
          : null,
      ondragover: onDrop != null ? (e) => e.preventDefault() : null,
      onclick: onClick,
      children: [
        span(
          children: [txt(card.n == CardN.joker ? '🃏' : card.n.name)],
        ),
        if (card.n != CardN.joker)
          span(
            style: 'color:${card.type.index < 2 ? 'red' : 'black'};',
            children: [txt(card.type.unicode)],
          )
      ],
    );
  }
}
