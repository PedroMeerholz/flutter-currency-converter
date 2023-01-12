import 'package:currency_converter/requisition/requisition.dart';
import 'package:currency_converter/widgets/request_message.dart';
import 'package:flutter/material.dart';

import '../widgets/currency_text_field.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  double? dolar;
  double? euro;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          title: const Text(
            'Currency Converter',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Container(
                  color: Colors.blue,
                );
              case ConnectionState.waiting:
                return RequestMessage(text: 'Carregando dados...');
              default:
                if (snapshot.hasError) {
                  return RequestMessage(text: 'Erro ao carregar dados...');
                } else {
                  dolar = snapshot.data!['results']['currencies']['USD']['buy'];
                  euro = snapshot.data!['results']['currencies']['EUR']['buy'];
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: const [
                          Icon(
                            Icons.monetization_on_rounded,
                            size: 150,
                            color: Colors.yellow,
                          ),
                          CurrencyTextField(prefixText: 'R\$', labelText: 'Reais',),
                          Divider(),
                          CurrencyTextField(prefixText: 'US', labelText: 'Dólares',),
                          Divider(),
                          CurrencyTextField(prefixText: 'EUR', labelText: 'Euros'),
                        ],
                      ),
                    ),
                  );
                }
            }
          },
          future: Requisition.fetch(),
        ),
      ),
    );
  }
}
