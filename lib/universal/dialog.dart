import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr/api/apis.dart';
import 'package:hr/universal/customalertdialog.dart';

class ShowDialog extends GetxController {
  String chairmessage = "Please notify the admin to create the related record.\nThank you.";
  
  void handleError(dynamic e) {
    if (e is ApiException) {
      if (e.statusCode == 400) {
        show_Dialog(Get.context!, 'Invalid email', e.message);
      } else if (e.statusCode == 401) {
        show_Dialog(Get.context!, 'Unauthenticated','Please Log In Again' );//e.message
      } else if (e.statusCode == 403) {
        show_Dialog(Get.context!, 'Please Verify Your Account', e.message);
      } else if (e.statusCode == 404) {
        show_Dialog(Get.context!, 'User not found', e.message);
      } else if (e.statusCode == 409) {
        show_Dialog(Get.context!, 'Registration Failed', e.message);
      } else if (e.statusCode == 422) {
        show_Dialog(Get.context!, 'Validation Error', e.message);//Validation Error
      } else {  show_Dialog(Get.context!,'Error',e.message,);}
    } else {
        // Handle other unexpected errors
      show_Dialog( Get.context!,'Error', 'Error' 'Unexpected error: $e');
    }
  }
  
  void show_Dialog(context, String title, String message) {
    // Ensures dialog is shown after the build phase is completed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Get.context!.mounted) {  // Check if the Get.context! is still valid
        showDialog(
          context: context,
          builder: (context) => CustomAlertDialog(
            title: title,
            message: message,
            onOkPressed: () {
              Navigator.of(context).pop(); // Close the dialog when the user presses OK
            },
          ),
        );
      }
    });
  }
}



class FutureDataWidget<T> extends StatelessWidget {
  final Future<T> future;
  final Widget Function(BuildContext context, T data) builder;
  final Widget loadingWidget;
  final Widget Function(Object error) errorWidget;

  const FutureDataWidget({
    required this.future,
    required this.builder,
    required this.loadingWidget,
    required this.errorWidget,
    Key? key,
  }) : super(key: key);

  @override
  Widget build( BuildContext context,) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingWidget;
        } else if (snapshot.hasError) {
          return errorWidget(snapshot.error!);
        } else if (snapshot.hasData) {
          return builder(context, snapshot.data!);
        } else {
          return errorWidget("No data available.");
        }
      },
    );
  }
}
