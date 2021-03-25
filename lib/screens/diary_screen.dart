import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cloud_9_client/models/diary.dart';

import 'package:cloud_9_client/components/text-fields/date_text_field.dart';
import 'package:cloud_9_client/components/text-fields/label_text_field.dart';
import 'package:cloud_9_client/screens/weight_care_screen.dart';

import 'package:cloud_9_client/provider/weight_care_provider.dart';
import 'package:cloud_9_client/provider/auth_provider.dart';
import 'package:intl/intl.dart';

class DiaryScreen extends StatefulWidget {
  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _weightTextEditingController =
      TextEditingController();
  final TextEditingController _heightTextEditingController =
      TextEditingController();
  final TextEditingController _bmiTextEditingController =
      TextEditingController();
  final TextEditingController _waistTextEditingController =
      TextEditingController();
  final TextEditingController _bodyWatterTextEditingController =
      TextEditingController();
  final TextEditingController _bloodPressureTextEditingController =
      TextEditingController();

  final FocusNode _weightFocusNode = FocusNode();
  final FocusNode _heightFocusNode = FocusNode();
  final FocusNode _bmiFocusNode = FocusNode();
  final FocusNode _waistFocusNode = FocusNode();
  final FocusNode _bodyWatterFocusNode = FocusNode();
  final FocusNode _bloodPressureFocusNode = FocusNode();

  final _diaryFormKey = GlobalKey<FormState>();

  DateTime startingDate = DateTime.now();

  bool _isBusy = false;

  @override
  Widget build(BuildContext context) {
    final _weightCareProvider = Provider.of<WeightCareProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Diaries'),
      ),
      body: _weightCareProvider.diaries.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('You have no Diary'),
                  FlatButton(
                    onPressed: () => _showNewDiaryDialog(context),
                    child: Text('Create Diary',style: TextStyle(color: Theme.of(context).primaryColor),),
                  )
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                  children: _weightCareProvider.diaries
                      .map((Diary diary) => InkWell(
                            onTap: () {
                              _weightCareProvider.activeDiary = diary;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          WeightCareScreen()));
                            },
                            child: Card(
                              margin: EdgeInsets.all(8),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              elevation: 12,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                                'From: ${DateFormat('dd-MM-yyyy').format(diary.from)}')),
                                        Expanded(
                                            child: Text(
                                                'To: ${DateFormat('dd-MM-yyyy').format(diary.to)}')),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Expanded(
                                          child:
                                              Text('Weight: ${diary.weight}'),
                                        ),
                                        Expanded(
                                          child:
                                              Text('Height: ${diary.height}'),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text('BMI: ${diary.bmi}'),
                                        ),
                                        Expanded(
                                          child: Text('Waist: ${diary.waist}'),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                        'Body water and Fat composition: ${diary.bodyComposition}'),
                                    SizedBox(height: 8),
                                    Text(
                                        'Blood Pressure: ${diary.bloodPressure}')
                                  ],
                                ),
                              ),
                            ),
                          ))
                      .toList()),
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showNewDiaryDialog(context),
      ),
    );
  }

  Future<void> _showNewDiaryDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(10),
          // title: Text('Appointment Booked'),
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Card(
              child: Container(
                // color: Colors.white,
                padding: EdgeInsets.all(8),
                // decoration:
                //     new BoxDecoration(color: Theme.of(context).primaryColor),
                child: SingleChildScrollView(
                  child: Form(
                    key: _diaryFormKey,
                    child: Column(
                      children: [
                        AppBar(
                          title: Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text('New Diary'),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFieldDatePicker(
                          labelText: "Starting Date",
                          prefixIcon: Icon(Icons.date_range),
                          suffixIcon: Icon(Icons.arrow_drop_down),
                          lastDate: DateTime.now().add(Duration(days: 45)),
                          firstDate: DateTime.now(),
                          initialDate: DateTime.now().add(Duration(days: 1)),
                          onDateChanged: (selectedDate) {
                            startingDate = selectedDate;
                            FocusScope.of(context).requestFocus(_weightFocusNode);
                          },
                        ),
                        SizedBox(height: 8),
                        LabelTextfield(
                          focusNode: _weightFocusNode,
                          hitText: "Eg. 55",
                          keyboardType: TextInputType.number,
                          labelText: "Weight (Kg)",
                          maxLines: 1,
                          message: null,
                          textEditingController: _weightTextEditingController,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () {
                            _weightFocusNode.unfocus();
                            FocusScope.of(context).requestFocus(_heightFocusNode);
                          },
                          validator: (input){
                            if(input.isEmpty) return "Please tell us your weight";

                            return null;
                          },
                        ),
                        SizedBox(height: 8),
                        LabelTextfield(
                          focusNode: _heightFocusNode,
                          hitText: "Eg. 167",
                          keyboardType: TextInputType.number,
                          labelText: "Height (cm)",
                          maxLines: 1,
                          message: null,
                          validator: (input){
                            if(input.isEmpty)
                              return 'Please fill your height';
                            return null;
                          },
                          textEditingController: _heightTextEditingController,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () {
                            _heightFocusNode.unfocus();
                            FocusScope.of(context).requestFocus(_bmiFocusNode);
                          },
                        ),
                        SizedBox(height: 8),
                        LabelTextfield(
                          focusNode: _bmiFocusNode,
                          hitText: "Eg 27",
                          keyboardType: TextInputType.number,
                          labelText: "Body to Mass Ratio",
                          maxLines: 1,
                          message: null,
                          validator: (input){
                            if(input.isEmpty) return "The BMI is required";
                            if(double.parse(input) < 15 || double.parse(input) > 35)
                              return "Please enter valid BMI value";
                            return null;
                          },
                          textEditingController: _bmiTextEditingController,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () {
                            _bmiFocusNode.unfocus();
                            FocusScope.of(context).requestFocus(_waistFocusNode);
                          },
                        ),
                        SizedBox(height: 8),
                        LabelTextfield(
                            focusNode: _waistFocusNode,
                            hitText: "Eg. 37",
                            keyboardType: TextInputType.number,
                            labelText: "Waist Circumference (cm)",
                            maxLines: 1,
                            validator: (input){
                              if(input.isEmpty) return "Waist circumference is required";
                              if(double.parse(input) < 10)
                                return "Waist circumference is invalid";
                              return null;
                            },
                            message: null,
                            textEditingController: _waistTextEditingController,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () {
                              _waistFocusNode.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(_bodyWatterFocusNode);
                            }),
                        SizedBox(height: 8),
                        LabelTextfield(
                            focusNode: _bodyWatterFocusNode,
                            hitText: "",
                            keyboardType: TextInputType.number,
                            labelText: "Body Water and Fat composition (%)",
                            maxLines: 1,
                            message: null,
                            validator: (input){
                              if(input.isEmpty) return "Please fill your body composition";
                              if(double.parse(input) < 0 || double.parse(input) > 100)
                                return "Invalid body composition";
                              return null;
                            },
                            textEditingController:
                                _bodyWatterTextEditingController,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () {
                              _bodyWatterFocusNode.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(_bloodPressureFocusNode);
                            }),
                        SizedBox(height: 8),
                        LabelTextfield(
                          focusNode: _bloodPressureFocusNode,
                          hitText: "",
                          keyboardType: TextInputType.number,
                          labelText: "Blood Pressure (mmHG)",
                          maxLines: 1,
                          message: null,
                          validator: (input){
                            if(input.isEmpty) return "Please fill your blood pressure";
                            return null;
                          },
                          textEditingController:
                              _bloodPressureTextEditingController,
                          textInputAction: TextInputAction.send,
                          onEditingComplete: (){
                            FocusScope.of(context).unfocus();
                            postDiary(setState);
                            } ,
                        ),
                        SizedBox(height: 16),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          child:
                          _isBusy
                              ? Padding(
                            padding:
                            const EdgeInsets.all(4.0),
                            child: CircularProgressIndicator(
                                backgroundColor:
                                Colors.white),
                          ) : Text('Add'),
                          color: Colors.blue,
                          onPressed: () => postDiary(setState),
                          textColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                        ),
                        SizedBox(height: 8)
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  void postDiary(StateSetter setState) {
    final _weightCareProvider =
        Provider.of<WeightCareProvider>(context, listen: false);
    final _authProvider = Provider.of<AuthProvider>(context, listen: false);

    if (_diaryFormKey.currentState.validate()) {

      setState((){
        _isBusy = true;
      });

      _weightCareProvider
          .postDiary(
          userId: _authProvider.authenticatedUser.id,
          from: startingDate,
          to: startingDate.add(Duration(days: 30)),
          initialWeight: double.parse(_weightTextEditingController.text),
          initialHeight: double.parse(_heightTextEditingController.text),
          initialBMI: double.parse(_bmiTextEditingController.text),
          initialWaistCircumference:
          double.parse(_waistTextEditingController.text),
          bodyFatAndWaterComposition:
          double.parse(_bodyWatterTextEditingController.text),
          bloodPressure:
          double.parse(_bloodPressureTextEditingController.text))
          .then((response) {
        setState((){
          _isBusy = false;
        });
        if (response['status']) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => WeightCareScreen()));
        }
        else {
          Navigator.of(context).pop();
          showInSnackBar(message: response['message'],
              context: context,
              color: Colors.red);
        }
      });

    }
  }

  void showInSnackBar(
      {@required String message, @required BuildContext context, Color color}) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        message,
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
}
