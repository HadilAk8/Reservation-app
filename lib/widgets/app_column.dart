import 'package:flutter/material.dart';
import 'package:test/utils/colors.dart';
import 'package:test/utils/dimensions.dart';
import 'package:test/widgets/big_text.dart';
import 'package:test/widgets/icon_and_text_widget.dart';
import 'package:test/widgets/small_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  final String loc;

  const AppColumn({Key? key, required this.text , this.loc=""}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BigText(text: text , size: Dimensions.font20,),
            SizedBox(height: Dimensions.height10,),
            Row(
              children: [
                Wrap(
                  children: List.generate(5, (index) => Icon(Icons.star , color: AppColors.mainColor, size: 15,)),
                ),
                SizedBox(width: 10,),
                SmallText(text: "4.5"),
                SizedBox(width: 10,),
                SmallText(text: "1287"),
                SizedBox(width: 5,),
                SmallText(text: "comments")
              ],
            ),
            SizedBox(height: Dimensions.height20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconAndTextWidget(icon: Icons.circle_sharp, text: "Normal", iconColor: AppColors.iconColor1),
                IconAndTextWidget(icon: Icons.location_on, text: loc, iconColor: AppColors.mainColor),
                //IconAndTextWidget(icon: Icons.access_time_rounded, text: "32min", iconColor: AppColors.iconColor2),
              ],
            )
          ],
    );
  }
}