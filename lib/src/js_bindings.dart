@JS()
library js_bindings;

import 'js_bindings_interface.dart' as i;
import 'package:universal_html/html.dart' as html;
import 'package:js/js.dart';

@JS('bootstrap.ScrollSpy')
class ScrollSpy implements i.ScrollSpy {
  external ScrollSpy(html.Element element, ScrollSpyConfig config);
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
  external ModalJS(html.Element element);

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
  external ToastJS(html.Element element);

  @override
  external void show();
  @override
  external void hide();
  @override
  external void dispose();
}

@JS('bootstrap.Tooltip')
class TooltipJS implements i.TooltipJS {
  external TooltipJS(html.Element element);

  @override
  external void dispose();
}

@JS('bootstrap.Offcanvas')
class Offcanvas implements i.Offcanvas {
  external Offcanvas(html.Element element);
  @override
  external void toggle();
  @override
  external void show();
  @override
  external void hide();
}

@JS('bootstrap.Popover')
class Popover implements i.Popover {
  external Popover(html.Element element);
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
