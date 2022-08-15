import 'dart:async';

import 'package:deact_bootstrap/hooks.dart';
import 'package:deact/deact.dart';
import 'package:universal_html/html.dart' as html;

final doubleStringInput = StringInputSerializer<double>(
  double.tryParse,
  (v) {
    final str = v.toString();
    return str.endsWith('.0') ? str.substring(0, str.length - 2) : str;
  },
);

String objectToString(Object v) => v.toString();

const intStringInput = StringInputSerializer<int>(
  int.tryParse,
  objectToString,
);

class StringInputSerializer<T> {
  final T? Function(String) fromString;
  final String Function(T) asString;
  final String? Function(String, T?)? validate;

  static String? defaultValidate(String s, Object? v) => v == null ? '' : null;

  const StringInputSerializer(
    this.fromString,
    this.asString, {
    this.validate = defaultValidate,
  });
}

TextInputParams useTextInput<T>(
  ComponentContext ctx,
  T? value,
  void Function(T?) onChanged,
  StringInputSerializer<T> serializer,
) {
  final ref = ctx.hookRef<html.Element?>(() => null);
  final controller = useMemo(ctx, () => TextController(ref, ''));
  // final focusNode = useFocusNode();

  final error = ctx.hookState<String?>(() => null);
  final wasTouched = ctx.hookRef(() => false);
  final wasFocused = ctx.hookState(() => false);
  final wasEdited = ctx.hookState(() => false);

  // ctx.hookEffect(() {
  if (value == null) {
    controller.text = '';
  } else if (serializer.fromString(controller.text) != value) {
    error.value = null;
    controller.text = serializer.asString(value);
  }
  // }, [serializer, value]);

  final onChangedString = useCallback(ctx, (String newString) {
    wasEdited.value = true;
    final newValue = serializer.fromString(newString);
    final newError = serializer.validate?.call(newString, newValue);

    if (newValue != null && newError == null) {
      if (value != newValue) {
        onChanged(newValue);
      }
      error.value = null;
    } else if (newString.isEmpty) {
      if (value != newValue) {
        onChanged(null);
      }
    } else {
      error.value = newError ?? '';
    }
  }, [serializer, value, onChanged]);

  // TODO:
  // ctx.hookEffect(() {
  //   if (!wasFocused.value) {
  //     void _c() {
  //       if (focusNode.hasPrimaryFocus) {
  //         wasFocused.value = true;
  //       }
  //     }

  //     focusNode.addListener(_c);
  //     return () {
  //       focusNode.removeListener(_c);
  //     };
  //   }
  // }, [wasFocused.value]);

  useValueChanged<bool, void>(ctx, controller.hasPrimaryFocus, (prev, _) {
    if (prev && !controller.hasPrimaryFocus) {
      wasTouched.value = true;
    }
  });

  return TextInputParams(
    controller: controller,
    // focusNode: focusNode,
    error: error.value,
    wasTouched: wasTouched.value,
    wasFocused: wasFocused.value,
    wasEdited: wasEdited.value,
    onChangedString: onChangedString,
  );
}

class TextController {
  final Ref<html.Element?> ref;

  String _text;
  String get text => _text;
  set text(String newText) {
    _text = newText;
    final _el = elem();
    if (_el != null) {
      _el.value = newText;
    }
  }

  bool _wasFocused = false;
  bool get wasFocused => _wasFocused;

  html.InputElement? elem() => ref.value as html.InputElement?;

  late final StreamSubscription _subs;
  StreamSubscription? _subsFocus;
  html.Element? __elem;

  TextController(this.ref, this._text) {
    _subs = ref.onChange.listen((event) {
      if (__elem != event) {
        __elem = event;
        _subsFocus?.cancel();
        _subsFocus = event?.onFocus.listen((event) {
          _wasFocused = true;
        });
        if (event != null) {
          (event as html.InputElement).value = text;
        }
      }
    });
  }

  bool get hasPrimaryFocus =>
      ref.value != null && html.document.activeElement == elem();

  void dispose() {
    _subs.cancel();
    _subsFocus?.cancel();
  }
}

class TextInputParams {
  final TextController controller;
  // final FocusNode focusNode;
  final String? error;
  final bool wasTouched;
  final bool wasFocused;
  final bool wasEdited;
  final void Function(String) onChangedString;
  void onInput(html.Event _) {
    final str = controller.elem()!.value!;
    controller._text = str;
    onChangedString(str);
  }

  Ref<html.Element?> get ref => controller.ref;

  const TextInputParams({
    required this.controller,
    // required this.focusNode,
    required this.error,
    required this.wasTouched,
    required this.wasFocused,
    required this.wasEdited,
    required this.onChangedString,
  });

  String? get errorIfTouched => wasTouched ? error : null;
  String? get errorIfTouchedNotEmpty =>
      wasTouched && controller.text.isNotEmpty ? error : null;

  String? errorIf({
    bool touched = false,
    bool edited = false,
    bool focused = false,
    bool notEmpty = false,
  }) {
    assert(touched || edited || focused || notEmpty);

    final params = [touched, edited, focused, notEmpty];
    final info = [
      wasTouched,
      wasEdited,
      wasFocused,
      controller.text.isNotEmpty
    ];
    for (final i in Iterable<int>.generate(4)) {
      if (params[i] && !info[i]) {
        return null;
      }
    }

    return error;
  }

  String? errorIfOpts(ShowErrorOpts opts) {
    return errorIf(
      edited: opts.edited ?? false,
      focused: opts.focused ?? false,
      notEmpty: opts.notEmpty ?? false,
      touched: opts.touched ?? false,
    );
  }
}

class ShowErrorOpts {
  final bool? touched;
  final bool? edited;
  final bool? focused;
  final bool? notEmpty;

  const ShowErrorOpts({
    this.touched,
    this.edited,
    this.focused,
    this.notEmpty,
  });

  ShowErrorOpts copyWith({
    bool? touched,
    bool? edited,
    bool? focused,
    bool? notEmpty,
  }) {
    return ShowErrorOpts(
      touched: touched ?? this.touched,
      edited: edited ?? this.edited,
      focused: focused ?? this.focused,
      notEmpty: notEmpty ?? this.notEmpty,
    );
  }
}
