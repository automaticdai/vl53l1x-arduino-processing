/**
 * Simple Read
 * 
 * Read data from the serial port and change the color of a rectangle
 * when a switch connected to a Wiring or Arduino board is pressed and released.
 * This example works with the Wiring / Arduino program that follows below.
 */


import processing.serial.*;

Serial myPort;  // Create object from Serial class
int val;        // Data received from the serial port
int lf = 10;    // Linefeed in ASCII
String myString = null;



void setup() 
{
  size(300, 1000);
  // I know that the first port in the serial list on my mac
  // is always my  FTDI adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 115200);
  
  textSize(48);
}

void draw()
{
   background(255);              // Set background to white
   
  //if ( myPort.available() > 0) {  // If data is available,
  //  val = myPort.read();          // read it and store it in val
  //  println(val);
  //}
  if ( myPort.available() > 0) {
    String myString = myPort.readStringUntil(lf);
    
    try {
      myString = myString.substring(0, myString.length() - 2);
    } catch (Exception e) {
  
    }
    
    try {
      val = Integer.parseInt(myString);
      //println(val);
    } catch (NumberFormatException e) {
      //Will Throw exception!
      //do something! anything to handle the exception.
      println("error");
    }
  }
  
  text(Integer.toString(val) + "mm", 70, 50);
  //colorMode(HSB, 360, 1000, 1000);
  fill(color(47,120,214));
  
  int recHeight = val;
  if (recHeight > 900) {recHeight = 900;}
  rect(250,970,-200,-recHeight);
}



/*

// Wiring / Arduino Code
// Code for sensing a switch status and writing the value to the serial port.

int switchPin = 4;                       // Switch connected to pin 4

void setup() {
  pinMode(switchPin, INPUT);             // Set pin 0 as an input
  Serial.begin(9600);                    // Start serial communication at 9600 bps
}

void loop() {
  if (digitalRead(switchPin) == HIGH) {  // If switch is ON,
    Serial.write(1);               // send 1 to Processing
  } else {                               // If the switch is not ON,
    Serial.write(0);               // send 0 to Processing
  }
  delay(100);                            // Wait 100 milliseconds
}

*/
