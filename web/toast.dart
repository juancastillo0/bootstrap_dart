import 'dart:html' as html;
import 'package:deact/deact.dart';
import 'package:deact/deact_html52.dart';
import 'package:js/js.dart';

import 'bootstrap.dart';

/// Toasts https://getbootstrap.com/docs/5.1/components/toasts/

enum ToastEventType {
  show,
  shown,
  hide,
  hidden,
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
  return div(
    className: 'toast-container position-absolute p-3',
    style: '${verticalPosition.verticalStyle()}'
        '${horizontalPosition.horizontalStyle()}',
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
    final toast = ctx.ref<Toast?>('toast', null);
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
  DeactNode? header,
  DeactNode? body,
  bool showCloseButton = false,
}) {
  return fragment([
    if (header != null)
      div(
        className: 'toast-header',
        children: [
          header,
          if (showCloseButton) closeToastButton(),
        ],
      ),
    if (body != null)
      div(
        className: 'toast-body',
        children: [body],
      ),
  ]);
}

class Toast {
  final _Toast _inner;
  final html.Element element;
  Toast(this.element) : _inner = _Toast(element);

  bool _isShowing = false;
  bool get isShowing => _isShowing;

  void show() {
    _isShowing = true;
    _inner.show();
  }

  void hide() {
    _isShowing = false;
    _inner.hide();
  }

  void dispose() {
    _isShowing = false;
    _inner.dispose();
  }
}

@JS('bootstrap.Toast')
class _Toast {
  external _Toast(html.Element element);

  external void show();
  external void hide();
  external void dispose();
}
