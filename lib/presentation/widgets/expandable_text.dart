import 'package:flutter/material.dart';
import 'package:food_delievery_app/presentation/widgets/small_text.dart';
import 'package:food_delievery_app/utils/colors.dart';
import 'package:food_delievery_app/utils/dimensions.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool hiddenText = true;
  double textHeight = Dimensions.screenHeight / 4;
  late String firstHalf;
  late String secondHalf;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SmallText(
        height: 1.8,
              text: firstHalf,
              size: Dimensions.font16,
              color: AppColors.paraColor,
            )
          : Container(
              child: Column(
                children: [
                  SmallText(
                    height: 1.8,
                    size: Dimensions.font16,
                    color: AppColors.paraColor,
                    text: hiddenText
                        ? firstHalf + '...'
                        : (firstHalf + secondHalf),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        hiddenText = !hiddenText;
                      });
                    },
                    child: Row(
                      children: [
                        SmallText(
                          text: hiddenText ? 'Show more' : 'Show less',
                          color: AppColors.mainColor,
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        hiddenText
                            ? Icon(
                                Icons.arrow_drop_down,
                                color: AppColors.mainColor,
                                size: 16,
                              )
                            : Icon(
                                Icons.arrow_drop_up,
                                color: AppColors.mainColor,
                                size: 16,
                              ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
