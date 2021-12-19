import 'package:universal_html/html.dart' as html;

import 'package:deact/deact.dart';
import 'package:mobx/mobx.dart';

html.Storage get localStorage => html.window.localStorage;

enum Tab {
  message,
  profile,
}

extension TabName on Tab {
  String get name => toString().split('.').last;
}

Tab? _tabFromUrl() {
  final qp = Uri.parse(html.window.location.href).queryParameters;
  final _index = Tab.values.indexWhere((v) => v.name == qp['tab']);
  if (_index != -1) {
    return Tab.values[_index];
  }
}

class RootStore {
  RootStore() {
    const _key = 'RootValue.count';
    final saved = int.tryParse(localStorage[_key] ?? '');
    if (saved != null) {
      runInAction(() => _count.value = saved);
    }
    autorun(
      (_) => localStorage[_key] = _count.value.toString(),
      delay: 300,
    );
    // _syncTabWithUrl();
    autorun((_) {
      if (_tabFromUrl() == tab.value) return;
      final _url = Uri.parse(html.window.location.href);
      final newUrl = _url.replace(queryParameters: {
        ..._url.queryParametersAll,
        'tab': [tab.value.name],
      });
      // html.window.history.pushState(null, '', newUrl.toString());
    });

    html.window.onPopState.listen((event) {
      // _syncTabWithUrl();
    });
  }

  void _syncTabWithUrl() {
    final _tab = _tabFromUrl();
    if (_tab != null) {
      tab.value = _tab;
    }
  }

  late final messageStore = MessageStore(this);

  final tab = Observable<Tab>(Tab.message);

  final _count = Observable<int>(0);
  int get count {
    print('read-count');
    return _count.value;
  }

  void increment() {
    print('increment');
    runInAction(() => _count.value++);
  }

  static RootStore fromCtx(ComponentContext ctx) =>
      ctx.globalRef<RootStore>('RootValue').value;
}

class MessageStore {
  final RootStore root;

  MessageStore(this.root);

  final messages = ObservableList<Message>();

  void sendMessage() {
    runInAction(() {
      messages.add(Message(content: message.value, createdAt: DateTime.now()));
      message.value = '';
    });
  }

  final message = Observable<String>('');

  static MessageStore fromCtx(ComponentContext ctx) =>
      RootStore.fromCtx(ctx).messageStore;
}

class Message {
  final String content;
  final DateTime createdAt;

  Message({
    required this.content,
    required this.createdAt,
  });
}
