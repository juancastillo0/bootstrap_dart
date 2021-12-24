import 'package:nanoid/nanoid.dart' show customAlphabet;

const _urlAlphabet =
    'ModuleSymbhasOwnPr0123456789ABCDEFGHNRVfgctiUvzKqYTJkLxpZXIjQW';

String customId() => customAlphabet(_urlAlphabet, 22);
