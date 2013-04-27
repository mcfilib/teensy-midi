//define how many pots are active up to number of available analog inputs
#define analogInputs 6
//make arrays for input values and lagged input values
int inputAnalog[analogInputs];
int iAlag[analogInputs];
//make array of cc values
int ccValue[analogInputs];
// index variable for loop
int i;

void setup() {
  //MIDI rate
  Serial.begin(31250);
}

void loop() {
  // loop trough active inputs
  for (i=0;i<analogInputs;i++){
    // read current value at i-th input
    inputAnalog[i] = analogRead(i);
    // if magnitude of difference is 8 or more...
    if (abs(inputAnalog[i] - iAlag[i]) > 7){
      // calc the CC value based on the raw value
      ccValue[i] = inputAnalog[i]/8;
      // send the MIDI
      usbMIDI.sendControlChange(i, ccValue[i], 1);
      // set raw reading to lagged array for next comparison
      iAlag[i] = inputAnalog[i];
    }
  delay(5); // limits MIDI messages to reasonable number
  }
}
