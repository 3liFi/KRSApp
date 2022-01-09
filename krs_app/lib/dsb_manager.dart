import 'package:dsbuntis/dsbuntis.dart';

class DSBManager {
  static const String _username = '152321';
  static const String _password = 'krsmrz21';
  static Future<dynamic>? _token;
  DSBManager() {
    _token = getSessionToken();
  }

  Future<List<Plan>> getTimeTable() async {
    final session = Session(await _token);
    print(await getSessionToken());
    final ttJson = await session.getTimetableJson();
    print("$ttJson");
    final dp = session.downloadPlans(ttJson);
    List<Plan> finishedPlan = <Plan>[];
    PlanParser parser = Substitution.fromUntis;
    for (final p in parsePlans(dp, parser: parser)) {
      final plan = await p;
      if (plan != null) finishedPlan.add(plan);
    }

    return finishedPlan;
  }

  Future<List<Substitution>> getData() async {
    final subs = <Substitution>[];
    List<Plan> plans = await getTimeTable();
    for (final plan in plans) {
      for (final sub in plan.subs) {
        subs.add(sub);
      }
    } return subs;
  }

  Future<String> getSessionToken() async {
    final session = await Session.login(_username, _password);
    return session.token;
  }

  /*getAllData() async {
    List<Plan> plans = await getAllSubs(_username, _password);
    int counter = 1;
    for (final p in plans) {
      print("Plan $counter:");
      counter ++;
      for (final s in p.subs) {
        print(s.toString());
      }
    }
  }*/
}
