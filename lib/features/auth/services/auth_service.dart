// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:ShopSphere/common/widgets/bottom_bar.dart';
import 'package:ShopSphere/constants/error_handling.dart';
import 'package:ShopSphere/constants/global_variables.dart';
import 'package:ShopSphere/constants/utils.dart';
import 'package:ShopSphere/models/user.dart';
import 'package:ShopSphere/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../features/home/screens/home_screen.dart';

class AuthService {
  // sign up user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      // print('im here');
      User user = User(
        id: '',
        name: name,
        password: password,
        email: email,
        address: '',
        type: '',
        token: '',
        cart: [],
      );
      /*
      The purpose of this request is likely to authenticate a user by sending their email and 
      password to the server for validation.Upon receiving the request, the server may perform 
      authentication logic, which may involve querying a database to verify the provided 
      credentials. However, the code snippet itself does not involve direct interaction with 
      a database. 
      */
      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Access-Control-Allow-Origin": "*",
          'Access-Control-Allow-Headers':
              'Origin, Content-Type, Cookie, X-CSRF-TOKEN, Accept, Authorization, X-XSRF-TOKEN, Access-Control-Allow-Origin',
          'Access-Control-Expose-Headers': "" 'Authorization, authenticated',
          'Access-Control-Allow-Methods': 'GET,POST,OPTIONS,DELETE,PUT',
          'Access-Control-Allow-Credentials': 'true',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () { 
          showSnackBar(
            context,
            'Account created! Login with the same credentials!',
          );
        },
      );
    } catch (e) {
      // print('error is ----------------------->');
      // print(e.toString());
      showSnackBar(context, e.toString());
    }
  }

//   // sign in user
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      /*
      If the user successfully logs in, the response from the server (res) will typically 
      contin a status code indicating success, such as 200 OK, along with any additional 
      data the server chooses to include in the response body.
      */
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        /*
        It includes the appropriate headers indicating that the content type is JSON.
        */
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );   
      httpErrorHandle( 
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          // yha store kraya h token ko getuserdata function se get krenge token ko
          Navigator.pushNamedAndRemoveUntil(
            context,
            BottomBar.routeName,
            //  HomeScreen.routeName,
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

//   // get user data
  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null){
        prefs.setString('x-auth-token','');
      }
      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token!
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }

      /*
      if (response == true) { ... }: This condition checks if the response variable contains 
      the boolean value true. If the condition is met, it means that the authentication token 
      is valid, and the user is authenticated.

http.Response userRes = await http.get(...);: If the response is true, the code sends another 
HTTP GET request to the URI specified by $uri/. This request likely fetches user data or 
information related to the authenticated user. The request includes the authentication token 
('x-auth-token') in the headers to authenticate the request.

var userProvider = Provider.of<UserProvider>(context, listen: false);: This line retrieves an 
instance of the UserProvider class using the Provider.of method. The UserProvider is likely a 
class responsible for managing user-related data or state within the application.

userProvider.setUser(userRes.body);: Once the response is received, the code sets the user 
data in the UserProvider instance using the setUser method. It likely extracts relevant 
information from the response body (userRes.body) and updates the user state within the 
application.*/
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}


/*
SharedPreferences prefs = await SharedPreferences.getInstance();: 
This line obtains an instance of SharedPreferences, which is a persistent storage 
mechanism used to store key-value pairs persistently across app sessions. 
By calling getInstance(), the code retrieves a reference to the shared preferences instance, 
which allows the app to read and write data to persistent storage.

Provider.of<UserProvider>(context, listen: false).setUser(res.body);: 
This line uses the Provider package to access the UserProvider class and call its setUser method.
 This method is typically used to update the state of the user within the app. Here, 
 res.body likely contains the response body from the server, which might include user 
 data obtained after a successful login. The setUser method is responsible for updating 
 the user state in the app with the data received from the server.

await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);: 
This line uses the shared preferences instance (prefs) obtained earlier to store 
the authentication token ('x-auth-token') in persistent storage. It uses jsonDecode 
to parse the JSON response body (res.body) received from the server and extract the 
authentication token from it. Then, it stores the token using setString method, ensuring 
that the token persists across app sessions. Storing the token locally allows the app to 
authenticate subsequent requests to the server without requiring the user to log in again.
*/