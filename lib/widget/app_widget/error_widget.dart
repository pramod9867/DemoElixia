import 'package:demo_elixia/utils/constants/appcontants.dart';
import 'package:flutter/cupertino.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(AppConstants.appMessages.error_message),
      ),
    );
  }
}