import 'package:universal_html/html.dart' as html;

class ScrollSpy {
  ScrollSpy(html.Element element, ScrollSpyConfig config) {}
  void dispose() {}
  void refresh() {}
}

class ScrollSpyConfig {
  ScrollSpyConfig({required this.target}) {}

  /// #navbar-example
  final String target;
}

class ModalJS {
  ModalJS(html.Element element) {}

  void toggle() {}
  void handleUpdate() {}
  void show() {}
  void hide() {}
  void dispose() {}
}

class ToastJS {
  ToastJS(html.Element element) {}

  void show() {}
  void hide() {}
  void dispose() {}
}

class TooltipJS {
  TooltipJS(html.Element element) {}

  void dispose() {}
}

class Offcanvas {
  Offcanvas(html.Element element) {}
  void toggle() {}
  void show() {}
  void hide() {}
}

class Popover {
  Popover(html.Element element) {}
  void show() {}
  void hide() {}
  void toggle() {}
  void update() {}
  void dispose() {}

  void enable() {}
  void disable() {}
  void toggleEnable() {}
}
