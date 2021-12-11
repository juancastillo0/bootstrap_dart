import 'package:deact/deact.dart';
import 'package:mobx/mobx.dart';
// ignore: implementation_imports
import 'package:mobx/src/core.dart' show ReactionImpl;

DeactNode mobxWrapper(
  ComponentContext ctx,
  DeactNode Function(ComponentContext) next,
) {
  final rxtRef = ctx.refProvided<ReactionImpl>(
    'mobxReaction',
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
  ctx.effect(
    'mobx',
    () => rxtRef.value.dispose,
    dependsOn: const [],
  );

  late final DeactNode node;
  rxtRef.value.track(() {
    print('${ctx.hashCode} start-track');
    node = next(ctx);
    print('${ctx.hashCode} end-track');
  });
  return node;
}
