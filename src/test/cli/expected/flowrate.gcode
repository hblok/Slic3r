G28 ; home
G1 Z0.3 F300
G1 X1 Y1 E1
G1 X2 Y2 E2 ; comment (x) ; dXY = 1.414mm ; dE = 1.00000mm ; dE/XY = 0.70711mm/mm; volspeed = 8.50396mm^3/sec
G1 X2.1 Y2.1 E2.001 F900 ; dXY = 0.141mm ; dE = 0.00100mm ; dE/XY = 0.00707mm/mm; volspeed = 0.25512mm^3/sec
G1 X2.15 Y2.1 E2.002 ; dXY = 0.050mm ; dE = 0.00100mm ; dE/XY = 0.02000mm/mm; volspeed = 0.72158mm^3/sec
T1
G1 X3 Y3 T1 E3 ; dXY = 1.238mm ; dE = 0.99800mm ; dE/XY = 0.80618mm/mm; volspeed = 77.14382mm^3/sec
G92 E0
G1 X-4 Y5 E.5 F1200 ; dXY = 7.280mm ; dE = 0.50000mm ; dE/XY = 0.06868mm/mm; volspeed = 8.76278mm^3/sec
G1 X10 Y5 E1.5 ; dXY = 14.000mm ; dE = 1.00000mm ; dE/XY = 0.07143mm/mm; volspeed = 9.11342mm^3/sec
; filament used = 12.3mm (4.5cm3)
M106 S128
M106 S0
