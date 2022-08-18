import '../src/prelude.dart';
import 'bootstrap_core.dart';

class AccordionItem {
  final Iterable<DeactNode> header;
  final Iterable<DeactNode> body;

  AccordionItem({
    required this.header,
    required this.body,
  });
}

/// A group of collapsible components.
/// Returns the component with the list of [items].
///
/// https://getbootstrap.com/docs/5.2/components/accordion/
DeactNode accordion({
  required String id,
  required Map<String, AccordionItem> items,
  bool multipleOpened = false,
  bool flush = false,
}) {
  return el(
    'div',
    attributes: {
      'class': 'accordion${flush ? ' accordion-flush' : ''}',
      'id': id,
    },
    children: [
      ...items.entries.map(
        (_e) {
          final itemId = _e.key;
          final item = _e.value;
          final headerId = '$itemId-header';

          return el(
            'div',
            attributes: {'class': 'accordion-item'},
            children: [
              el(
                'h2',
                attributes: {'class': 'accordion-header', 'id': headerId},
                children: [
                  el(
                    'button',
                    attributes: {
                      ...toggleButtonAttributes(
                        component: TogglableComponent.collapse,
                        targetId: itemId,
                      ),
                      'class': 'accordion-button collapsed',
                      'aria-expanded': 'false',
                    },
                    children: item.header,
                  )
                ],
              ),
              el(
                'div',
                attributes: {
                  'id': itemId,
                  'class': 'accordion-collapse collapse',
                  'aria-labelledby': headerId,
                  if (!multipleOpened) 'data-bs-parent': '#$id'
                },
                children: [
                  el(
                    'div',
                    attributes: {'class': 'accordion-body'},
                    children: item.body,
                  ),
                ],
              )
            ],
          );
        },
      )
    ],
  );
}
