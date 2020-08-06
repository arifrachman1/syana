import 'package:flutter/material.dart';
import 'package:syana/Controller/ProfileController.dart';
import 'package:syana/models/TripsModel.dart';
import 'package:syana/screens/profile/SyanaTripsVideo.dart';
import 'package:syana/screens/profile/SyanaTripsYoutubePlayer.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/GlobalVars.dart';
import 'package:syana/utils/ScreenSizeHelper.dart';
import 'package:syana/widgets/CustomBottomNav.dart';
import 'package:syana/widgets/CustomDialog.dart';

class SyanaTrips extends StatefulWidget {
  @override
  SyanaTripsState createState() => SyanaTripsState();
}

class SyanaTripsState extends State<SyanaTrips> {
  List tripTerbaru = ['papuma.jpg', 'city.jpg', ''];
  List tripFavorite = ['mountain.jpg', '', 'pasput.jpg'];

  List<TripsModel> _favouriteTrips = new List();
  List<TripsModel> _newestTrips = new List();
  List<TripsModel> _topThreeTrips = new List();
  List<TripsModel> _otherTrips = new List();

  Map _trips = new Map();

  ProfileController _profileController;
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _profileController = new ProfileController();
    _initData();
  }

  _initData() async {
    await _profileController.getTrips(context, setLoadingState, setData);
  }

  void setLoadingState() {
    setState(() {
      _isLoading = _isLoading ? _isLoading = false : _isLoading = true;
    });
  }

  setData(data) {
    if (data is Map) {
      setState(() {
        _trips = data;
        _favouriteTrips = _trips['favouriteTrips'];
        _newestTrips = _trips['newestTrips'];
        _topThreeTrips = _trips['topThreeTrips'];
        _otherTrips = _trips['otherTrips'];
      });
    }
  }

  imageTripTerbaru(index) {
    var filename = tripTerbaru[index];
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        'images/' + filename.toString(),
        fit: BoxFit.cover,
      ),
    );
  }

  imageTripFavorite(index) {
    var filename = tripFavorite[index];
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        'images/' + filename.toString(),
        fit: BoxFit.cover,
      ),
    );
  }

  _itemSmall(
      {@required isNewest,
      @required isFavourite,
      @required title,
      @required quote,
      @required thumbnail,
      @required youtubeVideoId}) {
    return GestureDetector(
      onTap: () {
        CustomDialog.getDialogWithVideo(
            title: title,
            message: quote,
            context: context,
            popCount: 1,
            videoId: youtubeVideoId);
        // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        //   return SyanaTripsVideo();
        // }));
      },
      child: Expanded(
        child: Container(
          width: ScreenSizeHelper.getDisplayWidth(context) * 0.5,
          height: ScreenSizeHelper.getDisplayWidth(context) * 0.5,
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: AppTheme.listBackground(),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(GlobalVars.thumbnailUrl + thumbnail),
          ),
        ),
      ),
    );
  }

  _itemMedium(
      {@required isNewest,
      @required isFavourite,
      @required title,
      @required quote,
      @required thumbnail,
      @required youtubeVideoId}) {
    return GestureDetector(
      onTap: () {
       CustomDialog.getDialogWithVideo(
           title: title,
           message: quote,
           context: context,
           popCount: 1,
           videoId: youtubeVideoId);

        // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        //   return SyanaTripsYoutubePlayer(idVideo: youtubeVideoId,);
        // }));

        /*Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return SyanaTripsVideo();
        }));*/
      },
      child: Stack(
        overflow: Overflow.clip,
        children: <Widget>[
          /*pictures*/
          Row(
            children: <Widget>[
              Expanded(
                child: AspectRatio(
                  aspectRatio: 16 / 10,
                  child: Container(
                    decoration: AppTheme.listBackground(),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(GlobalVars.thumbnailUrl + thumbnail),
                    ),
                  ),
                ),
              )
            ],
          ),
          /*header*/
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppTheme.yellow,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black45,
                        blurRadius: 5,
                        offset: Offset(-2, 2)),
                  ],
                ),
                height: MediaQuery.of(context).size.height * 0.04,
                width: MediaQuery.of(context).size.width * 0.2,
                child: Text(
                  isNewest ? 'Terbaru' : isFavourite ? 'Favorit' : '',
                  style: TextStyle(
                    color: AppTheme.text_dark,
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          /*title + quote*/
          Row(
            children: <Widget>[
              Expanded(
                child: AspectRatio(
                  aspectRatio: 16 / 10,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      title + "\n" + quote,
                      style: TextStyle(
                        color: AppTheme.white,
                        shadows: [AppTheme.shadowText()],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar: CustomBottomNav.getBottomNav(context, 4),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    /*Container(
              child: Text(
                'Syana Trip',
                style: TextStyle(
                  color: AppTheme.text_light,
                  fontSize: 20,
                ),
              ),
            ),*/
                    Container(
                      height: MediaQuery.of(context).size.width * 0.04,
                    ),
                    /*favorit*/
                    SizedBox(
                      height: ScreenSizeHelper.getDisplayHeight(
                              context: context,
                              which: ScreenSizeHelper.HEIGHT_WITH_STATUS_BAR) *
                          0.4,
                      child: ListView.builder(
                          itemCount: _favouriteTrips.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return _itemMedium(
                                isNewest: false,
                                isFavourite: true,
                                title: _favouriteTrips[index].title,
                                quote: _favouriteTrips[index].quote,
                                thumbnail: _favouriteTrips[index].thumbnail,
                                youtubeVideoId:
                                    _favouriteTrips[index].youtubeVideoId);
                          }),
                    ),

                    /*Top Three*/

                    SizedBox(
                      height: ScreenSizeHelper.getDisplayHeight(
                              context: context,
                              which: ScreenSizeHelper.HEIGHT_WITH_STATUS_BAR) *
                          0.2,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _topThreeTrips.length,
                          itemBuilder: (context, index) {
                            return _itemSmall(
                                isNewest: false,
                                isFavourite: false,
                                title: _topThreeTrips[index].title,
                                quote: _topThreeTrips[index].quote,
                                thumbnail: _topThreeTrips[index].thumbnail,
                                youtubeVideoId:
                                    _topThreeTrips[index].youtubeVideoId);
                          }),
                    ),

                    /*newest*/

                    SizedBox(
                      height: ScreenSizeHelper.getDisplayHeight(
                              context: context,
                              which: ScreenSizeHelper.HEIGHT_WITH_STATUS_BAR) *
                          0.4,
                      child: ListView.builder(
                          itemCount: _newestTrips.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return _itemMedium(
                                isNewest: true,
                                isFavourite: false,
                                title: _newestTrips[index].title,
                                quote: _newestTrips[index].quote,
                                thumbnail: _newestTrips[index].thumbnail,
                                youtubeVideoId:
                                    _newestTrips[index].youtubeVideoId);
                          }),
                    ),

                    /*others*/

                    SizedBox(
                      height: ScreenSizeHelper.getDisplayHeight(
                              context: context,
                              which: ScreenSizeHelper.HEIGHT_WITH_STATUS_BAR) *
                          0.2,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _otherTrips.length,
                          itemBuilder: (context, index) {
                            return _itemSmall(
                                isNewest: false,
                                isFavourite: false,
                                title: _otherTrips[index].title,
                                quote: _otherTrips[index].quote,
                                thumbnail: _otherTrips[index].thumbnail,
                                youtubeVideoId:
                                    _otherTrips[index].youtubeVideoId);
                          }),
                    ),
                    /*Stack(
                overflow: Overflow.clip,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 16 / 10,
                          child: Container(
                            decoration: AppTheme.listBackground(),
                            child: tripTerbaru[0].isEmpty
                                ? FittedBox(
                                    fit: BoxFit.fitHeight,
                                    child: Icon(
                                      Icons.image,
                                      color: AppTheme.teal_light,
                                    ),
                                  )
                                : imageTripTerbaru(0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppTheme.yellow,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black45,
                                blurRadius: 5,
                                offset: Offset(-2, 2)),
                          ],
                        ),
                        height: MediaQuery.of(context).size.height * 0.04,
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: Text(
                          'Terbaru',
                          style: TextStyle(
                            color: AppTheme.text_dark,
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 16 / 10,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Jangan Lupa Bahagia !! (^_^)',
                              style: TextStyle(
                                color: AppTheme.white,
                                shadows: [AppTheme.shadowText()],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),*/
                    Container(
                      height: MediaQuery.of(context).size.width * 0.03,
                    ),
                    /*Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: AppTheme.listBackground(),
                        child: tripTerbaru[1].isEmpty
                            ? FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Icon(
                                  Icons.image,
                                  color: AppTheme.teal_light,
                                ),
                              )
                            : imageTripTerbaru(1),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: AppTheme.listBackground(),
                        child: tripTerbaru[2].isEmpty
                            ? FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Icon(
                                  Icons.image,
                                  color: AppTheme.teal_light,
                                ),
                              )
                            : imageTripTerbaru(2),
                      ),
                    ),
                  ),
                ],
              ),*/
                    Container(
                      height: MediaQuery.of(context).size.width * 0.03,
                    ),
                    /*Stack(
                overflow: Overflow.clip,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 16 / 10,
                          child: Container(
                            decoration: AppTheme.listBackground(),
                            child: tripFavorite[0].isEmpty
                                ? FittedBox(
                                    fit: BoxFit.fitHeight,
                                    child: Icon(
                                      Icons.image,
                                      color: AppTheme.teal_light,
                                    ),
                                  )
                                : imageTripFavorite(0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppTheme.orange,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black45,
                                blurRadius: 5,
                                offset: Offset(-2, 2)),
                          ],
                        ),
                        height: MediaQuery.of(context).size.height * 0.04,
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: Text(
                          'Favorite',
                          style: TextStyle(
                            color: AppTheme.text_light,
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 16 / 10,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Jangan Lupa Bahagia !! (^_^)',
                              style: TextStyle(
                                color: AppTheme.white,
                                shadows: [AppTheme.shadowText()],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),*/
                    Container(
                      height: MediaQuery.of(context).size.width * 0.03,
                    ),
                    /*Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: AppTheme.listBackground(),
                        child: tripFavorite[1].isEmpty
                            ? FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Icon(
                                  Icons.image,
                                  color: AppTheme.teal_light,
                                ),
                              )
                            : imageTripFavorite(1),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: AppTheme.listBackground(),
                        child: tripFavorite[2].isEmpty
                            ? FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Icon(
                                  Icons.image,
                                  color: AppTheme.teal_light,
                                ),
                              )
                            : imageTripFavorite(2),
                      ),
                    ),
                  ),
                ],
              ),*/
                    Container(
                      height: MediaQuery.of(context).size.width * 0.03,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
