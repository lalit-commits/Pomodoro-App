import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_restart/flutter_restart.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home:Pomodoro() ,
    );
  }
}

class Pomodoro extends StatefulWidget {

  @override
  _PomodoroState createState() => _PomodoroState();
}
bool restart = false;
bool timerUpdate = true;
bool textUpdate = true;
String displayText = 'Tap Play to start';
CountDownController _controller = CountDownController();



class _PomodoroState extends State<Pomodoro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xFF30384C) ,
        centerTitle: true,
        title: Text('Pomodoro App',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xFF06EC8C),
        ),
        ),
      ),
      backgroundColor:Color(0xFF30384C) ,

      body: Padding(
        padding: EdgeInsets.symmetric(vertical:50),
        child: Column(
          children : [
            Flexible(
              child: CircularCountDownTimer(
                duration: 1500,
                initialDuration: 0,
                controller: _controller,
                width: MediaQuery.of(context).size.width / 1.5,
                height: MediaQuery.of(context).size.height /1.5,
                ringColor: Color(0xFF06EC8C),
                ringGradient: null,
                fillColor: Colors.purpleAccent,
                fillGradient: null,
                backgroundColor: Color(0xFF30384C),
                backgroundGradient: null,
                strokeWidth: 20.0,
                strokeCap: StrokeCap.round,
                textStyle: TextStyle(
                  fontFamily: 'Orbitron',
                    fontSize: 60.0, color: Colors.amber, fontWeight: FontWeight.bold),
                textFormat: CountdownTextFormat.MM_SS,
                isReverse: false,
                isReverseAnimation: false,
                isTimerTextShown: true,
                autoStart: false,
                onStart: () {
                  print('Countdown Started');
                  if(displayText=='Tap to restart'&& timerUpdate==false)
                  {
                    timerUpdate = true;
                  }
                  if(timerUpdate)
                    displayText = 'Working Time';
                  else
                    displayText = 'Break Time';

                  setState(() {
                  });
                  },
                onComplete: () {
                  print('Countdown Ended');
                  if(timerUpdate)
                  displayText = 'Break Time';
                  else {
                    displayText = 'Tap to restart ';
                    restart = true;
                  }
                  timerUpdate = false;

                  setState(() {

                  });
                }
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: ()async {
                    if(restart) {
                      final result = await FlutterRestart.restartApp();
                      print(result);
                    }
                  },
                  child: Container(

                    padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10,),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.amber,width: 3),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(displayText,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF06EC8C),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              children: [

              timerUpdate ? Expanded(
                    child:IconButton(
                      icon: Icon(Icons.play_arrow,
                      color: Colors.green.shade600,
                        size: 80,
                      ),
                      onPressed: () {
                        _controller.start();
                        setState(() {

                        });

                      },
                    )
               ):
              Expanded(
                  child:IconButton(
                    icon: Icon(Icons.play_arrow,
                      color: Colors.green.shade600,
                      size: 80,
                    ),
                    onPressed: () {

                      _controller.restart(duration: 300);
                      setState(() {

                      });

                    },
                  ),
              ),
                Expanded(
                    child:IconButton(
                      icon: Icon(Icons.pause,
                        color: Colors.red.shade700,
                        size: 80,
                      ),
                      onPressed: () {
                        setState(() {
                        _controller.pause();
                        });
                      },
                    )
               ),

              ],
            ),

          ]
        ),
      ),
    );
  }
}
