import 'package:flutter/material.dart';
import 'package:krs_app/common.dart';
import 'package:krs_app/providers/saved_classes_provider.dart';
import 'package:provider/provider.dart';

//Route that displays all the saved classes
//Users can add or remove saved Classes

class EditClasses extends StatelessWidget {
  const EditClasses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gespeicherte Kurse'),
        centerTitle: true,
        backgroundColor: CommonStyles.krsRed,
      ),
      body: _buildList(context),
    );
  }

  //builds a divided List consisting of rows
  Widget _buildList(BuildContext context) {
    if (Provider.of<SavedClasses>(context).length == 0) {
      return const AddClassesTile();
    }
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.all(16.0),
      itemCount: context.watch<SavedClasses>().length + 1,
      itemBuilder: (BuildContext context, int index) {
        return _buildRow(context, index);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  Widget _buildRow(BuildContext context, int index) {
    if (index == context.watch<SavedClasses>().length) {
      return const AddClassesTile();
    }
    return ListTile(
      title: Text(context.watch<SavedClasses>().savedClasses.elementAt(index),
          style: const TextStyle(fontSize: CommonStyles.contentFontSize)),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => Provider.of<SavedClasses>(context, listen: false)
            .removeClass(index: index),
      ),
    );
  }
}

class AddClassesTile extends StatelessWidget {
  const AddClassesTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: const Text(
          'Kurs hinzufügen',
          style: TextStyle(fontSize: CommonStyles.contentFontSize),
        ),
        trailing: const Icon(Icons.add),
        //Dialog zum Hinzufügen von Kursen
        onTap: () => showDialog(
            context: context, builder: (context) => const AddClassDialog()));
  }
}

class AddClassDialog extends StatelessWidget {
  const AddClassDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();
    return AlertDialog(
      title: const Text(
        'Kursname:',
        style: TextStyle(fontSize: CommonStyles.contentFontSize),
      ),
      content: const ClassInput(),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'abbrechen',
              style: TextStyle(),
            )),
        TextButton(
            onPressed: () => _submit(context, _controller.text),
            child: const Text(
              'hinzufügen',
              style: TextStyle(),
            ))
      ],
    );
  }

  void _submit(BuildContext context, String value) {
    Navigator.of(context).pop();
    Provider.of<SavedClasses>(context, listen: false).addClass(value);
  }
}

class ClassInput extends StatefulWidget {
  const ClassInput({Key? key}) : super(key: key);

  @override
  _ClassInputState createState() => _ClassInputState();
}

class _ClassInputState extends State<ClassInput> {
  String _grade = '5';
  String _group = 'a';
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButton<String>(
          value: _grade,
          onChanged: (String? newValue) {
            setState(() {
              _grade = newValue!;
            });
          },
          items: <String>['5', '6', '7', '8', '9', '10', 'Q12', 'Q34']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        _groupSelector(),
      ],
    );
  }

  Widget _groupSelector() {
    if (_grade.contains('Q')) {
      return TextField(
        controller: _textController,
        autofocus: true,
        decoration:  InputDecoration(
          constraints: BoxConstraints.loose(const Size.fromWidth(100)),
          label: const Text(
            'Bezeichnung',
            style: TextStyle(fontSize: CommonStyles.contentFontSize),
          ),
        ),
        onSubmitted: (String value) => _submit(context, value),
      );
    }
    return DropdownButton<String>(
      value: _group,
      onChanged: (String? newValue) {
        setState(() {
          _group = newValue!;
        });
      },
      items: <String>['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  void _submit(BuildContext context, String value) {
    Navigator.of(context).pop();
    Provider.of<SavedClasses>(context, listen: false).addClass(value);
  }
}
