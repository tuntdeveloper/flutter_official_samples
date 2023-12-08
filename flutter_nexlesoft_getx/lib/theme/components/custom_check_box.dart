import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({super.key, required this.onChange});

  final void Function(bool) onChange;

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  final _checkBoxNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _checkBoxNotifier.addListener(() {
      widget.onChange.call(_checkBoxNotifier.value);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _checkBoxNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _checkBoxNotifier,
        builder: (context, isCheck, _) {
          if (isCheck) {
            return InkWell(
              onTap: () {
                _checkBoxNotifier.value = false;
              },
              child: Image.asset('assets/icons/ic_check_box.png',
                  height: 23.h, width: 23.h),
            );
          }

          return InkWell(
            onTap: () {
              _checkBoxNotifier.value = true;
            },
            child: Image.asset('assets/icons/ic_un_check_box.png',
                height: 23.h, width: 23.h),
          );
        });
  }
}
