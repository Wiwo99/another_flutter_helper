import 'package:another_flutter_helper/another_flutter_helper.dart';
import 'package:flutter/material.dart';

final AnotherFlutterHelper anotherFlutterHelper = AnotherFlutterHelper();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  anotherFlutterHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _geolocatorInstance = anotherFlutterHelper.geolocatorInstance;
  GeolocatorPosition? _position;
  final _storageInstance = anotherFlutterHelper.storageInstance;
  final _httpInstance = anotherFlutterHelper.httpInstance;

  void _incrementCounter() {
    final int currentCounter = _storageInstance.get("counter")?["counter"] ?? 0;
    setState(() {
      _storageInstance.set("counter", {"counter": currentCounter + 1});
    });
  }

  void _decrementCounter() {
    final int currentCounter = _storageInstance.get("counter")?["counter"] ?? 0;
    setState(() {
      _storageInstance.set("counter", {"counter": currentCounter - 1});
    });
  }

  void _clearCounter() {
    setState(() {
      _storageInstance.delete("counter");
    });
  }

  Future<Response> _getHttp() async {
    return await _httpInstance
        .get(Uri.parse("https://dummyjson.com/products/1"));
  }

  Future<void> _getCurrentPosition() async {
    final bool isLocationServiceEnabled =
        await _geolocatorInstance.isLocationServiceEnabled();

    if (isLocationServiceEnabled) {
      final GeolocatorPosition? position =
          await _geolocatorInstance.getCurrentPosition();
      setState(() {
        _position = position;
      });
    }
  }

  @override
  void initState() {
    _storageInstance.setEncryptionKey("1234567890123456");
    anotherFlutterHelper.appTrackingInstance.request();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Your current position: ${_position?.position?.latitude ?? ''} ${_position?.position?.longitude ?? ''}',
            ),
            ElevatedButton(
                onPressed: () async => await _getCurrentPosition(),
                child: const Text("Get current position")),
            const SizedBox(height: 20),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              "${_storageInstance.get("counter")?["counter"] ?? 0}",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: _incrementCounter,
                    child: const Text("Increment")),
                ElevatedButton(
                    onPressed: _decrementCounter,
                    child: const Text("Decrement")),
                ElevatedButton(
                    onPressed: _clearCounter, child: const Text("Clear")),
              ],
            ),
            const SizedBox(height: 20),
            FutureBuilder<Response>(
              future: _getHttp(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data.body);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
