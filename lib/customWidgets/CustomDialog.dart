import 'dart:ui';
import 'package:fantafriends/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

double padding = 20;
double avatarRadius = 5;

class CustomDialogBox extends StatefulWidget {
  final String title;
  // final String title, descriptions, text;
  final List<DialogField> fields;
  // final Image img;

  const CustomDialogBox(
      // {Key key, required this.title, required this.descriptions, required this.text, required this.img})
      {Key? key,
      required this.title,
      // required this.descriptions,
      // required this.text,
      required this.fields})
      : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, bool> _checkboxValues = {};
  final Map<String, DateTime> _selectedDates =
      {}; // Store per gli oggetti DateTime

  @override
  void initState() {
    super.initState();
    for (var field in widget.fields) {
      print(field.type);
      if (field.type == DialogFieldType.text ||
          field.type == DialogFieldType.number) {
        _controllers[field.key] =
            TextEditingController(text: field.initialValue?.toString() ?? "");
      } else if (field.type == DialogFieldType.checkbox) {
        _checkboxValues[field.key] = field.initialValue ?? false;
      } else if (field.type == DialogFieldType.date) {
        // Se passiamo una data iniziale, la formattiamo nel controller
        DateTime initial = field.initialValue ?? DateTime.now();
        _selectedDates[field.key] = initial;
        String day = initial.day.toString().padLeft(2, '0');
        String month = initial.month.toString().padLeft(2, '0');
        String text_controller = "$day/$month/${initial.year}";
        _controllers[field.key] = TextEditingController(text: text_controller);
        // _controllers[field.key] = TextEditingController(
        //     text: DateFormat('dd/MM/yyyy').format(initial));
      }
    }
  }

  // Metodo per mostrare il calendario
  Future<void> _selectDate(BuildContext context, String key) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDates[key] ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDates[key]) {
      setState(() {
        _selectedDates[key] = picked;
        String day = picked.day.toString().padLeft(2, '0');
        String month = picked.month.toString().padLeft(2, '0');
        _controllers[key]?.text = "$day/$month/${picked.year}";
        // _controllers[key]?.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  // ... (build e contentBox rimangono simili, aggiorniamo _buildField)

  Widget _buildField(DialogField field) {
    switch (field.type) {
      case DialogFieldType.text:
      case DialogFieldType.number:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextField(
            controller: _controllers[field.key],
            keyboardType: field.type == DialogFieldType.number
                ? TextInputType.number
                : TextInputType.text,
            decoration: InputDecoration(
                labelText: field.label, border: const OutlineInputBorder()),
          ),
        );

      case DialogFieldType.date:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextField(
            controller: _controllers[field.key],
            readOnly: true, // Impedisce la tastiera
            onTap: () => _selectDate(context, field.key), // Apre il calendario
            decoration: InputDecoration(
              labelText: field.label,
              border: const OutlineInputBorder(),
              suffixIcon: const Icon(Icons.calendar_today),
            ),
          ),
        );

      case DialogFieldType.checkbox:
        return CheckboxListTile(
          title: Text(field.label),
          value: _checkboxValues[field.key],
          onChanged: (bool? value) =>
              setState(() => _checkboxValues[field.key] = value ?? false),
          controlAffinity: ListTileControlAffinity.leading,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: true, // Permette la chiusura del dialog
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          // Logica extra se vuoi impedire la chiusura in certi casi
        },
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(padding),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: contentBox(context),
        ));
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: padding,
              top: avatarRadius + padding,
              right: padding,
              bottom: padding),
          margin: EdgeInsets.only(top: avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(padding),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              for (var field in widget.fields) _buildField(field),
              // SizedBox(
              //   height: 15,
              // ),
              // Text(
              //   widget.descriptions,
              //   style: TextStyle(fontSize: 14),
              //   textAlign: TextAlign.center,
              // ),
              // // SizedBox(
              // //   height: 22,
              // // ),
              // // Align(
              // //   alignment: Alignment.bottomRight,
              // //   child: FlatButton(
              // //       onPressed: () {
              // //         Navigator.of(context).pop();
              // //       },
              // //       child: Text(
              // //         widget.text,
              // //         style: TextStyle(fontSize: 18),
              // //       )),
              // // ),
            ],
          ),
        ),
        // Positioned(
        //   left: padding,
        //   right: padding,
        //   child: CircleAvatar(
        //     backgroundColor: Colors.transparent,
        //     radius: avatarRadius,
        //     child: ClipRRect(
        //         borderRadius: BorderRadius.all(Radius.circular(avatarRadius)),
        //         child: Image.asset("assets/model.jpeg")),
        //   ),
        // ),
      ],
    );
  }
}
