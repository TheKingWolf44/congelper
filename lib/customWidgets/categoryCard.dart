import 'dart:io';

import 'package:congelper/utils/images.dart';
import 'package:flutter/material.dart';

class CategoryCard extends State<CategoryCardWidget> {
  static const Color color = Colors.transparent;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      color: widget.color,
      child: InkWell(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Allinea a sinistra
            children: [
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Allinea elementi in alto
                children: [
                  // Icona in alto a sinistra
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color, // Sfondo bianco per l'icona
                      shape: BoxShape.circle, // Forma circolare
                    ),
                    child: widget.icon, // L'icona passata dal widget
                  ),
                  // const SizedBox(width: 10), // Spaziatura tra icona e titolo
                  // // Titolo principale
                  // Expanded(
                  //   child: Text(
                  //     widget.text,
                  //     style: TextStyle(
                  //       fontSize: 18,
                  //       fontWeight: FontWeight.bold,
                  //       color: color, // Colore del testo
                  //     ),
                  //     overflow:
                  //         TextOverflow.ellipsis, // Gestisce il testo lungo
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(height: 10), // Spaziatura tra icona e titolo
              // Titolo principale
              Text(
                widget.text,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color.withOpacity(0.8), // Colore del testo
                ),
                overflow: TextOverflow.ellipsis, // Gestisce il testo lungo
              ),

              const SizedBox(height: 10), // Spazio tra titolo e sottotitolo
              // Sottotitolo
              Flexible(
                child: Text(
                  widget.description, // Sottotitolo passato al widget
                  style: TextStyle(
                    fontSize: 14,
                    color: color.withOpacity(0.8),
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3, // Limita il sottotitolo a un massimo di 3 righe
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryCardWidget extends StatefulWidget {
  final Image icon;
  final Color color;
  final String text;
  final String description;
  final VoidCallback onTap;
  const CategoryCardWidget(
      {Key? key,
      required this.text,
      required this.description,
      required this.icon,
      required this.color,
      required this.onTap})
      : super(key: key);
  @override
  State<CategoryCardWidget> createState() => CategoryCard();
}
