import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/utils/dimensions.dart';

class ResponsiveBuilder extends StatelessWidget {
  final Widget mobileLayout;
  final Widget webLayout;
  const ResponsiveBuilder({ Key? key, required this.mobileLayout, required this.webLayout }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints){
      if(constraints.maxWidth>webSize){
        return webLayout;
      }
      return mobileLayout;
    });
  }
}