import 'package:deact/deact.dart';
import 'package:mobx/mobx.dart';
// ignore: implementation_imports
import 'package:mobx/src/core.dart' show ReactionImpl;

DeactNode mobxWrapper(
  ComponentContext ctx,
  DeactNode Function(ComponentContext) next,
) {
  final rxtRef = ctx.hookRef<ReactionImpl>(
    () => ReactionImpl(
      mainContext,
      () {
        print('${ctx.hashCode} rerender');
        ctx.scheduleRerender();
      },
      name: ctx.hashCode.toString(),
      onError: (err, stackTrace) => print('$err $stackTrace'),
    ),
  );
  ctx.hookEffect(
    () => rxtRef.value.dispose,
    const [],
  );

  late final DeactNode node;
  rxtRef.value.track(() {
    print('${ctx.hashCode} start-track');
    try {
      node = next(ctx);
    } catch (e, s) {
      print('mobx.track error $e $s');
    }
    print('${ctx.hashCode} end-track');
  });
  return node;
}
