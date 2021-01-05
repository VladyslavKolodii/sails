import 'package:flutter/material.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';
import 'package:hybrid_sailmate/widgets/inputfiled_with_title.dart';

class HelpCenter extends StatefulWidget {
  @override
  _HelpCenterState createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {

  List<bool> isExpanded = [false,false, false, false, false];

  TextEditingController subjectController = new TextEditingController();
  TextEditingController messageController = new TextEditingController();

  Widget _onBindQuestionWidget(Map<String, String> testQuestion, int index) {
    return GestureDetector(
      onTap: () => {
        for (int i = 0 ; i < isExpanded.length; i ++) {
          if (i == index) {
            isExpanded[i] = !isExpanded[i]
          } else {
            isExpanded[i] = false
          }
        },
        setState(() {
        })
      },
      child: Container(
        decoration: BoxDecoration(
          color: mainColorLightBlue,
          borderRadius: BorderRadius.circular(8.0),
        ),
        margin: EdgeInsets.only(bottom: 8.0),
        padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(testQuestion.keys.first, style: bottomSheetItemLabel(),),
            isExpanded[index] ? Text(testQuestion.values.first, style: bottomSheetItemLabelGrey12(),) : SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Do you have some problems? Describe it here and we will help you!", style: bottomSheetItemLabel(),),
          SizedBox(height: 24.0,),
          InputFieldWithTitle(title: 'Subject', hint: 'Enter Subject of the message', controller: subjectController,),
          SizedBox(height: 16.0,),
          InputFieldWithTitle(title: 'Message', hint: 'Describe your problem', controller: messageController,),
          SizedBox(height: 24.0,),
          Container(
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width,
            height: 46.0,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              onPressed: () => print(subjectController.text + "////" + messageController.text),
              color: Colors.black12,
              child: Text("Send", style: buttonWhite(),),
            ),
          ),
          SizedBox(height: 64.0,),
          Text("Or you could check frequently asked questions. Maybe you could find your answer here :)", style: bottomSheetItemLabel(),),
          SizedBox(height: 16.0,),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: testQustions.length,
            itemBuilder: (context, index) {
              return _onBindQuestionWidget(testQustions[index], index);
            },
          )
        ],
      ),
    );
  }
}

