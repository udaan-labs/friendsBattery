import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

extension SnackbarExtension on BuildContext {
  /// Displays a floating success snackbar at the top of the screen.
  void showSuccessSnackBar(String message) {
    showTopSnackBar(
      Overlay.of(this),
      CustomSnackBar.success(
        message: message,
      ),
    );
  }

  /// Displays a floating error snackbar at the top of the screen.
  void showErrorSnackBar(String message) {
    showTopSnackBar(
      Overlay.of(this),
      CustomSnackBar.error(
        message: message,
      ),
    );
  }

  /// Displays a floating info snackbar at the top of the screen.
  void showInfoSnackBar(String message) {
    showTopSnackBar(
      Overlay.of(this),
      CustomSnackBar.info(
        message: message,
      ),
    );
  }
}
