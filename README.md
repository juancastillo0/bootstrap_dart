# Bootstrap Dart

[Bootstrap](https://getbootstrap.com/) web components in Dart. For more information on the different components provided by Bootstrap, please view the [documentation](https://getbootstrap.com/docs/5.1/getting-started/introduction/).

You can view all the implemented components (and the Dart code) in the deployed page (https://juancastillo0.github.io/bootstrap_dart/). The source code for the deployed page is in the [`web/bootstrap_examples.dart` file](web/bootstrap_examples.dart).


- [Bootstrap Dart](#bootstrap-dart)
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

```yaml
dependencies:
  universal_html: ^2.0.8
  bootstrap_dart:
    git:
      url: https://github.com/juancastillo0/bootstrap_dart.git
  deact:
    git:
      url: https://github.com/juancastillo0/deact.git
      ref: 537a9e600641a0aed15b7811c61f80fe4c0c0d12
  deact_bootstrap:
    git:
      url: https://github.com/juancastillo0/bootstrap_dart.git
      path: packages/deact_bootstrap

dev_dependencies:
  build_runner: ^1.10.0
  build_test: ^1.0.0
  test: ^1.0.0
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

## Cacho Game


# Packages

This repository contains multiple Dart packages.

## bootstrap_dart

Main package with all Bootstrap components. Independent of the rendering framework.

## Supported Frameworks

The main does not have a rendering framework, for that you need to provide a [Bootstrap Renderer](#bootstrap-renderer). We implement the bindings for rendering the components for multiple frameworks in the following package:

### deact_bootstrap for [package:deact](https://github.com/juancastillo0/deact)

### jaspr_bootstrap for [package:jaspr](https://github.com/schultek/jaspr)

You need to use the `MobXHooksObserverComponent` at the root of the Component tree.

### rad_bootstrap for [package:rad](https://github.com/erlage/rad)

# Bootstrap Renderer

To support multiple rendering frameworks an user has to override the `BootstrapRenderer bootstrapRenderer` found in [`lib/bootstrap/bootstrap_renderer.dart`](lib/bootstrap/bootstrap_renderer.dart). 

We provide bindings for the [supported frameworks](#supported-frameworks).

An usage example for the `package:rad` framework would be the following:

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
webdev serve web:8050 --auto refresh
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