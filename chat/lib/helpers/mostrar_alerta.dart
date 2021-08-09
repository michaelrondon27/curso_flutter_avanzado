import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mostrarAlerta( BuildContext context, String subtitle, String title ) {
  if ( Platform.isAndroid ) {
    return showDialog(
      builder: (_) => AlertDialog(
        actions: [
          MaterialButton(
            child: Text('Ok'),
            elevation: 5,
            onPressed: () => Navigator.pop(context),
            textColor: Colors.blue
          )
        ],
        content: Text( subtitle ),
        title: Text( title )
      ),
      context: context
    );
  }

  showCupertinoDialog(
    builder: (_) => CupertinoAlertDialog(
      actions: [
        CupertinoDialogAction(
          child: Text('Ok'),
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context),
        )
      ],
      content: Text( subtitle ),
      title: Text( title )
    ),
    context: context,
  );
}
