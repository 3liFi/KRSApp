import 'package:flutter/material.dart';
import 'package:krs_app/providers/saved_classes_provider.dart';
import 'package:krs_app/common.dart';
import 'package:provider/provider.dart';

class SubList extends StatelessWidget {
  const SubList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonStyles.krsRed,
        title: const Text('KRS App'),
        centerTitle: true,
      ),
      body: const ListWrapper(),
      drawer: Drawer(
        child: ListView(
          //remove any padding from ListView
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: CommonStyles.krsRed),
              child: const Text(
                'Einstellungen',
                style: TextStyle(
                    fontSize: CommonStyles.contentFontSize,
                    color: Colors.white),
              ),
            ),
            ListTile(
              title: const Text(
                'Gespeicherte Kurse',
                style: TextStyle(fontSize: CommonStyles.contentFontSize),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/editClasses');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ListWrapper extends StatelessWidget {
  const ListWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final savedClasses = Provider.of<SavedClasses>(context);
    if (savedClasses.hasSavedClasses) {
      return _buildList(context);
    }
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return TileBuilder(
              savedClasses.subs[index], savedClasses.subs[index].affectedClass);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: savedClasses.subs.length);
  }

  Widget _buildList(BuildContext context) {
    final savedClasses = Provider.of<SavedClasses>(context);
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8.0),
      itemCount: savedClasses.affectedSubs.length + savedClasses.subs.length,
      itemBuilder: (BuildContext context, int index) {
        return RowBuilder(index);
      },
      separatorBuilder: (BuildContext context, int index) {
        if (index == savedClasses.affectedSubs.length - 1) {
          return const Divider(
            thickness: 2.0,
          );
        }
        return const Divider();
      },
    );
  }
}

//builds a row consisting of ListTiles
//the content of the ListTiles are the substitutions
class RowBuilder extends StatelessWidget {
  final int index;
  const RowBuilder(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final savedClasses = Provider.of<SavedClasses>(context);
    if (index < savedClasses.affectedSubs.length) {
      return TileBuilder(savedClasses.affectedSubs[index],
          savedClasses.affectedSubs[index].affectedClass);
    }
    return TileBuilder(
        savedClasses.subs[index - savedClasses.affectedSubs.length],
        savedClasses
            .subs[index - savedClasses.affectedSubs.length].affectedClass);
  }
}
