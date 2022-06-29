import 'package:flutter/material.dart';
import 'package:scrollable_clean_calendar/controllers/clean_calendar_controller.dart';
import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
import 'package:scrollable_clean_calendar/utils/enums.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

   final CleanCalendarController calendarController = CleanCalendarController(
    minDate: DateTime.now(),
    maxDate: DateTime.now().add(const Duration(days: 100)),
    showRefresh: true,
    onRangeSelected: (firstDate, secondDate) {},
    onDayTapped: (date) {},
    // readOnly: true,
    onPreviousMinDateTapped: (date) {},
    onAfterMaxDateTapped: (date) {},
    weekdayStart: DateTime.monday,

    // initialDateSelected: DateTime(2022, 3, 15),
    // endDateSelected: DateTime.now(),
  );

   final Counter _counter = Counter();


   @override
  void initState() {
     calendarController.onLoad = () async {
      await Future.delayed(Duration(seconds: 2), () {
        calendarController.updateMonths(endDate: calendarController.maxDate.add(const Duration(days: 365)));
      });
    };
     calendarController.onRefresh = () async {
       await Future.delayed(Duration(seconds: 2), () {
         calendarController.resetMonths(endDate: DateTime.now().add(const Duration(days: 100)));
       });
     };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // return MaterialApp(
    //   title: 'Material App',
    //   home: Scaffold(
    //     appBar: AppBar(
    //       title: Text('Material App Bar'),
    //     ),
    //     body: Center(
    //       child: Container(
    //         child: RaisedButton(
    //             onPressed: (){
    //               _counter.addCount();
    //             },
    //             child: Text('计数:${_counter.count}'),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    return MaterialApp(
      title: 'Scrollable Clean Calendar',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          primary: Color(0xFF3F51B5),
          primaryVariant: Color(0xFF002984),
          secondary: Color(0xFFD32F2F),
          secondaryVariant: Color(0xFF9A0007),
          surface: Color(0xFFDEE2E6),
          background: Color(0xFFF8F9FA),
          error: Color(0xFF96031A),
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.black,
          onBackground: Colors.black,
          onError: Colors.white,
          brightness: Brightness.light,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Scrollable Clean Calendar'),
          actions: [
            IconButton(
              onPressed: () {
                calendarController.clearSelectedDates();
              },
              icon: const Icon(Icons.clear),
            )
          ],
        ),
        body: ScrollableCleanCalendar(
          calendarController: calendarController,
          layout: Layout.BEAUTY,
          locale: "zh",
          calendarCrossAxisSpacing: 0,
        ),
      ),
    );
  }
}


class Counter extends ChangeNotifier{
  int _count = 0;//数值计算

  int get count => _count;

  addCount(){
    _count++;
    notifyListeners();

  }

}
