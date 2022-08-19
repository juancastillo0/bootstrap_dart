# Bootstrap Dart

[Bootstrap](https://getbootstrap.com/) web components in Dart. For more information on the different components, check out Bootstrap's [documentation](https://getbootstrap.com/docs/5.1/getting-started/introduction/).

You can view all the implemented components (and the Dart code) in the deployed page (https://juancastillo0.github.io/bootstrap_dart/). The code for the deployed page is in the [`web/bootstrap_examples.dart` file](web/bootstrap_examples.dart).

## Versions

We currently support the following versions:

- Bootstrap 5.1.3 https://getbootstrap.com/docs/5.1/
- Bootstrap Icons 1.9.1 https://icons.getbootstrap.com/
- Bootstrap Dark 1.1.3 https://vinorodrigues.github.io/bootstrap-dark-5/

## Table of Contents

- [Bootstrap Dart](#bootstrap-dart)
  - [Versions](#versions)
  - [Table of Contents](#table-of-contents)
- [Usage](#usage)
    - [Custom scss and Dark Mode](#custom-scss-and-dark-mode)
- [Examples](#examples)
  - [Components Gallery](#components-gallery)
  - [Cacho Game](#cacho-game)
  - [CIDart](#cidart)
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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
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

### Custom scss and Dark Mode

We provide the Bootstrap scss along with the [Bootstrap Dark](https://github.com/vinorodrigues/bootstrap-dark-5) dark mode scss. With them, and using [`package:sass_builder`](https://pub.dev/packages/sass_builder) to compile scss files, you can customize Bootstrap and only import the components you need.

Add sass_builder to your dependencies

```yaml
dev_dependencies:
  sass_builder: ^2.1.2
```

Create an scss file (`web/bootstrap.scss`) that customizes variables and imports the Bootstrap scss

```scss
// Include any default variable overrides here (though functions won't be available)

$primary: #01388a; // was #0d6efd;

// Import the bootstrap nightshade scss.
// This includes the default Bootstrap and dark scss
// https://github.com/vinorodrigues/bootstrap-dark-5/blob/main/docs/bootstrap-nightshade.md
@import "package:bootstrap_dart/scss/bootstrap-nightshade";

// You can import the `bootstrap-icons.scss` in here also
@import "package:bootstrap_dart/icons/bootstrap-icons";

// Then add additional custom code here

:root {
  // shade-color function is from bootstrap.
  // Use in css with `background-color:var(--light-darker);`
  --light-darker: #{shade-color($light, 5%)}; 
  --dark-darker: #{shade-color($dark, 10%)};
}
```

Edit your html file to import the compiled css and the `darkmode.js` file:

```html
<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="scaffolded-by" content="https://github.com/dart-lang/sdk">
    <title>App Title</title>

    <!-- The page supports both dark and light color schemes,
    and the page author prefers / default is light. -->
    <meta name="color-scheme" content="light dark">

    <!-- Custom Bootstrap CSS created by package:sass_builder -->
    <link rel="stylesheet" href="bootstrap.css">
    <!-- Main App -->
    <script defer src="main.dart.js"></script>
</head>

<body>
  <!-- Main element, Dart will edit this -->
  <div id="output"></div>
  
  <!-- Some Bootstrap components require JS: Popper.js and Bootstrap JS -->
  <script src="./packages/bootstrap_dart/js/bootstrap.bundle.min.js"></script>
  <!-- Supports dark mode toggle https://github.com/vinorodrigues/bootstrap-dark-5/blob/main/docs/darkmode.js.md -->
  <script src="./packages/bootstrap_dart/dark_mode/darkmode.min.js"></script>
</body>
</html>
```

Because we imported the `bootstrap-icons.scss` in the `web/bootstrap.scss` file, the previous html already supports Bootstrap icons. However, you may also import the css directly:

```html
<link rel="stylesheet" href="./packages/bootstrap_dart/icons/bootstrap-icons.css">
```

Since the `web/bootstrap.scss` is importing `bootstrap-nightshade`, you can use the `html.dark` css class selector to change the styles of different elements when the dark mode is selected (CSS class `dark` over the `html` element):

```css
html.dark .code-section {
  background-color: var(--bs-dark-alt);
}
```

To toggle dark mode you may use the API in `package:bootstrap_dart/dark_mode/dark_mode.dart`. Which uses the underling [darkmode.js](https://github.com/vinorodrigues/bootstrap-dark-5/blob/main/docs/darkmode.js.md) file.

```dart
import 'package:bootstrap_dart/dark_mode/dark_mode.dart' show DarkMode;

final darkMode = DarkMode();

DeactNode darkModeSwitch() {
  return check(
    label: txt('Dark Mode'),
    id: 'darkModeSwitch',
    type: CheckType.switch_,
    checked: darkMode.inDarkMode,
    inline: true,
    onChange: (_) {
      darkMode.toggleDarkMode();
    },
  );
}
```

You may use the `DarkMode.inDarkModeChanges` Stream to subscribe to changes or the `inDarkModeValue` constructor parameter to use a `package:mobx` observable in the `DarkMode.inDarkMode` getter.

# Examples

## Components Gallery

You can view all the implemented components (and the Dart code) in the deployed page (https://juancastillo0.github.io/bootstrap_dart/). The code for the deployed page is in the [`web/bootstrap_examples.dart` file](web/bootstrap_examples.dart).

## Cacho Game

Work in progress.

A multiplayer board game. The code for complete example is in the [`example/` directory](example/).

## CIDart

Work in progress.

A service for compiling, executing and tracking the build process and deployment. With a git repository, one can set up a CLI pipeline for continuous integration and delivery. All the commands are tracked in realtime. This is a simple personal project for deploying in a VM. The service uses web sockets and the source code repository has three projects:

1. A [Leto](https://github.com/juancastillo0/leto) Shelf GraphQL server. Everything is saved in memory
2. A Dart client using [`package:graphql`](https://pub.dev/packages/graphql) and [`package:graphql_codegen`](https://pub.dev/packages/graphql_codegen)
3. A Web Dart client using [`package:jaspr`](https://github.com/schultek/jaspr) and [jaspr_bootstrap](#jaspr_bootstrap-for-packagejaspr).

You can view the code in the [Github repo](https://github.com/juancastillo0/cidart). The client UI and some links to the different GraphQL Schema UI explorer is deployed in [this page](https://juancastillo0.github.io/cidart/).

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
/// A renderer used within the Bootstrap components to create html elements.
///
/// A "node" is in reference to a Node, Widget or Component in each of the frameworks.
class BootstrapRenderer<N> {
  /// Returns a node that renders an html element of the given [tag].
  /// The [attributes], [listeners] and [children] should be set for the html element.
  /// The [ref] should be populated when an effect using [BootstrapBuildContext.hookEffect] is run.
  N el(
    String tag, {
    Map<String, String>? attributes,
    Iterable<dynamic>? children,
    Object? key,
    Map<String, void Function(html.Event)>? listeners,
    Ref<html.Element?>? ref,
  }) =>
      throw _error;

  /// Returns a node that renders an html text node.
  N txt(String text) => throw _error;

  /// Returns a node that renders multiple [children] nodes.
  N fragment(List<dynamic> children) => throw _error;

  /// Returns a node that support hooks with the API in [BootstrapBuildContext].
  N fc(dynamic Function(BootstrapBuildContext) builder, {Object? key}) =>
      throw _error;
}

abstract class BootstrapBuildContext {
  /// A reference to a mutable value of type [T] associated with this context.
  /// [create] will be called only once for setting up the initial value.
  Ref<T> hookRef<T>(T Function() create);

  /// The [effect] should be called when the html elements are rendered.
  /// If any of the [keys] change, [effect] should be re-executed.
  /// If [effect] returns a function, it should be called to release resources
  /// from the executed [effect] when the keys change or the component is unmounted.
  void hookEffect(
    void Function()? Function() effect, [
    List<Object?>? keys,
    bool Function(Object?, Object?)? equals,
  ]);

  /// A reference to a mutable value of type [T] associated with this context.
  /// If changed, this should rerender the component associated with this context.
  /// [create] will be called only once for setting up the initial value.
  State<T> hookState<T>(T Function() create);
}

/// The renderer used within the Bootstrap components to create html elements.
///
/// You should set the `bootstrapRenderer` for Bootstrap Dart to render the components.
/// You can use one of the provided packages:
/// - jaspr_bootstrap
/// - rad_bootstrap
/// - deact_bootstrap
BootstrapRenderer bootstrapRenderer = BootstrapRenderer();

/// A reference to a mutable [value] of type [T].
abstract class Ref<T> {
  Ref(this.value);
  T value;
}

/// A reference to a mutable [value] of type [T].
/// If changed, this should rerender the component in which this was created.
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