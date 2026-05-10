import 'dart:ui';
import 'package:fantafriends/utils/utils.dart';
import 'package:flutter/material.dart';

double padding = 20;
double avatarRadius = 5;

class CustomDialogBox extends StatefulWidget {
  final String title;
  final Color color;
  final List<DialogField> fields;
  final String textConfirm;
  final String textCancel;

  const CustomDialogBox({
    Key? key,
    required this.title,
    required this.color,
    required this.fields,
    this.textConfirm = "Salva",
    this.textCancel = "Annulla",
  }) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  // 1. Chiave globale per il Form
  final _formKey = GlobalKey<FormState>();

  final Map<String, TextEditingController> _controllers = {};
  final Map<String, bool> _checkboxValues = {};
  final Map<String, DateTime> _selectedDates = {};

  @override
  void initState() {
    super.initState();
    for (var field in widget.fields) {
      if (field.type == DialogFieldType.text ||
          field.type == DialogFieldType.number) {
        _controllers[field.key] =
            TextEditingController(text: field.initialValue?.toString() ?? "");
      } else if (field.type == DialogFieldType.checkbox) {
        _checkboxValues[field.key] = field.initialValue ?? false;
      } else if (field.type == DialogFieldType.date) {
        DateTime initial = field.initialValue ?? DateTime.now();
        _selectedDates[field.key] = initial;
        _controllers[field.key] =
            TextEditingController(text: _formatDate(initial));
      }
    }
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }

  Future<void> _selectDate(BuildContext context, String key) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDates[key] ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDates[key] = picked;
        _controllers[key]?.text = _formatDate(picked);
      });
    }
  }

  // 2. Metodo per processare i dati
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> results = {};

      for (var field in widget.fields) {
        if (field.type == DialogFieldType.checkbox) {
          results[field.key] = _checkboxValues[field.key];
        } else if (field.type == DialogFieldType.date) {
          results[field.key] = _selectedDates[field.key];
        } else if (field.type == DialogFieldType.number) {
          results[field.key] =
              double.tryParse(_controllers[field.key]!.text) ?? 0.0;
        } else {
          results[field.key] = _controllers[field.key]?.text;
        }
      }

      // Chiude il dialog e restituisce la mappa con i dati
      Navigator.of(context).pop(results);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(padding)),
      elevation: 0,
      backgroundColor: Colors.black,
      // Il Form avvolge il contenuto interno del Dialog
      child: contentBox(context),
    );
  }

  Widget contentBox(context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: widget.color.withAlpha((255.0 * 0.15).round()),
        borderRadius: BorderRadius.circular(padding),
        boxShadow: const [
          BoxShadow(
              color: Colors.black26, offset: Offset(0, 10), blurRadius: 10)
        ],
      ),
      child: Form(
        key: _formKey, // Assegnazione della chiave
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(widget.title,
                  style: TextStyle(
                      color: widget.color,
                      fontSize: 22,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 20),

              // Generazione dinamica dei campi
              ...widget.fields.map((field) => _buildField(field)).toList(),

              const SizedBox(height: 20),

              // Bottoni di azione
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ButtonStyle(
                        shadowColor: WidgetStatePropertyAll(
                            widget.color.withAlpha((255.0 * 0.2).round())),
                        overlayColor: WidgetStatePropertyAll(
                            widget.color.withAlpha((255.0 * 0.2).round()))),
                    child: Text(
                      widget.textConfirm,
                      style: TextStyle(color: widget.color),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(DialogField field) {
    // Usiamo TextFormField invece di TextField per l'integrazione con il Form
    if (field.type == DialogFieldType.checkbox) {
      return CheckboxListTile(
        title: Text(
          field.label,
          style: TextStyle(color: widget.color),
        ),
        checkColor: widget.color,
        value: _checkboxValues[field.key],
        activeColor: Colors.transparent,
        fillColor: WidgetStatePropertyAll(
            widget.color.withAlpha((255.0 * 0.2).round())),
        overlayColor: WidgetStatePropertyAll(widget.color),
        onChanged: (bool? value) =>
            setState(() => _checkboxValues[field.key] = value ?? false),
        controlAffinity: ListTileControlAffinity.leading,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        style: TextStyle(color: widget.color),
        // cursorColor: Colors.orange,
        controller: _controllers[field.key],
        readOnly: field.type == DialogFieldType.date,
        onTap: field.type == DialogFieldType.date
            ? () => _selectDate(context, field.key)
            : null,
        keyboardType: field.type == DialogFieldType.number
            ? TextInputType.number
            : TextInputType.text,
        decoration: InputDecoration(
          labelText: field.label,
          labelStyle: TextStyle(color: widget.color),
          border: const OutlineInputBorder(),
          errorStyle: TextStyle(color: widget.color),
          // focusColor: Colors.orange,
          // fillColor: Colors.orange,
          // hoverColor: Colors.orange,
          suffixIcon: field.type == DialogFieldType.date
              ? Icon(
                  Icons.calendar_today,
                  color: widget.color,
                )
              : null,
        ),
        // Esempio di validazione semplice
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Campo obbligatorio';
          }
          return null;
        },
      ),
    );
  }
}
