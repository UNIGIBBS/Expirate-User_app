import 'package:comp2/pages/filter_page.dart';
import 'package:comp2/pages/sort_page.dart';
import 'package:flutter/material.dart';

class filter_button extends StatelessWidget {
  filter_button({
    Key? key,
    required this.width,
    required this.categories
  }) : super(key: key);

  final double width;
  var categories;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          child: const Icon(Icons.tune),
          onTap: () => showModalBottomSheet(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              )
            ),
            isScrollControlled: true,
              context: context,
              builder: (context) => FilterPage(categories: categories))
        ),
        SizedBox(
          width: width * 0.005,
        ),
        VerticalDivider(
          thickness: 1,
          color: Colors.grey,
        ),
        SizedBox(
          width: width * 0.005,
        ),
        GestureDetector(
          child: const Icon(Icons.swap_vert),
          onTap: () => showModalBottomSheet(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    )
                ),
                isScrollControlled: true,
                context: context,
                builder: (context) => SortPage())
        ),
      ],
    );
  }
}
