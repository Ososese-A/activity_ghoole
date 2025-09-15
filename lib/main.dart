import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_ghoole/models/activity.dart';
import 'package:project_ghoole/providers/activity_provider.dart';
import 'package:provider/provider.dart';
import 'package:project_ghoole/screens/activity_details_screen.dart';
import 'package:project_ghoole/screens/main_screen.dart';
import 'package:project_ghoole/screens/my_activities_screen.dart';
import 'package:project_ghoole/screens/new_activities_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);

  Hive.registerAdapter(ActivityAdapter());
  // await Hive.deleteBoxFromDisk('activities');
  // var box = await Hive.openBox<Activity>('activities');
  // var box = await Hive.openBo('work_time');
  // await box.clear();

  await Hive.openBox<Activity>('activities');
  await Hive.openBox('work_time');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ActivityProvider())
      ],
      child: const Ghoole(),
    )
  );
}

class Ghoole extends StatelessWidget {
  const Ghoole({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Raleway'),
      initialRoute: '/home',
      routes: {
        '/home': (context) => MainScreen(),
        '/activities': (context) => MyActivitiesScreen(),
        '/new': (context) => NewActivitiesScreen(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/details':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => ActivityDetailsScreen(
                activityId: args['id'],
                areThereOptions: args['options'],
              )
            );
          default: 
            return MaterialPageRoute(
              builder: (context) => MainScreen()
            );
        }
      },
    );
  }
}