import 'package:flutter/material.dart';

enum BoxStorage { inventory, resultinventory }

// get name off enum
extension BoxStorageExtension on BoxStorage {
  String get name {
    switch (this) {
      case BoxStorage.inventory:
        return 'inventorys';
      case BoxStorage.resultinventory:
        return 'resultinventory';
      default:
        return '';
    }
  }
}

class CommonFunction {
  CommonFunction._();
  // Static instance variable
  static final CommonFunction _instance = CommonFunction._();

  // Factory method to return the same instance
  factory CommonFunction() {
    return _instance;
  }
  static void showSnackBar(String message, BuildContext context, Color color) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: const Duration(seconds: 3),
      shape: const StadiumBorder(),
      behavior: SnackBarBehavior.floating,
      elevation: 0,
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static showAlertError(BuildContext context, String title, dynamic error) async {
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.red,
          ),
        ),
        content: Text('$error'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Đóng'),
          )
        ],
      ),
    );
  }
}
