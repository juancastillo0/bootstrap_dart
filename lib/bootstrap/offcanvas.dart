import 'package:universal_html/html.dart' as html;

import '../src/prelude.dart';
import 'bootstrap_core.dart';

/// The html attributes for [offcanvas].
///
/// https://getbootstrap.com/docs/5.2/components/offcanvas/
ElementAttributes offcanvasAttributes({
  required Placement placement,
  String? className,
  String? id,
  String? labelledBy,
  bool scroll = false,
  bool backdrop = true,
  bool keyboard = true,
}) =>
    {
      'class': '${className ?? ''} offcanvas offcanvas-${placement.name}',
      'data-bs-scroll': scroll.toString(),
      'data-bs-backdrop': '$backdrop',
      'data-bs-keyboard': keyboard.toString(),
      'tabindex': "-1",
      if (labelledBy != null) 'aria-labelledby': labelledBy,
      if (id != null) 'id': id,
    };

/// A modal-like section or sheet that is shown from a side of the
/// page. The `placement` parameter in [offcanvasAttributes] specifies the side.
/// Use [offcanvasAttributes] to populate [attributes].
///
/// https://getbootstrap.com/docs/5.2/components/offcanvas/
DeactNode offcanvas({
  Object? key,
  required ElementAttributes attributes,
  required Iterable<DeactNode> title,
  required Iterable<DeactNode> body,
  String? labelId,
  bool showCloseButton = true,
  Ref<Offcanvas?>? offcanvasRef,
}) {
  return fc((ctx) {
    final ref = ctx.hookRef<html.Element?>(() => null);
    ctx.hookEffect(() {
      final _offcanvas = Offcanvas(ref.value!);
      if (offcanvasRef != null) offcanvasRef.value = _offcanvas;
    });

    return el(
      'div',
      ref: ref,
      key: key,
      attributes: attributes,
      children: [
        div(
          className: 'offcanvas-header',
          children: [
            el(
              'h5',
              attributes: {
                'class': 'offcanvas-title',
                if (labelId != null) 'id': labelId,
              },
              children: title,
            ),
            if (showCloseButton)
              closeButton(attributes: {'data-bs-dismiss': 'offcanvas'}),
          ],
        ),
        div(
          className: 'offcanvas-body',
          children: body,
        ),
      ],
    );
  });
}
