import 'bootstrap_core.dart';

/// Returns the css class with the styles for the Table component.
///
/// https://getbootstrap.com/docs/5.2/content/tables/
String tableClass({
  BColor? color,
  bool striped = false,
  bool hover = false,
  bool active = false,
  bool bordered = false,
  bool borderless = false,
  bool small = false,
  VerticalAlign? align,
  bool captionTop = false,
  ResponsiveBreakPoint? scrollHorizontal,
}) {
  return [
    'table',
    if (color != null) 'table-${color.name}',
    if (striped) 'table-striped',
    if (hover) 'table-hover',
    if (active) 'table-active',
    if (bordered) 'table-bordered',
    if (borderless) 'table-borderless',
    if (small) 'table-sm',
    if (align != null) align.nameHtml,
    if (captionTop) 'caption-top',
    if (scrollHorizontal != null)
      'table-responsive${scrollHorizontal == ResponsiveBreakPoint.always ? '' : '-${scrollHorizontal.name}'}'
  ].join(' ');
}
