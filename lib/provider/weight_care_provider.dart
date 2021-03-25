import 'dart:async';
import 'dart:io';
import 'dart:developer';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:cloud_9_client/api/api.dart';
import 'package:cloud_9_client/models/diary.dart';
import 'package:cloud_9_client/models/meal.dart';
import 'package:cloud_9_client/models/physical_activity.dart';

class WeightCareProvider with ChangeNotifier {
  final List<Diary> diaries = [];
  Diary activeDiary;

  Future<Map<String, dynamic>> fetchDiaries(int userId) async {
    try {
      http.Response response = await http.get('${api}diaries/$userId').timeout(Duration(seconds: 45));
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status']) {
        diaries.clear();
        responseData['diaries'].forEach((diaryMap) {
          final List<Meal> _diaryMeals = [];
          _diaryMeals.clear();
          diaryMap['meals'].forEach((meal) {
            _diaryMeals.add(Meal(
              date: DateTime.parse(meal['date']),
              time:
                  TimeOfDay.fromDateTime(DateFormat.Hms().parse(meal['time'])),
              type: meal['type'],
              carbohydrates: meal['carbohydrates'] ?? "",
              proteins: meal['proteins'] ?? "",
              vegetables: meal['vegetables'] ?? "",
              fruits: meal['fruits'] ?? "",
              others: meal['others'] ?? "",
            ));
          });

          final List<PhysicalActivity> _diaryActivities = [];
          _diaryActivities.clear();
          diaryMap['physical_activities'].forEach((activity) {
            _diaryActivities.add(PhysicalActivity(
              date: DateTime.parse(activity['date']),
              time: TimeOfDay.fromDateTime(
                  DateFormat.Hms().parse(activity['time'])),
              activity: activity['activity'],
              duration: activity['duration'],
            ));
          });

          diaries.add(Diary(
            id: int.parse('${diaryMap['id']}'),
            from: DateTime.parse(diaryMap['from']),
            to: DateTime.parse(diaryMap['to']),
            weight: double.parse('${diaryMap['initial_weight']}'),
            height: double.parse('${diaryMap['initial_height']}'),
            bmi: double.parse('${diaryMap['initial_BMI']}'),
            waist: double.parse('${diaryMap['initial_waist_circumference']}'),
            bodyComposition:
                double.parse('${diaryMap['body_fat_and_water_composition']}'),
            bloodPressure: double.parse('${diaryMap['blood_pressure']}'),
            meals: _diaryMeals,
            activities: _diaryActivities
          ));
        });

        if(diaries.length == 0){
          return {'status': true, 'message': 'No Diary'};
        }

        activeDiary = diaries.last;
        notifyListeners();
        return {'status': true, 'message': 'Data ready'};
      }
      return {
        'status': responseData['status'],
        'message': responseData['message']
      };
    } on SocketException {
      return {'status': false, 'message': 'No Network, please try again later'};
    } on FormatException catch (e) {
      return {
        'status': false,
        'message': 'Unable to process the request, please try again:'
      };
    } on TimeoutException {
      return {
        'status': false,
        'message': 'The request timed out, please try again later'
      };
    } catch (e) {
      print(e.toString());

      return {
        'status': false,
        'message': 'Something went wrong, please try again'
      };
    }

    return {};
  }

  Future<Map<String, dynamic>> postDiary(
      {@required int userId,
      @required DateTime from,
      @required DateTime to,
      @required double initialWeight,
      @required double initialHeight,
      @required double initialBMI,
      @required double initialWaistCircumference,
      @required double bodyFatAndWaterComposition,
      @required double bloodPressure}) async {
    print('Date is From: ' +
        DateFormat('yyyy-MM-dd').format(from) +
        ' To: ' +
        DateFormat('yyyy-MM-dd').format(to));

    Map<String, dynamic> diary = {
      'from': DateFormat('yyyy-MM-dd').format(from),
      'to': DateFormat('yyyy-MM-dd').format(to),
      'initial_weight': initialWeight,
      'initial_height': initialHeight,
      'initial_BMI': initialBMI,
      'initial_waist_circumference': initialWaistCircumference,
      'body_fat_and_water_composition': bodyFatAndWaterComposition,
      'blood_pressure': bloodPressure
    };

    try {
      http.Response response = await http.post(api + 'diary/$userId',
          body: json.encode(diary),
          headers: {
            'Content-Type': 'application/json'
          }).timeout(Duration(seconds: 45));
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status']) {
        Map<String, dynamic> diaryMap = responseData['diary'];

        activeDiary = Diary(
          id: int.parse(diaryMap['id'].toString()),
          from: DateTime.parse(diaryMap['from']),
          to: DateTime.parse(diaryMap['to']),
          weight: double.parse('${diaryMap['initial_weight']}'),
          height: double.parse('${diaryMap['initial_height']}'),
          bmi: double.parse('${diaryMap['initial_BMI']}'),
          waist: double.parse('${diaryMap['initial_waist_circumference']}'),
          bodyComposition:
              double.parse('${diaryMap['body_fat_and_water_composition']}'),
          bloodPressure: double.parse('${diaryMap['blood_pressure']}'),
          meals: [],
          activities: []
        );

        diaries.add(activeDiary);
        notifyListeners();

        return {'status': true, 'message': 'Data ready'};
      }
      return {
        'status': responseData['status'],
        'message': responseData['message']
      };
    } on SocketException {
      return {'status': false, 'message': 'Network, please try again'};
    } on FormatException catch (e) {
      return {
        'status': false,
        'message': 'Unable to process the request, please try again:'
      };
    } on TimeoutException {
      return {
        'status': false,
        'message': 'The request timed out, please try again later'
      };
    } catch (e) {
      print(e.toString());
      return {
        'status': false,
        'message': 'Something went wrong, please try again ' + e.toString()
      };
    }
  }

  Future<Map<String, dynamic>> postMeal({
    @required DateTime date,
    @required TimeOfDay time,
    @required String type,
    @required String carbohydrate,
    @required String proteins,
    @required String vegetables,
    @required String fruits,
    @required String others,
  }) async {
    Map<String, dynamic> _mealMap = {
      "diary_id": activeDiary.id,
      "date": DateFormat('yyyy-MM-dd').format(date),
      "time":
          '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
      "type": type,
      "carbohydrates": carbohydrate,
      "proteins": proteins,
      "vegetables": vegetables,
      "fruits": fruits,
      "others": others,
    };
    try {
      http.Response response = await http.post(api + 'meal',
          body: json.encode(_mealMap),
          headers: {
            'Content-Type': 'application/json'
          }).timeout(Duration(seconds: 45));
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status']) {
        Map<String, dynamic> mealMap = responseData['meal'];


        activeDiary.meals.add(Meal(
          date: DateTime.parse(mealMap['date']),
          time:
          TimeOfDay.fromDateTime(DateFormat.Hm().parse(mealMap['time'])),
          type: mealMap['type'],
          carbohydrates: mealMap['carbohydrates'] ?? "",
          proteins: mealMap['proteins'] ?? "",
          vegetables: mealMap['vegetables'] ?? "",
          fruits: mealMap['fruits'] ?? "",
          others: mealMap['others'] ?? "",
        ));

        notifyListeners();
        return {'status': true, 'message': 'Data ready'};
      }
      return {
        'status': responseData['status'],
        'message': responseData['message']
      };
    } on SocketException {
      return {'status': false, 'message': 'Network, please try again'};
    } on FormatException catch (e) {
      return {
        'status': false,
        'message': 'Unable to process the request, please try again:'
      };
    } on TimeoutException {
      return {
        'status': false,
        'message': 'The request timed out, please try again later'
      };
    }
    catch (e) {
      print(e.toString());

      return {
        'status': false,
        'message': 'Something went wrong, please try again'
      };
    }

    return {};
  }

  Future<Map<String, dynamic>> postPhysicalActivity({
    @required DateTime date,
    @required TimeOfDay time,
    @required String activity,
    @required String duration,
  }) async {
    Map<String, dynamic> _physicalActivityMap = {
      'diary_id': activeDiary.id,
      'date': DateFormat('yyyy-MM-dd').format(date),
      'time':
          '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
      'activity': activity,
      'duration': duration,
    };

    try {
      http.Response response = await http.post(api + 'activity',
          body: json.encode(_physicalActivityMap),
          headers: {
            'Content-Type': 'application/json'
          }).timeout(Duration(seconds: 45));
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status']) {
        print(responseData.toString());
        Map<String, dynamic> activityMap = responseData['activity'];

        activeDiary.activities.add(
            PhysicalActivity(
              date: DateTime.parse(activityMap['date']),
              time: TimeOfDay.fromDateTime(
                  DateFormat.Hm().parse(activityMap['time'])),
              activity: activityMap['activity'],
              duration: activityMap['duration'],
            )
        );

        notifyListeners();
        return {'status': true, 'message': 'Data ready'};
      }
      return {
        'status': responseData['status'],
        'message': responseData['message']
      };
    } on SocketException {
      return {'status': false, 'message': 'Network error, please try again'};
    } on FormatException catch (e) {
      return {
        'status': false,
        'message': 'Unable to process the request, please try again:'
      };
    } on TimeoutException {
      return {
        'status': false,
        'message': 'The request timed out, please try again later'
      };
    } catch (e) {
      print(e.toString());

      return {
        'status': false,
        'message': 'Something went wrong, please try again'
      };
    }
    return {};
  }
}
