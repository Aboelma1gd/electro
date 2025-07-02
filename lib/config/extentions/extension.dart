import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';

emptyFieldsWarning(context) {
  return FToast.toast(
    context,
    msg: 'Oops',
    subMsg: "You must fill all Fields!",
    corner: 20.0,
    duration: 2000,
    padding: const EdgeInsets.all(20),
  );
}

/// Nothing Enter When user try to edit the current task
errormessage(context, error) {
  return FToast.toast(
    context,
    msg: 'Oops',
    subMsg: error,
    corner: 20.0,
    duration: 3000,
    padding: const EdgeInsets.all(20),
  );
}

successmessage(context, msg) {
  return FToast.toast(
    context,
    msg: 'Success',
    subMsg: msg,
    corner: 20.0,
    duration: 3000,
    padding: const EdgeInsets.all(20),
  );
}