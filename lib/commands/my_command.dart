import 'dart:io';

import 'package:process_run/cmd_run.dart';
import 'package:process_run/shell_run.dart';

class MyCommand {
  static Shell? shell;

  static run({
    required String executable,
    required String arguments,
    Function(int)? onExitProcess,
  }) async {
    final runInShell = Platform.isWindows;

    List<String> listArg = [];
    if (arguments.isNotEmpty) {
      listArg = arguments.split(" ");
    }

    // Run the command
    var cmd = ProcessCmd(executable, listArg, runInShell: runInShell);
    await runCmd(cmd);
  }
}
