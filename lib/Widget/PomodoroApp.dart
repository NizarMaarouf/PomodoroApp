// ignore_for_file: file_names, prefer_const_constructors, non_constant_identifier_names, unused_local_variable, unrelated_type_equality_checks, avoid_unnecessary_containers, unnecessary_string_interpolations

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PomodoroApp extends StatefulWidget {
  const PomodoroApp({super.key});

  @override
  State<PomodoroApp> createState() => _PomodoroAppState();
}

class _PomodoroAppState extends State<PomodoroApp> {
  //----------------DURATION TIME---------------------------------
  Duration deuration = Duration(minutes: 25);
  //we must put the ? in the end of Timer .....
  Timer? pomodoro;
//------------------STARTTIMER FUNCTION--------------------------
  startTimer() {
    pomodoro = Timer.periodic(Duration(seconds: 1), (test) {
      setState(() {
        int newSeconds = deuration.inSeconds;
        if (deuration.inSeconds == 0) {
          test.cancel();

          setState(() {
            deuration = Duration(minutes: 25);
            isRunning = false;
          });
        } else {
          deuration = Duration(seconds: newSeconds - 1);
        }
      });
    });
  }

//-----------------CANCELTIMER FUNCTION---------------------------
  cancelTimer() {
    int newSeconds = deuration.inSeconds;
    setState(() {
      deuration.inSeconds > 0
          ? deuration = Duration(minutes: 25)
          : deuration = Duration(seconds: newSeconds);
      isRunning = false;
    });
  }

//---------------------STOPTIMER FUNCTION----------------------------
  stopTimer() {
    setState(() {
      pomodoro!.cancel();
      isRunning = true;
    });
  }

//--------------------RESUMETIMER FUNCTION----------------------------
  resumeTimer() {
    setState(() {
      startTimer();
    });
  }

//-------------------HELPER PARAMETER--------------------------------
  bool isRunning = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text(
            'POMODORO',
            style: TextStyle(fontSize: 30, color: Colors.amber),
          ),
          centerTitle: true,
        ),
//-----------------------------BODY-----------------------------------------
        body: Container(
          padding: EdgeInsets.fromLTRB(30, 8, 30, 8),
          color: Colors.yellow[800],
          width: double.infinity,
          height: double.infinity,

//-----------------------THE BOX'S OF THE TIMER -----------------------------
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
//------------------------TITLE CREATE---------------------------------------
              Container(
                margin: EdgeInsets.only(bottom: 100),
                alignment: AlignmentDirectional.center,
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue[800],
                  border: Border.all(width: 2, color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  'Created By Nizar Maarouf',
                  style: TextStyle(fontSize: 25, color: Colors.amber),
                ),
              ),
//----------------------TEXT : CircularPercentIndicator----------------------------

              Container(
                alignment: AlignmentDirectional.center,
               
                margin: EdgeInsets.only(bottom: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircularPercentIndicator(
                      radius: 110.0,
                      center: Text(
                        "${deuration.inMinutes.remainder(60).
                        toString().padLeft(2, "0")}:${deuration.inSeconds
                        .remainder(60).toString().padLeft(2, "0")}",
                        style: TextStyle(fontSize: 65, color: Colors.black),
                      ),
                      progressColor: Color.fromARGB(255, 255, 85, 113),
                      backgroundColor: Colors.blue,
                      lineWidth: 8.0,
                      percent:deuration.inSeconds/1500,
                      animation: true,
                      animateFromLastPercent: true,
                      animationDuration: 1000,
                    ),
                  ],
                ),
              ),

//-------------------------THR BUTTON OF THE STOPER---------------------------
              isRunning
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.red,
                            minimumSize: Size(80, 35),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                          onPressed: () {
                            (pomodoro!.isActive) ? stopTimer() : resumeTimer();
                          },
                          child: Text(
                            pomodoro!.isActive ? 'Stop' : 'Resume',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.red,
                            minimumSize: Size(80, 35),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                          onPressed: () {
                            cancelTimer();
                          },
                          child: Text(
                            'Cansel',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        // foregroundColor: Colors.white,
                        backgroundColor: Colors.blue[900],
                        minimumSize: Size(80, 35),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                      ),
                      onPressed: () {
                        setState(() {
                          startTimer();
                          isRunning = true;
                        });
                      },
                      child: Text(
                        'Start Timer',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
