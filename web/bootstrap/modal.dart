import 'dart:async';
import 'dart:html' as html;
import 'package:deact/deact.dart';
import 'package:deact/deact_html52.dart';
import 'package:js/js.dart';

import 'bootstrap_core.dart';

/// Modal https://getbootstrap.com/docs/5.1/components/modal/

class ModalConfig {
  final bool fade;
  final bool center;
  final bool backdrop;
  final bool closeOnClick;
  final bool closeOnEscKey;
  final bool focus;
  final bool scrollable;
  final BSize? size; // TODO: add more sizes
  final ResponsiveBreakPoint? fullScreen;

  ModalConfig({
    this.fade = true,
    this.center = true,
    this.backdrop = true,
    this.closeOnClick = false,
    this.closeOnEscKey = true,
    this.focus = true,
    this.scrollable = false,
    this.size,
    this.fullScreen,
  });
}

enum ModalEventType {
  show,
  shown,
  hide,
  hidden,
  hidePrevented,
}

extension ModalEventExt on ModalEventType {
  String get name => toString().split('.').last;
}

DeactNode modal({
  Object? key,
  required String id,
  required DeactNode dialog,
  bool fade = true,
  bool backdrop = true,
  bool closeOnClick = true,
  bool closeOnEscKey = true,
  bool focus = true,
  String? labelledBy,
  String? describedBy,
  Ref<Modal?>? modalRef,
}) {
  return fc((ctx) {
    final elemRef = ctx.ref<html.Element?>('modalElement', null);

    ctx.hookEffect(
      () {
        if (modalRef == null) return null;
        final _modal = Modal(elemRef.value!);
        modalRef.value = _modal;
        return _modal.dispose;
      },
      [modalRef, fade, backdrop, closeOnClick, closeOnEscKey, focus],
    );

    return el(
      'div',
      ref: elemRef,
      attributes: {
        'id': id,
        'class': 'modal${fade ? ' fade' : ''}',
        'tabindex': "-1",
        if (!closeOnClick) 'data-bs-backdrop': 'static',
        if (closeOnClick && !backdrop) 'data-bs-backdrop': false,
        if (!closeOnEscKey) 'data-bs-keyboard': false,
        if (!focus) 'data-bs-focus': false,

        /// accessibility
        'role': "dialog",
        'aria-hidden': "true",
        if (labelledBy != null) 'aria-labelledby': labelledBy,
        if (describedBy != null) 'aria-describedby': describedBy,
      },
      children: [dialog],
    );
  }, key: key);
}

DeactNode modalDialog({
  Iterable<DeactNode>? body,
  Iterable<DeactNode>? header,
  Iterable<DeactNode>? footer,
  required String dialogClass,
}) {
  return el(
    'div',
    attributes: {
      'class': dialogClass,
      'role': 'document',
    },
    children: [
      div(
        className: 'modal-content',
        children: [
          if (header != null)
            div(
              className: 'modal-header',
              key: 'header',
              children: header,
            ),
          if (body != null)
            div(
              className: 'modal-body',
              key: 'body',
              children: body,
            ),
          if (footer != null)
            div(
              className: 'modal-footer',
              key: 'footer',
              children: footer,
            ),
        ],
      )
    ],
  );
}

enum DialogSize {
  sm,
  lg,
  xl,
}

extension DialogSizeExt on DialogSize {
  String get name => toString().split('.').last;
}

String modalDialogClass({
  bool center = true,
  bool scrollable = false,
  DialogSize? size,
  ResponsiveBreakPoint? fullScreen,
}) {
  final _fullScreen = fullScreen != null
      ? fullScreen == ResponsiveBreakPoint.always
          ? ' modal-fullscreen'
          : ' modal-fullscreen-${fullScreen.name}-down'
      : '';

  return 'modal-dialog${size != null ? ' modal-${size.name}' : ''}'
      '${center ? ' modal-dialog-centered' : ''}'
      '${scrollable ? ' modal-dialog-scrollable' : ''}'
      '$_fullScreen';
}

class ModalEvent {
  final Modal modal;
  final ModalEventType type;
  final html.Event event;

  ModalEvent(this.modal, this.type, this.event);
}

class Modal {
  final _Modal _inner;
  final html.Element element;
  final _controller = StreamController<ModalEvent>.broadcast();
  Stream<ModalEvent> get events => _controller.stream;

  bool _disposed = false;
  bool get disposed => _disposed;

  bool _shown = false;
  bool get shown => !disposed && _shown;

  final List<void Function()> _onDispose = [];

  Modal(this.element) : _inner = _Modal(element) {
    ModalEventType.values.forEach((type) {
      final name = '${type.name}.bs.modal';
      void _callback(html.Event event) {
        switch (type) {
          case ModalEventType.shown:
            _shown = true;
            break;
          case ModalEventType.hidden:
            _shown = false;
            break;
          default:
        }
        _controller.add(ModalEvent(this, type, event));
      }

      _onDispose.add(() {
        element.removeEventListener(name, _callback);
      });
      element.addEventListener(name, _callback);
    });
  }

  void toggle() {
    if (_disposed) return;
    _inner.toggle();
  }

  void handleUpdate() {
    if (_disposed) return;
    _inner.handleUpdate();
  }

  void show() {
    if (_disposed) return;
    _inner.show();
  }

  void hide() {
    if (_disposed) return;
    _inner.hide();
  }

  void dispose() {
    if (_disposed) return;
    _disposed = true;
    _onDispose.forEach((element) => element());
    _inner.dispose();
    _controller.close();
  }
}

@JS('bootstrap.Modal')
class _Modal {
  external _Modal(html.Element element);

  external void toggle();
  external void handleUpdate();
  external void show();
  external void hide();
  external void dispose();
}
