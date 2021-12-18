import 'bootstrap_core.dart';

/// https://getbootstrap.com/docs/5.0/content/typography/
class BTypography {
  static const h1 = 'h1';
  static const h2 = 'h2';
  static const h3 = 'h3';
  static const h4 = 'h4';
  static const h5 = 'h5';
  static const h6 = 'h6';

  static const textMuted = 'text-muted';

  static const display1 = 'display-1';
  static const display2 = 'display-2';
  static const display3 = 'display-3';
  static const display4 = 'display-4';
  static const display5 = 'display-5';
  static const display6 = 'display-6';

  static const lead = 'lead';

  static const mark = 'mark';
  static const del = 'del';
  static const s = 'text-decoration-line-through';
  static const ins = 'ins';
  static const u = 'text-decoration-underline';
  static const small = 'small';
  static const strong = 'strong';
  static const em = 'em';

  static const attribute = 'attribute';
  static const initialism = 'initialism';

  static const blockquote = 'blockquote';
  static const blockquoteFooter = 'blockquote-footer';
}

/// https://getbootstrap.com/docs/5.1/utilities/text/
class BText {
  static const start = 'text-start';
  static const center = 'text-center';
  static const end = 'text-end';

  static String startR(ResponsiveBreakPoint b) =>
      b == ResponsiveBreakPoint.always ? 'text-start' : 'text-${b.name}-start';
  static String centerR(ResponsiveBreakPoint b) =>
      b == ResponsiveBreakPoint.always
          ? 'text-center'
          : 'text-${b.name}-center';
  static String endR(ResponsiveBreakPoint b) =>
      b == ResponsiveBreakPoint.always ? 'text-end' : 'text-${b.name}-end';

  static const wrap = 'text-wrap';
  static const noWrap = 'text-nowrap';
  static const break_ = 'text-break';

  static const upper = 'text-lowercase';
  static const lower = 'text-uppercase';
  static const capitalize = 'text-capitalize';

  static const fs1 = 'fs1';
  static const fs2 = 'fs2';
  static const fs3 = 'fs3';
  static const fs4 = 'fs4';
  static const fs5 = 'fs5';
  static const fs6 = 'fs6';

  static const fwNormal = 'fw-normal';
  static const fwBold = 'fw-bold';
  static const fwNBolder = 'fw-bolder';
  static const fwLight = 'fw-light';
  static const fwLighter = 'fw-lighter';

  static const lh1 = 'lh-1';
  static const lhSm = 'lh-sm';
  static const lgBase = 'lh-base';
  static const lhLg = 'lh-lg';

  static const muted = 'text-muted';
  static const reset = 'text-reset';
  static const white = 'text-white';
  static const white50 = 'text-white-50';
  static const black50 = 'text-black-50';
  static const body = 'text-body';

  static const opacity25 = 'text-opacity-25';
  static const opacity50 = 'text-opacity-50';
  static const opacity75 = 'text-opacity-75';

  static const monospace = 'font-monospace';

  static const userSelectAll = 'user-select-all';
  static const userSelectAuto = 'user-select-auto';
  static const userSelectNone = 'user-select-none';
}
