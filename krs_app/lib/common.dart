import 'package:dsbuntis/dsbuntis.dart';
import 'package:flutter/material.dart';

//class to group together styles used thorughout the app
class CommonStyles {
  static final krsRed = Colors.red[900];
  static const contentFontSize = 19.0;
}

class TileBuilder extends StatelessWidget {
  const TileBuilder(this.title, this.leading, {Key? key}) : super(key: key);
  
  final String leading;
  final Substitution title;
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(printSub(title),
          style: const TextStyle(fontSize: CommonStyles.contentFontSize)),
      leading: Text(
        leading,
        style: TextStyle(color: CommonStyles.krsRed, fontSize: CommonStyles.contentFontSize),
      ),
      tileColor: Colors.transparent,
    );
  }

  //function to format the print out of the substitutions within the ListTiles
  static String printSub(Substitution sub) {
    if (sub.isFree) {
      return '${sub.subTeacher} in der ${sub.lesson}. Stunde entfällt';
    } else {
      return 'Vertretung in ${sub.subTeacher} in der ${sub.lesson}. Stunde';
    }
  }
}
//Klasse -> affectedClass
//Stunde -> lesson
//Fach -> subTeacher
//Raum -> subject
//Art -> orgTeacher
//Informationen -> notes
//(Fach) ->