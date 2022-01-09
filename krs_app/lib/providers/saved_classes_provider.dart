import 'package:flutter/material.dart';
import 'package:krs_app/dsb_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dsbuntis/dsbuntis.dart';

class SavedClasses with ChangeNotifier {
  SavedClasses() {
    _loadSavedClasses();
    getSubs();
  }

  List<String> _savedClasses = [];
  final _subs = <Substitution>[];

  //getter for list, length, subs
  bool get hasSavedClasses => _savedClasses.isNotEmpty;

  List<String> get savedClasses => _savedClasses;

  int get length => _savedClasses.length;

  List<Substitution> get subs => _subs;

  List<Substitution> get affectedSubs {
    final affectedSubs = <Substitution>[];
    for (Substitution s in _subs) {
      if (_savedClasses.contains(s.affectedClass) || _savedClasses.contains(s.subTeacher)) {
        affectedSubs.add(s);
      }
    }
    return affectedSubs;
  }

  //function to add Classes from putside this class
  void addClass(String savedClass) {
    if (_savedClasses.contains(savedClass) || savedClass.isEmpty) return;
    _savedClasses.add(savedClass);
    _storeSavedClasses();
    notifyListeners();
  }

  //function to remove Classes from outside this class
  void removeClass({String? name, int? index}) {
    if (name != null) {
      _savedClasses.remove(name);
    } else if (index != null) {
      _savedClasses.removeAt(index);
    }
    _storeSavedClasses();
    notifyListeners();
  }

  void _loadSavedClasses() async {
    final prefs = await SharedPreferences.getInstance();
    final savedClasses = prefs.getStringList('savedClasses');
    if (savedClasses != null) {
      _savedClasses = savedClasses;
    }
    notifyListeners();
  }

  void _storeSavedClasses() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('savedClasses', _savedClasses);
  }

  //pseude subs for demo / test purposes
  /*final _subs = [
    Substitution('5a', 1, 'PSH', 'Mathe', true),
    Substitution('6d', 1, 'WAL', 'Info', false),
    Substitution('10d', 1, 'DAW', 'Deutsch', true),
    Substitution('8i', 4, 'MAZ', 'Sport', true),
    Substitution('9f', 9, 'WEI', 'Musik', false),
    Substitution('5f', 4, 'STE', 'Bio', true),
    Substitution('9i', 4, 'STE', 'Bio', true),
    Substitution('9i', 5, 'STE', 'Bio', true),
    Substitution('5a', 4, 'STE', 'Bio', true),
    Substitution('6c', 4, 'STE', 'Bio', true),
    Substitution('8l', 4, 'STE', 'Bio', true),
    Substitution('9g', 4, 'STE', 'Bio', true),
    Substitution('10h', 4, 'STE', 'Bio', true),
    Substitution('10b', 4, 'STE', 'Bio', true),
    Substitution('8a', 4, 'STE', 'Bio', true),
  ];*/

  void getSubs() async{
      final dsb = DSBManager();
    if (_subs.isNotEmpty) {
      _subs.removeRange(0, _subs.length - 1);
    }
    _subs.addAll(await dsb.getData());
    notifyListeners();
  }
}
