@JS()
library js_bindings;

import 'package:universal_html/html.dart' as html;
import 'package:js/js.dart';

@JS('bootstrap.ScrollSpy')
class ScrollSpy {
  external ScrollSpy(html.Element element, ScrollSpyConfig config);
  external void dispose();
  external void refresh();
}

@JS()
@anonymous
class ScrollSpyConfig {
  external factory ScrollSpyConfig({required String target});

  /// #navbar-example
  external String get target;
}

@JS('bootstrap.Modal')
class ModalJS {
  external ModalJS(html.Element element);

  external void toggle();
  external void handleUpdate();
  external void show();
  external void hide();
  external void dispose();
}

@JS('bootstrap.Toast')
class ToastJS {
  external ToastJS(html.Element element);

  external void show();
  external void hide();
  external void dispose();
}

@JS('bootstrap.Tooltip')
class TooltipJS {
  external TooltipJS(html.Element element);

  external void dispose();
}

@JS('bootstrap.Offcanvas')
class Offcanvas {
  external Offcanvas(html.Element element);
  external void toggle();
  external void show();
  external void hide();
}

@JS('bootstrap.Popover')
class Popover {
  external Popover(html.Element element);
  external void show();
  external void hide();
  external void toggle();
  external void update();
  external void dispose();

  external void enable();
  external void disable();
  external void toggleEnable();
}
