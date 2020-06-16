import 'dart:async';

import 'package:flutter/material.dart';
import 'package:syana/Controller/SaleController.dart';
import 'package:syana/models/TraceModel.dart';
import 'package:syana/screens/trace/SyanaTraceInput.dart';
import 'package:syana/utils/AppTheme.dart';
import '../../main.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;

class SyanaHomeTrace extends StatefulWidget {
  @override
  SyanaHomeTraceState createState() => SyanaHomeTraceState();
}

class SyanaHomeTraceState extends State<SyanaHomeTrace> {
  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();
//  List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];
  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
      color: Colors.white,
    ),
    child: new Icon(
      Icons.assignment,
      color: AppTheme.green,
    ),
  );

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {
      new DateTime(2019, 2, 10): [
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 1',
          icon: _eventIcon,
          dot: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            color: Colors.red,
            height: 5.0,
            width: 5.0,
          ),
        ),
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 2',
          icon: _eventIcon,
        ),
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 3',
          icon: _eventIcon,
        ),
      ],
    },
  );

  CalendarCarousel _calendarCarousel, _calendarCarouselNoHeader;

  // Variables
  SaleController _saleController;
  bool _isLoading = false;
  List<TraceModel> traceLists = new List();
  List<Event> eventList;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  DateTime _currentDateNow =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  int totalTraces = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _saleController = new SaleController();
    initDataTrace();
  }

  // API Implement

  initDataTrace() async {
    setLoadingState();
    await _saleController.getTraceListData(context, setLoadingState, setData);
    print("list length : " + traceLists.length.toString());
    setLoadingState();
  }

  void setLoadingState() {
    setState(() {
      _isLoading = _isLoading ? _isLoading = false : _isLoading = true;
    });
  }

  setData(data) {
    if (data is List<TraceModel> && data.isNotEmpty) {
      setState(() {
        traceLists = data;
        for (int i = 0; i < traceLists.length; i++) {
          String date = traceLists[i].traceDate;
          String trace = traceLists[i].trace;
          String productName = traceLists[i].productName;
          String teamName = traceLists[i].teamName;
          String employeeName = traceLists[i].employeeName;
          DateTime dateTrace = dateFormat.parse(date);

          _markedDateMap.add(
              dateTrace,
              Event(
                date: dateTrace,
                title: productName == "no data"
                    ? trace + "|" + teamName + "|" + employeeName
                    : trace + "|" + productName + "|" + employeeName,
                icon: _eventIcon,
                dot: Container(
                  margin: EdgeInsets.symmetric(horizontal: 1.0),
                  color: Colors.red,
                  height: 5.0,
                  width: 5.0,
                ),
              ));
        }
        eventList = _markedDateMap.getEvents(_currentDateNow);
        _currentDate2 = _targetDateTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    /// Example Calendar Carousel without header and custom prev & next button
    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Colors.green,
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() {
          _currentDate2 = date;
          totalTraces = events.length;
          eventList = events;
        });
        events.forEach((event) => print(event.title));
      },
      daysHaveCircularBorder: false,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
//      firstDayOfWeek: 4,
      markedDatesMap: _markedDateMap,
      height: 320.0,
      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
//      markedDateCustomShapeBorder: CircleBorder(
//          side: BorderSide(color: Colors.transparent)
//      ),
      markedDateCustomTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.blue,
      ),
      showHeader: false,
      todayTextStyle: TextStyle(
        color: Colors.blue,
      ),
      markedDateShowIcon: true,
      markedDateIconMaxShown: 1,
      markedDateIconBuilder: (event) {
        return event.icon;
      },
      markedDateMoreShowTotal: true,
      todayButtonColor: Colors.yellow,
      selectedDayTextStyle: TextStyle(
        color: Colors.yellow,
      ),
      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      prevDaysTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
      inactiveDaysTextStyle: TextStyle(
        color: Colors.tealAccent,
        fontSize: 16,
      ),
      onCalendarChanged: (DateTime date) {
        this.setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );

    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.lightGreen[200],
          title: new Text("Syana HQ"),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: AppTheme.yellow,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return SyanaHomeTraceInput(
                      date: _currentDate2,
                    );
                  },
                ),
              );
            }),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    //custom icon without header
                    Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.only(bottom: 5),
                      color: AppTheme.teal[200],
                      child: new Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.chevron_left,
                              color: AppTheme.text_light,
                            ),
                            onPressed: () {
                              setState(() {
                                _targetDateTime = DateTime(_targetDateTime.year,
                                    _targetDateTime.month - 1);
                                _currentMonth =
                                    DateFormat.yMMM().format(_targetDateTime);
                              });
                            },
                          ),
                          Expanded(
                              child: Text(
                            _currentMonth,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20.0, color: AppTheme.text_light),
                          )),
                          IconButton(
                            icon: Icon(Icons.chevron_right,
                                color: AppTheme.text_light),
                            onPressed: () {
                              setState(() {
                                _targetDateTime = DateTime(_targetDateTime.year,
                                    _targetDateTime.month + 1);
                                _currentMonth =
                                    DateFormat.yMMM().format(_targetDateTime);
                              });
                            },
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.0),
                      child: _calendarCarouselNoHeader,
                    ), //
                    eventList != null
                        ? ListView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: eventList.length,
                            itemBuilder: (context, position) {
                              return cardToday(position);
                            })
                        : Container(
                            width: double.infinity,
                            child: Text(
                              'Tidak ada catatan',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black26),
                            ),
                          ),
                  ],
                ),
              ));
  }

  Widget cardToday(int position) {
    List<String> split_title = new List();
    split_title = eventList[position].getTitle().split('|');
    return Card(
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                // align the text to the left instead of centered
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        split_title[0],
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 18,
                      ),
                      Expanded(
                        child: Text(
                          split_title[1],
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 18,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            split_title[2],
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
