import 'package:ShopSphere/common/widgets/bottom_bar.dart';
import 'package:ShopSphere/constants/global_variables.dart';
import 'package:ShopSphere/features/account/screens/account_screen.dart';
import 'package:ShopSphere/features/admin/screens/admin_screen.dart';
import 'package:ShopSphere/features/auth/screens/auth_screen.dart';
import 'package:ShopSphere/features/auth/services/auth_service.dart';
// import 'package:ShopSphere/features%20copy/admin/screens/admin_screen.dart';
// import 'package:ShopSphere/features%20copy/home/screens/home_screen.dart';
// import 'package:ShopSphere/features%20copy/home/screens/home_screen.dart';
import 'package:ShopSphere/providers/user_provider.dart';
import 'package:ShopSphere/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final userProvider = Provider.of<UserProvider>(context);
//     if (userProvider.user.token.isNotEmpty) {
//       return userProvider.user.type == 'user'
//           ? const BottomBar()
//           : const AdminScreen();
//     } else {
//       return const AuthScreen();
//     }
//   }
// }
void main(){
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ShopEase',
        theme: ThemeData(
          scaffoldBackgroundColor: GlobalVariables.backgroundColor,
          colorScheme: const ColorScheme.light(
            primary: GlobalVariables.secondaryColor,
          ),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black,
              
            ),
          ),
          useMaterial3: true, // can remove this line
        ),
        onGenerateRoute: (settings) => generateRoute(settings),
          home:
          Provider.of<UserProvider>(context).user.token!.isNotEmpty
            ? Provider.of<UserProvider>(context).user.type == 'user'
                ? const BottomBar()
                : const AdminScreen()
            : const AuthScreen() 


            //   Provider.of<UserProvider>(context).user.token!.isNotEmpty
            // ? Provider.of<UserProvider>(context).user.type == 'user'
            //     ? const BottomBar()
            //     : const AdminScreen()
            // : const AuthScreen() 

    
    );
  }
}
