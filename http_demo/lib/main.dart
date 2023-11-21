import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  String? number1 = sharedPreferences.getString('number1');
  String? number2 = sharedPreferences.getString('number2');
  runApp(MainApp(
    number1: number1,
    number2: number2,
    preferences: sharedPreferences,
  ));
}

class MainApp extends StatefulWidget {
  final String? number1;
  final String? number2;
  final SharedPreferences preferences;

  const MainApp(
      {super.key, this.number1, this.number2, required this.preferences});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late TextEditingController txtFirstNumber;
  late TextEditingController txtSecondNumber;
  bool isLoading = false;
  String result = "";

  @override
  void initState() {
    super.initState();
    txtFirstNumber = TextEditingController(text: widget.number1);
    txtSecondNumber = TextEditingController(text: widget.number2);
  }

  @override
  void dispose() {
    txtFirstNumber.dispose();
    txtSecondNumber.dispose();
    super.dispose();
  }

  Future<String> getDataFromInternet(String a, String b) async {
    final response = await http.get(
      Uri.parse('https://rodavid2012.pythonanywhere.com/add?a=$a&b=$b'),
    );
    if (response.statusCode == 200) {
      return (response.body);
    }
    return "Error accessing internet";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: txtFirstNumber,
                  decoration: const InputDecoration(labelText: 'Number 1'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: txtSecondNumber,
                  decoration: const InputDecoration(labelText: 'Number 2'),
                ),
              ),
              isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        onSubmit();
                      },
                      child: const Text('Submit'),
                    ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(result),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSubmit() async {
    setState(() {
      isLoading = true;
    });
    String number1 = txtFirstNumber.text;
    String number2 = txtSecondNumber.text;
    result = await getDataFromInternet(number1, number2);
    await widget.preferences.setString('number1', number1);
    await widget.preferences.setString('number2', number2);
    setState(() {
      isLoading = false;
    });
  }
}
