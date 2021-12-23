import 'package:deact/deact.dart';
import 'package:deact/deact_html52.dart';
import 'package:mobx/mobx.dart';
import 'package:test/test.dart';
import 'package:universal_html/html.dart' as html;

import 'package:bootstrap_dart/mobx_deact.dart';

class Action1<T, O> {
  final Action action;

  Action1(
    String name,
    O Function(T) execute,
  ) : action = Action(execute, name: name);

  O call(T arg1) => action([arg1]);
}

class Store {
  final items = ObservableList<Item>();

  int itemCountRebuilds = 0;

  late final itemCount = Computed(() => items.length);

  late final add = Action1<String, Item>('add', (String key) {
    print('add');
    final item = Item(key);
    items.add(item);
    return item;
  });

  void bringToFirst(Item item) {
    runInAction(() {
      if (item == items.first) return;
      items.remove(item);
      items.insert(0, item);
    });
  }

  static final scoped = Scoped((_) => Store());
}

class Item {
  final String key;
  final name = Observable('');
  final count = Observable(0);

  int rebuildCount = 0;

  void increment() => runInAction(() => count.value++);

  Item(this.key);
}

void main() {
  test('mobx wrapper and collection', () async {
    int rootBuilds = 0;
    int itemBuilds = 0;
    final globalStore = Store();

    final renderer = deact(
      '#output',
      (_) {
        return fc((ctx) {
          final store = ctx.setUpScoped(Store.scoped, globalStore);
          rootBuilds++;

          return div(
            id: 'div-id',
            children: [
              div(
                id: 'items-div',
                children: [
                  fc((ctx) {
                    itemBuilds++;
                    return fragment([
                      ...store.items.map(itemComponent),
                    ]);
                  }),
                ],
              ),
              itemCount()
            ],
          );
        });
      },
      wrappers: const [mobxWrapper],
    );

    await renderer.waitScheduledRender();

    final itemCountElem = html.querySelector('#item-count')!;
    final itemsDivElem = html.querySelector('#items-div')!;

    void _verifyCount(int count) {
      expect(itemCountElem.text, count.toString());
      expect(itemsDivElem.children.length, count);
    }

    _verifyCount(0);
    expect(rootBuilds, 1);
    expect(itemBuilds, 1);
    expect(globalStore.itemCountRebuilds, 1);

    final item1 = globalStore.add('key1');
    expect(globalStore.items, isNotEmpty);
    await renderer.waitScheduledRender();
    expect(rootBuilds, 1);
    expect(itemBuilds, 2);
    expect(globalStore.itemCountRebuilds, 2);
    _verifyCount(1);
    expect(item1.rebuildCount, 1);

    final item2 = globalStore.add('key2');
    await renderer.waitScheduledRender();
    expect(rootBuilds, 1);
    expect(itemBuilds, 3);
    expect(globalStore.itemCountRebuilds, 3);
    _verifyCount(2);
    expect(item1.rebuildCount, 2);
    expect(item2.rebuildCount, 1);

    final item2Div = html.querySelector('#item-${item2.key}')!;
    expect(item2Div.children.last, isA<html.ButtonElement>());

    item2Div.children.last.click();
    await renderer.waitScheduledRender();
    expect(rootBuilds, 1);
    expect(itemBuilds, 3);
    expect(globalStore.itemCountRebuilds, 3);
    _verifyCount(2);
    expect(item1.rebuildCount, 2);
    expect(item2.rebuildCount, 2);
    expect(item1.count.value, 0);
    expect(item2.count.value, 1);
    expect(itemsDivElem.children.first.id, 'item-${item1.key}');
    expect(itemsDivElem.children.last.id, 'item-${item2.key}');

    globalStore.bringToFirst(item2);

    await renderer.waitScheduledRender();
    expect(rootBuilds, 1);
    expect(itemBuilds, 4);
    expect(globalStore.itemCountRebuilds, 3);
    _verifyCount(2);
    expect(item1.rebuildCount, 3);
    expect(item2.rebuildCount, 3);
    expect(itemsDivElem.children.first.id, 'item-${item2.key}');
    expect(itemsDivElem.children.last.id, 'item-${item1.key}');
  });
}

DeactNode itemCount() {
  return span(
    id: 'item-count',
    children: [
      fc((ctx) {
        final store = Store.scoped.get(ctx);
        store.itemCountRebuilds++;
        return txt(
          store.itemCount.value.toString(),
        );
      })
    ],
  );
}

DeactNode itemComponent(Item item) {
  return div(
    key: 'item-${item.key}',
    id: 'item-${item.key}',
    children: [
      fc((ctx) {
        item.rebuildCount++;
        return fragment([
          span(
            children: [
              txt('${item.name.value}:${item.count.value}'),
            ],
          ),
          button(
            onclick: (_) => item.increment(),
          ),
        ]);
      })
    ],
  );
}
