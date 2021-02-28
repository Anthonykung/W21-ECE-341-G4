EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Device:Microphone Electret_Mic
U 1 1 603B1137
P 5470 4000
F 0 "Electret_Mic" H 5600 4046 50  0000 L CNN
F 1 "Microphone" H 5600 3955 50  0000 L CNN
F 2 "" V 5470 4100 50  0001 C CNN
F 3 "~" V 5470 4100 50  0001 C CNN
	1    5470 4000
	1    0    0    -1  
$EndComp
$Comp
L Device:R 5.9k
U 1 1 603B7BB6
P 5470 3450
F 0 "5.9k" H 5540 3496 50  0000 L CNN
F 1 "R" H 5540 3405 50  0000 L CNN
F 2 "" V 5400 3450 50  0001 C CNN
F 3 "~" H 5470 3450 50  0001 C CNN
	1    5470 3450
	1    0    0    -1  
$EndComp
Wire Wire Line
	5470 3800 5470 3600
$Comp
L power:Earth #PWR?
U 1 1 603B84A1
P 5470 4350
F 0 "#PWR?" H 5470 4100 50  0001 C CNN
F 1 "Earth" H 5470 4200 50  0001 C CNN
F 2 "" H 5470 4350 50  0001 C CNN
F 3 "~" H 5470 4350 50  0001 C CNN
	1    5470 4350
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 603B9718
P 5470 3150
F 0 "#PWR?" H 5470 3000 50  0001 C CNN
F 1 "VCC" H 5485 3323 50  0000 C CNN
F 2 "" H 5470 3150 50  0001 C CNN
F 3 "" H 5470 3150 50  0001 C CNN
	1    5470 3150
	1    0    0    -1  
$EndComp
Wire Wire Line
	5470 3150 5470 3300
Wire Wire Line
	5470 4200 5470 4350
$EndSCHEMATC
