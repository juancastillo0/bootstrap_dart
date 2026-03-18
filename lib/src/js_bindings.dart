@JS()
library js_bindings;

import 'js_bindings_interface.dart' as i;
import 'package:universal_web/web.dart' as web;
import 'dart:js_interop';

@JS('bootstrap.ScrollSpy')
class ScrollSpy implements i.ScrollSpy {
  external ScrollSpy(web.Element element, ScrollSpyConfig config);
  @override
  external void dispose();
  @override
  external void refresh();
}

@JS()
@anonymous
class ScrollSpyConfig implements i.ScrollSpyConfig {
  external factory ScrollSpyConfig({required String target});

  /// #navbar-example
  @override
  external String get target;
}

@JS('bootstrap.Modal')
class ModalJS implements i.ModalJS {
  external ModalJS(web.Element element);

  @override
  external void toggle();
  @override
  external void handleUpdate();
  @override
  external void show();
  @override
  external void hide();
  @override
  external void dispose();
}

@JS('bootstrap.Toast')
class ToastJS implements i.ToastJS {
  external ToastJS(web.Element element);

  @override
  external void show();
  @override
  external void hide();
  @override
  external void dispose();
}

@JS('bootstrap.Tooltip')
class TooltipJS implements i.TooltipJS {
  external TooltipJS(web.Element element);

  @override
  external void dispose();
}

@JS('bootstrap.Offcanvas')
class Offcanvas implements i.Offcanvas {
  external Offcanvas(web.Element element);
  @override
  external void toggle();
  @override
  external void show();
  @override
  external void hide();
}

@JS('bootstrap.Popover')
class Popover implements i.Popover {
  external Popover(web.Element element);
  @override
  external void show();
  @override
  external void hide();
  @override
  external void toggle();
  @override
  external void update();
  @override
  external void dispose();

  @override
  external void enable();
  @override
  external void disable();
  @override
  external void toggleEnable();
}
