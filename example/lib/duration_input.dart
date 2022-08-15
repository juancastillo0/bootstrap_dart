import 'package:bootstrap_dart/bootstrap/bootstrap_core.dart';
import 'package:bootstrap_dart/bootstrap/form.dart';
import 'package:deact_bootstrap/hooks.dart';
import 'package:bootstrap_dart_example/text_input.dart';
import 'package:deact/deact.dart';
import 'package:deact/deact_html52.dart';
import 'package:universal_html/html.dart' as html;

enum DurationRangeType {
  minutes,
  hours,
  days,
}

const maxMillisRange = {
  DurationRangeType.days: 1000 * 60 * 60 * 24 * 45,
  DurationRangeType.hours: 1000 * 60 * 60 * 24 * 2,
  DurationRangeType.minutes: 1000 * 60 * 60 * 2,
};

String durationString(Duration duration) {
  final mins = duration.inMinutes;
  final String str;
  if (mins > Duration.minutesPerDay * 30) {
    final months = (mins / (Duration.minutesPerDay * 30)).floor();
    final days = ((mins - (months * Duration.minutesPerDay * 30)) /
            Duration.minutesPerDay)
        .round();
    str = '${months}M ${days}d';
  } else if (mins > Duration.minutesPerDay) {
    final days = (mins / Duration.minutesPerDay).floor();
    final hours =
        ((mins - (days * Duration.minutesPerDay)) / Duration.minutesPerHour)
            .round();
    str = '${days}d ${hours}h';
  } else {
    final hours = (mins / Duration.minutesPerHour).floor();
    final _mins = (mins - (hours * Duration.minutesPerHour)).round();
    str = '${hours}h ${_mins}m';
  }
  return str;
}

Duration? parseDuration(String input) {
  final regexp = RegExp(
    r'(?<all>(?<num>0|[1-9]\d*|\.\d+|^0\.\d*|[1-9]\d*\.\d*) ?(?<dur>[smhdMy]))+',
  );
  final m = regexp
      .allMatches(input)
      .map(
        (e) => Map.fromEntries(
          e.groupNames.map((n) => MapEntry(n, e.namedGroup(n))),
        ),
      )
      .toList();
  if (m.isEmpty ||
      m.any((g) => g.values.any((v) => v == null)) ||
      input.trim().replaceAll(RegExp(r'\s+'), ' ') !=
          m.map((e) => e['all']).join(' ')) {
    return null;
  }
  return m.map((e) {
    final val = double.parse(e['num']!);
    const _m = {
      's': 1000,
      'm': 60 * 1000,
      'h': 60 * 60 * 1000,
      'd': 24 * 60 * 60 * 1000,
      'M': 30.4167 * 24 * 60 * 60 * 1000,
      'y': 365 * 24 * 60 * 60 * 1000,
    };
    return Duration(
      milliseconds: (_m[e['dur']]! * val).round(),
    );
  }).reduce((value, element) => value + element);
}

class DurationInput extends ComponentNode {
  const DurationInput({
    Object? key,
    required this.duration,
    required this.onChanged,
    this.onCancel,
  }) : super(key: key);

  final Duration duration;
  final void Function(Duration p1) onChanged;
  final void Function()? onCancel;

  @override
  DeactNode render(ComponentContext ctx) {
    final durationState = ctx.hookState(() => duration);
    final onChangedText = useCallback(ctx, (Duration? p0) {
      if (p0 != null) durationState.value = p0;
    }, const []);

    final durationInput = useTextInput<Duration>(
      ctx,
      durationState.value,
      onChangedText,
      const StringInputSerializer<Duration>(
        parseDuration,
        durationString,
      ),
    );

    final rangeType = ctx.hookState(() => DurationRangeType.hours);
    final maxMillis = maxMillisRange[rangeType.value]!;

    return div(
      style: 'width:210px;',
      children: [
        div(
          style: colStyle(),
          children: [
            div(
              style: flexStyle(main: AxisAlign.space_between, expand: true),
              children: [
                label(
                  forId: 'duration-input',
                  children: [txt('Duration')],
                ),
                input(
                  style: 'width:120px;',
                  type: 'text',
                  id: 'duration-input',
                  ref: durationInput.ref,
                  oninput: durationInput.onInput,
                  className: formControlClass(),
                  // controller: durationInput.controller,
                  // onChanged: durationInput.onChangedString,
                  // decoration: InputDecoration(
                  //   errorText: durationInput.error,
                  //   errorStyle: const TextStyle(height: 0),
                  // ),
                ),
              ],
            ),
            buttonGroup<DurationRangeType>(
              buttonClass: btn(outlined: true) + ' my-1',
              renderItem: (str) => [txt(str.name)],
              selection: UserSelection.single(rangeType.value, (selected) {
                rangeType.value = selected;
              }),
              values: DurationRangeType.values,
            ),
            div(
              style: flexStyle(main: AxisAlign.space_between, expand: true),
              children: [
                span(
                  // className: Theme.of(context).textTheme.subtitle2,
                  children: [txt('Range:')],
                ),
                span(
                  // className: Theme.of(context).textTheme.caption,
                  children: [
                    txt('''max: ${durationString(Duration(milliseconds: maxMillis))}''')
                  ],
                ),
              ],
            ),
            input(
              type: 'range',
              value: (durationState.value.inMilliseconds.toDouble() /
                      maxMillis.toDouble())
                  .clamp(0, 1)
                  .toString(),
              min: '0',
              max: '1',
              step: '${1 / 60}',
              className: formRangeClass,
              oninput: (e) {
                final percent =
                    double.parse((e.target as html.InputElement).value!);
                durationState.value = Duration(
                  milliseconds: (percent * maxMillis).round(),
                );
              },
            ),
            // span(
            //   className: 'p-1',
            //   // style: Theme.of(context).textTheme.headline6,
            //   children: [
            //     txt(durationString(durationState.value)),
            //   ],
            // ),
            // div(
            //   style: flexStyle(main: AxisAlign.space_between),
            //   children: [
            //     // if (onCancel != null)
            //     //   OutlinedButton(
            //     //     onPressed: () {
            //     //       onCancel!();
            //     //     },
            //     //     child: const Text('Cancel'),
            //     //   ),
            //     button(
            //       className: btn(),
            //       type: 'button',
            //       onclick: (_) {
            //         onChanged(durationState.value);
            //       },
            //       children: [txt('Accept')],
            //     ),
            //   ],
            // ),
          ],
        ),
      ],
    );
  }
}
