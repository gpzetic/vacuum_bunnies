import 'package:get_it/get_it.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter/cupertino.dart';

import '../../../../data/services/api/api_client.dart';
import '../../auth/widgets/login.dart';
import '../../auth/widgets/register.dart';

enum Pages { Login, Register }

class AccountScreen extends StatefulWidget implements ChangeListener {
  AccountScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AccountHandlerState();
  }

  @override
  void dispatch(Object? event) {
    // TODO: implement dispatch
  }
}

class _AccountHandlerState extends State<AccountScreen> {
  final api = GetIt.instance<ApiClient>();

  Pages _selectedPage = Pages.Login;

  var segmentsMap = <Pages, Widget>{
    Pages.Login: Text("Login"),
    Pages.Register: Text("Register"),
  };

  void _onChanged(Pages? page) {
    if (page != null) {
      setState(() {
        _selectedPage = page;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return api.client.auth.currentUser == null ? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CupertinoSlidingSegmentedControl(
            children: segmentsMap,
            onValueChanged: _onChanged,
            groupValue: _selectedPage,
          ),
          SizedBox(height: 50,),
          _selectedPage == Pages.Login ? Login() : Register(),
        ],
      ),
    ) : Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Email: ${api.client.auth.currentUser?.email}"),
          SizedBox(
            width: 200,
            child: Button.outline(child: Row(children: [Icon(Icons.logout), Text("Log out")],),
            onPressed: () => {api.logout()},
            ),
          )
        ],
      ).gap(20),
    );
  }
}
