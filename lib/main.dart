import 'package:flutter/material.dart';
import 'package:habit_tracker/providers/streams.dart';
import 'package:habit_tracker/screens/bad_habits/relapse_history.dart';
import 'package:habit_tracker/screens/countdown_screen.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pp;

import 'package:habit_tracker/providers/auth.dart';
import 'package:habit_tracker/providers/habits.dart';
import 'package:habit_tracker/screens/categories_screen.dart';
import 'package:habit_tracker/screens/edit_good_habit_screen.dart';
import 'package:habit_tracker/screens/edit_bad_habit_screen.dart';
import 'package:habit_tracker/screens/filters_screen.dart';
import 'package:habit_tracker/screens/tabs_screen.dart';
import 'models/badHabit.dart';
import 'models/event.dart';
import 'models/eventSource.dart';
import 'models/goodHabit.dart';
import 'screens/menu_habit_details_screen.dart';
import './screens/category_habits_screen.dart';
import 'screens/myBadHabitDetailScreen.dart';
import 'screens/myGoodHabitDetailScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await pp.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(GoodHabitAdapter());
  Hive.registerAdapter(BadHabitAdapter());
  Hive.registerAdapter(EventSourceAdapter());
  Hive.registerAdapter(EventAdapter());
  runApp(MyApp());
}

// splash screen activate command:
// flutter pub run flutter_native_splash:create --path=C:\Users\Jami\AndroidStudioProjects\habit_tracker\lib\flutter_native_splash.yaml

// Disable landscape mode (rotation)
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Habits>(
          create: (ctx) => Habits(),
          update: (ctx, auth, prevHabits) => Habits()
            ..updateTokenAndGoodHabit(auth.token, prevHabits!.goodHabits),
        ),
        ChangeNotifierProvider.value(
          value: Streams(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Habit Tracker',
          theme: ThemeData(
            // primarySwatch: Colors.blueGrey,
            // accentColor: Colors.amber,
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Colors.brown,
              secondary: Colors.teal.shade300,
            ),
            canvasColor: Color.fromRGBO(255, 254, 229, 1),
            fontFamily: 'Raleway',
            textTheme: ThemeData.light().textTheme.copyWith(
                  bodyText1: TextStyle(
                    color: Color.fromRGBO(20, 51, 51, 1),
                  ),
                  bodyText2: TextStyle(
                    color: Color.fromRGBO(20, 51, 51, 1),
                  ),
                  headline6: TextStyle(
                    fontFamily: 'RobotoCondensed',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  button: TextStyle(color: Colors.white),
                ),
            appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                    headline6: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            ),
          ),
          // home: auth.isAuthenticated
          //     ? TabsScreen()
          //     : FutureBuilder(
          //         future: auth.tryAutoLogin(),
          //         builder: (ctx, authResultSnapshot) =>
          //             authResultSnapshot.connectionState ==
          //                     ConnectionState.waiting
          //                 ? SplashScreen()
          //                 : AuthScreen(),
          //       ),
          home: TabsScreen(),

          routes: {
            // '/': (ctx) => TabsScreen(),
            // '/home': (ctx) => TabsScreen(),
            CategoriesScreen.routeName: (ctx) => CategoriesScreen(),
            CategoryHabitsScreen.routeName: (ctx) => CategoryHabitsScreen(),
            MenuHabitDetailsScreen.routeName: (ctx) => MenuHabitDetailsScreen(),
            MyGoodHabitDetailScreen.routeName: (ctx) =>
                MyGoodHabitDetailScreen(),
            MyBadHabitDetailScreen.routeName: (ctx) => MyBadHabitDetailScreen(),
            EditGoodHabitScreen.routeName: (ctx) => EditGoodHabitScreen(),
            EditBadHabitScreen.routeName: (ctx) => EditBadHabitScreen(),
            FilterScreen.routeName: (ctx) => FilterScreen(),
            CountDownScreen.routeName: (ctx) => CountDownScreen(),
            RelapseHistory.routeName: (ctx) => RelapseHistory(),
            // StatisticsScreen.routeName: (ctx) => StatisticsScreen(),
          },
          // onGenerateRoute: (settings) {
          //   print(settings.arguments);
          //   return MaterialPageRoute(builder: (ctx) => CategoriesScreen(),);
          // },
          // onUnknownRoute: (settings) {
          //   return MaterialPageRoute(
          //     builder: (ctx) => CategoriesScreen(),
          //   );
          // },
        ),
      ),
    );
  }
}
