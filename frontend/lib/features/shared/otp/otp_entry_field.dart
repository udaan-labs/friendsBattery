import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Reusable 6-digit OTP field for login and later sensitive screens.
class OtpEntryField extends StatelessWidget {
  final TextEditingController controller;
  final bool enabled;
  final ValueChanged<String>? onSubmitted;
  final String? helperText;

  const OtpEntryField({
    super.key,
    required this.controller,
    this.enabled = true,
    this.onSubmitted,
    this.helperText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enabled,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      maxLength: 6,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        labelText: 'OTP',
        counterText: '',
        helperText: helperText,
      ),
    );
  }
}
