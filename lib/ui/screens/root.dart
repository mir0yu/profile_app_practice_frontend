import 'package:flutter/cupertino.dart';
import 'package:profile/constants/paths.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Navigator.pushNamed(context, HOME);
    return Container(

    );
  }
}
