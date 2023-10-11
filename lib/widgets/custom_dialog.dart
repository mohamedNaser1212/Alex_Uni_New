import 'package:flutter/material.dart';

class DialogCustomized extends StatelessWidget {
  const DialogCustomized({
    super.key,
    this.headerIcon = Icons.info,
    this.title = "Attention",
    this.desc = "Alexandria University is not responsible for this action, you will lose your data forever and won't be able to restore it again.",
    this.secondDesc = "Do you want to proceed ?",
    this.leftBtn = "Cancel",
    this.rightBtn = "Delete",
    this.backgroundColor = Colors.white, // done
    this.headerColor = Colors.white,
    this.headerIconColor = Colors.red,
    this.titleColor = Colors.black,
    this.descColor = Colors.black,
    this.secondDescColor = Colors.black,
    this.leftBtnColor = Colors.green,
    this.leftBtnTextColor = Colors.white,
    this.rightBtnColor = Colors.red,
    this.rightBtnTextColor = Colors.white, 
    this.bgHeight = 0.36,
    this.headerPosition = 282, 
    required this.rightFunc, 
    
  });

  final String title, desc, secondDesc, leftBtn, rightBtn;
  final Color backgroundColor,
      headerColor,
      headerIconColor,
      titleColor,
      descColor,
      secondDescColor,
      leftBtnColor,
      leftBtnTextColor,
      rightBtnColor,
      rightBtnTextColor;
  final IconData headerIcon;
  final void Function()? rightFunc;
  final double bgHeight, headerPosition;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(17),
      ),
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * bgHeight,
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 64,
                left: 25,
                right: 25,
              ),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 23,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.015,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        desc,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.012,
                      ),
                      if(secondDesc == "Do you want to proceed ?")
                      Text(
                        secondDesc,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                      if(secondDesc == "")
                      Container(),
                    ],
                  ),
                  if(secondDesc == "Do you want to proceed ?")
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.032,
                  ),
                  if(secondDesc == "")
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.022,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(9),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: leftBtnColor,
                            ),
                            child: Center(
                              child: Text(
                                leftBtn,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: leftBtnTextColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: rightFunc,
                          child: Container(
                            padding: const EdgeInsets.all(9),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: rightBtnColor,
                            ),
                            child: Center(
                              child: Text(
                                rightBtn,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: rightBtnTextColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Align(
              child: Container(
                margin: EdgeInsets.only(
                  bottom: headerPosition,
                ),
                child: CircleAvatar(
                  radius: 54,
                  backgroundColor: headerColor,
                  child: Icon(
                    Icons.info,
                    color: headerIconColor,
                    size: 105,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}