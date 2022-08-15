import 'dart:async';
import 'package:universal_html/html.dart' as html;
import '../src/prelude.dart';

/// The state created in [useModal]. Can be used to access the [Modal] class
/// and edit the [show] state.
class ModalHook {
  final State<bool> show;
  final Ref<Modal?> ref;

  ModalHook(this.show, this.ref);

  void toggle() => show.value = !show.value;
}

/// Can be used with the [modal] component to access the [Modal] class.
ModalHook useModal(BootstrapBuildContext ctx) {
  final showModal = ctx.hookState(() => false);
  final modalRef = ctx.hookRef<Modal?>(() => null);

  ctx.hookEffect(() {
    if (showModal.value) {
      modalRef.value!.show();
      final subs = modalRef.value!.events.listen((event) {
        if (event.type == ModalEventType.hidden) {
          showModal.value = false;
        }
      });
      return () {
        subs.cancel();
        modalRef.value!.hide();
      };
    }
  }, [showModal.value]);

  return ModalHook(showModal, modalRef);
}

/// For the [dialog] you may use the [modalDialog] component.
///
/// https://getbootstrap.com/docs/5.2/components/modal/
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
    final elemRef = ctx.hookRef<html.Element?>(() => null);

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

/// A utility component for creating the content in a modal dialog.
/// Can be used as the `dialog` argument in [modal].
/// The [dialogClass] could be composed with [modalDialogClass].
///
/// https://getbootstrap.com/docs/5.2/components/modal/
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

/// The css class for a modal dialog.
///
/// https://getbootstrap.com/docs/5.2/components/modal/
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

/// The modal event types
///
/// https://getbootstrap.com/docs/5.2/components/modal/#events
enum ModalEventType {
  show,
  shown,
  hide,
  hidden,
  hidePrevented,
}

/// An event emitted by a [Modal].
///
/// https://getbootstrap.com/docs/5.2/components/modal/#events
class ModalEvent {
  final Modal modal;
  final ModalEventType type;
  final html.Event event;

  ModalEvent(this.modal, this.type, this.event);
}

/// A wrapper around the [ModalJS] instance with a stream ([events]) of [ModalEvent]
/// and other utilities for showing and closing the modal.
///
/// https://getbootstrap.com/docs/5.1/components/modal/
class Modal {
  final ModalJS _inner;
  final html.Element element;
  final _controller = StreamController<ModalEvent>.broadcast();
  Stream<ModalEvent> get events => _controller.stream;

  bool _disposed = false;
  bool get disposed => _disposed;

  bool _shown = false;
  bool get shown => !disposed && _shown;

  final List<void Function()> _onDispose = [];

  Modal(this.element) : _inner = ModalJS(element) {
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

/// Modal https://getbootstrap.com/docs/5.1/components/modal/
// class ModalConfig {
//   final bool fade;
//   final bool center;
//   final bool backdrop;
//   final bool closeOnClick;
//   final bool closeOnEscKey;
//   final bool focus;
//   final bool scrollable;
//   final BSize? size; // TODO: add more sizes
//   final ResponsiveBreakPoint? fullScreen;

//   ModalConfig({
//     this.fade = true,
//     this.center = true,
//     this.backdrop = true,
//     this.closeOnClick = false,
//     this.closeOnEscKey = true,
//     this.focus = true,
//     this.scrollable = false,
//     this.size,
//     this.fullScreen,
//   });
// }
