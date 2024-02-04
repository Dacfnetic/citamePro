import 'package:citame/services/api_service.dart';
import 'package:flutter/material.dart';


class SubscriptionPage extends StatefulWidget {
  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
 int selectedRadio = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('subscripciones', style: API.estiloJ14gris,),
      ),
      body: Column(
        children: [
          RadioButtonContainer(
            title: 'Plan 1',
            description: 'este es el plan 1 y este plan tiene un costo de 14.99 por mes',
            radioValue: 1,
            groupValue: selectedRadio,
            onChanged: handleRadioValueChanged,
            height: 200, 
          ),
          SizedBox(height: 20),
          RadioButtonContainer(
            title: 'Opción 2',
            description: 'Descripción de la opción 2',
            radioValue: 2,
            groupValue: selectedRadio,
            onChanged: handleRadioValueChanged,
            height: 200, 
          ),
        ],
      ),
    );
  }

  void handleRadioValueChanged(int value) {
    setState(() {
      selectedRadio = value;
    });
  }
}

class RadioButtonContainer extends StatelessWidget {
  final String title;
  final String description;
  final int radioValue;
  final int groupValue;
  final Function(int) onChanged;
  final double height;

  RadioButtonContainer({
    required this.title,
    required this.description,
    required this.radioValue,
    required this.groupValue,
    required this.onChanged,
    this.height = 100, 
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(radioValue);
      },
      child: Container(
        decoration: BoxDecoration(color: Colors.grey.withOpacity(0.5), borderRadius: BorderRadius.circular(12)),
        height: height,
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: TextStyle(fontSize: 18)),
                  Text(description, style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
                           
                          
            Radio(
              value: radioValue,
              groupValue: groupValue,
              onChanged: (value) => onChanged(value as int),
            ),
          ],
        ),
      ),
    );
  }
}