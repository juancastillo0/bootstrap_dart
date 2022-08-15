# Bootstrap Dart <!-- omit in toc -->

[Bootstrap](https://getbootstrap.com/) web components in Dart. For more information on the different components, check out Bootstrap's [documentation](https://getbootstrap.com/docs/5.1/getting-started/introduction/).

You can view all the implemented components (and the Dart code) in the deployed page (https://juancastillo0.github.io/bootstrap_dart/). The code for the deployed page is in the [`web/bootstrap_examples.dart` file](web/bootstrap_examples.dart).


- [Usage](#usage)
- [Examples](#examples)
  - [Components Gallery](#components-gallery)
  - [Cacho Game](#cacho-game)
- [Packages](#packages)
  - [bootstrap_dart](#bootstrap_dart)
  - [Supported Frameworks](#supported-frameworks)
    - [deact_bootstrap for package:deact](#deact_bootstrap-for-packagedeact)
    - [jaspr_bootstrap for package:jaspr](#jaspr_bootstrap-for-packagejaspr)
    - [rad_bootstrap for package:rad](#rad_bootstrap-for-packagerad)
- [Bootstrap Renderer](#bootstrap-renderer)
- [Commands](#commands)


# Usage

Add the dependencies to your `pubspec.yaml`

Since the package is agnostic to the rendering package, can chose any of the [supported frameworks](#supported-frameworks): `deact_bootstrap`, `jaspr_bootstrap` or `rad_bootstrap`.

```yaml
dependencies:
  bootstrap_dart: # main bootstrap package
    git:
      url: https://github.com/juancastillo0/bootstrap_dart.git

  deact: # could also be jaspr or rad
    git:
      url: https://github.com/juancastillo0/deact.git
      ref: 537a9e600641a0aed15b7811c61f80fe4c0c0d12
  incremental_dom_bindings: ^2.1.0 # only required for deact
  deact_bootstrap: # could also be jaspr_bootstrap or rad_bootstrap
    git:
      url: https://github.com/juancastillo0/bootstrap_dart.git
      path: packages/deact_bootstrap
  
  universal_html: ^2.0.8 # optional

dev_dependencies:
  build_runner: ^1.10.0
  build_test: ^1.0.0 # for testing
  build_web_compilers: ^2.11.0
```

Set up your `web/index.html`

```html
<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="scaffolded-by" content="https://github.com/dart-lang/sdk">
    <title>App Title</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
    <!-- App CSS -->
    <link rel="stylesheet" href="styles.css">
    <!-- Main App -->
    <script defer src="main.dart.js"></script>

    <!-- Used by package:deact to edit the HTML elements -->
    <script src="./packages/incremental_dom_bindings/assets/incremental-dom-min.js"></script>
</head>

<body>
  <!-- Main element, Dart will edit this -->
  <div id="output"></div>
  
  <!-- Some Bootstrap components require JS: Popper.js and Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>
```

# Examples

## Components Gallery

You can view all the implemented components (and the Dart code) in the deployed page (https://juancastillo0.github.io/bootstrap_dart/). The code for the deployed page is in the [`web/bootstrap_examples.dart` file](web/bootstrap_examples.dart).

## Cacho Game

Work in progress.

A multiplayer board game. The code for complete example is in the [`example/` directory](example/).

# Packages

This repository contains multiple Dart packages. The main bootstrap package and the bindings
for external rendering frameworks.

## bootstrap_dart

Main package with all Bootstrap components. Independent of the rendering framework.

## Supported Frameworks

The main package does not have a rendering framework, for that you need to provide a [Bootstrap Renderer](#bootstrap-renderer). We implement the rendering bindings for multiple frameworks in the following packages:

### deact_bootstrap for [package:deact](https://github.com/juancastillo0/deact)

SPA framework inspired by React.

### jaspr_bootstrap for [package:jaspr](https://github.com/schultek/jaspr)

Support for SPA, SSR, Islands with good test coverage. Inspired by Flutter.

You need to use the `MobXHooksObserverComponent` at the root of the Component tree.
This component is exported in `jaspr_bootstrap`.

### rad_bootstrap for [package:rad](https://github.com/erlage/rad)

SPA framework with Hooks, great test coverage and performance. Inspired by Flutter and React.

# Bootstrap Renderer

To support multiple rendering frameworks a global `bootstrapRenderer` should be overridden. The code is found in [`lib/bootstrap/bootstrap_renderer.dart`](lib/bootstrap/bootstrap_renderer.dart).

At the moment, the framework should support the following interface.

- Hooks (useRef, useState and useEffect)
- Render HTML elements
- Render text nodes
- Render a node with multiple children (React's fragment)
- Create functional components with Hooks support

<!-- include{bootstrap-renderer-interface} -->
```dart
class BootstrapRenderer<N> {
  N el(
    String tag, {
    Map<String, Object?>? attributes,
    Iterable<dynamic>? children,
    Object? key,
    Map<String, void Function(html.Event)>? listeners,
    Ref<html.Element?>? ref,
  }) =>
      throw _error;

  N txt(String text) => throw _error;

  N fragment(List<dynamic> children) => throw _error;

  N fc(dynamic Function(BootstrapBuildContext) builder, {Object? key}) =>
      throw _error;
}

abstract class BootstrapBuildContext {
  Ref<T> hookRef<T>(T Function() create);

  void hookEffect(
    void Function()? Function() effect, [
    List<Object?>? keys,
    bool Function(Object?, Object?)? equals,
  ]);

  State<T> hookState<T>(T Function() create);
}

BootstrapRenderer bootstrapRenderer = BootstrapRenderer();

abstract class Ref<T> {
  Ref(this.value);
  T value;
}

typedef State<T> = Ref<T>;
```
<!-- include-end{bootstrap-renderer-interface} -->


We provide bindings as a `BootstrapRenderer` class implementation for the [supported frameworks](#supported-frameworks). An usage example for the `package:rad` framework would be the following:

```dart
import 'package:rad/rad.dart';
import 'package:bootstrap_dart/bootstrap/bootstrap_core.dart';
import 'package:rad_bootstrap/rad_bootstrap.dart';

void main() {
  /// Set the global `bootstrapRenderer`
  RadBootstrapRenderer.setUp();

  // TODO:
}
```

# Commands

Install the `webdev` CLI

```bash
dart pub global activate webdev
```

Serve the web page locally

```bash
webdev serve web:8050 --auto refresh -- --delete-conflicting-outputs
```

Run a test file

```bash
dart run build_runner test -- -p chrome test/mobx_test.dart
```

Run static site generation (creates the html files for each route):

```bash
dart run web/main.dart
```

Collect examples for github pages deployment:

```bash
dart run scripts/collect_examples.dart --generate-dart-file web/generated_example_snippets.dart
```

Collect Bootstrap icons

```bash
dart run scripts/fetch_bootstrap_icons.dart
```