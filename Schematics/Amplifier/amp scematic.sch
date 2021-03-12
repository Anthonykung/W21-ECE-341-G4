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
L Device:R R2
U 1 1 603F26C3
P 4750 2600
F 0 "R2" H 4820 2646 50  0000 L CNN
F 1 "200k" H 4820 2555 50  0000 L CNN
F 2 "" V 4680 2600 50  0001 C CNN
F 3 "~" H 4750 2600 50  0001 C CNN
	1    4750 2600
	1    0    0    -1  
$EndComp
$Comp
L Device:R R3
U 1 1 603F337C
P 4750 3290
F 0 "R3" H 4820 3336 50  0000 L CNN
F 1 "200k" H 4820 3245 50  0000 L CNN
F 2 "" V 4680 3290 50  0001 C CNN
F 3 "~" H 4750 3290 50  0001 C CNN
	1    4750 3290
	1    0    0    -1  
$EndComp
$Comp
L Device:R 10k
U 1 1 603F4105
P 5730 3740
F 0 "10k" V 5523 3740 50  0000 C CNN
F 1 "R5" V 5614 3740 50  0000 C CNN
F 2 "" V 5660 3740 50  0001 C CNN
F 3 "~" H 5730 3740 50  0001 C CNN
	1    5730 3740
	0    1    1    0   
$EndComp
Wire Wire Line
	4750 2745 4750 2750
Wire Wire Line
	4750 3150 4750 3155
Connection ~ 4750 2750
Connection ~ 4750 3140
Wire Wire Line
	4750 3140 4750 3145
Wire Wire Line
	5315 4075 5310 4075
Wire Wire Line
	4880 4075 4880 4070
Wire Wire Line
	4880 4070 4885 4070
Wire Wire Line
	4885 4070 4885 4075
Connection ~ 4885 4075
Wire Wire Line
	4885 4075 4880 4075
Wire Wire Line
	4590 4075 4585 4075
Connection ~ 4585 4075
Wire Wire Line
	4585 4075 4495 4075
Wire Wire Line
	5510 2800 5510 2615
Wire Wire Line
	5510 3400 5510 3480
$Comp
L power:Earth #PWR?
U 1 1 60400051
P 5510 3480
F 0 "#PWR?" H 5510 3230 50  0001 C CNN
F 1 "Earth" H 5510 3330 50  0001 C CNN
F 2 "" H 5510 3480 50  0001 C CNN
F 3 "~" H 5510 3480 50  0001 C CNN
	1    5510 3480
	1    0    0    -1  
$EndComp
$Comp
L power:Earth #PWR?
U 1 1 6040102D
P 4495 4075
F 0 "#PWR?" H 4495 3825 50  0001 C CNN
F 1 "Earth" H 4495 3925 50  0001 C CNN
F 2 "" H 4495 4075 50  0001 C CNN
F 3 "~" H 4495 4075 50  0001 C CNN
	1    4495 4075
	0    1    1    0   
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 604023CB
P 5510 2615
F 0 "#PWR?" H 5510 2465 50  0001 C CNN
F 1 "VCC" H 5525 2788 50  0000 C CNN
F 2 "" H 5510 2615 50  0001 C CNN
F 3 "" H 5510 2615 50  0001 C CNN
	1    5510 2615
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 604031FD
P 4750 2305
F 0 "#PWR?" H 4750 2155 50  0001 C CNN
F 1 "VCC" H 4765 2478 50  0000 C CNN
F 2 "" H 4750 2305 50  0001 C CNN
F 3 "" H 4750 2305 50  0001 C CNN
	1    4750 2305
	1    0    0    -1  
$EndComp
Wire Wire Line
	4750 2305 4750 2450
Connection ~ 4750 2450
Wire Wire Line
	4750 2450 4750 2455
$Comp
L power:Earth #PWR?
U 1 1 60404380
P 4750 3575
F 0 "#PWR?" H 4750 3325 50  0001 C CNN
F 1 "Earth" H 4750 3425 50  0001 C CNN
F 2 "" H 4750 3575 50  0001 C CNN
F 3 "~" H 4750 3575 50  0001 C CNN
	1    4750 3575
	1    0    0    -1  
$EndComp
Wire Wire Line
	4750 3440 4750 3575
Connection ~ 4750 3575
Wire Wire Line
	4750 3575 4750 3580
Wire Wire Line
	5880 3740 6320 3740
Wire Wire Line
	5910 3100 6320 3100
Wire Wire Line
	6320 3100 6320 3740
$Comp
L Device:R R4
U 1 1 603F4F3E
P 4735 4075
F 0 "R4" V 4528 4075 50  0000 C CNN
F 1 "220" V 4619 4075 50  0000 C CNN
F 2 "" V 4665 4075 50  0001 C CNN
F 3 "~" H 4735 4075 50  0001 C CNN
	1    4735 4075
	0    1    1    0   
$EndComp
$Comp
L pspice:OPAMP U1
U 1 1 603EF996
P 5610 3100
F 0 "U1" H 5954 3146 50  0000 L CNN
F 1 "LMC6032" H 5954 3055 50  0000 L CNN
F 2 "" H 5610 3100 50  0001 C CNN
F 3 "~" H 5610 3100 50  0001 C CNN
	1    5610 3100
	1    0    0    -1  
$EndComp
Wire Wire Line
	5010 4075 4885 4075
Wire Wire Line
	5580 3740 5310 3740
Wire Wire Line
	5310 3200 5310 3740
Connection ~ 5310 3740
Wire Wire Line
	5310 3740 5310 4075
$Comp
L Device:C C1
U 1 1 604070AD
P 4370 3000
F 0 "C1" V 4118 3000 50  0000 C CNN
F 1 "47n" V 4209 3000 50  0000 C CNN
F 2 "" H 4408 2850 50  0001 C CNN
F 3 "~" H 4370 3000 50  0001 C CNN
	1    4370 3000
	0    1    1    0   
$EndComp
$Comp
L Device:C C3
U 1 1 6040803B
P 5720 4080
F 0 "C3" V 5468 4080 50  0000 C CNN
F 1 "240p" V 5559 4080 50  0000 C CNN
F 2 "" H 5758 3930 50  0001 C CNN
F 3 "~" H 5720 4080 50  0001 C CNN
	1    5720 4080
	0    1    1    0   
$EndComp
$Comp
L Device:C C2
U 1 1 60409275
P 5160 4075
F 0 "C2" V 4908 4075 50  0000 C CNN
F 1 "47u" V 4999 4075 50  0000 C CNN
F 2 "" H 5198 3925 50  0001 C CNN
F 3 "~" H 5160 4075 50  0001 C CNN
	1    5160 4075
	0    1    1    0   
$EndComp
Connection ~ 5310 4075
Wire Wire Line
	4750 2750 4750 3000
Connection ~ 4750 3000
Wire Wire Line
	4750 3000 4750 3140
Wire Wire Line
	5320 4080 5570 4080
Wire Wire Line
	5570 4080 5570 4075
Wire Wire Line
	6320 3740 6320 4080
Connection ~ 6320 3740
Connection ~ 5570 4080
Wire Wire Line
	5870 4080 6320 4080
Wire Wire Line
	4750 3000 5310 3000
Wire Wire Line
	4750 3000 4520 3000
Connection ~ 4520 3000
Wire Wire Line
	4520 3000 4515 3000
$EndSCHEMATC
