<<<<<<< HEAD
/**
 * Copyright (c) 2021 ECE 341 Winter 2021 Section 3 Group 4
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * @file   index.ino
 * @author Anthony Kung <hi@anth.dev>
 * @date   Created on Feburary 18 2021, 10:33 PM
 */

/* Add Libraries */
#include "arduinoFFT.h"


/* Set Prescaler To 16 */
/* 16MHz / 16 = 1MHz ADC rate */
#define sbi(ADCSRA, ADPS2); /* Set Bit in I/O Register */
#define cbi(ADCSRA, ADPS1); /* Clear Bit in I/O Register */
#define cbi(ADCSRA, ADPS0); /* Prescale 16: ADPS2 1 ADPS1 0 ADPS0 0*/

#define SCL_INDEX 0x00
#define SCL_TIME 0x01
#define SCL_FREQUENCY 0x02
#define SCL_PLOT 0x03

/* Global Constants */
const int LED1 = 3;
const int LED2 = 4;
const int LED3 = 5;
const int LED4 = 6;
const int LED5 = 7;
const int LED6 = 8;
const int LED7 = 9;
const int LED8 = 10;
const int loopTime = 500; /* miliseconds */
const int MCIN = A0;
const int numSams = 128; /* Number of Samples */
const int samFreq = 10500; /* Sampling Frequency (Hz) */

/* Global Variables */
unsigned int curry = 0;
double sams[numSams];
double fake[numSams];
arduinoFFT FFT = arduinoFFT();

/* Declare Functions */
void allOff();
void allOn();
void testLoop();
void sampling();
void deepFake();
double fftFun();
void PrintVector(double *vData, uint16_t bufferSize, uint8_t scaleType);

/* Initialization */
void setup() {
  Serial.begin(115200);
  deepFake();
  allOff();
}

/* Main Function */
void loop() {
  sampling();
  double FFT = fftFun();
  if (FFT < 248) {
    allOff();
  }
  /* C4 261.6256 */
  else if (FFT > 248 && FFT <= 275) {
    allOff();
    digitalWrite(LED1, HIGH);
  }
  /* D4 293.6648 */
  else if (FFT > 278 && FFT <= 309) {
    allOff();
    digitalWrite(LED2, HIGH);
  }
  /* E4 329.6276 */
  else if (FFT > 313 && FFT <= 338) {
    allOff();
    digitalWrite(LED3, HIGH);
  }
  /* F4 349.2282 */
  else if (FFT > 338 && FFT <= 367) {
    allOff();
    digitalWrite(LED4, HIGH);
  }
  /* G4 391.9954 */
  else if (FFT > 372 && FFT <= 412) {
    allOff();
    digitalWrite(LED5, HIGH);
  }
  /* A4 440.0000 */
  else if (FFT > 418 && FFT <= 462) {
    allOff();
    digitalWrite(LED6, HIGH);
  }
  /* B4 493.8833 */
  else if (FFT > 469 && FFT <= 507) {
    allOff();
    digitalWrite(LED7, HIGH);
  }
  /* C5 523.2511 */
  else if (FFT > 507 && FFT <= 550) {
    allOff();
    digitalWrite(LED8, HIGH);
  }
  else if (FFT > 550) {
    allOff();
  }
}

void allOff() {
  digitalWrite(LED1, LOW);
  digitalWrite(LED2, LOW);
  digitalWrite(LED3, LOW);
  digitalWrite(LED4, LOW);
  digitalWrite(LED5, LOW);
  digitalWrite(LED6, LOW);
  digitalWrite(LED7, LOW);
  digitalWrite(LED8, LOW);
}

void allOn() {
  digitalWrite(LED1, HIGH);
  digitalWrite(LED2, HIGH);
  digitalWrite(LED3, HIGH);
  digitalWrite(LED4, HIGH);
  digitalWrite(LED5, HIGH);
  digitalWrite(LED6, HIGH);
  digitalWrite(LED7, HIGH);
  digitalWrite(LED8, HIGH);
}

void testLoop() {
  digitalWrite(LED1, HIGH);
  delay(loopTime);
  digitalWrite(LED1, LOW);
  digitalWrite(LED2, HIGH);
  delay(loopTime);
  digitalWrite(LED2, LOW);
  digitalWrite(LED3, HIGH);
  delay(loopTime);
  digitalWrite(LED3, LOW);
  digitalWrite(LED4, HIGH);
  delay(loopTime);
  digitalWrite(LED4, LOW);
  digitalWrite(LED5, HIGH);
  delay(loopTime);
  digitalWrite(LED5, LOW);
  digitalWrite(LED6, HIGH);
  delay(loopTime);
  digitalWrite(LED6, LOW);
  digitalWrite(LED7, HIGH);
  delay(loopTime);
  digitalWrite(LED7, LOW);
  digitalWrite(LED8, HIGH);
  delay(loopTime);
  digitalWrite(LED8, LOW);
}

/**
 * Sampling Function
 * Required Frequency: 10.5 kHz
 * Minimium Period: 95 us
 * Arduino Resolution: 4 us
 * Arduino @ 16MHz
 * Time overflow at ~4200000000 us
 * We are not waiting here for anything
 * To get the maximium sampling rate
 */
void sampling() {
  for (int i = 0; i < numSams; i++) {
    curry = micros();
    sams[i] = analogRead(MCIN);
    while(micros() < (curry + samFreq)){
      /* Do Nothing During This Time */
      /* This is to make sure there is a fixed */
      /* Sampling frequency for FFT to use */
    }
  }
}

/**
 * Set all imagine values to 0
 */
void deepFake() {
  for (int i = 0; i < numSams; i++) {
    fake[i] = 0;
  }
}

/**
 * FFT Function
 * Use the FFT library
 */
double fftFun() {
  Serial.println("Data:");
  PrintVector(sams, numSams, SCL_TIME);

  FFT.Windowing(sams, numSams, FFT_WIN_TYP_HAMMING, FFT_FORWARD);
  Serial.println("Weighed data:");
  PrintVector(sams, numSams, SCL_TIME);

  FFT.Compute(sams, fake, numSams, FFT_FORWARD);
  Serial.println("Computed Real values:");
  PrintVector(sams, numSams, SCL_INDEX);

  FFT.ComplexToMagnitude(sams, fake, numSams);
  Serial.println("Computed magnitudes:");
  PrintVector(sams, (numSams >> 1), SCL_FREQUENCY);

  double freq = FFT.MajorPeak(sams, numSams, samFreq);
  //Serial.print(micros());
  //Serial.print(" ");
  //Serial.println(freq);
  return freq;
}

/**
 * Debug Printout
 */
void PrintVector(double *vData, uint16_t bufferSize, uint8_t scaleType)
{
  for (uint16_t i = 0; i < bufferSize; i++)
  {
    double abscissa;
    /* Print abscissa value */
    switch (scaleType)
    {
      case SCL_INDEX:
        abscissa = (i * 1.0);
  break;
      case SCL_TIME:
        abscissa = ((i * 1.0) / samFreq);
  break;
      case SCL_FREQUENCY:
        abscissa = ((i * 1.0 * samFreq) / numSams);
  break;
    }
    Serial.print(abscissa, 6);
    if(scaleType==SCL_FREQUENCY)
      Serial.print("Hz");
    Serial.print(" ");
    Serial.println(vData[i], 4);
  }
  Serial.println();
}
=======
/**
 * Copyright (c) 2021 ECE 341 Winter 2021 Section 3 Group 4
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * @file   index.ino
 * @author Anthony Kung <hi@anth.dev>
 * @date   Created on Feburary 18 2021, 10:33 PM
 */

/* Add Libraries */
#include "arduinoFFT.h"


/* Set Prescaler To 16 */
/* 16MHz / 16 = 1MHz ADC rate */
#define sbi(ADCSRA, ADPS2); /* Set Bit in I/O Register */
#define cbi(ADCSRA, ADPS1); /* Clear Bit in I/O Register */
#define cbi(ADCSRA, ADPS0); /* Prescale 16: ADPS2 1 ADPS1 0 ADPS0 0*/

#define SCL_INDEX 0x00
#define SCL_TIME 0x01
#define SCL_FREQUENCY 0x02
#define SCL_PLOT 0x03

/* Global Constants */
const int LED1 = 3;
const int LED2 = 4;
const int LED3 = 5;
const int LED4 = 6;
const int LED5 = 7;
const int LED6 = 8;
const int LED7 = 9;
const int LED8 = 10;
const int loopTime = 500; /* miliseconds */
const int MCIN = A0;
const int numSams = 128; /* Number of Samples */
const int samFreq = 10500; /* Sampling Frequency (Hz) */

/* Global Variables */
unsigned int curry = 0;
double sams[numSams];
double fake[numSams];
arduinoFFT FFT = arduinoFFT();

/* Declare Functions */
void allOff();
void allOn();
void testLoop();
void sampling();
void deepFake();
double fftFun();
void PrintVector(double *vData, uint16_t bufferSize, uint8_t scaleType);

/* Initialization */
void setup() {
  Serial.begin(115200);
  deepFake();
  allOff();
}

/* Main Function */
void loop() {
  sampling();
  double FFT = fftFun();
  if (FFT < 248) {
    allOff();
  }
  /* C4 261.6256 */
  else if (FFT > 248 && FFT <= 275) {
    allOff();
    digitalWrite(LED1, HIGH);
  }
  /* D4 293.6648 */
  else if (FFT > 278 && FFT <= 309) {
    allOff();
    digitalWrite(LED2, HIGH);
  }
  /* E4 329.6276 */
  else if (FFT > 313 && FFT <= 338) {
    allOff();
    digitalWrite(LED3, HIGH);
  }
  /* F4 349.2282 */
  else if (FFT > 338 && FFT <= 367) {
    allOff();
    digitalWrite(LED4, HIGH);
  }
  /* G4 391.9954 */
  else if (FFT > 372 && FFT <= 412) {
    allOff();
    digitalWrite(LED5, HIGH);
  }
  /* A4 440.0000 */
  else if (FFT > 418 && FFT <= 462) {
    allOff();
    digitalWrite(LED6, HIGH);
  }
  /* B4 493.8833 */
  else if (FFT > 469 && FFT <= 507) {
    allOff();
    digitalWrite(LED7, HIGH);
  }
  /* C5 523.2511 */
  else if (FFT > 507 && FFT <= 550) {
    allOff();
    digitalWrite(LED8, HIGH);
  }
  else if (FFT > 550) {
    allOff();
  }
}

void allOff() {
  digitalWrite(LED1, LOW);
  digitalWrite(LED2, LOW);
  digitalWrite(LED3, LOW);
  digitalWrite(LED4, LOW);
  digitalWrite(LED5, LOW);
  digitalWrite(LED6, LOW);
  digitalWrite(LED7, LOW);
  digitalWrite(LED8, LOW);
}

void allOn() {
  digitalWrite(LED1, HIGH);
  digitalWrite(LED2, HIGH);
  digitalWrite(LED3, HIGH);
  digitalWrite(LED4, HIGH);
  digitalWrite(LED5, HIGH);
  digitalWrite(LED6, HIGH);
  digitalWrite(LED7, HIGH);
  digitalWrite(LED8, HIGH);
}

void testLoop() {
  digitalWrite(LED1, HIGH);
  delay(loopTime);
  digitalWrite(LED1, LOW);
  digitalWrite(LED2, HIGH);
  delay(loopTime);
  digitalWrite(LED2, LOW);
  digitalWrite(LED3, HIGH);
  delay(loopTime);
  digitalWrite(LED3, LOW);
  digitalWrite(LED4, HIGH);
  delay(loopTime);
  digitalWrite(LED4, LOW);
  digitalWrite(LED5, HIGH);
  delay(loopTime);
  digitalWrite(LED5, LOW);
  digitalWrite(LED6, HIGH);
  delay(loopTime);
  digitalWrite(LED6, LOW);
  digitalWrite(LED7, HIGH);
  delay(loopTime);
  digitalWrite(LED7, LOW);
  digitalWrite(LED8, HIGH);
  delay(loopTime);
  digitalWrite(LED8, LOW);
}

/**
 * Sampling Function
 * Required Frequency: 10.5 kHz
 * Minimium Period: 95 us
 * Arduino Resolution: 4 us
 * Arduino @ 16MHz
 * Time overflow at ~4200000000 us
 * We are not waiting here for anything
 * To get the maximium sampling rate
 */
void sampling() {
  for (int i = 0; i < numSams; i++) {
    curry = micros();
    sams[i] = (analogRead(MCIN) - 512)/8;
    while(micros() < (curry + 95)){
      /* Do Nothing During This Time */
      /* This is to make sure there is a fixed */
      /* Sampling frequency for FFT to use */
      //Serial.println(curry);
    }
    //Serial.println("Test out");
  }
}

/**
 * Set all imagine values to 0
 */
void deepFake() {
  for (int i = 0; i < numSams; i++) {
    sams[i] = 0.0;
    fake[i] = 0.0;
  }
}

/**
 * FFT Function
 * Use the FFT library
 */
double fftFun() {
  Serial.println("Data:");
  PrintVector(sams, numSams, SCL_TIME);
  
  FFT.Windowing(sams, numSams, FFT_WIN_TYP_HAMMING, FFT_FORWARD);
  Serial.println("Weighed data:");
  PrintVector(sams, numSams, SCL_TIME);
  
  FFT.Compute(sams, fake, numSams, FFT_FORWARD);
  Serial.println("Computed Real values:");
  PrintVector(sams, numSams, SCL_INDEX);
  
  FFT.ComplexToMagnitude(sams, fake, numSams);
  Serial.println("Computed magnitudes:");
  PrintVector(sams, (numSams >> 1), SCL_FREQUENCY);
  
  double freq = FFT.MajorPeak(sams, numSams, samFreq);
  Serial.print(micros());
  Serial.print(" ");
  Serial.println(freq);
  deepFake();
  return freq;
}



/**
 * Debug Printout
 */
void PrintVector(double *vData, uint16_t bufferSize, uint8_t scaleType)
{
  for (uint16_t i = 0; i < bufferSize; i++)
  {
    double abscissa;
    /* Print abscissa value */
    switch (scaleType)
    {
      case SCL_INDEX:
        abscissa = (i * 1.0);
  break;
      case SCL_TIME:
        abscissa = ((i * 1.0) / samFreq);
  break;
      case SCL_FREQUENCY:
        abscissa = ((i * 1.0 * samFreq) / numSams);
  break;
    }
    Serial.print(abscissa, 6);
    if(scaleType==SCL_FREQUENCY)
      Serial.print("Hz");
    Serial.print(" ");
    Serial.println(vData[i], 4);
  }
  Serial.println();
}
>>>>>>> a0c44afd348220d474752e383cc5503cd4fe023b
