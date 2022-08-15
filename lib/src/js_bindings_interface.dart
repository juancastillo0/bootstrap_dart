import 'package:universal_html/html.dart' as html;

/// https://getbootstrap.com/docs/5.2/components/scrollspy/
class ScrollSpy {
  ScrollSpy(html.Element element, ScrollSpyConfig config);
  void dispose() {}
  void refresh() {}
}

/// https://getbootstrap.com/docs/5.2/components/scrollspy/
class ScrollSpyConfig {
  ScrollSpyConfig({required this.target});

  /// #navbar-example
  final String target;
}

/// https://getbootstrap.com/docs/5.2/components/modal/
class ModalJS {
  ModalJS(html.Element element);

  void toggle() {}
  void handleUpdate() {}
  void show() {}
  void hide() {}
  void dispose() {}
}

/// https://getbootstrap.com/docs/5.2/components/modal/
class ToastJS {
  ToastJS(html.Element element);

  void show() {}
  void hide() {}
  void dispose() {}
}

/// https://getbootstrap.com/docs/5.2/components/tooltips/
class TooltipJS {
  TooltipJS(html.Element element);

  void dispose() {}
}

/// https://getbootstrap.com/docs/5.2/components/offcanvas/
class Offcanvas {
  Offcanvas(html.Element element);
  void toggle() {}
  void show() {}
  void hide() {}
}

/// https://getbootstrap.com/docs/5.2/components/popovers/
class Popover {
  Popover(html.Element element);
  void show() {}
  void hide() {}
  void toggle() {}
  void update() {}
  void dispose() {}

  void enable() {}
  void disable() {}
  void toggleEnable() {}
}
