import 'package:universal_web/web.dart' as web;

/// https://getbootstrap.com/docs/5.2/components/scrollspy/
class ScrollSpy {
  ScrollSpy(web.Element element, ScrollSpyConfig config);
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
  ModalJS(web.Element element);

  void toggle() {}
  void handleUpdate() {}
  void show() {}
  void hide() {}
  void dispose() {}
}

/// https://getbootstrap.com/docs/5.2/components/modal/
class ToastJS {
  ToastJS(web.Element element);

  void show() {}
  void hide() {}
  void dispose() {}
}

/// https://getbootstrap.com/docs/5.2/components/tooltips/
class TooltipJS {
  TooltipJS(web.Element element);

  void dispose() {}
}

/// https://getbootstrap.com/docs/5.2/components/offcanvas/
class Offcanvas {
  Offcanvas(web.Element element);
  void toggle() {}
  void show() {}
  void hide() {}
}

/// https://getbootstrap.com/docs/5.2/components/popovers/
class Popover {
  Popover(web.Element element);
  void show() {}
  void hide() {}
  void toggle() {}
  void update() {}
  void dispose() {}

  void enable() {}
  void disable() {}
  void toggleEnable() {}
}
