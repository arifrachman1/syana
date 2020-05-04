import 'package:flutter/material.dart';
import 'file:///E:/workspace/flutter_project/syana/lib/screens/profile/SyanaAkunAboutFAQ.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/Dimens.dart';
import '../../main.dart';

class SyanaAkunAbout extends StatefulWidget {
  @override
  SyanaAkunAboutState createState() => SyanaAkunAboutState();
}

class SyanaAkunAboutState extends State<SyanaAkunAbout> {
  String aboutText =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce lobortis vestibulum fringilla. Proin mauris sem, iaculis pharetra finibus in, aliquam at est. Sed placerat, est quis luctus fermentum, lorem augue commodo velit, id tincidunt arcu erat quis risus. Proin vestibulum dolor sit amet ex efficitur, sed tincidunt sem tincidunt. Sed auctor mi ac ultrices porta. Mauris luctus gravida purus, laoreet ornare metus lobortis eget. Pellentesque nibh odio, tempor ut odio in, consequat dignissim libero. Etiam tristique pellentesque malesuada. Donec aliquam tortor vel risus semper, sed ornare massa sollicitudin. Cras non felis pretium, condimentum turpis a, iaculis nisi. Cras porta maximus sem sit amet aliquet. Aenean urna sapien, vestibulum eget mollis nec, posuere sed ex. ";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.bottomLeft,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Text(
                'About Syana',
                style: TextStyle(
                  color: AppTheme.text_light,
                  fontSize: 25,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 25),
              alignment: Alignment.centerLeft,
              child: Text(
                aboutText,
                style: TextStyle(
                  color: AppTheme.text_light,
                ),
              ),
            ),
            Container(
              width: Dimens.buttonWidth(context),
              child: AspectRatio(
                aspectRatio: Dimens.buttonRatio(),
                child: RaisedButton(
                  color: AppTheme.yellow,
                  shape: AppTheme.roundButton(),
                  child: Text(
                    'FAQ',
                    style: TextStyle(
                      color: AppTheme.text_dark,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context){
                          return SyanaAkunAboutFAQ();
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
