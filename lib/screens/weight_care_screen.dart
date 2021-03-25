import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';

import 'package:cloud_9_client/components/text-fields/label_text_field.dart';
import 'package:cloud_9_client/components/text-fields/labelledText.dart';
import 'package:cloud_9_client/components/card/meal_card.dart';
import 'package:cloud_9_client/components/card/activity_card.dart';
import 'package:cloud_9_client/screens/diary_screen.dart';

import 'package:cloud_9_client/provider/weight_care_provider.dart';
import 'package:intl/intl.dart' as intl;

class WeightCareScreen extends StatefulWidget {
  @override
  _WeightCareScreenState createState() => _WeightCareScreenState();
}

class _WeightCareScreenState extends State<WeightCareScreen>
    with SingleTickerProviderStateMixin {
  bool _isBusssy = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TabController _controller;
  final TextEditingController _timeTextEditingController =
      TextEditingController();
  final TextEditingController _carbohydratesTextEditingController =
      TextEditingController();
  final TextEditingController _proteinsTextEditingController =
      TextEditingController();
  final TextEditingController _vegetablesTextEditingController =
      TextEditingController();
  final TextEditingController _fruitsTextEditingController =
      TextEditingController();
  final TextEditingController _otherFoodsTextEditingController =
      TextEditingController();

  final TextEditingController _activityTextEditingController =
      TextEditingController();
  final TextEditingController _activityTimeTextEditingController =
      TextEditingController();
  final TextEditingController _activityDurationTextEditingController =
      TextEditingController();

  final FocusNode _timeFocusNode = FocusNode();
  final FocusNode _carbohydratesFocusNode = FocusNode();
  final FocusNode _proteinsFocusNode = FocusNode();
  final FocusNode _vegetablesFocusNode = FocusNode();
  final FocusNode _fruitsFocusNode = FocusNode();
  final FocusNode _otherFoodsFocusNode = FocusNode();

  final FocusNode _activityFocusNode = FocusNode();
  final FocusNode _activityTimeFocusNode = FocusNode();
  final FocusNode _activityDurationFocusNode = FocusNode();
  final FocusNode _mealTypeFocusNode = FocusNode();
  final FocusNode _activityDurationUnitFocusNode = FocusNode();

  List<String> _meals = ['Pick Meal', 'Breakfast', 'Lunch', 'Dinner', 'Other'];
  String _selectedMeal = 'Pick Meal';

  List<String> _durationUnits = ['Seconds', 'Minutes', 'Hours'];
  String _activityDurationUnit = 'Minutes';
  TimeOfDay _time, _activityTime;
  DateTime _pickedDate;

  @override
  void initState() {
    _controller = new TabController(length: 2, vsync: this);
    _pickedDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    super.initState();
  }

  final List<String> options = [
    'My Diaries',
    // 'About Weigh Care Diary',
    // 'Usage'
  ];

  void onOptionSelected(String selected) {
    switch (selected) {
      case 'My Diaries':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DiaryScreen()));
        break;
      case 'About Weigh Care Diary':
        break;
      case 'Usage':
        break;
    }
  }



  @override
  Widget build(BuildContext context) {
    final _weightCareProvider = Provider.of<WeightCareProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Weight Care Manual'),
        actions: [
          PopupMenuButton<String>(
            onSelected: onOptionSelected,
            itemBuilder: (BuildContext context) {
              return options.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Container(
          child: Row(mainAxisSize: MainAxisSize.max, children: [
        SingleChildScrollView(
          child: Container(
            color: Colors.blue,
            child: StickyHeader(
              header: Text(
                ' day | date    ',
                style: TextStyle(
                  backgroundColor: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Column(
                children: indicators(),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: StickyHeader(
                header: Container(
                  color: Colors.white,
                  child: ListTile(
                    title: Text(
                        '${_weightCareProvider.activeDiary.from.day.toString().padLeft(2, '0')}/'
                        '${_weightCareProvider.activeDiary.from.month.toString().padLeft(2, '0')}/'
                        '${_weightCareProvider.activeDiary.from.year.toString().padLeft(4, '0')}'
                        ' - '
                        '${_weightCareProvider.activeDiary.to.day.toString().padLeft(2, '0')}/'
                        '${_weightCareProvider.activeDiary.to.month.toString().padLeft(2, '0')}/'
                        '${_weightCareProvider.activeDiary.to.year.toString().padLeft(4, '0')}'),
                    subtitle: Text(
                        'Date: ${_pickedDate.day.toString().padLeft(2, '0')}/${_pickedDate.month.toString().padLeft(2, '0')}/${_pickedDate.year}'),
                  ),
                ),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Meals'),
                        ),
                        Divider(),
                      ] +
                      _mealCards(_weightCareProvider) +
                      [
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Physical Activities'),
                        ),
                        Divider(),
                      ] +
                      _activitiesCard(_weightCareProvider) +
                      [
                        SizedBox(
                          height: 72,
                        )
                      ],
                ),
              ),
            ),
          ),
        )
      ])),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showNewActivityDialog(context);
        },
      ),
    );
  }

  List<Widget> indicators() {
    final _weightCareProvider =
        Provider.of<WeightCareProvider>(context, listen: false);
    List<Widget> indicators = [];

    // DateTime _theDate = _weightCareProvider.activeDiary.from;
    List<DateTime> dateTime = [];
    dateTime.clear();

    for (DateTime dateTime = _weightCareProvider.activeDiary.from;
        dateTime.isBefore(_weightCareProvider.activeDiary.to);
        dateTime = dateTime.add(Duration(days: 1))) {
      indicators.add(InkWell(
        onTap: () {
          if (dateTime.isBefore(DateTime.now())) {
            setState(() {
              _pickedDate = dateTime;
            });
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
          color: dateTime.isAfter(DateTime.now())
              ? Colors.blueGrey
              : dateTime == _pickedDate
                  ? Theme.of(context).primaryColor
                  : Colors.white,
          child: Text(
            ' ${(1 + dateTime.difference(_weightCareProvider.activeDiary.from).inDays).toString().padLeft(2, '0')} ' +
                ' ${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}',
            style: TextStyle(
                color: dateTime.isBefore(_pickedDate)
                    ? Colors.black
                    : (dateTime == _pickedDate ? Colors.white : Colors.black)),
          ),
        ),
      ));
    }

    return indicators;
  }

  List<Widget> _mealCards(WeightCareProvider _weighCareProvider) {
    List<Widget> content = [];
    content.clear();
    if(_weighCareProvider.activeDiary.meals.isEmpty)
      return [];
    _weighCareProvider.activeDiary.meals
        .where((meal) => meal.date == _pickedDate)
        .forEach((meal) {
      content.add(
        MealCard(
          meal: meal.type,
          carbohydrates: meal.carbohydrates,
          proteins: meal.proteins,
          vegetables: meal.vegetables,
          fruits: meal.fruits,
          other: meal.others,
        ),
      );
    });

    return content;
  }

  List<Widget> _activitiesCard(WeightCareProvider weightCareProvider) {
    List<Widget> content = [];
    content.clear();
    if(weightCareProvider.activeDiary.activities.isEmpty)
      return [];
    weightCareProvider.activeDiary.activities
        .where((activity) => activity.date == _pickedDate)
        .forEach((activity) {
      content.add(ActivityCard(activity: activity));
    });
    return content;
  }

  Future<void> _showNewActivityDialog(BuildContext context) async {
    _time = TimeOfDay.now();
    _activityTime = TimeOfDay.now();
    _timeTextEditingController.text = _time.format(context);
    _activityTimeTextEditingController.text = _activityTime.format(context);
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        DateTime dateTime = _pickedDate;

        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(10),
          // title: Text('Appointment Booked'),
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              // color: Colors.white,
              padding: EdgeInsets.all(8),
              // decoration:
              //     new BoxDecoration(color: Theme.of(context).primaryColor),
              child: Column(
                children: [
                  AppBar(
                    title: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text('New Entry'),
                    ),
                    flexibleSpace: Padding(
                      padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year.toString().padLeft(4, '0')}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.blue,
                    child: TabBar(
                      controller: _controller,
                      tabs: [
                        Tab(
                          icon: const Icon(Icons.fastfood),
                          text: 'Meal',
                        ),
                        Tab(
                          icon: const Icon(Icons.access_time),
                          text: 'Physical Activity',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _controller,
                      children: <Widget>[
                        Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    LabelTextfield(
                                      focusNode: _timeFocusNode,
                                      hitText: "",
                                      keyboardType: TextInputType.text,
                                      labelText: "Meal Time",
                                      maxLines: 1,
                                      message: null,
                                      textEditingController:
                                          _timeTextEditingController,
                                      readOnly: true,
                                      onEditingComplete: () {
                                        _timeFocusNode.unfocus();
                                        FocusScope.of(context)
                                            .requestFocus(_mealTypeFocusNode);
                                      },
                                      textInputAction: TextInputAction.next,
                                      onTap: () {
                                        timePicker().then((value) {
                                          setState(() {
                                            _time = value;
                                            _timeTextEditingController.text =
                                                value.format(context);
                                            // '${_time.hour.toString().padLeft(2, '0')}:${_time.minute.toString().padLeft(2, '0')}';
                                          });
                                        });
                                      },
                                    ),

                                    ListTile(
                                      title: Text('Meal'),
                                      subtitle: DropdownButton(
                                        isExpanded: true,
                                        focusNode: _mealTypeFocusNode,
                                        value: _selectedMeal,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            _selectedMeal = newValue;
                                          });
                                          _mealTypeFocusNode.unfocus();
                                          FocusScope.of(context).requestFocus(
                                              _carbohydratesFocusNode);
                                        },
                                        items: _meals
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              overflow: TextOverflow.fade,
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    LabelTextfield(
                                      focusNode: _carbohydratesFocusNode,
                                      hitText: "Eg. 1 plate",
                                      keyboardType: TextInputType.text,
                                      labelText: "Carbohydrates",
                                      maxLines: 1,
                                      message: null,
                                      textEditingController:
                                          _carbohydratesTextEditingController,
                                      textInputAction: TextInputAction.next,
                                      onEditingComplete: () {
                                        _carbohydratesFocusNode.unfocus();
                                        FocusScope.of(context)
                                            .requestFocus(_proteinsFocusNode);
                                      },
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    LabelTextfield(
                                      focusNode: _proteinsFocusNode,
                                      hitText: "",
                                      keyboardType: TextInputType.text,
                                      labelText: "Proteins",
                                      maxLines: 1,
                                      message: null,
                                      textEditingController:
                                          _proteinsTextEditingController,
                                      textInputAction: TextInputAction.next,
                                      onEditingComplete: () {
                                        _proteinsFocusNode.unfocus();
                                        FocusScope.of(context)
                                            .requestFocus(_vegetablesFocusNode);
                                      },
                                    ),
                                    // TextField(
                                    //   decoration:
                                    //       InputDecoration(labelText: 'Proteins'),
                                    // ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    LabelTextfield(
                                        focusNode: _vegetablesFocusNode,
                                        hitText: "",
                                        keyboardType: TextInputType.text,
                                        labelText: "Vegetables",
                                        maxLines: 1,
                                        message: null,
                                        textEditingController:
                                            _vegetablesTextEditingController,
                                        textInputAction: TextInputAction.next,
                                        onEditingComplete: () {
                                          _vegetablesFocusNode.unfocus();
                                          FocusScope.of(context)
                                              .requestFocus(_fruitsFocusNode);
                                        }),

                                    SizedBox(
                                      height: 8,
                                    ),
                                    LabelTextfield(
                                        focusNode: _fruitsFocusNode,
                                        hitText: "",
                                        keyboardType: TextInputType.text,
                                        labelText: "Fruits",
                                        maxLines: 1,
                                        message: null,
                                        textEditingController:
                                            _fruitsTextEditingController,
                                        textInputAction: TextInputAction.next,
                                        onEditingComplete: () {
                                          _fruitsFocusNode.unfocus();
                                          FocusScope.of(context).requestFocus(
                                              _otherFoodsFocusNode);
                                        }),

                                    SizedBox(
                                      height: 8,
                                    ),
                                    LabelTextfield(
                                        focusNode: _otherFoodsFocusNode,
                                        hitText: "",
                                        keyboardType: TextInputType.text,
                                        labelText: "Other Foods",
                                        maxLines: 1,
                                        message: null,
                                        textEditingController:
                                            _otherFoodsTextEditingController,
                                        textInputAction: TextInputAction.send,
                                        onEditingComplete: () {
                                          FocusScope.of(context).unfocus();
                                          _postMeal(setState);
                                        }),

                                    SizedBox(
                                      height: 12,
                                    ),
                                    RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      child: _isBusssy
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: CircularProgressIndicator(
                                                  backgroundColor:
                                                      Colors.white),
                                            )
                                          : Text('Add'),
                                      color: Colors.blue,
                                      onPressed: () => _postMeal(setState),
                                      textColor: Colors.white,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          color: Colors.white,
                          child: Center(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  LabelTextfield(
                                    focusNode: _activityFocusNode,
                                    hitText: "",
                                    keyboardType: TextInputType.text,
                                    labelText: "Activity",
                                    maxLines: 1,
                                    message: null,
                                    textEditingController:
                                        _activityTextEditingController,
                                    textInputAction: TextInputAction.next,
                                    onEditingComplete: () {
                                      _activityFocusNode.unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(_activityTimeFocusNode);
                                    },
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  LabelTextfield(
                                    focusNode: _activityTimeFocusNode,
                                    hitText: "",
                                    keyboardType: TextInputType.text,
                                    labelText: "Time",
                                    maxLines: 1,
                                    message: null,
                                    textInputAction: TextInputAction.next,
                                    textEditingController:
                                        _activityTimeTextEditingController,
                                    readOnly: true,
                                    onTap: () {
                                      timePicker().then((value) {
                                        setState(() {
                                          _activityTime = value;
                                          _activityTimeTextEditingController
                                                  .text =
                                              '${_activityTime.hour.toString().padLeft(2, '0')}:${_activityTime.minute.toString().padLeft(2, '0')}';
                                        });
                                        _activityTimeFocusNode.requestFocus();
                                        FocusScope.of(context).requestFocus(
                                            _activityDurationFocusNode);
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: LabelTextfield(
                                          focusNode: _activityDurationFocusNode,
                                          hitText: "",
                                          keyboardType: TextInputType.number,
                                          labelText: "Duration",
                                          maxLines: 1,
                                          message: null,
                                          textEditingController:
                                              _activityDurationTextEditingController,
                                          textInputAction: TextInputAction.next,
                                          onEditingComplete: () {
                                            _activityDurationFocusNode
                                                .unfocus();
                                            FocusScope.of(context).requestFocus(
                                                _activityDurationUnitFocusNode);
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Expanded(
                                        child: DropdownButton(
                                          isExpanded: true,
                                          value: _activityDurationUnit,
                                          focusNode:
                                              _activityDurationUnitFocusNode,
                                          onChanged: (String newValue) {
                                            setState(() {
                                              _activityDurationUnit = newValue;
                                            });
                                            FocusScope.of(context).unfocus();
                                          },
                                          items: _durationUnits
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                overflow: TextOverflow.fade,
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: _isBusssy
                                        ? Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: CircularProgressIndicator(
                                              backgroundColor: Colors.white,
                                            ),
                                          )
                                        : Text('Add'),
                                    color: Colors.blue,
                                    onPressed: () =>
                                        _postPhysicalActivity(setState),
                                    textColor: Colors.white,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }

  Future<TimeOfDay> timePicker() async {
    Future<TimeOfDay> selectedTimeRTL = showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child,
        );
      },
    );

    // selectedTimeRTL.then((value) {
    //   _time = value;
    // });
    return await selectedTimeRTL;
  }

  void showInSnackBar(
      {@required String value, @required BuildContext context, Color color}) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: color == null ? Colors.green : color,
      duration: Duration(seconds: 3),
    ));
  }

  void _postMeal(StateSetter setState) {
    if (_selectedMeal == 'Pick Meal') {
      setState(() {
        _isBusssy = false;
      });
      Navigator.of(context).pop();
      showInSnackBar(
          value: 'Please select Meal Type',
          context: context,
          color: Colors.red);
      return;
    }
    final _weightCareProvider =
        Provider.of<WeightCareProvider>(context, listen: false);

    setState(() {
      _isBusssy = true;
    });
    _weightCareProvider
        .postMeal(
      date: _pickedDate,
      time: _time,
      type: _selectedMeal,
      carbohydrate: _carbohydratesTextEditingController.text,
      proteins: _proteinsTextEditingController.text,
      vegetables: _vegetablesTextEditingController.text,
      fruits: _fruitsTextEditingController.text,
      others: _otherFoodsTextEditingController.text,
    )
        .then((response) {
      setState(() {
        _isBusssy = false;
      });
      Navigator.of(context).pop();
      if (response['status']) {
        _selectedMeal = 'Pick Meal';
        _carbohydratesTextEditingController.text = "";
        _proteinsTextEditingController.text = "";
        _vegetablesTextEditingController.text = "";
        _fruitsTextEditingController.text = "";
        _otherFoodsTextEditingController.text = "";
      } else {
        showInSnackBar(
            value: response['message'], context: context, color: Colors.red);
      }
    });
  }

  void _postPhysicalActivity(StateSetter setState) {
    final _weightCareProvider =
        Provider.of<WeightCareProvider>(context, listen: false);

    setState(() {
      _isBusssy = true;
    });
    _weightCareProvider
        .postPhysicalActivity(
            date: _pickedDate,
            time: _activityTime,
            activity: _activityTextEditingController.text,
            duration:
                '${_activityDurationTextEditingController.text} $_activityDurationUnit')
        .then((response) {
      setState(() {
        _isBusssy = false;
      });
      Navigator.of(context).pop();
      if (response['status']) {
        _activityTextEditingController.text = "";
        _activityDurationTextEditingController.text = "";
        _activityDurationUnit = 'Minutes';
      } else {
        showInSnackBar(
            value: response['message'], context: context, color: Colors.red);
      }
    });
  }
}
