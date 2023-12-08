import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_screenutil/flutter_screenutil.dart';

enum CustomTextFieldType {
  normal,
  password,
}

enum CustomPasswordTextFieldStatus {
  tooShort,
  weak,
  fair,
  good,
  strong,
  shouldNotCheck;

  const CustomPasswordTextFieldStatus();

  String get getName {
    switch (this) {
      case CustomPasswordTextFieldStatus.tooShort:
        return 'Too Short';
      case CustomPasswordTextFieldStatus.weak:
        return 'Weak';
      case CustomPasswordTextFieldStatus.fair:
        return 'Fair';
      case CustomPasswordTextFieldStatus.good:
        return 'Good';
      case CustomPasswordTextFieldStatus.strong:
        return 'Strong';
      case CustomPasswordTextFieldStatus.shouldNotCheck:
        return '';
    }
  }

  Color get getColor {
    switch (this) {
      case CustomPasswordTextFieldStatus.tooShort:
        return Colors.grey;
      case CustomPasswordTextFieldStatus.weak:
        return Colors.red;
      case CustomPasswordTextFieldStatus.fair:
        return Colors.yellow;
      case CustomPasswordTextFieldStatus.good:
        return const Color(0xFF647FFF);
      case CustomPasswordTextFieldStatus.strong:
        return Colors.greenAccent;
      case CustomPasswordTextFieldStatus.shouldNotCheck:
        return const Color(0xFF647FFF);
    }
  }
}

class CustomTextField extends StatefulWidget {
  const CustomTextField._(
      {required this.type,
      required this.onChange,
      required this.hintText,
      this.status = CustomPasswordTextFieldStatus.weak});

  final CustomTextFieldType type;

  final void Function(String?)? onChange;
  final String hintText;
  final CustomPasswordTextFieldStatus status;

  factory CustomTextField.normal({
    void Function(String?)? onChange,
    String hintText = '',
  }) {
    return CustomTextField._(
      type: CustomTextFieldType.normal,
      onChange: onChange,
      hintText: hintText,
    );
  }

  factory CustomTextField.password({
    void Function(String?)? onChange,
    required CustomPasswordTextFieldStatus status,
  }) {
    return CustomTextField._(
      type: CustomTextFieldType.password,
      onChange: onChange,
      hintText: 'Your password',
      status: status,
    );
  }

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final _statusContentNotifier = ValueNotifier<bool>(false);
  final _statusNotifier = ValueNotifier<CustomPasswordTextFieldStatus>(
      CustomPasswordTextFieldStatus.shouldNotCheck);

  @override
  void didUpdateWidget(covariant CustomTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.status != oldWidget.status) {
      _statusNotifier.value = widget.status;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == CustomTextFieldType.normal) {
      return TextFormField(
        validator: (value) {
          if((value ?? '').isEmpty) {
            return 'Email can not be empty';
          }
        },
        onChanged: widget.onChange,
        decoration: InputDecoration(
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 3,
              style: BorderStyle.solid,
              color: Theme.of(context).colorScheme.error,
              strokeAlign: 0.5,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 3,
              style: BorderStyle.solid,
              color: Theme.of(context).colorScheme.primary,
              strokeAlign: 0.5,
            ),
          ),
          hintText: widget.hintText,
          hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.white.withOpacity(0.5),
              ),
          labelText: widget.hintText,
          labelStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.white.withOpacity(0.5),
              ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ValueListenableBuilder(
            valueListenable: _statusNotifier,
            builder: (context, status, _) {
              return TextFormField(
                onChanged: (value) {
                  widget.onChange?.call(value);
                  _statusContentNotifier.value = (value ?? '').isNotEmpty;
                },
                decoration: InputDecoration(
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 3,
                      style: BorderStyle.solid,
                      color: Theme.of(context).colorScheme.error,
                      strokeAlign: 0.5,
                    ),
                  ),
                  focusedBorder: CustomPasswordInputBorder(
                    passwordStatus: status,
                    borderSide: BorderSide(
                      width: 3,
                      style: BorderStyle.solid,
                      color: Theme.of(context).colorScheme.primary,
                      strokeAlign: 0.5,
                    ),
                  ),
                  hintText: widget.hintText,
                  hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.white.withOpacity(0.5),
                      ),
                  labelText: widget.hintText,
                  labelStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.white.withOpacity(0.5),
                      ),
                ),
              );
            }),
        SizedBox(height: 8.h),
        ValueListenableBuilder(
          builder: (context, shouldShow, _) {
            return Visibility(
              visible: shouldShow,
              replacement:
                  Text('', style: Theme.of(context).textTheme.bodySmall),
              child: Text(widget.status.getName,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: widget.status.getColor)),
            );
          },
          valueListenable: _statusContentNotifier,
        ),
      ],
    );
  }
}

class CustomPasswordInputBorder extends InputBorder {
  const CustomPasswordInputBorder({
    required this.passwordStatus,
    super.borderSide = const BorderSide(),
    this.borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(4.0),
      topRight: Radius.circular(4.0),
    ),
  }) : super();

  final BorderRadius borderRadius;
  final CustomPasswordTextFieldStatus passwordStatus;

  @override
  bool get isOutline => false;

  @override
  CustomPasswordInputBorder copyWith(
      {BorderSide? borderSide, BorderRadius? borderRadius}) {
    return CustomPasswordInputBorder(
      borderSide: borderSide ?? this.borderSide,
      borderRadius: borderRadius ?? this.borderRadius,
      passwordStatus: passwordStatus,
    );
  }

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.only(bottom: borderSide.width);
  }

  @override
  CustomPasswordInputBorder scale(double t) {
    return CustomPasswordInputBorder(
        borderSide: borderSide.scale(t), passwordStatus: passwordStatus);
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRect(Rect.fromLTWH(rect.left, rect.top, rect.width,
          math.max(0.0, rect.height - borderSide.width)));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRRect(borderRadius.resolve(textDirection).toRRect(rect));
  }

  @override
  void paintInterior(Canvas canvas, Rect rect, Paint paint,
      {TextDirection? textDirection}) {
    canvas.drawRRect(borderRadius.resolve(textDirection).toRRect(rect), paint);
  }

  @override
  bool get preferPaintInterior => true;

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is CustomPasswordInputBorder) {
      return CustomPasswordInputBorder(
        borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
        borderRadius: BorderRadius.lerp(a.borderRadius, borderRadius, t)!,
        passwordStatus: passwordStatus,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is CustomPasswordInputBorder) {
      return CustomPasswordInputBorder(
        borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
        borderRadius: BorderRadius.lerp(borderRadius, b.borderRadius, t)!,
        passwordStatus: passwordStatus,
      );
    }
    return super.lerpTo(b, t);
  }

  /// Draw a horizontal line at the bottom of [rect].
  ///
  /// The [borderSide] defines the line's color and weight. The `textDirection`
  /// `gap` and `textDirection` parameters are ignored.
  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double? gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection? textDirection,
  }) {
    if (borderRadius.bottomLeft != Radius.zero ||
        borderRadius.bottomRight != Radius.zero) {
      canvas.clipPath(getOuterPath(rect, textDirection: textDirection));
    }

    if (passwordStatus == CustomPasswordTextFieldStatus.shouldNotCheck) {
      canvas.drawLine(rect.bottomLeft, rect.bottomRight, borderSide.toPaint());
      return;
    }

    canvas.drawLine(rect.bottomLeft, rect.bottomRight,
        borderSide.copyWith(color: Colors.grey).toPaint());

    var statusOffset = 0.0;

    switch (passwordStatus) {
      case CustomPasswordTextFieldStatus.tooShort:
        statusOffset = 0.0;
      case CustomPasswordTextFieldStatus.weak:
        statusOffset = rect.bottomRight.dx / 4;
      case CustomPasswordTextFieldStatus.fair:
        statusOffset = rect.bottomRight.dx / 2;
      case CustomPasswordTextFieldStatus.good:
        statusOffset = rect.bottomRight.dx * 3 / 4;
      case CustomPasswordTextFieldStatus.strong:
        statusOffset = rect.bottomRight.dx;
      case CustomPasswordTextFieldStatus.shouldNotCheck:
      // TODO: Handle this case.
    }

    canvas.drawLine(rect.bottomLeft, Offset(statusOffset, rect.bottomRight.dy),
        borderSide.copyWith(color: passwordStatus.getColor).toPaint());
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is CustomPasswordInputBorder &&
        other.borderSide == borderSide &&
        other.borderRadius == borderRadius &&
        other.passwordStatus == passwordStatus;
  }

  @override
  int get hashCode => Object.hash(borderSide, borderRadius, passwordStatus);
}
