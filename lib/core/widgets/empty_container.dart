import 'package:electro/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyContainer extends StatelessWidget {
  const EmptyContainer(this.image,  this.text1,  this.text2,{super.key, this.onPressed});
    final String? image;
    final String? text1;
    final String? text2;
    final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    double screenHeight= MediaQuery.of(context).size.height;
    double screenWidth= MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Padding(
          padding:  EdgeInsets.symmetric( horizontal: screenWidth*0.1, vertical: screenHeight*0.2),
          child: Column(
            children: [
              SvgPicture.asset(image!),
              SizedBox(height: screenHeight*0.1,),
              Text(text1!, textAlign: TextAlign.center, style: TextStyles.authtitle.copyWith(
                color: Colors.white
              ),),
              SizedBox(height: screenHeight*0.05,),
              ElevatedButton(onPressed: onPressed, child: Text(text2!, style: TextStyles.authtitle.copyWith(color: Colors.white,
              fontSize:  screenWidth*0.05
              ),),)
            ],
          ),
        ),
      ),
    );
  }
}