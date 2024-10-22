/*
  Knock Sensor

  This sketch reads a piezo element to detect a knocking sound.
  It reads an analog pin and compares the result to a set threshold.
  If the result is greater than the threshold, it writes "knock" to the serial
  port, and toggles the LED on pin 13.

  The circuit:
	- positive connection of the piezo attached to analog in 0
	- negative connection of the piezo attached to ground
	- 1 megohm resistor attached from analog in 0 to ground

  created 25 Mar 2007
  by David Cuartielles <http://www.0j0.org>
  modified 30 Aug 2011
  by Tom Igoe

  This example code is in the public domain.

  https://www.arduino.cc/en/Tutorial/BuiltInExamples/Knock
*/

#include <Keyboard.h>
#include <Servo.h>

// these constants won't change:
const int ledPin = 13;       // LED connected to digital pin 13
const int player1_knockSensor = A0;  // the piezo is connected to analog pin 0
const int player2_knockSensor = A1;  // the piezo is connected to analog pin 0
const int threshold = 20;   // threshold value to decide when the detected sound is a knock or not

// these variables will change:
int player1_sensorReading = 0;  // variable to store the value read from the sensor pin
int player2_sensorReading = 0;  // variable to store the value read from the sensor pin
int ledState = LOW;     // variable used to store the last LED status, to toggle the light
float player1_speed = 0;
float player2_speed = 0;
String player1_string = "";
String player2_string = "";

Servo player1;  // create Servo object to control a servo
Servo player2;  // create Servo object to control a servo
// twelve Servo objects can be created on most boards

void setup() {
  pinMode(ledPin, OUTPUT);  // declare the ledPin as as OUTPUT
  Serial.begin(9600);       // use the serial port
  player1.attach(9);  // attaches the servo on pin 9 to the Servo object
  player2.attach(10);  // attaches the servo on pin 9 to the Servo object
  player1_speed = 0;
  player2_speed = 0;
}

void loop() {
  // read the sensor and store it in the variable sensorReading:
  player1_sensorReading = analogRead(player1_knockSensor);
  player2_sensorReading = analogRead(player2_knockSensor);

  // if the sensor reading is greater than the threshold:
  if (player1_sensorReading >= threshold) {
    // toggle the status of the ledPin:
    ledState = !ledState;
    // update the LED pin itself:
    digitalWrite(ledPin, ledState);
    // send the string "Knock!" back to the computer, followed by newline

    Keyboard.press(97);
    Keyboard.release(97);
    if (player1_speed <= 90) { player1_speed += 5.0; }
  }
  if (player2_sensorReading >= threshold) {
    // toggle the status of the ledPin:
    ledState = !ledState;
    // update the LED pin itself:
    digitalWrite(ledPin, ledState);
    // send the string "Knock!" back to the computer, followed by newline

    Keyboard.press(103);
    Keyboard.release(103);
    if (player2_speed <= 90) { player2_speed += 5.0; }
  }

  if (player1_speed > 0) { player1_speed -= 1.5; }
  else { player1_speed = 0; }

  if (player2_speed > 0) { player2_speed -= 1.5; }
  else { player2_speed = 0; }

  Serial.print("P1:");
  Serial.println(player1_speed);
  Serial.print("P2:");
  Serial.println(player2_speed);
  player1.write(player1_speed);    
  player2.write(player2_speed);           // tell servo to go to position in variable 'pos'
  delay(100);  // delay to avoida overloading the serial port buffer
}
