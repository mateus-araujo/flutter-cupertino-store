import 'package:flutter/cupertino.dart';

class CupertinoTextInput extends StatelessWidget {
  const CupertinoTextInput({
    this.autocorrect,
    required this.icon,
    required this.placeholder,
    this.onChanged,
    this.keyboardType,
    this.textCapitalization,
  });

  final bool? autocorrect;
  final IconData icon;
  final String placeholder;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;

  @override
  Widget build(BuildContext context) {
    var cupertinoTextField = CupertinoTextField(
      prefix: Icon(
        icon,
        color: CupertinoColors.lightBackgroundGray,
        size: 28,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      clearButtonMode: OverlayVisibilityMode.editing,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      keyboardType: keyboardType,
      autocorrect: autocorrect ?? true,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0,
            color: CupertinoColors.inactiveGray,
          ),
        ),
      ),
      placeholder: placeholder,
      onChanged: onChanged,
    );
    return cupertinoTextField;
  }
}
