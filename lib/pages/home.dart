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

  final TextEditingController realController = TextEditingController();
  final TextEditingController dolarController = TextEditingController();
  final TextEditingController euroController = TextEditingController();

  void _realChanged(String text) {
    double real = double.parse(text);
    dolarController.text = (real / dolar!).toStringAsFixed(2);
    euroController.text = (real / euro!).toStringAsFixed(2);
  }

  void _dolarChanged(String text) {
    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar!).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar! / euro!).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    double euro = double.parse(text);
    realController.text = (euro * this.euro!).toStringAsFixed(2);
    dolarController.text = (euro * this.euro! / dolar!).toStringAsFixed(2);
  }

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
          actions: [
            IconButton(
              onPressed: () {
                realController.clear();
                dolarController.clear();
                euroController.clear();
              },
              icon: Icon(
                Icons.refresh,
                color: Colors.black,
              ),
            ),
          ],
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
                        children: [
                          const Icon(
                            Icons.monetization_on_rounded,
                            size: 150,
                            color: Colors.yellow,
                          ),
                          CurrencyTextField(
                            prefixText: 'R\$',
                            labelText: 'Reais',
                            controller: realController,
                            onChangedFunction: _realChanged,
                          ),
                          Divider(),
                          CurrencyTextField(
                            prefixText: 'US',
                            labelText: 'Dólares',
                            controller: dolarController,
                            onChangedFunction: _dolarChanged,
                          ),
                          Divider(),
                          CurrencyTextField(
                            prefixText: 'EUR',
                            labelText: 'Euros',
                            controller: euroController,
                            onChangedFunction: _euroChanged,
                          ),
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
