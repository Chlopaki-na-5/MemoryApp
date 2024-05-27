import 'package:flutter/material.dart';

class OptionsScreen extends StatefulWidget {
  @override
  _OptionsScreenState createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  int _numberOfPlayers = 1;
  int _roundTime = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Opcje',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: Offset(2.0, 2.0),
                blurRadius: 3.0,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ],
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffbeb4ff),
              Color(0xffb4efff),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Liczba graczy:', style: TextStyle(fontSize: 24)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (_numberOfPlayers > 1) _numberOfPlayers--;
                      });
                    },
                  ),
                  Text('$_numberOfPlayers', style: TextStyle(fontSize: 24)),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        _numberOfPlayers++;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text('Czas rundy (sekundy):', style: TextStyle(fontSize: 24)),
              Slider(
                value: _roundTime.toDouble(),
                min: 30,
                max: 300,
                divisions: 27,
                label: _roundTime.toString(),
                onChanged: (double value) {
                  setState(() {
                    _roundTime = value.toInt();
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {'players': _numberOfPlayers, 'time': _roundTime});
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffb298ff),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  minimumSize: const Size(120, 50),
                ),
                child: Text('Zapisz', style: TextStyle(fontSize: 24, color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
