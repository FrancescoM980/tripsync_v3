import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';

class SendReportPage extends StatelessWidget {
  TextEditingController infoController = TextEditingController();
  String typeSegnalazione = 'bug';
  SendReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: [
            Text(
              'Cosa ci vuoi segnalare?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16
              )
            ),
            SizedBox(height: 10),
            SelectFormField(
              labelText: '',
              items: [
                {
                  'value': 'bug',
                  'label': 'Problema'
                },
                {
                  'value': 'feature',
                  'label': 'Suggerimento'
                },     
              ],
              onChanged: (val) => typeSegnalazione = val,
              initialValue: typeSegnalazione,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.arrow_drop_down),
              ),
            ),
            SizedBox(height: 35),
            Text(
              'Descrivi in modo dettagliato ciò che hai da dire',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16
              )
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: infoController,
              decoration: InputDecoration(
                labelText: 'Descrizione',
                border: OutlineInputBorder(
                  
                ),
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
          ],
        ),
      )
    );
  }
}



class Selection extends StatelessWidget {
  Selection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Text('ciao'),
              ],
            )
          )
        ],
      )
    );
  }
}