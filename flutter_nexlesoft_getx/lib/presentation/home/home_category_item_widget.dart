
import 'package:flutter/material.dart';
import 'package:flutter_nexlesoft_getx/data/model/category_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeCategoryItemWidget extends StatelessWidget {
  const HomeCategoryItemWidget({
    super.key,
    required this.data,
    required this.onTap,
  });

  final CategoryModel data;
  final void Function(int?) onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap.call(data.id),
      child: Container(
        alignment: Alignment.center,
        decoration: data.isSelected ?? false
            ? BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          gradient: LinearGradient(
            begin: Alignment(0.49, 0.87),
            end: Alignment(-0.49, -0.87),
            colors: [Color(0xFF8A31A8), Color(0xFF8A00FF)],
          ),
        )
            : ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: Colors.white.withOpacity(0.11999999731779099),
            ),
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: Text(
          data.name ?? '',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            height: 0.12,
            fontSize: 14.sp,
            color: Colors.white.withOpacity(0.8199999928474426),
          ),
        ),
      ),
    );
  }
}