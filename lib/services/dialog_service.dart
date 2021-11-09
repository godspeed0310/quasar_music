import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quasar_music/models/dialog_model.dart';

class DialogService {
  final GlobalKey<NavigatorState> _dialogNavigationKey =
      GlobalKey<NavigatorState>();
  late Function(DialogRequest) _showDialogListener;
  late var _dialogCompleter;

  GlobalKey<NavigatorState> get dialogNavigationKey => _dialogNavigationKey;

  void registerDialogListener(Function(DialogRequest) showDialogListener) {
    _showDialogListener = showDialogListener;
  }

  Future<DialogResponse> showDialog({
    required String title,
    required String description,
    String buttonTitle = 'Ok',
  }) {
    _dialogCompleter = Completer<DialogResponse>();
    _showDialogListener(
      DialogRequest(
        buttonTitle: buttonTitle,
        cancelTitle: '',
        description: description,
        title: title,
      ),
    );
    return _dialogCompleter.future;
  }

  Future<DialogResponse> showConfirmationDialog(
      {required String title,
      required String description,
      String confirmationTitle = 'Ok',
      String cancelTitle = 'Cancel'}) {
    _dialogCompleter = Completer<DialogResponse>();
    _showDialogListener(DialogRequest(
      title: title,
      description: description,
      buttonTitle: confirmationTitle,
      cancelTitle: cancelTitle,
    ));
    return _dialogCompleter.future;
  }

  void dialogComplete(DialogResponse response) {
    _dialogNavigationKey.currentState?.pop();
    _dialogCompleter.complete(response);
    _dialogCompleter = null;
  }
}
