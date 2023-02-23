import 'package:amlelshefaa/core/utils/size_config.dart';
import 'package:flutter/material.dart';

import '../../../core/models/category_model.dart';
import '../../../core/utils/app_colors.dart';

class CategoryItem extends StatefulWidget {
  const CategoryItem({
    Key? key,
    required this.categoryModel,
    required this.selectFunction,
  }) : super(key: key);
  final CategoryModel categoryModel;
  final VoidCallback selectFunction;
  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 5,
            child: Stack(
              children: [
                Image.asset(
                  widget.categoryModel.imagePath,
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: double.infinity,
                ),
                SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 40,
                            decoration: const BoxDecoration(color: AppColors.secondaryColor, shape: BoxShape.circle),
                            child: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Text(
                                          widget.categoryModel.description,
                                          textAlign: TextAlign.right,
                                        ),
                                        scrollable: true,
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.question_mark_rounded,
                                  color: Colors.white,
                                  size: 22,
                                )),
                          ),
                          IconButton(
                            splashRadius: 1,
                            iconSize: 28,
                            tooltip: 'select',
                            color: Colors.white,
                            onPressed: widget.selectFunction,
                            icon: Icon(
                              !widget.categoryModel.isSelected ? Icons.check_box_outline_blank : Icons.check_box,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )),
        Expanded(
          flex: 3,
          child: Text(
            widget.categoryModel.categoryName,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.grey.shade700,
                  fontSize: 14,
                ),
            softWrap: true,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
