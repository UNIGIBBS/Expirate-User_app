
import 'package:comp2/pages/home_page.dart';
import 'package:comp2/providers/list_checker.dart';
import 'package:comp2/providers/product_list.dart';
import 'package:comp2/providers/shopping_list_provider.dart';
import 'package:comp2/services/auth.dart';
import 'package:comp2/services/location_service.dart';
import 'package:comp2/widgets/bottomNavigationBar.dart';
import 'package:comp2/widgets/navigation_deneme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:comp2/pages/page.dart';

import 'models/product_model.dart';
import 'models/products.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'models/user_model.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 // await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatefulWidget {

  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initializtion = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return StreamProvider(
      create: (context) => LocationService().locationStream, initialData: null,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthenticationService>(create: (BuildContext context)=> AuthenticationService(FirebaseAuth.instance)),
          ChangeNotifierProvider<ShoppingListProvider>(create: (BuildContext context)=> ShoppingListProvider()),
          ChangeNotifierProvider<ListChecker>(create: (BuildContext context)=> ListChecker()),
          ChangeNotifierProvider<SLpage>(create: (BuildContext context) => SLpage()),
          ChangeNotifierProvider<ProductList>(create: (BuildContext context) => ProductList()),
          ChangeNotifierProvider<Products>(create: (BuildContext context) => Products()),
          ChangeNotifierProvider<ProductModel>(create: (BuildContext context) => ProductModel(),
          ),
          ChangeNotifierProvider<UserModel>(create: (BuildContext context) => UserModel(),),



        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          //home: Provider.of<SLpage>(context).Login,
          home: FutureBuilder(
            future:  _initializtion,
            builder: (context, snapshot){
              if(snapshot.hasError){
                return Center(child: Text("Error"),);
              }
              else if(snapshot.hasData){
                return StreamBuilder<User?>(
                  stream: AuthenticationService(FirebaseAuth.instance).authService,
                  builder: (context, snapshot) {
                    Widget returnedChild;
                    if(snapshot.connectionState == ConnectionState.waiting){
                      returnedChild = CircularProgressIndicator();
                    }else{
                      if (snapshot.data == null) {
                        returnedChild = CommonPage();
                      }else{
                        returnedChild = BottomNavigate();
                      }
                    }
                    return returnedChild;
                  },

                );
              }
              else{
                return Center(child: CircularProgressIndicator(),);
              }
            },
          )

          //CommonPage(),
        ),
      ),
    );
  }
}


class CommonPage extends StatefulWidget {
  const CommonPage({Key? key}) : super(key: key);

  @override
  _CommonPageState createState() => _CommonPageState();
}

class _CommonPageState extends State<CommonPage> {

  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(

      body: Provider.of<SLpage>(context).Login,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: height * 0.2,
        centerTitle: true,
        title: SwitchListTile(
          activeColor: Colors.blueGrey,
          autofocus: false,
          title: Provider.of<SLpage>(context).isLogin?
          Text("Sign In", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),):
          Text("Sign Up",  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          onChanged: (_){
            Provider.of<SLpage>(context, listen: false).toggleLogin();
          },
          value: Provider.of<SLpage>(context).isLogin,
        ),
      ),

    );

  }
}


