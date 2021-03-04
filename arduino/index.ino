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

/* Global Variables */

/* Declare Functions */
void allOff();
void allOn();
void testLoop();

/* Initialization */
void setup() {
  Serial.begin(115200);
  allOff();
}

/* Main Function */
void loop() {
  double MCVAL = analogRead(MCIN);
  double PWM = map(MCVAL, 0, 1023, 0, 255);
  Serial.print("MCVAL: ");
  Serial.println(MCVAL);
  Serial.print("PWM: ");
  Serial.println(PWM);
  if (MCVAL < 255) {
    allOff();
  }
  else if (MCVAL > 255 && MCVAL <= 351) {
    allOff();
    digitalWrite(LED1, HIGH);
  }
  else if (MCVAL > 351 && MCVAL <= 447) {
    allOff();
    digitalWrite(LED2, HIGH);
  }
  else if (MCVAL > 447 && MCVAL <= 543) {
    allOff();
    digitalWrite(LED3, HIGH);
  }
  else if (MCVAL > 543 && MCVAL <= 639) {
    allOff();
    digitalWrite(LED4, HIGH);
  }
  else if (MCVAL > 639 && MCVAL <= 735) {
    allOff();
    digitalWrite(LED5, HIGH);
  }
  else if (MCVAL > 735 && MCVAL <= 831) {
    allOff();
    digitalWrite(LED6, HIGH);
  }
  else if (MCVAL > 831 && MCVAL <= 927) {
    allOff();
    digitalWrite(LED7, HIGH);
  }
  else if (MCVAL > 927 && MCVAL <= 1023) {
    allOff();
    digitalWrite(LED8, HIGH);
  }
  else {
    allOn();
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
