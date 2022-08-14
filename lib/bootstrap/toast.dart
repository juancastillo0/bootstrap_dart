import 'dart:async';
import 'package:universal_html/html.dart' as html;

import 'bootstrap_core.dart';

/// Toasts https://getbootstrap.com/docs/5.1/components/toasts/

enum ToastEventType {
  show,
  shown,
  hide,
  hidden,
}

enum ToastsControllerEvent {
  added,
  deleted,
}

class ToastInfo {
  final int id;
  final DeactNode node;
  final Duration duration;

  ToastInfo({
    required this.id,
    required this.node,
    required this.duration,
  });
}

class ToastsController {
  final bool allowMultiple;
  final Alignment verticalPosition;
  final Alignment horizontalPosition;

  ToastsController({
    this.allowMultiple = true,
    this.verticalPosition = Alignment.end,
    this.horizontalPosition = Alignment.end,
  });

  final _controller = StreamController<ToastsControllerEvent>.broadcast();
  Stream<ToastsControllerEvent> get stream => _controller.stream;

  final List<ToastInfo> queue = [];
  final Map<int, Timer?> _timers = {};

  int _count = 0;

  void Function() add(
    DeactNode _node, {
    Duration duration = const Duration(seconds: 5),
  }) {
    _count++;
    final node = ToastInfo(id: _count, node: _node, duration: duration);
    final remove = _setUpRemove(node);

    if (allowMultiple || queue.isEmpty) {
      _timers[node.id] = Timer(duration, remove);
      _controller.add(ToastsControllerEvent.added);
    }
    queue.add(node);

    return remove;
  }

  void Function() _setUpRemove(ToastInfo node) {
    bool removed = false;
    void remove() {
      if (removed) return;
      removed = true;
      final timer = _timers.remove(node.id);
      timer?.cancel();
      queue.remove(node);

      if (!allowMultiple && queue.isNotEmpty) {
        final _toAdd = queue.first;
        _timers[node.id] = Timer(_toAdd.duration, _setUpRemove(_toAdd));
      }
      _controller.add(ToastsControllerEvent.deleted);
    }

    return remove;
  }

  DeactNode render() {
    return fc(
      (ctx) {
        ctx.hookEffect(
          () => stream.listen((event) => ctx.scheduleRerender()).cancel,
          const [],
        );
        final toRender =
            allowMultiple ? queue : [if (queue.isNotEmpty) queue.first];

        return toastsContainer(
          horizontalPosition: horizontalPosition,
          verticalPosition: verticalPosition,
          children: toRender.map(
            (e) => toast(
              key: e.id,
              toastId: e.id.toString(),
              autoHide: false,
              content: e.node,
            ),
          ),
        );
      },
    );
  }
}

void showToast() {
  final elem = html.Element.div()
    ..className = 'toast'
    ..setAttribute('role', 'alert')
    ..setAttribute('aria-live', 'assertive')
    ..setAttribute('aria-atomic', 'true')
    ..append(
      html.Element.div()
        ..className = 'toast-header'
        ..appendText('HEADER'),
    )
    ..append(
      html.Element.div()
        ..className = 'toast-body'
        ..appendText('Toast message!'),
    );

  html.querySelector('#output')!.append(elem);
  Toast(elem).show();
}

DeactNode toastsContainer({
  Alignment verticalPosition = Alignment.end,
  Alignment horizontalPosition = Alignment.end,
  required Iterable<DeactNode>? children,
}) {
  // return el(
  //   'div',
  //   attributes: {
  //     'aria-live': 'polite',
  //     'aria-atomic': 'true',
  //     'class': 'position-absolute', // TODO: was position-relative
  //     'style': 'width:100%;height:100%;top:0;left:0;',
  //   },
  //   children: [
  return el(
    'div',
    attributes: {
      'class': 'toast-container position-absolute p-3',
      'style': '${verticalPosition.verticalStyle()}'
          '${horizontalPosition.horizontalStyle()}',
    },
    children: children,
  );
  //   ],
  // );
}

DeactNode toast({
  required Object key,
  required DeactNode content,
  void Function(Toast)? onSetUp,
  bool autoHide = true,
  Duration delay = const Duration(seconds: 5),
  bool animated = true,
  String? toastClass,
  String? toastId,
}) {
  return fc((ctx) {
    final toast = ctx.hookRef<Toast?>(() => null);
    final elemRef = useSetUpElement(
      ctx,
      onSetUp: (elem) {
        final _toast = Toast(elem);
        toast.value = _toast;
        onSetUp?.call(_toast);

        _toast.show();
      },
      onDispose: () {
        if (toast.value != null) {
          toast.value!.dispose();
        }
      },
    );

    return el(
      'div',
      key: key,
      ref: elemRef,
      attributes: {
        'class': 'toast ${toastClass ?? ''}',
        'role': 'alert',
        'aria-live': 'assertive',
        'aria-atomic': 'true',
        if (toastId != null) 'id': toastId,
        if (!autoHide) 'data-bs-autohide': 'false',
        'data-bs-delay': delay.inMilliseconds,
        if (!animated) 'data-bs-animation': 'false',
      },
      children: [content],
    );
  });
}

DeactNode closeToastButton({
  bool disabled = false,
  bool white = false,
  String? targetId,
}) {
  return closeButton(
    attributes: {
      'data-bs-dismiss': 'toast',
      if (targetId != null) 'data-bs-target': targetId
    },
    white: white,
    disabled: disabled,
    onClick: null,
  );
}

DeactNode toastContent({
  Iterable<DeactNode>? header,
  Iterable<DeactNode>? body,
  bool showCloseButton = false,
  String headerClass = 'justify-content-between',
}) {
  return fragment([
    if (header != null)
      div(
        className: 'toast-header $headerClass',
        children: [
          ...header,
          if (showCloseButton) closeToastButton(),
        ],
      ),
    if (body != null)
      div(
        className: 'toast-body',
        children: body,
      ),
  ]);
}

class Toast {
  final ToastJS _inner;
  final html.Element element;
  Toast(this.element) : _inner = ToastJS(element);

  bool _isDisposed = false;
  bool get isDisposed => _isDisposed;

  bool _isShowing = false;
  bool get isShowing => _isShowing;

  void show() {
    if (_isDisposed) return;
    _isShowing = true;
    _inner.show();
  }

  void hide() {
    if (_isDisposed) return;
    _isShowing = false;
    _inner.hide();
  }

  void dispose() {
    if (_isDisposed) return;
    _isDisposed = true;
    _isShowing = false;
    _inner.dispose();
  }
}
