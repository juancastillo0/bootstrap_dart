import 'dart:async';
import 'dart:html' as html;
import 'package:deact/deact.dart';
import 'package:deact/deact_html52.dart';
import 'package:js/js.dart';

import 'bootstrap_core.dart';

/// Modal https://getbootstrap.com/docs/5.1/components/modal/

enum ModalFullScreenBellow {
  sm,
  md,
  lg,
  xl,
  xxl,
  always,
}

extension ModalFullScreenBellowExt on ModalFullScreenBellow {
  String get name => toString().split('.').last;
}

class ModalConfig {
  final bool fade;
  final bool center;
  final bool backdrop;
  final bool closeOnClick;
  final bool closeOnEscKey;
  final bool focus;
  final bool scrollable;
  final BSize? size; // TODO: add more sizes
  final ModalFullScreenBellow? fullScreen;

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

/// TODO: data-toggle="modal" data-target="#myModal"
DeactNode modal({
  Object? key,
  required String id,
  bool fade = true,
  bool center = true,
  bool backdrop = true,
  bool closeOnClick = true,
  bool closeOnEscKey = true,
  bool focus = true,
  bool scrollable = false,
  BSize? size,
  ModalFullScreenBellow? fullScreen,
  DeactNode? body,
  DeactNode? header,
  DeactNode? footer,
  String? labelledBy,
  String? describedBy,
  void Function(Modal)? onSetUp,
  void Function(ModalEventType, html.Event)? onEvent,
}) {
  final _fullScreen = fullScreen != null
      ? fullScreen == ModalFullScreenBellow.always
          ? ' modal-fullscreen'
          : ' modal-fullscreen-${fullScreen.name}-down'
      : '';

  return fc((ctx) {
    final modal = ctx.ref<Modal?>('modal', null);
    final elemRef = useSetUpElement(
      ctx,
      onSetUp: (elem) {
        final _modal = Modal(elem);
        modal.value = _modal;
        onSetUp?.call(_modal);

        _modal.show();
      },
      onDispose: () {
        if (modal.value != null) {
          modal.value!.dispose();
        }
      },
    );

    return el(
      'div',
      ref: elemRef,
      attributes: {
        'id': id,
        'class': 'modal${fade ? ' fade' : ''}',
        'tabindex': "-1",
        if (!closeOnClick) 'data-bs-backdrop': "static",
        if (closeOnClick && !backdrop) 'data-bs-backdrop': "false",
        if (!closeOnEscKey) 'data-bs-keyboard': "false",
        if (!focus) 'data-bs-focus': "false",

        /// accessibility
        'role': "dialog",
        'aria-hidden': "true",
        if (labelledBy != null) 'aria-labelledby': labelledBy,
        if (describedBy != null) 'aria-describedby': describedBy,
      },
      // listeners: {
      //   'show.bs.modal': (html.Event event) {
      //     onEvent?.call(ModalEvent.show, event);
      //   },
      //   'shown.bs.modal': (html.Event event) {
      //     onEvent?.call(ModalEvent.shown, event);
      //   },
      //   'hide.bs.modal': (html.Event event) {
      //     onEvent?.call(ModalEvent.hide, event);
      //   },
      //   'hidden.bs.modal': (html.Event event) {
      //     onEvent?.call(ModalEvent.hidden, event);
      //   },
      //   'hidePrevented.bs.modal': (html.Event event) {
      //     onEvent?.call(ModalEvent.hidePrevented, event);
      //   },
      // },
      children: [
        el(
          'div',
          attributes: {
            'class': 'modal-dialog${size != null ? ' modal-${size.name}' : ''}'
                '${center ? ' modal-dialog-centered' : ''}'
                '${scrollable ? ' modal-dialog-scrollable' : ''}'
                '$_fullScreen',
            'role': 'document',
          },
          children: [
            div(className: 'modal-content', children: [
              if (header != null)
                div(className: 'modal-header', children: [header]),
              if (body != null) div(className: 'modal-body', children: [body]),
              if (footer != null)
                div(className: 'modal-footer', children: [footer]),
            ])
          ],
        ),
      ],
    );
  }, key: key);
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

  Modal(this.element) : _inner = _Modal(element) {
    ModalEventType.values.forEach((type) {
      element.addEventListener('${type.name}.bs.modal', (event) {
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
      });
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
