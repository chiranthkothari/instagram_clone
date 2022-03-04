import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/utils/dimensions.dart';
import 'package:provider/provider.dart';

class ResponsiveBuilder extends StatefulWidget {
  final Widget mobileLayout;
  final Widget webLayout;
  const ResponsiveBuilder(
      {Key? key, required this.mobileLayout, required this.webLayout})
      : super(key: key);

  @override
  State<ResponsiveBuilder> createState() => _ResponsiveBuilderState();
}

class _ResponsiveBuilderState extends State<ResponsiveBuilder> {
  @override
  void initState() {
    addData();
    super.initState();
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > webSize) {
        return widget.webLayout;
      }
      return widget.mobileLayout;
    });
  }
}
