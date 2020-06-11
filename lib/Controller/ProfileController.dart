import 'package:syana/models/TripsModel.dart';
import 'package:syana/models/UserModel.dart';
import 'package:syana/utils/GlobalFunctions.dart';
import 'package:syana/utils/GlobalVars.dart';

class ProfileController {
  UserModel _userModel;

  ProfileController() {
    _getPersistence();
  }

  _getPersistence() async {
    _userModel = await GlobalFunctions.getPersistence();
  }

  getPersonalInfo(context, loadingStateCallback, setDataCallback) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    loadingStateCallback();

    DateTime _joinDate,
        _now = new DateTime(DateTime.now().year, DateTime.now().month),
        _diffDate;

    _joinDate = GlobalFunctions.getDateTimeFromString(
        targetDateTime: _userModel.dateTimeJoined,
        intendedFormat: GlobalFunctions.FORMAT_YYYY_MM_DD);

    int _yearDiff = _now.year - _joinDate.year, _montDiff = 0;
    if (_joinDate.month > _now.month) {
      _yearDiff--;
      _montDiff = _now.month + (12 - _joinDate.month);
    } else {
      _montDiff = _now.month - _joinDate.month;
    }

    _diffDate = new DateTime(_yearDiff, _montDiff);

    Map returnValues = new Map();

    returnValues['fullName'] = _userModel.fullName;
    returnValues['joinDate'] = _joinDate;
    returnValues['diffDate'] = _diffDate;

    loadingStateCallback();

    setDataCallback(returnValues);
  }

  getMyPoints(context, loadingStateCallback, setDataCallback) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    Map myPoints = new Map();

    loadingStateCallback();
    var params =
        GlobalFunctions.generateMapParam(['id_employee'], [_userModel.id]);
    final data = await GlobalFunctions.dioGetCall(
        path: GlobalVars.apiUrl + "get-my-points",
        params: params,
        context: context);

    if (data != null) {
      if (data['status'] == 1) {
        myPoints['pointsThisMonth'] = data['pointsThisMonth'];
        myPoints['pointsThreeMonthsPrior'] = data['pointsThreeMonthsPrior'];
        myPoints['packagesThisMonth'] = data['packagesThisMonth'];
        myPoints['packagesThreeMonthsPrior'] = data['packagesThreeMonthsPrior'];

        setDataCallback(myPoints);
      }
    }
    loadingStateCallback();
  }

  getTrips(context, loadingStateCallback, setDataCallback) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    loadingStateCallback();

    var params =
        GlobalFunctions.generateMapParam(["id_employee"], [_userModel.id]);
    final data = await GlobalFunctions.dioGetCall(
        context: context,
        path: GlobalVars.apiUrl + "get-syana-trip",
        params: params);
    if (data != null) {
      if (data['status'] == 1) {
        List tripsFromApi = data['favourite'];
        List<TripsModel> favouriteTrips = new List();

        if (tripsFromApi != null || tripsFromApi.isNotEmpty) {
          tripsFromApi.forEach((element) {
            favouriteTrips.add(new TripsModel.init(
                element['id'].toString(),
                element['title'].toString(),
                element['quote'].toString(),
                element['youtube_link'].toString(),
                element['view_number'].toString(),
                element['thumbnail'].toString(),
                element['description'].toString()));
          });
        }

        tripsFromApi = data['newest'];
        List<TripsModel> newestTrips = new List();

        if (tripsFromApi != null || tripsFromApi.isNotEmpty) {
          tripsFromApi.forEach((element) {
            newestTrips.add(new TripsModel.init(
                element['id'].toString(),
                element['title'].toString(),
                element['quote'].toString(),
                element['youtube_link'].toString(),
                element['view_number'].toString(),
                element['thumbnail'].toString(),
                element['description'].toString()));
          });
        }

        tripsFromApi = data['top_3'];
        List<TripsModel> topThreeTrips = new List();

        if (tripsFromApi != null || tripsFromApi.isNotEmpty) {
          tripsFromApi.forEach((element) {
            topThreeTrips.add(new TripsModel.init(
                element['id'].toString(),
                element['title'].toString(),
                element['quote'].toString(),
                element['youtube_link'].toString(),
                element['view_number'].toString(),
                element['thumbnail'].toString(),
                element['description'].toString()));
          });
        }

        tripsFromApi = data['rest'];
        List<TripsModel> otherTrips = new List();

        if (tripsFromApi != null || tripsFromApi.isNotEmpty) {
          tripsFromApi.forEach((element) {
            otherTrips.add(new TripsModel.init(
                element['id'].toString(),
                element['title'].toString(),
                element['quote'].toString(),
                element['youtube_link'].toString(),
                element['view_number'].toString(),
                element['thumbnail'].toString(),
                element['description'].toString()));
          });
        }

        Map returnValues = new Map();

        returnValues['favouriteTrips'] = favouriteTrips;
        returnValues['newestTrips'] = newestTrips;
        returnValues['topThreeTrips'] = topThreeTrips;
        returnValues['otherTrips'] = otherTrips;

        setDataCallback(returnValues);
      }
    }
    loadingStateCallback();
  }
}
