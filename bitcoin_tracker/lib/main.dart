import 'package:extension_example/api/crypto_api.dart';
import 'package:extension_example/model/currency.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark(),
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        title: 'Crypto Tracker',
        home: const Currencies());
  }
}

class Currencies extends StatefulWidget {
  const Currencies({Key? key}) : super(key: key);

  @override
  _CurrenciesState createState() => _CurrenciesState();
}

class _CurrenciesState extends State<Currencies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crypto Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
              // updating the data using setstate.
              // this is not a clean. just faster.
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Currency>>(
        future: CryptoApi.getCurrencies(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              Currency currency = Currency.fromJson(snapshot.data[index]);

              return ListTile(
                leading: Image.network(
                  currency.logoUrl,
                ),
                title: Text("${currency.name} (${currency.currency})"),
                subtitle: Text(currency.price.toStringAsFixed(2)),
                trailing: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: currency.oneDayChange >= 0
                            ? const RotatedBox(
                                quarterTurns: 1,
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.green,
                                ),
                              )
                            : const RotatedBox(
                                quarterTurns: 3,
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.red,
                                ),
                              ),
                      ),
                      TextSpan(
                        text: " % " +
                            (currency.oneDayChange * 100).toStringAsFixed(2),
                        style: TextStyle(
                            color: currency.oneDayChange >= 0
                                ? Colors.green
                                : Colors.red),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
