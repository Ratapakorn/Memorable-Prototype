import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:senex/Pages/Reminder.dart';
//import 'package:senex/controller/file_controller.dart';
import 'package:senex/mainMenu.dart';
import 'package:senex/helper/SQlite.dart';
import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:senex/models/User.dart';
import 'package:senex/themes.dart';
import 'package:senex/utils/user_simple_preferences.dart';
import 'package:senex/widget/notification_api.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


const MethodChannel platform = MethodChannel('dexterx.dev/flutter_local_notifications_example');

Future main() async {
  // runApp(
  //   MultiProvider(
  //     providers: [ChangeNotifierProvider(create: (_)=> FileController())],
  //     child: const MyApp()),
  // );
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(UserAdapter());
  await UserSimplePreferences.init();
  //await Hive
  await _configureLocalTime();

  runApp(const MyApp());

  //final usersBox = await Hive.openBox('users'); //only open it once
}

Future<void> _configureLocalTime() async {
  tz.initializeTimeZones();
  final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone(); //await platform.invokeMethod('getTimeZoneName');
  tz.setLocalLocation(tz.getLocation(timeZoneName!));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    NotificationApi.init();
    listenNotifications();
    //Hive.openBox('users');
  }

  void listenNotifications() =>
      NotificationApi.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) =>
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Reminder(),
      ));



  @override
  Widget build(BuildContext context) {
    //final userBox = Hive.box('users').get(0);
    //final usersBox = Hive.box('users');
    // usersBox.add(value)
    //context.read<FileController>().readText();
    return ThemeProvider(
      onInitCallback: (controller, previouslySavedThemeFuture) async {
        controller.setTheme('dark');
        // if(Hive.box('users').get(0).isDarkMode != null) {
        //   if(Hive.box('users').get(0).isDarkMode){
        //     controller.setTheme('dark');
        //   }
        //   else{
        //     controller.setTheme('light');
        //   }
        // }else{
        //   controller.setTheme('light');
        // }
      },
      themes: <AppTheme>[
        AppTheme.light(id: 'light'),
        AppTheme.dark(id: 'dark'),
      ],
      child: Builder(
        builder: (context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeProvider.themeOf(context).data,
          // theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            //fontFamily: 'Robotto',
            // primarySwatch: Colors.blue,
            // primaryColor: Colors.blue.shade300,
          //),
          home: FutureBuilder(
            future: Hive.openBox('users'),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(snapshot.connectionState == ConnectionState.done) {
                if(snapshot.hasError){
                  return Text(snapshot.error.toString());
                }
                return MyHomePage(title: 'MainPage');


              }else{
                //print("hello");
                return Scaffold();
              }

            },
          ),
          //home: const MyHomePage(title: 'MainPage'),

          routes: {
            '/mainMenu' : (context) => mainMenu(),
          },
        ),
      ),
    );

    // final ValueNotifier<ThemeMode> _notifier = ValueNotifier(ThemeMode.light);
    //
    // return ValueListenableBuilder<ThemeMode>(
    //   valueListenable: _notifier,
    //   builder: (_, mode, __) {
    //     return MaterialApp(
    //       theme: ThemeData.light(),
    //       darkTheme: ThemeData.dark(),
    //       themeMode: mode,
    //       // Decides which theme to show, light or dark.
    //       home: FutureBuilder(
    //         future: Hive.openBox('users'),
    //         builder: (BuildContext context, AsyncSnapshot snapshot) {
    //           if (snapshot.connectionState == ConnectionState.done) {
    //             if (snapshot.hasError) {
    //               return Text(snapshot.error.toString());
    //             }
    //             return MyHomePage(title: 'MainPage');
    //           } else {
    //             //print("hello");
    //             return Scaffold();
    //           }
    //         },
    //       ),
    //       //home: const MyHomePage(title: 'MainPage'),
    //
    //       routes: {
    //         '/mainMenu': (context) => mainMenu(),
    //       },
    //
    //     );
    //   },
    // );

    // return ChangeNotifierProvider(
    //   create: (context) => ThemeProvider(),
    //   builder: (context, _) {
    //     final themeProvider = Provider.of<ThemeProvider>(context);
    //     return MaterialApp(
    //       debugShowCheckedModeBanner: false,
    //       theme: MyThemes.lightTheme,
    //       darkTheme: MyThemes.darkTheme,
    //       themeMode: themeProvider.themeMode,
    //       home: MyHomePage(),
    //     );
    //   },
    // );
  }


  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  int _counter = 0;
  SQlite oDB = SQlite();
  List data = [];

  String formattedDate = DateFormat.yMMMMEEEEd().format(DateTime.now());

  late NavigatorState _navigator;

  @override
  void didChangeDependencies() {
    _navigator = Navigator.of(context);
    super.didChangeDependencies();
  }


  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  Future queryData() async {
    const String strSql = "SELECT id, name FROM Name";

    final allRows = await oDB.queryDatabase(strSql);

    return allRows;
  }

  //Future<bool> databaseExists(String path) =>
      //oDB.databaseExists(path);

  void insertData(String name) async {
    final String strSql = "INSERT INTO Name(name) VALUES ('"+name+"')";

    oDB.insertDatabase(strSql);
  }

  @override
  void initState() {
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 7),
    );

    animationController?.repeat() ?? new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 7),
    );

    super.initState();


    //listenNotifications();
    //Hive.openBox('users');
  }

  // void listenNotifications() =>
  //     NotificationApi.onNotifications.stream.listen(onClickedNotification);
  //
  // void onClickedNotification(String? payload) =>
  //     _navigator.push(MaterialPageRoute(
  //       builder: (context) => Reminder(),
  //     ));

  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      // appBar: AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   //title: Text(widget.title),
      // ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Stack(
         children: <Widget>[
           Container(
             color: Colors.black,
             width: MediaQuery.of(context).size.width,
             height: (MediaQuery.of(context).size.height),
           ),
           Center(
             child: Column(
             children: [
               SizedBox(
                 width: MediaQuery.of(context).size.width,
                 height: (3/8) * (MediaQuery.of(context).size.height),
               ),
               Image.asset(
               'assets/images/PlaceholderIcon.png',
               width: MediaQuery.of(context).size.width/4,
               height: MediaQuery.of(context).size.width/4,
               fit: BoxFit.fill,
             ),
             SizedBox(
               height: (1/32) * (MediaQuery.of(context).size.height),
             ),
             Text(formattedDate, style: const TextStyle(color: Colors.white, fontFamily: 'Binjay', fontSize: 20),),
             SizedBox(
               height: (9/40) * (MediaQuery.of(context).size.height),
             ),
             GestureDetector(
               onLongPress: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context) => const mainMenu()))
                //print(oDB.dbPath),

                //print("hello");
                //changeIsDarkMode(false);
                //Navigator.of(context).push(_createRoute());

                final userBox = Hive.box('users');
                if(userBox.get(0) == null){
                  showAlertDialog(context);
                }else{
                  //print("hello2");
                  checkUser();
                  //print("hello3");
                  Navigator.of(context).push(_createRoute());
                }

                //showAlertDialog(context);

                //print(File(oDB.dbPath).exists()),
                //print(oDB.dbPath.isEmpty),
                //Navigator.of(context).push(_createRoute())
               },
               // child: RotationTransition(
               //   turns: Tween(begin: 0.0, end: 1.0).animate(animationController!),
               //   child: Image.asset(
               //       'assets/images/ContinueButton.png',
               //       width: (1/8) * (MediaQuery.of(context).size.height),
               //       height: (1/7) * (MediaQuery.of(context).size.height)
               //   ),
               // ),
               child: ElevatedButton(
                 onPressed: () {},
                 child: Icon(Icons.fingerprint, size: (1/9) * (MediaQuery.of(context).size.height), color: Color.fromRGBO(
                     0, 0, 0, 1.0),),
                 style: ButtonStyle(
                   shape: MaterialStateProperty.all(CircleBorder()),
                   padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                   backgroundColor: MaterialStateProperty.all(Color.fromRGBO(
                       255, 255, 255, 1.0)), // <-- Button color
                   overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                     if (states.contains(MaterialState.pressed)) return Color.fromRGBO(
                         0, 0, 0, 1.0); // <-- Splash color
                   }),
                 ),
               )
             ),
               Column(
                 children:  [
                   Container(height: 10,),
                   Text('Hold to continue', style: TextStyle(color: Colors.white, fontFamily: 'Robotto', fontSize: 15, fontWeight: FontWeight.normal),),
                 ],
               )
               //const Text('Hold to continue', style: TextStyle(color: Colors.white, fontFamily: 'Robotto', fontSize: 15, fontWeight: FontWeight.bold),),//fontWeight: FontWeight.normal
               //const Text('Hold to continue', style: TextStyle(color: Colors.white, fontFamily: 'Robotto', fontSize: 15, fontWeight: FontWeight.normal),),//fontWeight: FontWeight.normal

             // ElevatedButton(
             //   style: ButtonStyle.,
             //   onPressed: () => {
             //     print("Hello")
             //   },
             //   child: const Text(
             //     "Click",
             //     style: TextStyle(
             //         color: Colors.white
             //     )
             //  ),
             // )
             //ElevatedButton(onPressed: () => {}, child: Text("Welcome")),
            ]
           ),

         )
         ],
        )
      )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

void giveUser(String name){
  // Hive.box('users').put(0, user);
  //Hive.box('users').values();
  String about = "You can enter your information about you here :)";
  String profilePath = "https://bestprofilepictures.com/wp-content/uploads/2021/05/Star-Wars-Profile-Picture.jpg";
  bool isDarkMode = false;
  final userBox = Hive.box('users');
  if(userBox.get(0) != null){
    about = userBox.get(0).about;
    profilePath = userBox.get(0).imagePath;
    isDarkMode = userBox.get(0).isDarkMode;
  }

  final currUser = User(name: name, about: about, imagePath: profilePath, isDarkMode: isDarkMode);
  userBox.put(0, currUser);


}

void changeIsDarkMode(bool boolean){
  String about = "You can enter your information about you here :)";
  String profilePath = "https://bestprofilepictures.com/wp-content/uploads/2021/05/Star-Wars-Profile-Picture.jpg";
  //final userBox = ;

  if(Hive.box('users').get(0).about != null){
    about = Hive.box('users').get(0).about;
  }

  if(Hive.box('users').get(0).imagePath != null){
    profilePath = Hive.box('users').get(0).imagePath;
  }

  final currUser = User(name: Hive.box('users').get(0).name, about: about, imagePath: profilePath, isDarkMode: boolean);
  Hive.box('users').put(0, currUser);
}

void checkUser(){
  String about = "You can enter your information about you here :)";
  bool isDarkMode = false;
  String profilePath = "https://bestprofilepictures.com/wp-content/uploads/2021/05/Star-Wars-Profile-Picture.jpg";
  //final userBox = ;

  if(Hive.box('users').get(0).about != null){
    about = Hive.box('users').get(0).about;
  }

  if(Hive.box('users').get(0).imagePath != null){
    profilePath = Hive.box('users').get(0).imagePath;
  }

  if(Hive.box('users').get(0).isDarkMode != null){
    isDarkMode = Hive.box('users').get(0).isDarkMode;
  }

  final currUser = User(name: Hive.box('users').get(0).name, about: about, imagePath: profilePath, isDarkMode: isDarkMode);
  Hive.box('users').put(0, currUser);

}

// void removeUser(){
//   final userBox = Hive.box('users');
//   userBox.clear();
// }

showAlertDialog(BuildContext context) {
  // Init
  TextEditingController controller = TextEditingController();

  AlertDialog dialog = AlertDialog(
    title: Text("Enter your name:"),
    actions: [
      TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          //hintText: 'Enter your name',
        ),
      ),
      ElevatedButton(
          child: Text("Enter"),
          onPressed: () {
            print(controller.text);

            giveUser(controller.text);
            Navigator.of(context).push(_createRoute());
          }
      ),
      // ElevatedButton(
      //     child: Text("Remove"),
      //     onPressed: () {
      //       removeUser();
      //     }
      // ),
    ],
  );
  showGeneralDialog(
    context: context,
    pageBuilder: (context, anim1, anim2) {return Wrap();},
    transitionBuilder: (context, anim1, anim2, child) {
      return Transform(
        transform: Matrix4.translationValues(
          0.0,
          (1.0-Curves.easeInOut.transform(anim1.value))*400,
          0.0,
        ),
        child: dialog,
      );
    },
    transitionDuration: Duration(milliseconds: 400),
  );
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => mainMenu(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      final tween = Tween(begin: begin, end: end);
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: curve,
      );

      return SlideTransition(
        position: tween.animate(curvedAnimation),
        child: child,
      );
    },
  );
}
