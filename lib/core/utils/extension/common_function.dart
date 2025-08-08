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

  Future<void> showDeleteConfirmationDialog(BuildContext context, Function onConfirm) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button to close the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this document?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                onConfirm(); // Call the function to delete the document
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  static String formatRelativeTime(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateTime now = DateTime.now();
    Duration difference = now.difference(date);

    if (difference.inDays >= 365) {
      int years = (difference.inDays / 365).floor();
      return years == 1 ? 'một năm trước' : '$years năm trước';
    } else if (difference.inDays >= 30) {
      int months = (difference.inDays / 30).floor();
      return months == 1 ? 'một tháng trước' : '$months tháng trước';
    } else if (difference.inDays >= 7) {
      int weeks = (difference.inDays / 7).floor();
      return weeks == 1 ? 'một tuần trước' : '$weeks tuần trước';
    } else if (difference.inDays >= 1) {
      return difference.inDays == 1 ? 'một ngày trước' : '${difference.inDays} ngày trước';
    } else if (difference.inHours >= 1) {
      return difference.inHours == 1 ? 'một giờ trước' : '${difference.inHours} giờ trước';
    } else if (difference.inMinutes >= 1) {
      return difference.inMinutes == 1 ? 'một phút trước' : '${difference.inMinutes} phút trước';
    } else {
      return 'vài giây trước';
    }
  }
}
