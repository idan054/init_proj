import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/themes/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart' /*as provider*/;

import '../common/mixins/assets.gen.dart';
import '../common/service/auth_services.dart';
import '../widgets/widgets.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  Widget build(BuildContext context) {
    print('START: LoginScreen()');
    GoogleSignInAccount? user = _googleSignIn.currentUser;

    return Scaffold(
      body: Column(
        children: [
          const Spacer(flex: 3,),
          googleLoginButton(),
          const Spacer(flex: 7,),
        ],
      ),
    );
  }

  Widget googleLoginButton() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
    child: InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () async => AuthService().signInWithGoogle(context),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: borderDeco(),
        child: ListTile(
          visualDensity: VisualDensity.compact,
          leading: Assets.svg.gLogoIcon.svg(height: 25),
          title: Text(
            // loadingText ? 'מיד נכנסים...' :
            'התחבר עם גוגל',
            style: AppStyles.text16PxBold,
          ),
          trailing: const Icon(Icons.east).rtl,
        ),
      ),
    ),
  );
}
