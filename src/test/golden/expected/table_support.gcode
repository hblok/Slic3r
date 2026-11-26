

; input_file = table.stl
; input_file_size = 2245
; input_file_crc32 = e2ae83e8

; external perimeters extrusion width = 0.55mm (4.37mm^3/s)
; perimeters extrusion width = 0.70mm (11.44mm^3/s)
; infill extrusion width = 0.62mm (13.45mm^3/s)
; solid infill extrusion width = 0.70mm (3.81mm^3/s)
; top solid infill extrusion width = 0.70mm (2.86mm^3/s)
; support material extrusion width = 0.55mm (8.74mm^3/s)
; first layer extrusion width = 0.70mm 
M107 ; disable fan

G92 E0 ; reset extrusion distance
M104 S200 ; set temperature
G28 ; home all axes
G1 Z5 F5000 ; lift nozzle
; Filament gcode
M109 S200 ; set temperature and wait for it to be reached
G21 ; set units to millimeters
G90 ; use absolute coordinates
M82 ; use absolute distances for extrusion
G92 E0 ; reset extrusion distance
G1 Z0.350 F7800.000 ; move to next layer (0)
G1 E-2.00000 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X84.917 Y84.565 F7800.000 ; move to first skirt point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F1800.000
G1 X86.670 Y83.086 E2.07096 ; skirt
G1 X88.822 Y82.293 E2.14192 ; skirt
G1 X90.002 Y82.188 E2.17858 ; skirt
G1 X109.998 Y82.188 E2.79729 ; skirt
G1 X112.257 Y82.585 E2.86825 ; skirt
G1 X114.245 Y83.728 E2.93922 ; skirt
G1 X115.724 Y85.481 E3.01018 ; skirt
G1 X116.517 Y87.633 E3.08114 ; skirt
G1 X116.623 Y88.812 E3.11779 ; skirt
G1 X116.623 Y111.188 E3.81011 ; skirt
G1 X116.226 Y113.446 E3.88107 ; skirt
G1 X115.083 Y115.435 E3.95203 ; skirt
G1 X113.330 Y116.914 E4.02299 ; skirt
G1 X111.178 Y117.707 E4.09396 ; skirt
G1 X109.998 Y117.812 E4.13061 ; skirt
G1 X90.002 Y117.812 E4.74932 ; skirt
G1 X87.743 Y117.415 E4.82029 ; skirt
G1 X85.755 Y116.272 E4.89125 ; skirt
G1 X84.276 Y114.519 E4.96221 ; skirt
G1 X83.483 Y112.367 E5.03317 ; skirt
G1 X83.377 Y111.188 E5.06982 ; skirt
G1 X83.377 Y88.812 E5.76214 ; skirt
G1 X83.774 Y86.554 E5.83310 ; skirt
G1 X84.880 Y84.631 E5.90174 ; skirt
G1 E3.90174 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.400 Y100.400 F7800.000 ; move to first small perimeter point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F1800.000
G1 X99.600 Y100.400 E2.02477 ; small perimeter
G1 X99.600 Y99.600 E2.04953 ; small perimeter
G1 X100.400 Y99.600 E2.07430 ; small perimeter
G1 X100.400 Y100.325 E2.09675 ; small perimeter
G1 X101.025 Y101.025 F7800.000 ; move to first small perimeter point
G1 F1800.000
G1 X98.975 Y101.025 E2.16018 ; small perimeter
G1 X98.975 Y98.975 E2.22362 ; small perimeter
G1 X101.025 Y98.975 E2.28706 ; small perimeter
G1 X101.025 Y100.950 E2.34817 ; small perimeter
G1 X101.650 Y101.650 F7800.000 ; move to first external small perimeter point
G1 F1800.000
G1 X98.350 Y101.650 E2.45028 ; external small perimeter
G1 X98.350 Y98.350 E2.55239 ; external small perimeter
G1 X101.650 Y98.350 E2.65449 ; external small perimeter
G1 X101.650 Y101.575 E2.75428 ; external small perimeter
G1 X101.167 Y101.521 F7800.000 ; move inwards before travel
G1 Z0.350 F7800.000 ; move to next layer (1)
G1 E0.75428 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X102.500 Y103.888 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F1800.000
G1 X102.500 Y103.137 E2.02321 ; support material
G1 X101.250 Y103.137 E2.06188 ; support material
G1 X101.250 Y103.888 E2.08509 ; support material
G1 X100.000 Y103.888 E2.12376 ; support material
G1 X100.000 Y103.137 E2.14697 ; support material
G1 X98.750 Y103.137 E2.18564 ; support material
G1 X98.750 Y103.888 E2.20885 ; support material
G1 X97.500 Y103.888 E2.24752 ; support material
G1 X96.251 Y105.337 F7800.000 ; move to first support material point
G1 F1800.000
G1 X95.337 Y105.337 E2.27577 ; support material
G1 X95.337 Y111.188 E2.45678 ; support material
G1 X96.251 Y111.188 E2.48504 ; support material
G1 X96.251 Y105.337 E2.66605 ; support material
G1 X97.500 Y105.337 E2.70472 ; support material
G1 X97.500 Y111.188 E2.88573 ; support material
G1 X98.750 Y111.188 E2.92440 ; support material
G1 X98.750 Y105.337 E3.10541 ; support material
G1 X100.000 Y105.337 E3.14408 ; support material
G1 X100.000 Y111.188 E3.32509 ; support material
G1 X101.250 Y111.188 E3.36376 ; support material
G1 X101.250 Y105.337 E3.54477 ; support material
G1 X102.500 Y105.337 E3.58344 ; support material
G1 X102.500 Y111.188 E3.76445 ; support material
G1 E1.76445 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.249 Y105.337 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F1800.000
G1 X105.337 Y105.337 E2.02820 ; support material
G1 X105.337 Y111.188 E2.20921 ; support material
G1 X106.249 Y111.188 E2.23741 ; support material
G1 X106.249 Y105.337 E2.41842 ; support material
G1 X107.499 Y105.337 E2.45709 ; support material
G1 X107.499 Y111.188 E2.63810 ; support material
G1 X108.748 Y111.188 E2.67677 ; support material
G1 X108.748 Y105.337 E2.85778 ; support material
G1 X109.998 Y105.337 E2.89645 ; support material
G1 X109.998 Y111.188 E3.07746 ; support material
G1 E1.07746 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X109.998 Y103.613 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F1800.000
G1 X109.998 Y95.337 E2.25604 ; support material
G1 X108.748 Y95.337 E2.29471 ; support material
G1 X108.748 Y103.613 E2.55076 ; support material
G1 X107.499 Y103.613 E2.58943 ; support material
G1 X107.499 Y95.337 E2.84547 ; support material
G1 X106.249 Y95.337 E2.88414 ; support material
G1 X106.249 Y103.613 E3.14018 ; support material
G1 X105.337 Y103.613 E3.16838 ; support material
G1 X105.337 Y95.337 E3.42443 ; support material
G1 X106.249 Y95.337 E3.45263 ; support material
G1 E1.45263 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X102.500 Y93.613 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F1800.000
G1 X102.500 Y88.812 E2.14852 ; support material
G1 X101.250 Y88.812 E2.18719 ; support material
G1 X101.250 Y93.613 E2.33571 ; support material
G1 X100.000 Y93.613 E2.37438 ; support material
G1 X100.000 Y88.812 E2.52290 ; support material
G1 X98.750 Y88.812 E2.56157 ; support material
G1 X98.750 Y93.613 E2.71010 ; support material
G1 X97.500 Y93.613 E2.74877 ; support material
G1 X97.500 Y88.812 E2.89729 ; support material
G1 X96.251 Y88.812 E2.93596 ; support material
G1 X96.251 Y93.613 E3.08448 ; support material
G1 X95.337 Y93.613 E3.11274 ; support material
G1 X95.337 Y88.812 E3.26126 ; support material
G1 X96.251 Y88.812 E3.28951 ; support material
G1 E1.28951 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X92.501 Y93.613 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F1800.000
G1 X92.501 Y88.812 E2.14852 ; support material
G1 X91.252 Y88.812 E2.18719 ; support material
G1 X91.252 Y93.613 E2.33571 ; support material
G1 X90.002 Y93.613 E2.37438 ; support material
G1 X90.002 Y88.812 E2.52290 ; support material
G1 E0.52290 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.002 Y95.337 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F1800.000
G1 X90.002 Y103.613 E2.25604 ; support material
G1 X91.252 Y103.613 E2.29471 ; support material
G1 X91.252 Y95.337 E2.55076 ; support material
G1 X92.501 Y95.337 E2.58943 ; support material
G1 X92.501 Y103.613 E2.84547 ; support material
G1 E0.84547 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.002 Y105.337 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F1800.000
G1 X90.002 Y111.188 E2.18101 ; support material
G1 X91.252 Y111.188 E2.21968 ; support material
G1 X91.252 Y105.337 E2.40069 ; support material
G1 X92.501 Y105.337 E2.43936 ; support material
G1 X92.501 Y111.188 E2.62037 ; support material
G1 E0.62037 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.749 Y103.888 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F1800.000
G1 X103.749 Y95.062 E2.27306 ; support material
G1 X102.500 Y95.062 E2.31173 ; support material
G1 X102.500 Y96.863 E2.36743 ; support material
G1 X101.250 Y96.863 E2.40610 ; support material
G1 X101.250 Y95.062 E2.46180 ; support material
G1 X100.000 Y95.062 E2.50047 ; support material
G1 X100.000 Y96.863 E2.55616 ; support material
G1 X98.750 Y96.863 E2.59483 ; support material
G1 X98.750 Y95.062 E2.65053 ; support material
G1 X97.500 Y95.062 E2.68920 ; support material
G1 X97.500 Y96.863 E2.74490 ; support material
G1 X96.863 Y96.863 E2.76464 ; support material
G1 X96.863 Y103.137 E2.95879 ; support material
G1 X97.500 Y103.137 E2.97853 ; support material
G1 X97.500 Y103.888 E3.00174 ; support material
G1 X96.251 Y103.888 E3.04041 ; support material
G1 X96.251 Y95.062 E3.31347 ; support material
G1 E1.31347 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.249 Y88.812 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F1800.000
G1 X105.337 Y88.812 E2.02820 ; support material
G1 X105.337 Y93.613 E2.17672 ; support material
G1 X106.249 Y93.613 E2.20492 ; support material
G1 X106.249 Y88.812 E2.35345 ; support material
G1 X107.499 Y88.812 E2.39212 ; support material
G1 X107.499 Y93.613 E2.54064 ; support material
G1 X108.748 Y93.613 E2.57931 ; support material
G1 X108.748 Y88.812 E2.72783 ; support material
G1 X109.998 Y88.812 E2.76650 ; support material
G1 X109.998 Y93.613 E2.91502 ; support material
G1 Z0.550 F7800.000 ; move to next layer (2)
G1 E0.91502 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.450 Y90.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2833.302
G1 X110.450 Y88.500 E2.02798 ; support material
G1 X108.500 Y88.500 E2.05595 ; support material
G1 X108.500 Y90.450 E2.08393 ; support material
G1 X110.450 Y90.450 E2.11191 ; support material
G1 E0.11191 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.450 Y96.190 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2833.302
G1 X103.450 Y95.500 E2.00991 ; support material
G1 X101.066 Y95.500 E2.04412 ; support material
G1 X101.464 Y96.190 E2.05556 ; support material
G1 X103.450 Y96.190 E2.08405 ; support material
G1 X97.175 Y97.175 F7800.000 ; move to first support material point
G1 F2833.302
G1 X102.825 Y97.175 E2.16511 ; support material
G1 X102.825 Y102.825 E2.24618 ; support material
G1 X97.175 Y102.825 E2.32724 ; support material
G1 X97.175 Y97.175 E2.40830 ; support material
G1 X96.293 Y99.176 F7800.000 ; move to first support material point
G1 F2833.302
G1 X95.500 Y97.802 E2.43106 ; support material
G1 X95.500 Y101.035 E2.47744 ; support material
G1 X96.293 Y99.662 E2.50019 ; support material
G1 X96.425 Y99.662 E2.50209 ; support material
G1 X96.425 Y99.176 E2.50906 ; support material
G1 X96.293 Y99.176 E2.51096 ; support material
G1 E0.51096 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.450 Y100.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2833.302
G1 X90.450 Y98.500 E2.02798 ; support material
G1 X88.500 Y98.500 E2.05595 ; support material
G1 X88.500 Y100.450 E2.08393 ; support material
G1 X90.450 Y100.450 E2.11191 ; support material
G1 X89.700 Y99.699 F7800.000 ; move to first support material point
G1 F2833.302
G1 X89.700 Y99.250 E2.11836 ; support material
G1 X89.250 Y99.250 E2.12482 ; support material
G1 X89.250 Y99.662 E2.13072 ; support material
G1 X89.678 Y99.662 E2.13687 ; support material
G1 X89.700 Y99.699 E2.13750 ; support material
G1 E0.13750 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.450 Y90.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2833.302
G1 X90.450 Y88.500 E2.02798 ; support material
G1 X88.500 Y88.500 E2.05595 ; support material
G1 X88.500 Y90.450 E2.08393 ; support material
G1 X90.450 Y90.450 E2.11191 ; support material
G1 X100.450 Y90.450 F7800.000 ; move to first support material point
G1 F2833.302
G1 X100.450 Y88.500 E2.13989 ; support material
G1 X98.500 Y88.500 E2.16786 ; support material
G1 X98.500 Y90.450 E2.19584 ; support material
G1 X100.450 Y90.450 E2.22382 ; support material
G1 E0.22382 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X109.700 Y99.662 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2833.302
G1 X109.700 Y99.250 E2.00591 ; support material
G1 X109.250 Y99.250 E2.01237 ; support material
G1 X109.250 Y99.662 E2.01827 ; support material
G1 X109.700 Y99.662 E2.02473 ; support material
G1 X110.450 Y100.450 F7800.000 ; move to first support material point
G1 F2833.302
G1 X110.450 Y98.500 E2.05271 ; support material
G1 X108.500 Y98.500 E2.08069 ; support material
G1 X108.500 Y100.450 E2.10866 ; support material
G1 X110.450 Y100.450 E2.13664 ; support material
G1 E0.13664 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X104.200 Y104.200 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2833.302
G1 X104.200 Y94.750 E2.13558 ; support material
G1 X94.750 Y94.750 E2.27117 ; support material
G1 X94.750 Y104.200 E2.40675 ; support material
G1 X104.200 Y104.200 E2.54233 ; support material
G1 E0.54233 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.450 Y110.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2833.302
G1 X100.450 Y108.500 E2.02798 ; support material
G1 X98.500 Y108.500 E2.05595 ; support material
G1 X98.500 Y110.450 E2.08393 ; support material
G1 X100.450 Y110.450 E2.11191 ; support material
G1 E0.11191 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.450 Y110.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2833.302
G1 X90.450 Y108.500 E2.02798 ; support material
G1 X88.500 Y108.500 E2.05595 ; support material
G1 X88.500 Y110.450 E2.08393 ; support material
G1 X90.450 Y110.450 E2.11191 ; support material
G1 E0.11191 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.450 Y110.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2833.302
G1 X110.450 Y108.500 E2.02798 ; support material
G1 X108.500 Y108.500 E2.05595 ; support material
G1 X108.500 Y110.450 E2.08393 ; support material
G1 X110.450 Y110.450 E2.11191 ; support material
G1 Z0.650 F7800.000 ; move to next layer (3)
G1 E0.11191 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F708.326
G1 X99.471 Y100.529 E2.02853 ; small perimeter
G1 X99.471 Y99.471 E2.05706 ; small perimeter
G1 X100.529 Y99.471 E2.08558 ; small perimeter
G1 X100.529 Y100.454 E2.11209 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F708.326
G1 X98.836 Y101.164 E2.17491 ; small perimeter
G1 X98.836 Y98.836 E2.23773 ; small perimeter
G1 X101.164 Y98.836 E2.30056 ; small perimeter
G1 X101.164 Y101.089 E2.36135 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F900.000
G1 X98.275 Y101.725 E2.43246 ; external small perimeter
G1 X98.275 Y98.275 E2.50357 ; external small perimeter
G1 X101.725 Y98.275 E2.57467 ; external small perimeter
G1 X101.725 Y101.650 E2.64423 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z0.925 F7800.000 ; move to next layer (4)
G1 E0.64423 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X104.200 Y104.200 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X104.200 Y94.750 E2.23539 ; support material
G1 X94.750 Y94.750 E2.47078 ; support material
G1 X94.750 Y104.200 E2.70617 ; support material
G1 X104.200 Y104.200 E2.94156 ; support material
G1 E0.94156 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X109.738 Y99.662 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X109.738 Y99.212 E2.01119 ; support material
G1 X109.212 Y99.212 E2.02427 ; support material
G1 X109.212 Y99.662 E2.03546 ; support material
G1 X109.738 Y99.662 E2.04855 ; support material
G1 X110.450 Y100.450 F7800.000 ; move to first support material point
G1 F2848.542
G1 X110.450 Y98.500 E2.09712 ; support material
G1 X108.500 Y98.500 E2.14569 ; support material
G1 X108.500 Y100.450 E2.19427 ; support material
G1 X110.450 Y100.450 E2.24284 ; support material
G1 E0.24284 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.488 Y96.190 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X103.488 Y95.462 E2.01813 ; support material
G1 X101.044 Y95.462 E2.07901 ; support material
G1 X101.464 Y96.190 E2.09994 ; support material
G1 X103.488 Y96.190 E2.15035 ; support material
G1 X97.175 Y97.175 F7800.000 ; move to first support material point
G1 F2848.542
G1 X102.825 Y97.175 E2.29108 ; support material
G1 X102.825 Y102.825 E2.43182 ; support material
G1 X97.175 Y102.825 E2.57256 ; support material
G1 X97.175 Y97.175 E2.71329 ; support material
G1 X96.293 Y99.176 F7800.000 ; move to first support material point
G1 F2848.542
G1 X95.462 Y97.737 E2.75467 ; support material
G1 X95.462 Y101.100 E2.83844 ; support material
G1 X96.293 Y99.662 E2.87981 ; support material
G1 X96.463 Y99.662 E2.88404 ; support material
G1 X96.463 Y99.176 E2.89614 ; support material
G1 X96.293 Y99.176 E2.90037 ; support material
G1 E0.90037 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.450 Y100.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X90.450 Y98.500 E2.04857 ; support material
G1 X88.500 Y98.500 E2.09715 ; support material
G1 X88.500 Y100.450 E2.14572 ; support material
G1 X90.450 Y100.450 E2.19429 ; support material
G1 X89.738 Y99.738 F7800.000 ; move to first support material point
G1 F2848.542
G1 X89.738 Y99.212 E2.20738 ; support material
G1 X89.212 Y99.212 E2.22046 ; support material
G1 X89.212 Y99.662 E2.23165 ; support material
G1 X89.678 Y99.662 E2.24326 ; support material
G1 X89.738 Y99.738 E2.24566 ; support material
G1 E0.24566 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.450 Y90.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X90.450 Y88.500 E2.04857 ; support material
G1 X88.500 Y88.500 E2.09715 ; support material
G1 X88.500 Y90.450 E2.14572 ; support material
G1 X90.450 Y90.450 E2.19429 ; support material
G1 X100.450 Y90.450 F7800.000 ; move to first support material point
G1 F2848.542
G1 X100.450 Y88.500 E2.24286 ; support material
G1 X98.500 Y88.500 E2.29144 ; support material
G1 X98.500 Y90.450 E2.34001 ; support material
G1 X100.450 Y90.450 E2.38858 ; support material
G1 X110.450 Y90.450 F7800.000 ; move to first support material point
G1 F2848.542
G1 X110.450 Y88.500 E2.43715 ; support material
G1 X108.500 Y88.500 E2.48573 ; support material
G1 X108.500 Y90.450 E2.53430 ; support material
G1 X110.450 Y90.450 E2.58287 ; support material
G1 E0.58287 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.450 Y110.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X110.450 Y108.500 E2.04857 ; support material
G1 X108.500 Y108.500 E2.09715 ; support material
G1 X108.500 Y110.450 E2.14572 ; support material
G1 X110.450 Y110.450 E2.19429 ; support material
G1 E0.19429 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.450 Y110.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X100.450 Y108.500 E2.04857 ; support material
G1 X98.500 Y108.500 E2.09715 ; support material
G1 X98.500 Y110.450 E2.14572 ; support material
G1 X100.450 Y110.450 E2.19429 ; support material
G1 E0.19429 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.450 Y110.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X90.450 Y108.500 E2.04857 ; support material
G1 X88.500 Y108.500 E2.09715 ; support material
G1 X88.500 Y110.450 E2.14572 ; support material
G1 X90.450 Y110.450 E2.19429 ; support material
G1 Z0.950 F7800.000 ; move to next layer (5)
G1 E0.19429 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F712.135
G1 X99.471 Y100.529 E2.02853 ; small perimeter
G1 X99.471 Y99.471 E2.05706 ; small perimeter
G1 X100.529 Y99.471 E2.08558 ; small perimeter
G1 X100.529 Y100.454 E2.11209 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F712.135
G1 X98.836 Y101.164 E2.17491 ; small perimeter
G1 X98.836 Y98.836 E2.23773 ; small perimeter
G1 X101.164 Y98.836 E2.30056 ; small perimeter
G1 X101.164 Y101.089 E2.36135 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F900.000
G1 X98.275 Y101.725 E2.43246 ; external small perimeter
G1 X98.275 Y98.275 E2.50357 ; external small perimeter
G1 X101.725 Y98.275 E2.57467 ; external small perimeter
G1 X101.725 Y101.650 E2.64423 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
M106 S255 ; enable fan
G1 Z1.250 F7800.000 ; move to next layer (6)
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 F712.135
G1 X99.471 Y100.529 E2.67276 ; small perimeter
G1 X99.471 Y99.471 E2.70129 ; small perimeter
G1 X100.529 Y99.471 E2.72982 ; small perimeter
G1 X100.529 Y100.454 E2.75632 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F712.135
G1 X98.836 Y101.164 E2.81914 ; small perimeter
G1 X98.836 Y98.836 E2.88197 ; small perimeter
G1 X101.164 Y98.836 E2.94479 ; small perimeter
G1 X101.164 Y101.089 E3.00559 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F900.000
G1 X98.275 Y101.725 E3.07669 ; external small perimeter
G1 X98.275 Y98.275 E3.14780 ; external small perimeter
G1 X101.725 Y98.275 E3.21890 ; external small perimeter
G1 X101.725 Y101.650 E3.28846 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z1.300 F7800.000 ; move to next layer (7)
G1 E1.28846 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X104.200 Y104.200 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X104.200 Y94.750 E2.23539 ; support material
G1 X94.750 Y94.750 E2.47078 ; support material
G1 X94.750 Y104.200 E2.70617 ; support material
G1 X104.200 Y104.200 E2.94156 ; support material
G1 E0.94156 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X109.738 Y99.662 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X109.738 Y99.212 E2.01119 ; support material
G1 X109.212 Y99.212 E2.02427 ; support material
G1 X109.212 Y99.662 E2.03546 ; support material
G1 X109.738 Y99.662 E2.04855 ; support material
G1 X110.450 Y100.450 F7800.000 ; move to first support material point
G1 F2848.542
G1 X110.450 Y98.500 E2.09712 ; support material
G1 X108.500 Y98.500 E2.14569 ; support material
G1 X108.500 Y100.450 E2.19427 ; support material
G1 X110.450 Y100.450 E2.24284 ; support material
G1 E0.24284 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.488 Y96.190 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X103.488 Y95.462 E2.01813 ; support material
G1 X101.044 Y95.462 E2.07901 ; support material
G1 X101.464 Y96.190 E2.09994 ; support material
G1 X103.488 Y96.190 E2.15035 ; support material
G1 X97.175 Y97.175 F7800.000 ; move to first support material point
G1 F2848.542
G1 X102.825 Y97.175 E2.29108 ; support material
G1 X102.825 Y102.825 E2.43182 ; support material
G1 X97.175 Y102.825 E2.57256 ; support material
G1 X97.175 Y97.175 E2.71329 ; support material
G1 X96.293 Y99.176 F7800.000 ; move to first support material point
G1 F2848.542
G1 X95.462 Y97.737 E2.75467 ; support material
G1 X95.462 Y101.100 E2.83844 ; support material
G1 X96.293 Y99.662 E2.87981 ; support material
G1 X96.463 Y99.662 E2.88404 ; support material
G1 X96.463 Y99.176 E2.89614 ; support material
G1 X96.293 Y99.176 E2.90037 ; support material
G1 E0.90037 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.450 Y100.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X90.450 Y98.500 E2.04857 ; support material
G1 X88.500 Y98.500 E2.09715 ; support material
G1 X88.500 Y100.450 E2.14572 ; support material
G1 X90.450 Y100.450 E2.19429 ; support material
G1 X89.738 Y99.738 F7800.000 ; move to first support material point
G1 F2848.542
G1 X89.738 Y99.212 E2.20738 ; support material
G1 X89.212 Y99.212 E2.22046 ; support material
G1 X89.212 Y99.662 E2.23165 ; support material
G1 X89.678 Y99.662 E2.24326 ; support material
G1 X89.738 Y99.738 E2.24566 ; support material
G1 E0.24566 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.450 Y90.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X90.450 Y88.500 E2.04857 ; support material
G1 X88.500 Y88.500 E2.09715 ; support material
G1 X88.500 Y90.450 E2.14572 ; support material
G1 X90.450 Y90.450 E2.19429 ; support material
G1 X100.450 Y90.450 F7800.000 ; move to first support material point
G1 F2848.542
G1 X100.450 Y88.500 E2.24286 ; support material
G1 X98.500 Y88.500 E2.29144 ; support material
G1 X98.500 Y90.450 E2.34001 ; support material
G1 X100.450 Y90.450 E2.38858 ; support material
G1 X110.450 Y90.450 F7800.000 ; move to first support material point
G1 F2848.542
G1 X110.450 Y88.500 E2.43715 ; support material
G1 X108.500 Y88.500 E2.48573 ; support material
G1 X108.500 Y90.450 E2.53430 ; support material
G1 X110.450 Y90.450 E2.58287 ; support material
G1 E0.58287 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.450 Y110.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X110.450 Y108.500 E2.04857 ; support material
G1 X108.500 Y108.500 E2.09715 ; support material
G1 X108.500 Y110.450 E2.14572 ; support material
G1 X110.450 Y110.450 E2.19429 ; support material
G1 E0.19429 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.450 Y110.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X100.450 Y108.500 E2.04857 ; support material
G1 X98.500 Y108.500 E2.09715 ; support material
G1 X98.500 Y110.450 E2.14572 ; support material
G1 X100.450 Y110.450 E2.19429 ; support material
G1 E0.19429 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.450 Y110.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X90.450 Y108.500 E2.04857 ; support material
G1 X88.500 Y108.500 E2.09715 ; support material
G1 X88.500 Y110.450 E2.14572 ; support material
G1 X90.450 Y110.450 E2.19429 ; support material
G1 Z1.550 F7800.000 ; move to next layer (8)
G1 E0.19429 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F712.135
G1 X99.471 Y100.529 E2.02853 ; small perimeter
G1 X99.471 Y99.471 E2.05706 ; small perimeter
G1 X100.529 Y99.471 E2.08558 ; small perimeter
G1 X100.529 Y100.454 E2.11209 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F712.135
G1 X98.836 Y101.164 E2.17491 ; small perimeter
G1 X98.836 Y98.836 E2.23773 ; small perimeter
G1 X101.164 Y98.836 E2.30056 ; small perimeter
G1 X101.164 Y101.089 E2.36135 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F900.000
G1 X98.275 Y101.725 E2.43246 ; external small perimeter
G1 X98.275 Y98.275 E2.50357 ; external small perimeter
G1 X101.725 Y98.275 E2.57467 ; external small perimeter
G1 X101.725 Y101.650 E2.64423 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z1.675 F7800.000 ; move to next layer (9)
G1 E0.64423 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X104.200 Y104.200 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X104.200 Y94.750 E2.23539 ; support material
G1 X94.750 Y94.750 E2.47078 ; support material
G1 X94.750 Y104.200 E2.70617 ; support material
G1 X104.200 Y104.200 E2.94156 ; support material
G1 E0.94156 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X109.738 Y99.662 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X109.738 Y99.212 E2.01119 ; support material
G1 X109.212 Y99.212 E2.02427 ; support material
G1 X109.212 Y99.662 E2.03546 ; support material
G1 X109.738 Y99.662 E2.04855 ; support material
G1 X110.450 Y100.450 F7800.000 ; move to first support material point
G1 F2848.542
G1 X110.450 Y98.500 E2.09712 ; support material
G1 X108.500 Y98.500 E2.14569 ; support material
G1 X108.500 Y100.450 E2.19427 ; support material
G1 X110.450 Y100.450 E2.24284 ; support material
G1 E0.24284 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.488 Y96.190 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X103.488 Y95.462 E2.01813 ; support material
G1 X101.044 Y95.462 E2.07901 ; support material
G1 X101.464 Y96.190 E2.09994 ; support material
G1 X103.488 Y96.190 E2.15035 ; support material
G1 X97.175 Y97.175 F7800.000 ; move to first support material point
G1 F2848.542
G1 X102.825 Y97.175 E2.29108 ; support material
G1 X102.825 Y102.825 E2.43182 ; support material
G1 X97.175 Y102.825 E2.57256 ; support material
G1 X97.175 Y97.175 E2.71329 ; support material
G1 X96.293 Y99.176 F7800.000 ; move to first support material point
G1 F2848.542
G1 X95.462 Y97.737 E2.75467 ; support material
G1 X95.462 Y101.100 E2.83844 ; support material
G1 X96.293 Y99.662 E2.87981 ; support material
G1 X96.463 Y99.662 E2.88404 ; support material
G1 X96.463 Y99.176 E2.89614 ; support material
G1 X96.293 Y99.176 E2.90037 ; support material
G1 E0.90037 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.450 Y100.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X90.450 Y98.500 E2.04857 ; support material
G1 X88.500 Y98.500 E2.09715 ; support material
G1 X88.500 Y100.450 E2.14572 ; support material
G1 X90.450 Y100.450 E2.19429 ; support material
G1 X89.738 Y99.738 F7800.000 ; move to first support material point
G1 F2848.542
G1 X89.738 Y99.212 E2.20738 ; support material
G1 X89.212 Y99.212 E2.22046 ; support material
G1 X89.212 Y99.662 E2.23165 ; support material
G1 X89.678 Y99.662 E2.24326 ; support material
G1 X89.738 Y99.738 E2.24566 ; support material
G1 E0.24566 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.450 Y90.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X90.450 Y88.500 E2.04857 ; support material
G1 X88.500 Y88.500 E2.09715 ; support material
G1 X88.500 Y90.450 E2.14572 ; support material
G1 X90.450 Y90.450 E2.19429 ; support material
G1 X100.450 Y90.450 F7800.000 ; move to first support material point
G1 F2848.542
G1 X100.450 Y88.500 E2.24286 ; support material
G1 X98.500 Y88.500 E2.29144 ; support material
G1 X98.500 Y90.450 E2.34001 ; support material
G1 X100.450 Y90.450 E2.38858 ; support material
G1 X110.450 Y90.450 F7800.000 ; move to first support material point
G1 F2848.542
G1 X110.450 Y88.500 E2.43715 ; support material
G1 X108.500 Y88.500 E2.48573 ; support material
G1 X108.500 Y90.450 E2.53430 ; support material
G1 X110.450 Y90.450 E2.58287 ; support material
G1 E0.58287 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.450 Y110.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X110.450 Y108.500 E2.04857 ; support material
G1 X108.500 Y108.500 E2.09715 ; support material
G1 X108.500 Y110.450 E2.14572 ; support material
G1 X110.450 Y110.450 E2.19429 ; support material
G1 E0.19429 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.450 Y110.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X100.450 Y108.500 E2.04857 ; support material
G1 X98.500 Y108.500 E2.09715 ; support material
G1 X98.500 Y110.450 E2.14572 ; support material
G1 X100.450 Y110.450 E2.19429 ; support material
G1 E0.19429 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.450 Y110.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X90.450 Y108.500 E2.04857 ; support material
G1 X88.500 Y108.500 E2.09715 ; support material
G1 X88.500 Y110.450 E2.14572 ; support material
G1 X90.450 Y110.450 E2.19429 ; support material
G1 Z1.850 F7800.000 ; move to next layer (10)
G1 E0.19429 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F712.135
G1 X99.471 Y100.529 E2.02853 ; small perimeter
G1 X99.471 Y99.471 E2.05706 ; small perimeter
G1 X100.529 Y99.471 E2.08558 ; small perimeter
G1 X100.529 Y100.454 E2.11209 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F712.135
G1 X98.836 Y101.164 E2.17491 ; small perimeter
G1 X98.836 Y98.836 E2.23773 ; small perimeter
G1 X101.164 Y98.836 E2.30056 ; small perimeter
G1 X101.164 Y101.089 E2.36135 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F900.000
G1 X98.275 Y101.725 E2.43246 ; external small perimeter
G1 X98.275 Y98.275 E2.50357 ; external small perimeter
G1 X101.725 Y98.275 E2.57467 ; external small perimeter
G1 X101.725 Y101.650 E2.64423 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z2.050 F7800.000 ; move to next layer (11)
G1 E0.64423 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X104.200 Y104.200 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X104.200 Y94.750 E2.23539 ; support material
G1 X94.750 Y94.750 E2.47078 ; support material
G1 X94.750 Y104.200 E2.70617 ; support material
G1 X104.200 Y104.200 E2.94156 ; support material
G1 E0.94156 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X109.738 Y99.662 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X109.738 Y99.212 E2.01119 ; support material
G1 X109.212 Y99.212 E2.02427 ; support material
G1 X109.212 Y99.662 E2.03546 ; support material
G1 X109.738 Y99.662 E2.04855 ; support material
G1 X110.450 Y100.450 F7800.000 ; move to first support material point
G1 F2848.542
G1 X110.450 Y98.500 E2.09712 ; support material
G1 X108.500 Y98.500 E2.14569 ; support material
G1 X108.500 Y100.450 E2.19427 ; support material
G1 X110.450 Y100.450 E2.24284 ; support material
G1 E0.24284 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.488 Y96.190 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X103.488 Y95.462 E2.01813 ; support material
G1 X101.044 Y95.462 E2.07901 ; support material
G1 X101.464 Y96.190 E2.09994 ; support material
G1 X103.488 Y96.190 E2.15035 ; support material
G1 X97.175 Y97.175 F7800.000 ; move to first support material point
G1 F2848.542
G1 X102.825 Y97.175 E2.29108 ; support material
G1 X102.825 Y102.825 E2.43182 ; support material
G1 X97.175 Y102.825 E2.57256 ; support material
G1 X97.175 Y97.175 E2.71329 ; support material
G1 X96.293 Y99.176 F7800.000 ; move to first support material point
G1 F2848.542
G1 X95.462 Y97.737 E2.75467 ; support material
G1 X95.462 Y101.100 E2.83844 ; support material
G1 X96.293 Y99.662 E2.87981 ; support material
G1 X96.463 Y99.662 E2.88404 ; support material
G1 X96.463 Y99.176 E2.89614 ; support material
G1 X96.293 Y99.176 E2.90037 ; support material
G1 E0.90037 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.450 Y100.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X90.450 Y98.500 E2.04857 ; support material
G1 X88.500 Y98.500 E2.09715 ; support material
G1 X88.500 Y100.450 E2.14572 ; support material
G1 X90.450 Y100.450 E2.19429 ; support material
G1 X89.738 Y99.738 F7800.000 ; move to first support material point
G1 F2848.542
G1 X89.738 Y99.212 E2.20738 ; support material
G1 X89.212 Y99.212 E2.22046 ; support material
G1 X89.212 Y99.662 E2.23165 ; support material
G1 X89.678 Y99.662 E2.24326 ; support material
G1 X89.738 Y99.738 E2.24566 ; support material
G1 E0.24566 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.450 Y90.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X90.450 Y88.500 E2.04857 ; support material
G1 X88.500 Y88.500 E2.09715 ; support material
G1 X88.500 Y90.450 E2.14572 ; support material
G1 X90.450 Y90.450 E2.19429 ; support material
G1 X100.450 Y90.450 F7800.000 ; move to first support material point
G1 F2848.542
G1 X100.450 Y88.500 E2.24286 ; support material
G1 X98.500 Y88.500 E2.29144 ; support material
G1 X98.500 Y90.450 E2.34001 ; support material
G1 X100.450 Y90.450 E2.38858 ; support material
G1 X110.450 Y90.450 F7800.000 ; move to first support material point
G1 F2848.542
G1 X110.450 Y88.500 E2.43715 ; support material
G1 X108.500 Y88.500 E2.48573 ; support material
G1 X108.500 Y90.450 E2.53430 ; support material
G1 X110.450 Y90.450 E2.58287 ; support material
G1 E0.58287 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.450 Y110.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X110.450 Y108.500 E2.04857 ; support material
G1 X108.500 Y108.500 E2.09715 ; support material
G1 X108.500 Y110.450 E2.14572 ; support material
G1 X110.450 Y110.450 E2.19429 ; support material
G1 E0.19429 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.450 Y110.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X100.450 Y108.500 E2.04857 ; support material
G1 X98.500 Y108.500 E2.09715 ; support material
G1 X98.500 Y110.450 E2.14572 ; support material
G1 X100.450 Y110.450 E2.19429 ; support material
G1 E0.19429 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.450 Y110.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X90.450 Y108.500 E2.04857 ; support material
G1 X88.500 Y108.500 E2.09715 ; support material
G1 X88.500 Y110.450 E2.14572 ; support material
G1 X90.450 Y110.450 E2.19429 ; support material
G1 Z2.150 F7800.000 ; move to next layer (12)
G1 E0.19429 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F712.135
G1 X99.471 Y100.529 E2.02853 ; small perimeter
G1 X99.471 Y99.471 E2.05706 ; small perimeter
G1 X100.529 Y99.471 E2.08558 ; small perimeter
G1 X100.529 Y100.454 E2.11209 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F712.135
G1 X98.836 Y101.164 E2.17491 ; small perimeter
G1 X98.836 Y98.836 E2.23773 ; small perimeter
G1 X101.164 Y98.836 E2.30056 ; small perimeter
G1 X101.164 Y101.089 E2.36135 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F900.000
G1 X98.275 Y101.725 E2.43246 ; external small perimeter
G1 X98.275 Y98.275 E2.50357 ; external small perimeter
G1 X101.725 Y98.275 E2.57467 ; external small perimeter
G1 X101.725 Y101.650 E2.64423 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z2.425 F7800.000 ; move to next layer (13)
G1 E0.64423 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X104.200 Y104.200 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X104.200 Y94.750 E2.23539 ; support material
G1 X94.750 Y94.750 E2.47078 ; support material
G1 X94.750 Y104.200 E2.70617 ; support material
G1 X104.200 Y104.200 E2.94156 ; support material
G1 E0.94156 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X109.738 Y99.662 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X109.738 Y99.212 E2.01119 ; support material
G1 X109.212 Y99.212 E2.02427 ; support material
G1 X109.212 Y99.662 E2.03546 ; support material
G1 X109.738 Y99.662 E2.04855 ; support material
G1 X110.450 Y100.450 F7800.000 ; move to first support material point
G1 F2848.542
G1 X110.450 Y98.500 E2.09712 ; support material
G1 X108.500 Y98.500 E2.14569 ; support material
G1 X108.500 Y100.450 E2.19427 ; support material
G1 X110.450 Y100.450 E2.24284 ; support material
G1 E0.24284 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.488 Y96.190 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X103.488 Y95.462 E2.01813 ; support material
G1 X101.044 Y95.462 E2.07901 ; support material
G1 X101.464 Y96.190 E2.09994 ; support material
G1 X103.488 Y96.190 E2.15035 ; support material
G1 X97.175 Y97.175 F7800.000 ; move to first support material point
G1 F2848.542
G1 X102.825 Y97.175 E2.29108 ; support material
G1 X102.825 Y102.825 E2.43182 ; support material
G1 X97.175 Y102.825 E2.57256 ; support material
G1 X97.175 Y97.175 E2.71329 ; support material
G1 X96.293 Y99.176 F7800.000 ; move to first support material point
G1 F2848.542
G1 X95.462 Y97.737 E2.75467 ; support material
G1 X95.462 Y101.100 E2.83844 ; support material
G1 X96.293 Y99.662 E2.87981 ; support material
G1 X96.463 Y99.662 E2.88404 ; support material
G1 X96.463 Y99.176 E2.89614 ; support material
G1 X96.293 Y99.176 E2.90037 ; support material
G1 E0.90037 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.450 Y100.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X90.450 Y98.500 E2.04857 ; support material
G1 X88.500 Y98.500 E2.09715 ; support material
G1 X88.500 Y100.450 E2.14572 ; support material
G1 X90.450 Y100.450 E2.19429 ; support material
G1 X89.738 Y99.738 F7800.000 ; move to first support material point
G1 F2848.542
G1 X89.738 Y99.212 E2.20738 ; support material
G1 X89.212 Y99.212 E2.22046 ; support material
G1 X89.212 Y99.662 E2.23165 ; support material
G1 X89.678 Y99.662 E2.24326 ; support material
G1 X89.738 Y99.738 E2.24566 ; support material
G1 E0.24566 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.450 Y90.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X90.450 Y88.500 E2.04857 ; support material
G1 X88.500 Y88.500 E2.09715 ; support material
G1 X88.500 Y90.450 E2.14572 ; support material
G1 X90.450 Y90.450 E2.19429 ; support material
G1 X100.450 Y90.450 F7800.000 ; move to first support material point
G1 F2848.542
G1 X100.450 Y88.500 E2.24286 ; support material
G1 X98.500 Y88.500 E2.29144 ; support material
G1 X98.500 Y90.450 E2.34001 ; support material
G1 X100.450 Y90.450 E2.38858 ; support material
G1 X110.450 Y90.450 F7800.000 ; move to first support material point
G1 F2848.542
G1 X110.450 Y88.500 E2.43715 ; support material
G1 X108.500 Y88.500 E2.48573 ; support material
G1 X108.500 Y90.450 E2.53430 ; support material
G1 X110.450 Y90.450 E2.58287 ; support material
G1 E0.58287 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.450 Y110.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X110.450 Y108.500 E2.04857 ; support material
G1 X108.500 Y108.500 E2.09715 ; support material
G1 X108.500 Y110.450 E2.14572 ; support material
G1 X110.450 Y110.450 E2.19429 ; support material
G1 E0.19429 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.450 Y110.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X100.450 Y108.500 E2.04857 ; support material
G1 X98.500 Y108.500 E2.09715 ; support material
G1 X98.500 Y110.450 E2.14572 ; support material
G1 X100.450 Y110.450 E2.19429 ; support material
G1 E0.19429 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.450 Y110.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X90.450 Y108.500 E2.04857 ; support material
G1 X88.500 Y108.500 E2.09715 ; support material
G1 X88.500 Y110.450 E2.14572 ; support material
G1 X90.450 Y110.450 E2.19429 ; support material
G1 Z2.450 F7800.000 ; move to next layer (14)
G1 E0.19429 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F600.000
G1 X99.471 Y100.529 E2.02853 ; small perimeter
G1 X99.471 Y99.471 E2.05706 ; small perimeter
G1 X100.529 Y99.471 E2.08558 ; small perimeter
G1 X100.529 Y100.454 E2.11209 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X98.836 Y101.164 E2.17491 ; small perimeter
G1 X98.836 Y98.836 E2.23773 ; small perimeter
G1 X101.164 Y98.836 E2.30056 ; small perimeter
G1 X101.164 Y101.089 E2.36135 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F600.000
G1 X98.275 Y101.725 E2.43246 ; external small perimeter
G1 X98.275 Y98.275 E2.50357 ; external small perimeter
G1 X101.725 Y98.275 E2.57467 ; external small perimeter
G1 X101.725 Y101.650 E2.64423 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z2.750 F7800.000 ; move to next layer (15)
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 F712.135
G1 X99.471 Y100.529 E2.67276 ; small perimeter
G1 X99.471 Y99.471 E2.70129 ; small perimeter
G1 X100.529 Y99.471 E2.72982 ; small perimeter
G1 X100.529 Y100.454 E2.75632 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F712.135
G1 X98.836 Y101.164 E2.81914 ; small perimeter
G1 X98.836 Y98.836 E2.88197 ; small perimeter
G1 X101.164 Y98.836 E2.94479 ; small perimeter
G1 X101.164 Y101.089 E3.00559 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F900.000
G1 X98.275 Y101.725 E3.07669 ; external small perimeter
G1 X98.275 Y98.275 E3.14780 ; external small perimeter
G1 X101.725 Y98.275 E3.21890 ; external small perimeter
G1 X101.725 Y101.650 E3.28846 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z2.800 F7800.000 ; move to next layer (16)
G1 E1.28846 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X104.200 Y104.200 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X104.200 Y94.750 E2.23539 ; support material
G1 X94.750 Y94.750 E2.47078 ; support material
G1 X94.750 Y104.200 E2.70617 ; support material
G1 X104.200 Y104.200 E2.94156 ; support material
G1 E0.94156 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X109.738 Y99.662 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X109.738 Y99.212 E2.01119 ; support material
G1 X109.212 Y99.212 E2.02427 ; support material
G1 X109.212 Y99.662 E2.03546 ; support material
G1 X109.738 Y99.662 E2.04855 ; support material
G1 X110.450 Y100.450 F7800.000 ; move to first support material point
G1 F2848.542
G1 X110.450 Y98.500 E2.09712 ; support material
G1 X108.500 Y98.500 E2.14569 ; support material
G1 X108.500 Y100.450 E2.19427 ; support material
G1 X110.450 Y100.450 E2.24284 ; support material
G1 E0.24284 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.488 Y96.190 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X103.488 Y95.462 E2.01813 ; support material
G1 X101.044 Y95.462 E2.07901 ; support material
G1 X101.464 Y96.190 E2.09994 ; support material
G1 X103.488 Y96.190 E2.15035 ; support material
G1 X97.175 Y97.175 F7800.000 ; move to first support material point
G1 F2848.542
G1 X102.825 Y97.175 E2.29108 ; support material
G1 X102.825 Y102.825 E2.43182 ; support material
G1 X97.175 Y102.825 E2.57256 ; support material
G1 X97.175 Y97.175 E2.71329 ; support material
G1 X96.293 Y99.176 F7800.000 ; move to first support material point
G1 F2848.542
G1 X95.462 Y97.737 E2.75467 ; support material
G1 X95.462 Y101.100 E2.83844 ; support material
G1 X96.293 Y99.662 E2.87981 ; support material
G1 X96.463 Y99.662 E2.88404 ; support material
G1 X96.463 Y99.176 E2.89614 ; support material
G1 X96.293 Y99.176 E2.90037 ; support material
G1 E0.90037 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.450 Y100.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X90.450 Y98.500 E2.04857 ; support material
G1 X88.500 Y98.500 E2.09715 ; support material
G1 X88.500 Y100.450 E2.14572 ; support material
G1 X90.450 Y100.450 E2.19429 ; support material
G1 X89.738 Y99.738 F7800.000 ; move to first support material point
G1 F2848.542
G1 X89.738 Y99.212 E2.20738 ; support material
G1 X89.212 Y99.212 E2.22046 ; support material
G1 X89.212 Y99.662 E2.23165 ; support material
G1 X89.678 Y99.662 E2.24326 ; support material
G1 X89.738 Y99.738 E2.24566 ; support material
G1 E0.24566 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.450 Y90.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X90.450 Y88.500 E2.04857 ; support material
G1 X88.500 Y88.500 E2.09715 ; support material
G1 X88.500 Y90.450 E2.14572 ; support material
G1 X90.450 Y90.450 E2.19429 ; support material
G1 X100.450 Y90.450 F7800.000 ; move to first support material point
G1 F2848.542
G1 X100.450 Y88.500 E2.24286 ; support material
G1 X98.500 Y88.500 E2.29144 ; support material
G1 X98.500 Y90.450 E2.34001 ; support material
G1 X100.450 Y90.450 E2.38858 ; support material
G1 X110.450 Y90.450 F7800.000 ; move to first support material point
G1 F2848.542
G1 X110.450 Y88.500 E2.43715 ; support material
G1 X108.500 Y88.500 E2.48573 ; support material
G1 X108.500 Y90.450 E2.53430 ; support material
G1 X110.450 Y90.450 E2.58287 ; support material
G1 E0.58287 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.450 Y110.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X110.450 Y108.500 E2.04857 ; support material
G1 X108.500 Y108.500 E2.09715 ; support material
G1 X108.500 Y110.450 E2.14572 ; support material
G1 X110.450 Y110.450 E2.19429 ; support material
G1 E0.19429 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.450 Y110.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X100.450 Y108.500 E2.04857 ; support material
G1 X98.500 Y108.500 E2.09715 ; support material
G1 X98.500 Y110.450 E2.14572 ; support material
G1 X100.450 Y110.450 E2.19429 ; support material
G1 E0.19429 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.450 Y110.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X90.450 Y108.500 E2.04857 ; support material
G1 X88.500 Y108.500 E2.09715 ; support material
G1 X88.500 Y110.450 E2.14572 ; support material
G1 X90.450 Y110.450 E2.19429 ; support material
G1 Z3.050 F7800.000 ; move to next layer (17)
G1 E0.19429 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F712.135
G1 X99.471 Y100.529 E2.02853 ; small perimeter
G1 X99.471 Y99.471 E2.05706 ; small perimeter
G1 X100.529 Y99.471 E2.08558 ; small perimeter
G1 X100.529 Y100.454 E2.11209 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F712.135
G1 X98.836 Y101.164 E2.17491 ; small perimeter
G1 X98.836 Y98.836 E2.23773 ; small perimeter
G1 X101.164 Y98.836 E2.30056 ; small perimeter
G1 X101.164 Y101.089 E2.36135 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F900.000
G1 X98.275 Y101.725 E2.43246 ; external small perimeter
G1 X98.275 Y98.275 E2.50357 ; external small perimeter
G1 X101.725 Y98.275 E2.57467 ; external small perimeter
G1 X101.725 Y101.650 E2.64423 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z3.175 F7800.000 ; move to next layer (18)
G1 E0.64423 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X104.200 Y104.200 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X104.200 Y94.750 E2.23539 ; support material
G1 X94.750 Y94.750 E2.47078 ; support material
G1 X94.750 Y104.200 E2.70617 ; support material
G1 X104.200 Y104.200 E2.94156 ; support material
G1 E0.94156 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X109.738 Y99.662 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X109.738 Y99.212 E2.01119 ; support material
G1 X109.212 Y99.212 E2.02427 ; support material
G1 X109.212 Y99.662 E2.03546 ; support material
G1 X109.738 Y99.662 E2.04855 ; support material
G1 X110.450 Y100.450 F7800.000 ; move to first support material point
G1 F2848.542
G1 X110.450 Y98.500 E2.09712 ; support material
G1 X108.500 Y98.500 E2.14569 ; support material
G1 X108.500 Y100.450 E2.19427 ; support material
G1 X110.450 Y100.450 E2.24284 ; support material
G1 E0.24284 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.488 Y96.190 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X103.488 Y95.462 E2.01813 ; support material
G1 X101.044 Y95.462 E2.07901 ; support material
G1 X101.464 Y96.190 E2.09994 ; support material
G1 X103.488 Y96.190 E2.15035 ; support material
G1 X97.175 Y97.175 F7800.000 ; move to first support material point
G1 F2848.542
G1 X102.825 Y97.175 E2.29108 ; support material
G1 X102.825 Y102.825 E2.43182 ; support material
G1 X97.175 Y102.825 E2.57256 ; support material
G1 X97.175 Y97.175 E2.71329 ; support material
G1 X96.293 Y99.176 F7800.000 ; move to first support material point
G1 F2848.542
G1 X95.462 Y97.737 E2.75467 ; support material
G1 X95.462 Y101.100 E2.83844 ; support material
G1 X96.293 Y99.662 E2.87981 ; support material
G1 X96.463 Y99.662 E2.88404 ; support material
G1 X96.463 Y99.176 E2.89614 ; support material
G1 X96.293 Y99.176 E2.90037 ; support material
G1 E0.90037 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.450 Y100.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X90.450 Y98.500 E2.04857 ; support material
G1 X88.500 Y98.500 E2.09715 ; support material
G1 X88.500 Y100.450 E2.14572 ; support material
G1 X90.450 Y100.450 E2.19429 ; support material
G1 X89.738 Y99.738 F7800.000 ; move to first support material point
G1 F2848.542
G1 X89.738 Y99.212 E2.20738 ; support material
G1 X89.212 Y99.212 E2.22046 ; support material
G1 X89.212 Y99.662 E2.23165 ; support material
G1 X89.678 Y99.662 E2.24326 ; support material
G1 X89.738 Y99.738 E2.24566 ; support material
G1 E0.24566 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.450 Y90.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X90.450 Y88.500 E2.04857 ; support material
G1 X88.500 Y88.500 E2.09715 ; support material
G1 X88.500 Y90.450 E2.14572 ; support material
G1 X90.450 Y90.450 E2.19429 ; support material
G1 X100.450 Y90.450 F7800.000 ; move to first support material point
G1 F2848.542
G1 X100.450 Y88.500 E2.24286 ; support material
G1 X98.500 Y88.500 E2.29144 ; support material
G1 X98.500 Y90.450 E2.34001 ; support material
G1 X100.450 Y90.450 E2.38858 ; support material
G1 X110.450 Y90.450 F7800.000 ; move to first support material point
G1 F2848.542
G1 X110.450 Y88.500 E2.43715 ; support material
G1 X108.500 Y88.500 E2.48573 ; support material
G1 X108.500 Y90.450 E2.53430 ; support material
G1 X110.450 Y90.450 E2.58287 ; support material
G1 E0.58287 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.450 Y110.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X110.450 Y108.500 E2.04857 ; support material
G1 X108.500 Y108.500 E2.09715 ; support material
G1 X108.500 Y110.450 E2.14572 ; support material
G1 X110.450 Y110.450 E2.19429 ; support material
G1 E0.19429 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.450 Y110.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X100.450 Y108.500 E2.04857 ; support material
G1 X98.500 Y108.500 E2.09715 ; support material
G1 X98.500 Y110.450 E2.14572 ; support material
G1 X100.450 Y110.450 E2.19429 ; support material
G1 E0.19429 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.450 Y110.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X90.450 Y108.500 E2.04857 ; support material
G1 X88.500 Y108.500 E2.09715 ; support material
G1 X88.500 Y110.450 E2.14572 ; support material
G1 X90.450 Y110.450 E2.19429 ; support material
G1 Z3.350 F7800.000 ; move to next layer (19)
G1 E0.19429 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F712.135
G1 X99.471 Y100.529 E2.02853 ; small perimeter
G1 X99.471 Y99.471 E2.05706 ; small perimeter
G1 X100.529 Y99.471 E2.08558 ; small perimeter
G1 X100.529 Y100.454 E2.11209 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F712.135
G1 X98.836 Y101.164 E2.17491 ; small perimeter
G1 X98.836 Y98.836 E2.23773 ; small perimeter
G1 X101.164 Y98.836 E2.30056 ; small perimeter
G1 X101.164 Y101.089 E2.36135 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F900.000
G1 X98.275 Y101.725 E2.43246 ; external small perimeter
G1 X98.275 Y98.275 E2.50357 ; external small perimeter
G1 X101.725 Y98.275 E2.57467 ; external small perimeter
G1 X101.725 Y101.650 E2.64423 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z3.550 F7800.000 ; move to next layer (20)
G1 E0.64423 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X104.200 Y104.200 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X104.200 Y94.750 E2.23539 ; support material
G1 X94.750 Y94.750 E2.47078 ; support material
G1 X94.750 Y104.200 E2.70617 ; support material
G1 X104.200 Y104.200 E2.94156 ; support material
G1 E0.94156 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X109.738 Y99.662 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X109.738 Y99.212 E2.01119 ; support material
G1 X109.212 Y99.212 E2.02427 ; support material
G1 X109.212 Y99.662 E2.03546 ; support material
G1 X109.738 Y99.662 E2.04855 ; support material
G1 X110.450 Y100.450 F7800.000 ; move to first support material point
G1 F2848.542
G1 X110.450 Y98.500 E2.09712 ; support material
G1 X108.500 Y98.500 E2.14569 ; support material
G1 X108.500 Y100.450 E2.19427 ; support material
G1 X110.450 Y100.450 E2.24284 ; support material
G1 E0.24284 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.488 Y96.190 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X103.488 Y95.462 E2.01813 ; support material
G1 X101.044 Y95.462 E2.07901 ; support material
G1 X101.464 Y96.190 E2.09994 ; support material
G1 X103.488 Y96.190 E2.15035 ; support material
G1 X97.175 Y97.175 F7800.000 ; move to first support material point
G1 F2848.542
G1 X102.825 Y97.175 E2.29108 ; support material
G1 X102.825 Y102.825 E2.43182 ; support material
G1 X97.175 Y102.825 E2.57256 ; support material
G1 X97.175 Y97.175 E2.71329 ; support material
G1 X96.293 Y99.176 F7800.000 ; move to first support material point
G1 F2848.542
G1 X95.462 Y97.737 E2.75467 ; support material
G1 X95.462 Y101.100 E2.83844 ; support material
G1 X96.293 Y99.662 E2.87981 ; support material
G1 X96.463 Y99.662 E2.88404 ; support material
G1 X96.463 Y99.176 E2.89614 ; support material
G1 X96.293 Y99.176 E2.90037 ; support material
G1 E0.90037 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.450 Y100.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X90.450 Y98.500 E2.04857 ; support material
G1 X88.500 Y98.500 E2.09715 ; support material
G1 X88.500 Y100.450 E2.14572 ; support material
G1 X90.450 Y100.450 E2.19429 ; support material
G1 X89.738 Y99.738 F7800.000 ; move to first support material point
G1 F2848.542
G1 X89.738 Y99.212 E2.20738 ; support material
G1 X89.212 Y99.212 E2.22046 ; support material
G1 X89.212 Y99.662 E2.23165 ; support material
G1 X89.678 Y99.662 E2.24326 ; support material
G1 X89.738 Y99.738 E2.24566 ; support material
G1 E0.24566 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.450 Y90.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X90.450 Y88.500 E2.04857 ; support material
G1 X88.500 Y88.500 E2.09715 ; support material
G1 X88.500 Y90.450 E2.14572 ; support material
G1 X90.450 Y90.450 E2.19429 ; support material
G1 X100.450 Y90.450 F7800.000 ; move to first support material point
G1 F2848.542
G1 X100.450 Y88.500 E2.24286 ; support material
G1 X98.500 Y88.500 E2.29144 ; support material
G1 X98.500 Y90.450 E2.34001 ; support material
G1 X100.450 Y90.450 E2.38858 ; support material
G1 X110.450 Y90.450 F7800.000 ; move to first support material point
G1 F2848.542
G1 X110.450 Y88.500 E2.43715 ; support material
G1 X108.500 Y88.500 E2.48573 ; support material
G1 X108.500 Y90.450 E2.53430 ; support material
G1 X110.450 Y90.450 E2.58287 ; support material
G1 E0.58287 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.450 Y110.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X110.450 Y108.500 E2.04857 ; support material
G1 X108.500 Y108.500 E2.09715 ; support material
G1 X108.500 Y110.450 E2.14572 ; support material
G1 X110.450 Y110.450 E2.19429 ; support material
G1 E0.19429 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.450 Y110.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X100.450 Y108.500 E2.04857 ; support material
G1 X98.500 Y108.500 E2.09715 ; support material
G1 X98.500 Y110.450 E2.14572 ; support material
G1 X100.450 Y110.450 E2.19429 ; support material
G1 E0.19429 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.450 Y110.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X90.450 Y108.500 E2.04857 ; support material
G1 X88.500 Y108.500 E2.09715 ; support material
G1 X88.500 Y110.450 E2.14572 ; support material
G1 X90.450 Y110.450 E2.19429 ; support material
G1 Z3.650 F7800.000 ; move to next layer (21)
G1 E0.19429 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F712.135
G1 X99.471 Y100.529 E2.02853 ; small perimeter
G1 X99.471 Y99.471 E2.05706 ; small perimeter
G1 X100.529 Y99.471 E2.08558 ; small perimeter
G1 X100.529 Y100.454 E2.11209 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F712.135
G1 X98.836 Y101.164 E2.17491 ; small perimeter
G1 X98.836 Y98.836 E2.23773 ; small perimeter
G1 X101.164 Y98.836 E2.30056 ; small perimeter
G1 X101.164 Y101.089 E2.36135 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F900.000
G1 X98.275 Y101.725 E2.43246 ; external small perimeter
G1 X98.275 Y98.275 E2.50357 ; external small perimeter
G1 X101.725 Y98.275 E2.57467 ; external small perimeter
G1 X101.725 Y101.650 E2.64423 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z3.925 F7800.000 ; move to next layer (22)
G1 E0.64423 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X104.200 Y104.200 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X104.200 Y94.750 E2.23539 ; support material
G1 X94.750 Y94.750 E2.47078 ; support material
G1 X94.750 Y104.200 E2.70617 ; support material
G1 X104.200 Y104.200 E2.94156 ; support material
G1 E0.94156 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X109.738 Y99.662 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X109.738 Y99.212 E2.01119 ; support material
G1 X109.212 Y99.212 E2.02427 ; support material
G1 X109.212 Y99.662 E2.03546 ; support material
G1 X109.738 Y99.662 E2.04855 ; support material
G1 X110.450 Y100.450 F7800.000 ; move to first support material point
G1 F2848.542
G1 X110.450 Y98.500 E2.09712 ; support material
G1 X108.500 Y98.500 E2.14569 ; support material
G1 X108.500 Y100.450 E2.19427 ; support material
G1 X110.450 Y100.450 E2.24284 ; support material
G1 E0.24284 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.488 Y96.190 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X103.488 Y95.462 E2.01813 ; support material
G1 X101.044 Y95.462 E2.07901 ; support material
G1 X101.464 Y96.190 E2.09994 ; support material
G1 X103.488 Y96.190 E2.15035 ; support material
G1 X97.175 Y97.175 F7800.000 ; move to first support material point
G1 F2848.542
G1 X102.825 Y97.175 E2.29108 ; support material
G1 X102.825 Y102.825 E2.43182 ; support material
G1 X97.175 Y102.825 E2.57256 ; support material
G1 X97.175 Y97.175 E2.71329 ; support material
G1 X96.293 Y99.176 F7800.000 ; move to first support material point
G1 F2848.542
G1 X95.462 Y97.737 E2.75467 ; support material
G1 X95.462 Y101.100 E2.83844 ; support material
G1 X96.293 Y99.662 E2.87981 ; support material
G1 X96.463 Y99.662 E2.88404 ; support material
G1 X96.463 Y99.176 E2.89614 ; support material
G1 X96.293 Y99.176 E2.90037 ; support material
G1 E0.90037 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.450 Y100.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X90.450 Y98.500 E2.04857 ; support material
G1 X88.500 Y98.500 E2.09715 ; support material
G1 X88.500 Y100.450 E2.14572 ; support material
G1 X90.450 Y100.450 E2.19429 ; support material
G1 X89.738 Y99.738 F7800.000 ; move to first support material point
G1 F2848.542
G1 X89.738 Y99.212 E2.20738 ; support material
G1 X89.212 Y99.212 E2.22046 ; support material
G1 X89.212 Y99.662 E2.23165 ; support material
G1 X89.678 Y99.662 E2.24326 ; support material
G1 X89.738 Y99.738 E2.24566 ; support material
G1 E0.24566 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.450 Y90.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X90.450 Y88.500 E2.04857 ; support material
G1 X88.500 Y88.500 E2.09715 ; support material
G1 X88.500 Y90.450 E2.14572 ; support material
G1 X90.450 Y90.450 E2.19429 ; support material
G1 X100.450 Y90.450 F7800.000 ; move to first support material point
G1 F2848.542
G1 X100.450 Y88.500 E2.24286 ; support material
G1 X98.500 Y88.500 E2.29144 ; support material
G1 X98.500 Y90.450 E2.34001 ; support material
G1 X100.450 Y90.450 E2.38858 ; support material
G1 X110.450 Y90.450 F7800.000 ; move to first support material point
G1 F2848.542
G1 X110.450 Y88.500 E2.43715 ; support material
G1 X108.500 Y88.500 E2.48573 ; support material
G1 X108.500 Y90.450 E2.53430 ; support material
G1 X110.450 Y90.450 E2.58287 ; support material
G1 E0.58287 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.450 Y110.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X110.450 Y108.500 E2.04857 ; support material
G1 X108.500 Y108.500 E2.09715 ; support material
G1 X108.500 Y110.450 E2.14572 ; support material
G1 X110.450 Y110.450 E2.19429 ; support material
G1 E0.19429 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.450 Y110.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X100.450 Y108.500 E2.04857 ; support material
G1 X98.500 Y108.500 E2.09715 ; support material
G1 X98.500 Y110.450 E2.14572 ; support material
G1 X100.450 Y110.450 E2.19429 ; support material
G1 E0.19429 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.450 Y110.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X90.450 Y108.500 E2.04857 ; support material
G1 X88.500 Y108.500 E2.09715 ; support material
G1 X88.500 Y110.450 E2.14572 ; support material
G1 X90.450 Y110.450 E2.19429 ; support material
G1 Z3.950 F7800.000 ; move to next layer (23)
G1 E0.19429 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F600.000
G1 X99.471 Y100.529 E2.02853 ; small perimeter
G1 X99.471 Y99.471 E2.05706 ; small perimeter
G1 X100.529 Y99.471 E2.08558 ; small perimeter
G1 X100.529 Y100.454 E2.11209 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X98.836 Y101.164 E2.17491 ; small perimeter
G1 X98.836 Y98.836 E2.23773 ; small perimeter
G1 X101.164 Y98.836 E2.30056 ; small perimeter
G1 X101.164 Y101.089 E2.36135 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F600.000
G1 X98.275 Y101.725 E2.43246 ; external small perimeter
G1 X98.275 Y98.275 E2.50357 ; external small perimeter
G1 X101.725 Y98.275 E2.57467 ; external small perimeter
G1 X101.725 Y101.650 E2.64423 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z4.250 F7800.000 ; move to next layer (24)
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 F712.135
G1 X99.471 Y100.529 E2.67276 ; small perimeter
G1 X99.471 Y99.471 E2.70129 ; small perimeter
G1 X100.529 Y99.471 E2.72982 ; small perimeter
G1 X100.529 Y100.454 E2.75632 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F712.135
G1 X98.836 Y101.164 E2.81914 ; small perimeter
G1 X98.836 Y98.836 E2.88197 ; small perimeter
G1 X101.164 Y98.836 E2.94479 ; small perimeter
G1 X101.164 Y101.089 E3.00559 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F900.000
G1 X98.275 Y101.725 E3.07669 ; external small perimeter
G1 X98.275 Y98.275 E3.14780 ; external small perimeter
G1 X101.725 Y98.275 E3.21890 ; external small perimeter
G1 X101.725 Y101.650 E3.28846 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z4.300 F7800.000 ; move to next layer (25)
G1 E1.28846 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X104.200 Y104.200 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X104.200 Y94.750 E2.23539 ; support material
G1 X94.750 Y94.750 E2.47078 ; support material
G1 X94.750 Y104.200 E2.70617 ; support material
G1 X104.200 Y104.200 E2.94156 ; support material
G1 E0.94156 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X109.738 Y99.662 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X109.738 Y99.212 E2.01119 ; support material
G1 X109.212 Y99.212 E2.02427 ; support material
G1 X109.212 Y99.662 E2.03546 ; support material
G1 X109.738 Y99.662 E2.04855 ; support material
G1 X110.450 Y100.450 F7800.000 ; move to first support material point
G1 F2848.542
G1 X110.450 Y98.500 E2.09712 ; support material
G1 X108.500 Y98.500 E2.14569 ; support material
G1 X108.500 Y100.450 E2.19427 ; support material
G1 X110.450 Y100.450 E2.24284 ; support material
G1 E0.24284 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.488 Y96.190 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X103.488 Y95.462 E2.01813 ; support material
G1 X101.044 Y95.462 E2.07901 ; support material
G1 X101.464 Y96.190 E2.09994 ; support material
G1 X103.488 Y96.190 E2.15035 ; support material
G1 X97.175 Y97.175 F7800.000 ; move to first support material point
G1 F2848.542
G1 X102.825 Y97.175 E2.29108 ; support material
G1 X102.825 Y102.825 E2.43182 ; support material
G1 X97.175 Y102.825 E2.57256 ; support material
G1 X97.175 Y97.175 E2.71329 ; support material
G1 X96.293 Y99.176 F7800.000 ; move to first support material point
G1 F2848.542
G1 X95.462 Y97.737 E2.75467 ; support material
G1 X95.462 Y101.100 E2.83844 ; support material
G1 X96.293 Y99.662 E2.87981 ; support material
G1 X96.463 Y99.662 E2.88404 ; support material
G1 X96.463 Y99.176 E2.89614 ; support material
G1 X96.293 Y99.176 E2.90037 ; support material
G1 E0.90037 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.450 Y100.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X90.450 Y98.500 E2.04857 ; support material
G1 X88.500 Y98.500 E2.09715 ; support material
G1 X88.500 Y100.450 E2.14572 ; support material
G1 X90.450 Y100.450 E2.19429 ; support material
G1 X89.738 Y99.738 F7800.000 ; move to first support material point
G1 F2848.542
G1 X89.738 Y99.212 E2.20738 ; support material
G1 X89.212 Y99.212 E2.22046 ; support material
G1 X89.212 Y99.662 E2.23165 ; support material
G1 X89.678 Y99.662 E2.24326 ; support material
G1 X89.738 Y99.738 E2.24566 ; support material
G1 E0.24566 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.450 Y90.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X90.450 Y88.500 E2.04857 ; support material
G1 X88.500 Y88.500 E2.09715 ; support material
G1 X88.500 Y90.450 E2.14572 ; support material
G1 X90.450 Y90.450 E2.19429 ; support material
G1 X100.450 Y90.450 F7800.000 ; move to first support material point
G1 F2848.542
G1 X100.450 Y88.500 E2.24286 ; support material
G1 X98.500 Y88.500 E2.29144 ; support material
G1 X98.500 Y90.450 E2.34001 ; support material
G1 X100.450 Y90.450 E2.38858 ; support material
G1 X110.450 Y90.450 F7800.000 ; move to first support material point
G1 F2848.542
G1 X110.450 Y88.500 E2.43715 ; support material
G1 X108.500 Y88.500 E2.48573 ; support material
G1 X108.500 Y90.450 E2.53430 ; support material
G1 X110.450 Y90.450 E2.58287 ; support material
G1 E0.58287 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.450 Y110.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X110.450 Y108.500 E2.04857 ; support material
G1 X108.500 Y108.500 E2.09715 ; support material
G1 X108.500 Y110.450 E2.14572 ; support material
G1 X110.450 Y110.450 E2.19429 ; support material
G1 E0.19429 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.450 Y110.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X100.450 Y108.500 E2.04857 ; support material
G1 X98.500 Y108.500 E2.09715 ; support material
G1 X98.500 Y110.450 E2.14572 ; support material
G1 X100.450 Y110.450 E2.19429 ; support material
G1 E0.19429 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.450 Y110.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2848.542
G1 X90.450 Y108.500 E2.04857 ; support material
G1 X88.500 Y108.500 E2.09715 ; support material
G1 X88.500 Y110.450 E2.14572 ; support material
G1 X90.450 Y110.450 E2.19429 ; support material
G1 Z4.550 F7800.000 ; move to next layer (26)
G1 E0.19429 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F751.782
G1 X99.471 Y100.529 E2.02853 ; small perimeter
G1 X99.471 Y99.471 E2.05706 ; small perimeter
G1 X100.529 Y99.471 E2.08558 ; small perimeter
G1 X100.529 Y100.454 E2.11209 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F751.782
G1 X98.836 Y101.164 E2.17491 ; small perimeter
G1 X98.836 Y98.836 E2.23773 ; small perimeter
G1 X101.164 Y98.836 E2.30056 ; small perimeter
G1 X101.164 Y101.089 E2.36135 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F900.000
G1 X98.275 Y101.725 E2.43246 ; external small perimeter
G1 X98.275 Y98.275 E2.50357 ; external small perimeter
G1 X101.725 Y98.275 E2.57467 ; external small perimeter
G1 X101.725 Y101.650 E2.64423 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z4.675 F7800.000 ; move to next layer (27)
G1 E0.64423 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X104.200 Y104.200 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3007.128
G1 X104.200 Y94.750 E2.23539 ; support material
G1 X94.750 Y94.750 E2.47078 ; support material
G1 X94.750 Y104.200 E2.70617 ; support material
G1 X104.200 Y104.200 E2.94156 ; support material
G1 E0.94156 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.625 Y100.625 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3007.128
G1 X110.625 Y98.325 E2.05729 ; support material
G1 X108.325 Y98.325 E2.11458 ; support material
G1 X108.325 Y100.625 E2.17187 ; support material
G1 X110.625 Y100.625 E2.22916 ; support material
G1 X109.913 Y99.176 F7800.000 ; move to first support material point
G1 F3007.128
G1 X109.037 Y99.176 E2.25097 ; support material
G1 X109.037 Y99.662 E2.26306 ; support material
G1 X109.913 Y99.662 E2.28487 ; support material
G1 X109.913 Y99.176 E2.29696 ; support material
G1 E0.29696 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.488 Y96.190 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3007.128
G1 X103.488 Y95.462 E2.01813 ; support material
G1 X101.044 Y95.462 E2.07901 ; support material
G1 X101.464 Y96.190 E2.09994 ; support material
G1 X103.488 Y96.190 E2.15035 ; support material
G1 E0.15035 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.625 Y90.625 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3007.128
G1 X100.625 Y88.500 E2.05293 ; support material
G1 X98.325 Y88.500 E2.11022 ; support material
G1 X98.325 Y90.625 E2.16315 ; support material
G1 X100.625 Y90.625 E2.22045 ; support material
G1 E0.22045 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X97.175 Y97.175 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3007.128
G1 X102.825 Y97.175 E2.14074 ; support material
G1 X102.825 Y102.825 E2.28147 ; support material
G1 X97.175 Y102.825 E2.42221 ; support material
G1 X97.175 Y97.175 E2.56294 ; support material
G1 X96.293 Y99.176 F7800.000 ; move to first support material point
G1 F3007.128
G1 X95.462 Y97.737 E2.60432 ; support material
G1 X95.462 Y101.100 E2.68809 ; support material
G1 X96.293 Y99.662 E2.72947 ; support material
G1 X96.463 Y99.662 E2.73369 ; support material
G1 X96.463 Y99.176 E2.74579 ; support material
G1 X96.293 Y99.176 E2.75002 ; support material
G1 E0.75002 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.625 Y100.625 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3007.128
G1 X90.625 Y98.325 E2.05729 ; support material
G1 X88.500 Y98.325 E2.11022 ; support material
G1 X88.500 Y100.625 E2.16751 ; support material
G1 X90.625 Y100.625 E2.22045 ; support material
G1 X89.913 Y99.913 F7800.000 ; move to first support material point
G1 F3007.128
G1 X89.913 Y99.037 E2.24225 ; support material
G1 X89.758 Y99.037 E2.24609 ; support material
G1 X89.678 Y99.176 E2.25008 ; support material
G1 X89.212 Y99.176 E2.26169 ; support material
G1 X89.212 Y99.662 E2.27378 ; support material
G1 X89.678 Y99.662 E2.28539 ; support material
G1 X89.823 Y99.913 E2.29261 ; support material
G1 X89.913 Y99.913 E2.29484 ; support material
G1 E0.29484 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.625 Y90.625 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3007.128
G1 X90.625 Y88.500 E2.05293 ; support material
G1 X88.500 Y88.500 E2.10586 ; support material
G1 X88.500 Y90.625 E2.15880 ; support material
G1 X90.625 Y90.625 E2.21173 ; support material
G1 X110.625 Y90.625 F7800.000 ; move to first support material point
G1 F3007.128
G1 X110.625 Y88.500 E2.26466 ; support material
G1 X108.325 Y88.500 E2.32195 ; support material
G1 X108.325 Y90.625 E2.37488 ; support material
G1 X110.625 Y90.625 E2.43217 ; support material
G1 E0.43217 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.625 Y110.625 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3007.128
G1 X110.625 Y108.325 E2.05729 ; support material
G1 X108.325 Y108.325 E2.11458 ; support material
G1 X108.325 Y110.625 E2.17187 ; support material
G1 X110.625 Y110.625 E2.22916 ; support material
G1 E0.22916 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.625 Y110.625 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3007.128
G1 X100.625 Y108.325 E2.05729 ; support material
G1 X98.325 Y108.325 E2.11458 ; support material
G1 X98.325 Y110.625 E2.17187 ; support material
G1 X100.625 Y110.625 E2.22916 ; support material
G1 E0.22916 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.625 Y110.625 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3007.128
G1 X90.625 Y108.325 E2.05729 ; support material
G1 X88.500 Y108.325 E2.11022 ; support material
G1 X88.500 Y110.625 E2.16751 ; support material
G1 X90.625 Y110.625 E2.22045 ; support material
G1 Z4.850 F7800.000 ; move to next layer (28)
G1 E0.22045 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F813.535
G1 X99.471 Y100.529 E2.02853 ; small perimeter
G1 X99.471 Y99.471 E2.05706 ; small perimeter
G1 X100.529 Y99.471 E2.08558 ; small perimeter
G1 X100.529 Y100.454 E2.11209 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F813.535
G1 X98.836 Y101.164 E2.17491 ; small perimeter
G1 X98.836 Y98.836 E2.23773 ; small perimeter
G1 X101.164 Y98.836 E2.30056 ; small perimeter
G1 X101.164 Y101.089 E2.36135 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F900.000
G1 X98.275 Y101.725 E2.43246 ; external small perimeter
G1 X98.275 Y98.275 E2.50357 ; external small perimeter
G1 X101.725 Y98.275 E2.57467 ; external small perimeter
G1 X101.725 Y101.650 E2.64423 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z5.050 F7800.000 ; move to next layer (29)
G1 E0.64423 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X104.200 Y104.200 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3254.142
G1 X104.200 Y94.750 E2.23539 ; support material
G1 X94.750 Y94.750 E2.47078 ; support material
G1 X94.750 Y104.200 E2.70617 ; support material
G1 X104.200 Y104.200 E2.94156 ; support material
G1 E0.94156 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.900 Y100.900 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3254.142
G1 X110.900 Y98.050 E2.07099 ; support material
G1 X108.050 Y98.050 E2.14198 ; support material
G1 X108.050 Y100.900 E2.21297 ; support material
G1 X110.900 Y100.900 E2.28396 ; support material
G1 X110.188 Y99.176 F7800.000 ; move to first support material point
G1 F3254.142
G1 X108.762 Y99.176 E2.31947 ; support material
G1 X108.762 Y99.662 E2.33156 ; support material
G1 X110.188 Y99.662 E2.36707 ; support material
G1 X110.188 Y99.176 E2.37916 ; support material
G1 E0.37916 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.488 Y96.190 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3254.142
G1 X103.488 Y95.462 E2.01813 ; support material
G1 X101.044 Y95.462 E2.07901 ; support material
G1 X101.464 Y96.190 E2.09994 ; support material
G1 X103.488 Y96.190 E2.15035 ; support material
G1 E0.15035 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.900 Y90.900 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3254.142
G1 X100.900 Y88.500 E2.05978 ; support material
G1 X98.050 Y88.500 E2.13077 ; support material
G1 X98.050 Y90.900 E2.19055 ; support material
G1 X100.900 Y90.900 E2.26154 ; support material
G1 E0.26154 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X97.175 Y97.175 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3254.142
G1 X102.825 Y97.175 E2.14074 ; support material
G1 X102.825 Y102.825 E2.28147 ; support material
G1 X97.175 Y102.825 E2.42221 ; support material
G1 X97.175 Y97.175 E2.56294 ; support material
G1 X96.293 Y99.176 F7800.000 ; move to first support material point
G1 F3254.142
G1 X95.462 Y97.737 E2.60432 ; support material
G1 X95.462 Y101.100 E2.68809 ; support material
G1 X96.293 Y99.662 E2.72947 ; support material
G1 X96.463 Y99.662 E2.73369 ; support material
G1 X96.463 Y99.176 E2.74579 ; support material
G1 X96.293 Y99.176 E2.75002 ; support material
G1 E0.75002 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.900 Y100.900 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3254.142
G1 X90.900 Y98.050 E2.07099 ; support material
G1 X88.500 Y98.050 E2.13077 ; support material
G1 X88.500 Y100.900 E2.20176 ; support material
G1 X90.900 Y100.900 E2.26154 ; support material
G1 X90.188 Y100.188 F7800.000 ; move to first support material point
G1 F3254.142
G1 X90.188 Y98.762 E2.29705 ; support material
G1 X89.917 Y98.762 E2.30379 ; support material
G1 X89.678 Y99.176 E2.31568 ; support material
G1 X89.212 Y99.176 E2.32729 ; support material
G1 X89.212 Y99.662 E2.33939 ; support material
G1 X89.678 Y99.662 E2.35099 ; support material
G1 X89.982 Y100.188 E2.36613 ; support material
G1 X90.188 Y100.188 E2.37125 ; support material
G1 E0.37125 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.900 Y90.900 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3254.142
G1 X90.900 Y88.500 E2.05978 ; support material
G1 X88.500 Y88.500 E2.11956 ; support material
G1 X88.500 Y90.900 E2.17935 ; support material
G1 X90.900 Y90.900 E2.23913 ; support material
G1 X110.900 Y90.900 F7800.000 ; move to first support material point
G1 F3254.142
G1 X110.900 Y88.500 E2.29891 ; support material
G1 X108.050 Y88.500 E2.36990 ; support material
G1 X108.050 Y90.900 E2.42968 ; support material
G1 X110.900 Y90.900 E2.50067 ; support material
G1 E0.50067 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.900 Y110.900 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3254.142
G1 X110.900 Y108.050 E2.07099 ; support material
G1 X108.050 Y108.050 E2.14198 ; support material
G1 X108.050 Y110.900 E2.21297 ; support material
G1 X110.900 Y110.900 E2.28396 ; support material
G1 E0.28396 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.900 Y110.900 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3254.142
G1 X100.900 Y108.050 E2.07099 ; support material
G1 X98.050 Y108.050 E2.14198 ; support material
G1 X98.050 Y110.900 E2.21297 ; support material
G1 X100.900 Y110.900 E2.28396 ; support material
G1 E0.28396 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.900 Y110.900 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3254.142
G1 X90.900 Y108.050 E2.07099 ; support material
G1 X88.500 Y108.050 E2.13077 ; support material
G1 X88.500 Y110.900 E2.20176 ; support material
G1 X90.900 Y110.900 E2.26154 ; support material
G1 Z5.150 F7800.000 ; move to next layer (30)
G1 E0.26154 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F885.434
G1 X99.471 Y100.529 E2.02853 ; small perimeter
G1 X99.471 Y99.471 E2.05706 ; small perimeter
G1 X100.529 Y99.471 E2.08558 ; small perimeter
G1 X100.529 Y100.454 E2.11209 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F885.434
G1 X98.836 Y101.164 E2.17491 ; small perimeter
G1 X98.836 Y98.836 E2.23773 ; small perimeter
G1 X101.164 Y98.836 E2.30056 ; small perimeter
G1 X101.164 Y101.089 E2.36135 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F900.000
G1 X98.275 Y101.725 E2.43246 ; external small perimeter
G1 X98.275 Y98.275 E2.50357 ; external small perimeter
G1 X101.725 Y98.275 E2.57467 ; external small perimeter
G1 X101.725 Y101.650 E2.64423 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z5.425 F7800.000 ; move to next layer (31)
G1 E0.64423 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X104.200 Y104.200 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3541.737
G1 X104.200 Y94.750 E2.23539 ; support material
G1 X94.750 Y94.750 E2.47078 ; support material
G1 X94.750 Y104.200 E2.70617 ; support material
G1 X104.200 Y104.200 E2.94156 ; support material
G1 E0.94156 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.463 Y110.463 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3541.737
G1 X100.463 Y110.353 E2.00273 ; support material
G1 X100.399 Y110.463 E2.00588 ; support material
G1 X100.463 Y110.463 E2.00746 ; support material
G1 X101.175 Y111.175 F7800.000 ; move to first support material point
G1 F3541.737
G1 X101.175 Y107.775 E2.09215 ; support material
G1 X97.775 Y107.775 E2.17684 ; support material
G1 X97.775 Y111.175 E2.26153 ; support material
G1 X101.175 Y111.175 E2.34622 ; support material
G1 E0.34622 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.175 Y111.175 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3541.737
G1 X91.175 Y107.775 E2.08469 ; support material
G1 X88.500 Y107.775 E2.15132 ; support material
G1 X88.500 Y111.175 E2.23601 ; support material
G1 X91.175 Y111.175 E2.30264 ; support material
G1 X90.463 Y110.463 F7800.000 ; move to first support material point
G1 F3541.737
G1 X90.463 Y109.760 E2.32015 ; support material
G1 X90.057 Y110.463 E2.34037 ; support material
G1 X90.463 Y110.463 E2.35047 ; support material
G1 E0.35047 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.175 Y101.175 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3541.737
G1 X91.175 Y97.775 E2.08469 ; support material
G1 X88.500 Y97.775 E2.15132 ; support material
G1 X88.500 Y101.175 E2.23601 ; support material
G1 X91.175 Y101.175 E2.30264 ; support material
G1 X90.463 Y100.463 F7800.000 ; move to first support material point
G1 F3541.737
G1 X90.463 Y98.487 E2.35185 ; support material
G1 X90.076 Y98.487 E2.36148 ; support material
G1 X89.678 Y99.176 E2.38129 ; support material
G1 X89.212 Y99.176 E2.39290 ; support material
G1 X89.212 Y99.662 E2.40499 ; support material
G1 X89.678 Y99.662 E2.41660 ; support material
G1 X90.141 Y100.463 E2.43964 ; support material
G1 X90.463 Y100.463 E2.44766 ; support material
G1 E0.44766 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X96.293 Y99.176 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3541.737
G1 X95.462 Y97.737 E2.04138 ; support material
G1 X95.462 Y101.100 E2.12514 ; support material
G1 X96.293 Y99.662 E2.16652 ; support material
G1 X96.463 Y99.662 E2.17075 ; support material
G1 X96.463 Y99.176 E2.18285 ; support material
G1 X96.293 Y99.176 E2.18708 ; support material
G1 X97.175 Y97.175 F7800.000 ; move to first support material point
G1 F3541.737
G1 X102.825 Y97.175 E2.32781 ; support material
G1 X102.825 Y102.825 E2.46855 ; support material
G1 X97.175 Y102.825 E2.60928 ; support material
G1 X97.175 Y97.175 E2.75002 ; support material
G1 X103.488 Y96.190 F7800.000 ; move to first support material point
G1 F3541.737
G1 X103.488 Y95.462 E2.76815 ; support material
G1 X101.044 Y95.462 E2.82902 ; support material
G1 X101.464 Y96.190 E2.84996 ; support material
G1 X103.488 Y96.190 E2.90037 ; support material
G1 E0.90037 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X101.175 Y91.175 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3541.737
G1 X101.175 Y88.500 E2.06663 ; support material
G1 X97.775 Y88.500 E2.15132 ; support material
G1 X97.775 Y91.175 E2.21795 ; support material
G1 X101.175 Y91.175 E2.30264 ; support material
G1 X91.175 Y91.175 F7800.000 ; move to first support material point
G1 F3541.737
G1 X91.175 Y88.500 E2.36928 ; support material
G1 X88.500 Y88.500 E2.43591 ; support material
G1 X88.500 Y91.175 E2.50254 ; support material
G1 X91.175 Y91.175 E2.56917 ; support material
G1 X111.175 Y91.175 F7800.000 ; move to first support material point
G1 F3541.737
G1 X111.175 Y88.500 E2.63580 ; support material
G1 X107.775 Y88.500 E2.72049 ; support material
G1 X107.775 Y91.175 E2.78713 ; support material
G1 X111.175 Y91.175 E2.87182 ; support material
G1 E0.87182 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.463 Y99.834 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3541.737
G1 X110.463 Y99.004 E2.02067 ; support material
G1 X110.363 Y99.176 E2.02563 ; support material
G1 X108.487 Y99.176 E2.07235 ; support material
G1 X108.487 Y99.662 E2.08445 ; support material
G1 X110.363 Y99.662 E2.13118 ; support material
G1 X110.463 Y99.834 E2.13613 ; support material
G1 X111.175 Y101.175 F7800.000 ; move to first support material point
G1 F3541.737
G1 X111.175 Y97.775 E2.22082 ; support material
G1 X107.775 Y97.775 E2.30551 ; support material
G1 X107.775 Y101.175 E2.39020 ; support material
G1 X111.175 Y101.175 E2.47489 ; support material
G1 E0.47489 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X111.175 Y111.175 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3541.737
G1 X111.175 Y107.775 E2.08469 ; support material
G1 X107.775 Y107.775 E2.16938 ; support material
G1 X107.775 Y111.175 E2.25407 ; support material
G1 X111.175 Y111.175 E2.33876 ; support material
G1 Z5.450 F7800.000 ; move to next layer (32)
G1 E0.33876 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F600.000
G1 X99.471 Y100.529 E2.02853 ; small perimeter
G1 X99.471 Y99.471 E2.05706 ; small perimeter
G1 X100.529 Y99.471 E2.08558 ; small perimeter
G1 X100.529 Y100.454 E2.11209 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X98.836 Y101.164 E2.17491 ; small perimeter
G1 X98.836 Y98.836 E2.23773 ; small perimeter
G1 X101.164 Y98.836 E2.30056 ; small perimeter
G1 X101.164 Y101.089 E2.36135 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F600.000
G1 X98.275 Y101.725 E2.43246 ; external small perimeter
G1 X98.275 Y98.275 E2.50357 ; external small perimeter
G1 X101.725 Y98.275 E2.57467 ; external small perimeter
G1 X101.725 Y101.650 E2.64423 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
M106 S252.45 ; enable fan
G1 Z5.750 F7800.000 ; move to next layer (33)
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 F900.000
G1 X99.471 Y100.529 E2.67276 ; small perimeter
G1 X99.471 Y99.471 E2.70129 ; small perimeter
G1 X100.529 Y99.471 E2.72982 ; small perimeter
G1 X100.529 Y100.454 E2.75632 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F900.000
G1 X98.836 Y101.164 E2.81914 ; small perimeter
G1 X98.836 Y98.836 E2.88197 ; small perimeter
G1 X101.164 Y98.836 E2.94479 ; small perimeter
G1 X101.164 Y101.089 E3.00559 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F900.000
G1 X98.275 Y101.725 E3.07669 ; external small perimeter
G1 X98.275 Y98.275 E3.14780 ; external small perimeter
G1 X101.725 Y98.275 E3.21890 ; external small perimeter
G1 X101.725 Y101.650 E3.28846 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z5.800 F7800.000 ; move to next layer (34)
G1 E1.28846 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X104.200 Y104.200 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X104.200 Y94.750 E2.23539 ; support material
G1 X94.750 Y94.750 E2.47078 ; support material
G1 X94.750 Y104.200 E2.70617 ; support material
G1 X104.200 Y104.200 E2.94156 ; support material
G1 E0.94156 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.738 Y110.738 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X100.738 Y109.877 E2.02145 ; support material
G1 X100.241 Y110.738 E2.04621 ; support material
G1 X100.738 Y110.738 E2.05859 ; support material
G1 X101.450 Y111.450 F7800.000 ; move to first support material point
G1 F3600.000
G1 X101.450 Y107.500 E2.15698 ; support material
G1 X97.500 Y107.500 E2.25537 ; support material
G1 X97.500 Y111.450 E2.35376 ; support material
G1 X101.450 Y111.450 E2.45215 ; support material
G1 E0.45215 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.738 Y110.738 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X110.738 Y110.470 E2.00667 ; support material
G1 X110.583 Y110.738 E2.01437 ; support material
G1 X110.738 Y110.738 E2.01822 ; support material
G1 X111.450 Y111.450 F7800.000 ; move to first support material point
G1 F3600.000
G1 X111.450 Y107.500 E2.11661 ; support material
G1 X107.500 Y107.500 E2.21500 ; support material
G1 X107.500 Y111.450 E2.31340 ; support material
G1 X111.450 Y111.450 E2.41179 ; support material
G1 E0.41179 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X111.450 Y101.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X111.450 Y97.500 E2.09839 ; support material
G1 X107.500 Y97.500 E2.19678 ; support material
G1 X107.500 Y101.450 E2.29517 ; support material
G1 X111.450 Y101.450 E2.39356 ; support material
G1 X110.738 Y100.310 F7800.000 ; move to first support material point
G1 F3600.000
G1 X110.738 Y98.527 E2.43797 ; support material
G1 X110.363 Y99.176 E2.45662 ; support material
G1 X108.212 Y99.176 E2.51020 ; support material
G1 X108.212 Y99.662 E2.52229 ; support material
G1 X110.363 Y99.662 E2.57587 ; support material
G1 X110.738 Y100.310 E2.59452 ; support material
G1 E0.59452 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.488 Y96.190 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X103.488 Y95.462 E2.01813 ; support material
G1 X101.044 Y95.462 E2.07901 ; support material
G1 X101.464 Y96.190 E2.09994 ; support material
G1 X103.488 Y96.190 E2.15035 ; support material
G1 E0.15035 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X101.450 Y91.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X101.450 Y88.500 E2.07348 ; support material
G1 X97.500 Y88.500 E2.17187 ; support material
G1 X97.500 Y91.450 E2.24535 ; support material
G1 X101.450 Y91.450 E2.34374 ; support material
G1 E0.34374 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X97.175 Y97.175 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X102.825 Y97.175 E2.14074 ; support material
G1 X102.825 Y102.825 E2.28147 ; support material
G1 X97.175 Y102.825 E2.42221 ; support material
G1 X97.175 Y97.175 E2.56294 ; support material
G1 X96.293 Y99.176 F7800.000 ; move to first support material point
G1 F3600.000
G1 X95.462 Y97.737 E2.60432 ; support material
G1 X95.462 Y101.100 E2.68809 ; support material
G1 X96.293 Y99.662 E2.72947 ; support material
G1 X96.463 Y99.662 E2.73369 ; support material
G1 X96.463 Y99.176 E2.74579 ; support material
G1 X96.293 Y99.176 E2.75002 ; support material
G1 E0.75002 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.450 Y101.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.450 Y97.500 E2.09839 ; support material
G1 X88.500 Y97.500 E2.17187 ; support material
G1 X88.500 Y101.450 E2.27026 ; support material
G1 X91.450 Y101.450 E2.34374 ; support material
G1 X90.738 Y100.738 F7800.000 ; move to first support material point
G1 F3600.000
G1 X90.738 Y98.212 E2.40665 ; support material
G1 X90.235 Y98.212 E2.41918 ; support material
G1 X89.678 Y99.176 E2.44689 ; support material
G1 X89.212 Y99.176 E2.45850 ; support material
G1 X89.212 Y99.662 E2.47060 ; support material
G1 X89.678 Y99.662 E2.48220 ; support material
G1 X90.300 Y100.738 E2.51316 ; support material
G1 X90.738 Y100.738 E2.52407 ; support material
G1 E0.52407 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.450 Y91.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.450 Y88.500 E2.07348 ; support material
G1 X88.500 Y88.500 E2.14696 ; support material
G1 X88.500 Y91.450 E2.22045 ; support material
G1 X91.450 Y91.450 E2.29393 ; support material
G1 X90.738 Y89.554 F7800.000 ; move to first support material point
G1 F3600.000
G1 X90.738 Y89.212 E2.30244 ; support material
G1 X90.540 Y89.212 E2.30735 ; support material
G1 X90.738 Y89.554 E2.31717 ; support material
G1 E0.31717 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X111.450 Y91.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X111.450 Y88.500 E2.07348 ; support material
G1 X107.500 Y88.500 E2.17187 ; support material
G1 X107.500 Y91.450 E2.24535 ; support material
G1 X111.450 Y91.450 E2.34374 ; support material
G1 E0.34374 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.450 Y111.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.450 Y107.500 E2.09839 ; support material
G1 X88.500 Y107.500 E2.17187 ; support material
G1 X88.500 Y111.450 E2.27026 ; support material
G1 X91.450 Y111.450 E2.34374 ; support material
G1 X90.738 Y110.738 F7800.000 ; move to first support material point
G1 F3600.000
G1 X90.738 Y109.284 E2.37997 ; support material
G1 X89.898 Y110.738 E2.42179 ; support material
G1 X90.738 Y110.738 E2.44270 ; support material
G1 Z6.050 F7800.000 ; move to next layer (35)
G1 E0.44270 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F900.000
G1 X99.471 Y100.529 E2.02853 ; small perimeter
G1 X99.471 Y99.471 E2.05706 ; small perimeter
G1 X100.529 Y99.471 E2.08558 ; small perimeter
G1 X100.529 Y100.454 E2.11209 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F900.000
G1 X98.836 Y101.164 E2.17491 ; small perimeter
G1 X98.836 Y98.836 E2.23773 ; small perimeter
G1 X101.164 Y98.836 E2.30056 ; small perimeter
G1 X101.164 Y101.089 E2.36135 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F900.000
G1 X98.275 Y101.725 E2.43246 ; external small perimeter
G1 X98.275 Y98.275 E2.50357 ; external small perimeter
G1 X101.725 Y98.275 E2.57467 ; external small perimeter
G1 X101.725 Y101.650 E2.64423 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z6.175 F7800.000 ; move to next layer (36)
G1 E0.64423 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X104.200 Y104.200 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X104.200 Y94.750 E2.23539 ; support material
G1 X94.750 Y94.750 E2.47078 ; support material
G1 X94.750 Y104.200 E2.70617 ; support material
G1 X104.200 Y104.200 E2.94156 ; support material
G1 E0.94156 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X101.013 Y110.788 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X101.013 Y109.400 E2.03456 ; support material
G1 X100.212 Y110.788 E2.07446 ; support material
G1 X101.013 Y110.788 E2.09441 ; support material
G1 X101.725 Y111.500 F7800.000 ; move to first support material point
G1 F3600.000
G1 X101.725 Y107.225 E2.20089 ; support material
G1 X97.225 Y107.225 E2.31298 ; support material
G1 X97.225 Y111.500 E2.41947 ; support material
G1 X101.725 Y111.500 E2.53156 ; support material
G1 E0.53156 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.788 Y110.788 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X110.788 Y110.383 E2.01007 ; support material
G1 X110.554 Y110.788 E2.02170 ; support material
G1 X110.788 Y110.788 E2.02752 ; support material
G1 X111.500 Y111.500 F7800.000 ; move to first support material point
G1 F3600.000
G1 X111.500 Y107.225 E2.13401 ; support material
G1 X107.225 Y107.225 E2.24049 ; support material
G1 X107.225 Y111.500 E2.34698 ; support material
G1 X111.500 Y111.500 E2.45346 ; support material
G1 E0.45346 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X111.500 Y101.725 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X111.500 Y97.225 E2.11209 ; support material
G1 X107.225 Y97.225 E2.21858 ; support material
G1 X107.225 Y101.725 E2.33067 ; support material
G1 X111.500 Y101.725 E2.43715 ; support material
G1 X110.788 Y100.397 F7800.000 ; move to first support material point
G1 F3600.000
G1 X110.788 Y98.441 E2.48587 ; support material
G1 X110.363 Y99.176 E2.50701 ; support material
G1 X107.937 Y99.176 E2.56744 ; support material
G1 X107.937 Y99.662 E2.57954 ; support material
G1 X110.363 Y99.662 E2.63997 ; support material
G1 X110.788 Y100.397 E2.66111 ; support material
G1 E0.66111 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.488 Y96.190 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X103.488 Y95.462 E2.01813 ; support material
G1 X101.044 Y95.462 E2.07901 ; support material
G1 X101.464 Y96.190 E2.09994 ; support material
G1 X103.488 Y96.190 E2.15035 ; support material
G1 E0.15035 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X101.725 Y91.725 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X101.725 Y88.500 E2.08033 ; support material
G1 X97.225 Y88.500 E2.19242 ; support material
G1 X97.225 Y91.725 E2.27275 ; support material
G1 X101.725 Y91.725 E2.38484 ; support material
G1 X101.013 Y89.437 F7800.000 ; move to first support material point
G1 F3600.000
G1 X101.013 Y89.212 E2.39044 ; support material
G1 X100.883 Y89.212 E2.39367 ; support material
G1 X101.013 Y89.437 E2.40014 ; support material
G1 E0.40014 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X97.175 Y97.175 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X102.825 Y97.175 E2.14074 ; support material
G1 X102.825 Y102.825 E2.28147 ; support material
G1 X97.175 Y102.825 E2.42221 ; support material
G1 X97.175 Y97.175 E2.56294 ; support material
G1 X96.293 Y99.176 F7800.000 ; move to first support material point
G1 F3600.000
G1 X95.462 Y97.737 E2.60432 ; support material
G1 X95.462 Y101.100 E2.68809 ; support material
G1 X96.293 Y99.662 E2.72947 ; support material
G1 X96.463 Y99.662 E2.73369 ; support material
G1 X96.463 Y99.176 E2.74579 ; support material
G1 X96.293 Y99.176 E2.75002 ; support material
G1 E0.75002 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.725 Y101.725 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.725 Y97.225 E2.11209 ; support material
G1 X88.500 Y97.225 E2.19242 ; support material
G1 X88.500 Y101.725 E2.30451 ; support material
G1 X91.725 Y101.725 E2.38484 ; support material
G1 X91.013 Y101.013 F7800.000 ; move to first support material point
G1 F3600.000
G1 X91.013 Y97.937 E2.46145 ; support material
G1 X90.393 Y97.937 E2.47687 ; support material
G1 X89.678 Y99.176 E2.51250 ; support material
G1 X89.212 Y99.176 E2.52411 ; support material
G1 X89.212 Y99.662 E2.53620 ; support material
G1 X89.678 Y99.662 E2.54781 ; support material
G1 X90.458 Y101.013 E2.58667 ; support material
G1 X91.013 Y101.013 E2.60048 ; support material
G1 E0.60048 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.013 Y107.944 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.013 Y107.944 E2.00000 ; support material
G1 X91.013 Y110.788 F7800.000 ; move to first support material point
G1 F3600.000
G1 X91.013 Y108.807 E2.04933 ; support material
G1 X89.869 Y110.788 E2.10629 ; support material
G1 X91.013 Y110.788 E2.13478 ; support material
G1 X91.725 Y111.500 F7800.000 ; move to first support material point
G1 F3600.000
G1 X91.725 Y107.225 E2.24126 ; support material
G1 X88.500 Y107.225 E2.32159 ; support material
G1 X88.500 Y111.500 E2.42808 ; support material
G1 X91.725 Y111.500 E2.50841 ; support material
G1 E0.50841 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.725 Y91.725 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.725 Y88.500 E2.08033 ; support material
G1 X88.500 Y88.500 E2.16066 ; support material
G1 X88.500 Y91.725 E2.24099 ; support material
G1 X91.725 Y91.725 E2.32133 ; support material
G1 X91.013 Y91.013 F7800.000 ; move to first support material point
G1 F3600.000
G1 X91.013 Y90.894 E2.32429 ; support material
G1 X90.944 Y91.013 E2.32772 ; support material
G1 X91.013 Y91.013 E2.32944 ; support material
G1 X91.013 Y90.030 F7800.000 ; move to first support material point
G1 F3600.000
G1 X91.013 Y89.212 E2.34981 ; support material
G1 X90.540 Y89.212 E2.36157 ; support material
G1 X91.013 Y90.030 E2.38510 ; support material
G1 E0.38510 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X111.500 Y91.725 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X111.500 Y88.500 E2.08033 ; support material
G1 X107.225 Y88.500 E2.18682 ; support material
G1 X107.225 Y91.725 E2.26715 ; support material
G1 X111.500 Y91.725 E2.37364 ; support material
M106 S249.9 ; enable fan
G1 Z6.350 F7800.000 ; move to next layer (37)
G1 E0.37364 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F900.000
G1 X99.471 Y100.529 E2.02853 ; small perimeter
G1 X99.471 Y99.471 E2.05706 ; small perimeter
G1 X100.529 Y99.471 E2.08558 ; small perimeter
G1 X100.529 Y100.454 E2.11209 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F900.000
G1 X98.836 Y101.164 E2.17491 ; small perimeter
G1 X98.836 Y98.836 E2.23773 ; small perimeter
G1 X101.164 Y98.836 E2.30056 ; small perimeter
G1 X101.164 Y101.089 E2.36135 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F900.000
G1 X98.275 Y101.725 E2.43246 ; external small perimeter
G1 X98.275 Y98.275 E2.50357 ; external small perimeter
G1 X101.725 Y98.275 E2.57467 ; external small perimeter
G1 X101.725 Y101.650 E2.64423 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z6.550 F7800.000 ; move to next layer (38)
G1 E0.64423 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X104.200 Y104.200 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X104.200 Y94.750 E2.23539 ; support material
G1 X94.750 Y94.750 E2.47078 ; support material
G1 X94.750 Y104.200 E2.70617 ; support material
G1 X104.200 Y104.200 E2.94156 ; support material
G1 E0.94156 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X101.288 Y107.827 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X101.288 Y107.662 E2.00410 ; support material
G1 X101.193 Y107.662 E2.00647 ; support material
G1 X101.288 Y107.827 E2.01121 ; support material
G1 X101.288 Y110.788 F7800.000 ; move to first support material point
G1 F3600.000
G1 X101.288 Y108.924 E2.05763 ; support material
G1 X100.212 Y110.788 E2.11123 ; support material
G1 X101.288 Y110.788 E2.13803 ; support material
G1 X102.000 Y111.500 F7800.000 ; move to first support material point
G1 F3600.000
G1 X102.000 Y106.950 E2.25137 ; support material
G1 X96.950 Y106.950 E2.37716 ; support material
G1 X96.950 Y111.500 E2.49050 ; support material
G1 X102.000 Y111.500 E2.61629 ; support material
G1 E0.61629 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.788 Y110.788 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X110.788 Y110.383 E2.01007 ; support material
G1 X110.554 Y110.788 E2.02170 ; support material
G1 X110.788 Y110.788 E2.02752 ; support material
G1 X111.500 Y111.500 F7800.000 ; move to first support material point
G1 F3600.000
G1 X111.500 Y106.950 E2.14086 ; support material
G1 X106.950 Y106.950 E2.25419 ; support material
G1 X106.950 Y111.500 E2.36753 ; support material
G1 X111.500 Y111.500 E2.48086 ; support material
G1 E0.48086 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X111.500 Y102.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X111.500 Y96.950 E2.12579 ; support material
G1 X106.950 Y96.950 E2.23913 ; support material
G1 X106.950 Y102.000 E2.36492 ; support material
G1 X111.500 Y102.000 E2.47825 ; support material
G1 X110.788 Y100.397 F7800.000 ; move to first support material point
G1 F3600.000
G1 X110.788 Y98.441 E2.52697 ; support material
G1 X110.363 Y99.176 E2.54811 ; support material
G1 X107.662 Y99.176 E2.61539 ; support material
G1 X107.662 Y99.662 E2.62749 ; support material
G1 X110.363 Y99.662 E2.69477 ; support material
G1 X110.788 Y100.397 E2.71591 ; support material
G1 E0.71591 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.488 Y96.190 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X103.488 Y95.462 E2.01813 ; support material
G1 X101.044 Y95.462 E2.07901 ; support material
G1 X101.464 Y96.190 E2.09994 ; support material
G1 X103.488 Y96.190 E2.15035 ; support material
G1 E0.15035 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X102.000 Y92.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X102.000 Y88.500 E2.08718 ; support material
G1 X96.950 Y88.500 E2.21297 ; support material
G1 X96.950 Y92.000 E2.30015 ; support material
G1 X102.000 Y92.000 E2.42594 ; support material
G1 X101.288 Y91.288 F7800.000 ; move to first support material point
G1 F3600.000
G1 X101.288 Y91.010 E2.43285 ; support material
G1 X101.128 Y91.288 E2.44083 ; support material
G1 X101.288 Y91.288 E2.44481 ; support material
G1 X101.288 Y89.913 F7800.000 ; move to first support material point
G1 F3600.000
G1 X101.288 Y89.212 E2.46228 ; support material
G1 X100.883 Y89.212 E2.47236 ; support material
G1 X101.288 Y89.913 E2.49252 ; support material
G1 E0.49252 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X97.175 Y97.175 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X102.825 Y97.175 E2.14074 ; support material
G1 X102.825 Y102.825 E2.28147 ; support material
G1 X97.175 Y102.825 E2.42221 ; support material
G1 X97.175 Y97.175 E2.56294 ; support material
G1 X96.293 Y99.176 F7800.000 ; move to first support material point
G1 F3600.000
G1 X95.462 Y97.737 E2.60432 ; support material
G1 X95.462 Y101.100 E2.68809 ; support material
G1 X96.293 Y99.662 E2.72947 ; support material
G1 X96.463 Y99.662 E2.73369 ; support material
G1 X96.463 Y99.176 E2.74579 ; support material
G1 X96.293 Y99.176 E2.75002 ; support material
G1 E0.75002 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X92.000 Y102.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X92.000 Y96.950 E2.12579 ; support material
G1 X88.500 Y96.950 E2.21297 ; support material
G1 X88.500 Y102.000 E2.33876 ; support material
G1 X92.000 Y102.000 E2.42594 ; support material
G1 X91.288 Y101.288 F7800.000 ; move to first support material point
G1 F3600.000
G1 X91.288 Y97.662 E2.51625 ; support material
G1 X90.552 Y97.662 E2.53457 ; support material
G1 X89.678 Y99.176 E2.57810 ; support material
G1 X89.212 Y99.176 E2.58971 ; support material
G1 X89.212 Y99.662 E2.60181 ; support material
G1 X89.678 Y99.662 E2.61341 ; support material
G1 X90.617 Y101.288 E2.66018 ; support material
G1 X91.288 Y101.288 E2.67689 ; support material
G1 E0.67689 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.288 Y108.133 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.288 Y107.662 E2.01172 ; support material
G1 X90.850 Y107.662 E2.02262 ; support material
G1 X91.122 Y108.133 E2.03615 ; support material
G1 X91.288 Y108.133 E2.04028 ; support material
G1 X91.288 Y110.788 F7800.000 ; move to first support material point
G1 F3600.000
G1 X91.288 Y108.618 E2.09432 ; support material
G1 X91.122 Y108.618 E2.09845 ; support material
G1 X89.869 Y110.788 E2.16085 ; support material
G1 X91.288 Y110.788 E2.19618 ; support material
G1 X92.000 Y111.500 F7800.000 ; move to first support material point
G1 F3600.000
G1 X92.000 Y106.950 E2.30951 ; support material
G1 X88.500 Y106.950 E2.39670 ; support material
G1 X88.500 Y111.500 E2.51003 ; support material
G1 X92.000 Y111.500 E2.59721 ; support material
G1 E0.59721 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X92.000 Y92.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X92.000 Y88.500 E2.08718 ; support material
G1 X88.500 Y88.500 E2.17436 ; support material
G1 X88.500 Y92.000 E2.26154 ; support material
G1 X92.000 Y92.000 E2.34873 ; support material
G1 X91.288 Y91.288 F7800.000 ; move to first support material point
G1 F3600.000
G1 X91.288 Y90.705 E2.36325 ; support material
G1 X91.122 Y90.705 E2.36738 ; support material
G1 X90.785 Y91.288 E2.38415 ; support material
G1 X91.288 Y91.288 E2.39667 ; support material
G1 X91.288 Y90.219 F7800.000 ; move to first support material point
G1 F3600.000
G1 X91.288 Y89.212 E2.42175 ; support material
G1 X90.540 Y89.212 E2.44036 ; support material
G1 X91.122 Y90.219 E2.46931 ; support material
G1 X91.288 Y90.219 E2.47345 ; support material
G1 E0.47345 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X111.500 Y92.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X111.500 Y88.500 E2.08718 ; support material
G1 X106.950 Y88.500 E2.20052 ; support material
G1 X106.950 Y92.000 E2.28770 ; support material
G1 X111.500 Y92.000 E2.40104 ; support material
G1 Z6.650 F7800.000 ; move to next layer (39)
G1 E0.40104 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F900.000
G1 X99.471 Y100.529 E2.02853 ; small perimeter
G1 X99.471 Y99.471 E2.05706 ; small perimeter
G1 X100.529 Y99.471 E2.08558 ; small perimeter
G1 X100.529 Y100.454 E2.11209 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F900.000
G1 X98.836 Y101.164 E2.17491 ; small perimeter
G1 X98.836 Y98.836 E2.23773 ; small perimeter
G1 X101.164 Y98.836 E2.30056 ; small perimeter
G1 X101.164 Y101.089 E2.36135 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F900.000
G1 X98.275 Y101.725 E2.43246 ; external small perimeter
G1 X98.275 Y98.275 E2.50357 ; external small perimeter
G1 X101.725 Y98.275 E2.57467 ; external small perimeter
G1 X101.725 Y101.650 E2.64423 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z6.925 F7800.000 ; move to next layer (40)
G1 E0.64423 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X104.200 Y104.200 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X104.200 Y94.750 E2.23539 ; support material
G1 X94.750 Y94.750 E2.47078 ; support material
G1 X94.750 Y104.200 E2.70617 ; support material
G1 X104.200 Y104.200 E2.94156 ; support material
G1 E0.94156 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X101.563 Y108.133 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X101.563 Y107.387 E2.01857 ; support material
G1 X101.034 Y107.387 E2.03174 ; support material
G1 X101.464 Y108.133 E2.05318 ; support material
G1 X101.563 Y108.133 E2.05564 ; support material
G1 X101.563 Y110.788 F7800.000 ; move to first support material point
G1 F3600.000
G1 X101.563 Y108.618 E2.10967 ; support material
G1 X101.464 Y108.618 E2.11212 ; support material
G1 X100.212 Y110.788 E2.17452 ; support material
G1 X101.563 Y110.788 E2.20817 ; support material
G1 X102.275 Y111.500 F7800.000 ; move to first support material point
G1 F3600.000
G1 X102.275 Y106.675 E2.32836 ; support material
G1 X96.675 Y106.675 E2.46785 ; support material
G1 X96.675 Y111.500 E2.58803 ; support material
G1 X102.275 Y111.500 E2.72752 ; support material
G1 E0.72752 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.788 Y110.788 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X110.788 Y110.383 E2.01007 ; support material
G1 X110.554 Y110.788 E2.02170 ; support material
G1 X110.788 Y110.788 E2.02752 ; support material
G1 X111.500 Y111.500 F7800.000 ; move to first support material point
G1 F3600.000
G1 X111.500 Y106.675 E2.14771 ; support material
G1 X106.675 Y106.675 E2.26789 ; support material
G1 X106.675 Y111.500 E2.38808 ; support material
G1 X111.500 Y111.500 E2.50826 ; support material
G1 E0.50826 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X111.500 Y102.275 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X111.500 Y96.675 E2.13949 ; support material
G1 X106.675 Y96.675 E2.25968 ; support material
G1 X106.675 Y102.275 E2.39917 ; support material
G1 X111.500 Y102.275 E2.51935 ; support material
G1 X110.788 Y100.397 F7800.000 ; move to first support material point
G1 F3600.000
G1 X110.788 Y98.441 E2.56807 ; support material
G1 X110.363 Y99.176 E2.58921 ; support material
G1 X107.387 Y99.176 E2.66334 ; support material
G1 X107.387 Y99.662 E2.67544 ; support material
G1 X110.363 Y99.662 E2.74957 ; support material
G1 X110.788 Y100.397 E2.77071 ; support material
G1 E0.77071 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X111.500 Y92.275 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X111.500 Y88.500 E2.09403 ; support material
G1 X106.675 Y88.500 E2.21422 ; support material
G1 X106.675 Y92.275 E2.30825 ; support material
G1 X111.500 Y92.275 E2.42844 ; support material
G1 E0.42844 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.488 Y96.190 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X103.488 Y95.462 E2.01813 ; support material
G1 X101.044 Y95.462 E2.07901 ; support material
G1 X101.464 Y96.190 E2.09994 ; support material
G1 X103.488 Y96.190 E2.15035 ; support material
G1 E0.15035 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X102.275 Y92.275 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X102.275 Y88.500 E2.09403 ; support material
G1 X96.675 Y88.500 E2.23352 ; support material
G1 X96.675 Y92.275 E2.32755 ; support material
G1 X102.275 Y92.275 E2.46704 ; support material
G1 X101.563 Y91.563 F7800.000 ; move to first support material point
G1 F3600.000
G1 X101.563 Y90.705 E2.48842 ; support material
G1 X101.464 Y90.705 E2.49087 ; support material
G1 X100.969 Y91.563 E2.51555 ; support material
G1 X101.563 Y91.563 E2.53034 ; support material
G1 X101.563 Y90.219 F7800.000 ; move to first support material point
G1 F3600.000
G1 X101.563 Y89.212 E2.55542 ; support material
G1 X100.883 Y89.212 E2.57235 ; support material
G1 X101.464 Y90.219 E2.60130 ; support material
G1 X101.563 Y90.219 E2.60376 ; support material
G1 E0.60376 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X97.175 Y97.175 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X102.825 Y97.175 E2.14074 ; support material
G1 X102.825 Y102.825 E2.28147 ; support material
G1 X97.175 Y102.825 E2.42221 ; support material
G1 X97.175 Y97.175 E2.56294 ; support material
G1 X96.293 Y99.176 F7800.000 ; move to first support material point
G1 F3600.000
G1 X95.462 Y97.737 E2.60432 ; support material
G1 X95.462 Y101.100 E2.68809 ; support material
G1 X96.293 Y99.662 E2.72947 ; support material
G1 X96.463 Y99.662 E2.73369 ; support material
G1 X96.463 Y99.176 E2.74579 ; support material
G1 X96.293 Y99.176 E2.75002 ; support material
G1 E0.75002 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X92.275 Y102.275 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X92.275 Y96.675 E2.13949 ; support material
G1 X88.500 Y96.675 E2.23352 ; support material
G1 X88.500 Y102.275 E2.37301 ; support material
G1 X92.275 Y102.275 E2.46704 ; support material
G1 X91.563 Y101.563 F7800.000 ; move to first support material point
G1 F3600.000
G1 X91.563 Y97.387 E2.57105 ; support material
G1 X90.711 Y97.387 E2.59226 ; support material
G1 X89.678 Y99.176 E2.64371 ; support material
G1 X89.212 Y99.176 E2.65531 ; support material
G1 X89.212 Y99.662 E2.66741 ; support material
G1 X89.678 Y99.662 E2.67902 ; support material
G1 X90.776 Y101.563 E2.73370 ; support material
G1 X91.563 Y101.563 E2.75330 ; support material
G1 E0.75330 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.563 Y108.133 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.563 Y107.387 E2.01857 ; support material
G1 X90.691 Y107.387 E2.04027 ; support material
G1 X91.122 Y108.133 E2.06171 ; support material
G1 X91.563 Y108.133 E2.07270 ; support material
G1 X91.563 Y110.788 F7800.000 ; move to first support material point
G1 F3600.000
G1 X91.563 Y108.618 E2.12673 ; support material
G1 X91.122 Y108.618 E2.13772 ; support material
G1 X89.869 Y110.788 E2.20011 ; support material
G1 X91.563 Y110.788 E2.24229 ; support material
G1 X92.275 Y111.500 F7800.000 ; move to first support material point
G1 F3600.000
G1 X92.275 Y106.675 E2.36248 ; support material
G1 X88.500 Y106.675 E2.45651 ; support material
G1 X88.500 Y111.500 E2.57670 ; support material
G1 X92.275 Y111.500 E2.67073 ; support material
G1 E0.67073 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X92.275 Y92.275 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X92.275 Y88.500 E2.09403 ; support material
G1 X88.500 Y88.500 E2.18806 ; support material
G1 X88.500 Y92.275 E2.28209 ; support material
G1 X92.275 Y92.275 E2.37613 ; support material
G1 X91.563 Y91.563 F7800.000 ; move to first support material point
G1 F3600.000
G1 X91.563 Y90.705 E2.39750 ; support material
G1 X91.122 Y90.705 E2.40848 ; support material
G1 X90.626 Y91.563 E2.43316 ; support material
G1 X91.563 Y91.563 E2.45648 ; support material
G1 X91.563 Y90.219 F7800.000 ; move to first support material point
G1 F3600.000
G1 X91.563 Y89.212 E2.48156 ; support material
G1 X90.540 Y89.212 E2.50702 ; support material
G1 X91.122 Y90.219 E2.53598 ; support material
G1 X91.563 Y90.219 E2.54696 ; support material
M106 S255 ; enable fan
G1 Z6.950 F7800.000 ; move to next layer (41)
G1 E0.54696 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F600.000
G1 X99.471 Y100.529 E2.02853 ; small perimeter
G1 X99.471 Y99.471 E2.05706 ; small perimeter
G1 X100.529 Y99.471 E2.08558 ; small perimeter
G1 X100.529 Y100.454 E2.11209 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X98.836 Y101.164 E2.17491 ; small perimeter
G1 X98.836 Y98.836 E2.23773 ; small perimeter
G1 X101.164 Y98.836 E2.30056 ; small perimeter
G1 X101.164 Y101.089 E2.36135 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F600.000
G1 X98.275 Y101.725 E2.43246 ; external small perimeter
G1 X98.275 Y98.275 E2.50357 ; external small perimeter
G1 X101.725 Y98.275 E2.57467 ; external small perimeter
G1 X101.725 Y101.650 E2.64423 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
M106 S247.35 ; enable fan
G1 Z7.250 F7800.000 ; move to next layer (42)
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 F900.000
G1 X99.471 Y100.529 E2.67276 ; small perimeter
G1 X99.471 Y99.471 E2.70129 ; small perimeter
G1 X100.529 Y99.471 E2.72982 ; small perimeter
G1 X100.529 Y100.454 E2.75632 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F900.000
G1 X98.836 Y101.164 E2.81914 ; small perimeter
G1 X98.836 Y98.836 E2.88197 ; small perimeter
G1 X101.164 Y98.836 E2.94479 ; small perimeter
G1 X101.164 Y101.089 E3.00559 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F900.000
G1 X98.275 Y101.725 E3.07669 ; external small perimeter
G1 X98.275 Y98.275 E3.14780 ; external small perimeter
G1 X101.725 Y98.275 E3.21890 ; external small perimeter
G1 X101.725 Y101.650 E3.28846 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z7.300 F7800.000 ; move to next layer (43)
G1 E1.28846 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X104.200 Y104.200 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X104.200 Y94.750 E2.23539 ; support material
G1 X94.750 Y94.750 E2.47078 ; support material
G1 X94.750 Y104.200 E2.70617 ; support material
G1 X104.200 Y104.200 E2.94156 ; support material
G1 E0.94156 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X101.838 Y108.133 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X101.838 Y107.112 E2.02542 ; support material
G1 X100.875 Y107.112 E2.04940 ; support material
G1 X101.464 Y108.133 E2.07875 ; support material
G1 X101.838 Y108.133 E2.08805 ; support material
G1 X101.838 Y110.788 F7800.000 ; move to first support material point
G1 F3600.000
G1 X101.838 Y108.618 E2.14209 ; support material
G1 X101.464 Y108.618 E2.15139 ; support material
G1 X100.212 Y110.788 E2.21378 ; support material
G1 X101.838 Y110.788 E2.25428 ; support material
G1 X102.550 Y111.500 F7800.000 ; move to first support material point
G1 F3600.000
G1 X102.550 Y106.400 E2.38132 ; support material
G1 X96.400 Y106.400 E2.53451 ; support material
G1 X96.400 Y111.500 E2.66155 ; support material
G1 X102.550 Y111.500 E2.81474 ; support material
G1 E0.81474 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.788 Y110.788 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X110.788 Y110.383 E2.01007 ; support material
G1 X110.554 Y110.788 E2.02170 ; support material
G1 X110.788 Y110.788 E2.02752 ; support material
G1 X111.500 Y111.500 F7800.000 ; move to first support material point
G1 F3600.000
G1 X111.500 Y106.400 E2.15456 ; support material
G1 X106.400 Y106.400 E2.28159 ; support material
G1 X106.400 Y111.500 E2.40863 ; support material
G1 X111.500 Y111.500 E2.53566 ; support material
G1 E0.53566 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X111.500 Y102.550 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X111.500 Y96.400 E2.15319 ; support material
G1 X106.400 Y96.400 E2.28023 ; support material
G1 X106.400 Y102.550 E2.43342 ; support material
G1 X111.500 Y102.550 E2.56045 ; support material
G1 X110.788 Y100.397 F7800.000 ; move to first support material point
G1 F3600.000
G1 X110.788 Y98.441 E2.60917 ; support material
G1 X110.363 Y99.176 E2.63031 ; support material
G1 X107.112 Y99.176 E2.71129 ; support material
G1 X107.112 Y99.662 E2.72339 ; support material
G1 X110.363 Y99.662 E2.80436 ; support material
G1 X110.788 Y100.397 E2.82551 ; support material
G1 E0.82551 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X111.500 Y92.550 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X111.500 Y88.500 E2.10088 ; support material
G1 X106.400 Y88.500 E2.22792 ; support material
G1 X106.400 Y92.550 E2.32880 ; support material
G1 X111.500 Y92.550 E2.45584 ; support material
G1 E0.45584 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.488 Y96.190 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X103.488 Y95.462 E2.01813 ; support material
G1 X101.044 Y95.462 E2.07901 ; support material
G1 X101.464 Y96.190 E2.09994 ; support material
G1 X103.488 Y96.190 E2.15035 ; support material
G1 E0.15035 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X102.550 Y92.550 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X102.550 Y88.500 E2.10088 ; support material
G1 X96.400 Y88.500 E2.25407 ; support material
G1 X96.400 Y92.550 E2.35495 ; support material
G1 X102.550 Y92.550 E2.50814 ; support material
G1 X101.838 Y91.838 F7800.000 ; move to first support material point
G1 F3600.000
G1 X101.838 Y90.705 E2.53637 ; support material
G1 X101.464 Y90.705 E2.54567 ; support material
G1 X100.810 Y91.838 E2.57826 ; support material
G1 X101.838 Y91.838 E2.60385 ; support material
G1 X101.838 Y90.219 F7800.000 ; move to first support material point
G1 F3600.000
G1 X101.838 Y89.212 E2.62893 ; support material
G1 X100.883 Y89.212 E2.65271 ; support material
G1 X101.464 Y90.219 E2.68167 ; support material
G1 X101.838 Y90.219 E2.69097 ; support material
G1 E0.69097 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X97.175 Y97.175 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X102.825 Y97.175 E2.14074 ; support material
G1 X102.825 Y102.825 E2.28147 ; support material
G1 X97.175 Y102.825 E2.42221 ; support material
G1 X97.175 Y97.175 E2.56294 ; support material
G1 X96.293 Y99.176 F7800.000 ; move to first support material point
G1 F3600.000
G1 X95.462 Y97.737 E2.60432 ; support material
G1 X95.462 Y101.100 E2.68809 ; support material
G1 X96.293 Y99.662 E2.72947 ; support material
G1 X96.463 Y99.662 E2.73369 ; support material
G1 X96.463 Y99.176 E2.74579 ; support material
G1 X96.293 Y99.176 E2.75002 ; support material
G1 E0.75002 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X92.550 Y102.550 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X92.550 Y96.400 E2.15319 ; support material
G1 X88.500 Y96.400 E2.25407 ; support material
G1 X88.500 Y102.550 E2.40726 ; support material
G1 X92.550 Y102.550 E2.50814 ; support material
G1 X91.838 Y101.838 F7800.000 ; move to first support material point
G1 F3600.000
G1 X91.838 Y97.112 E2.62585 ; support material
G1 X90.870 Y97.112 E2.64996 ; support material
G1 X89.678 Y99.176 E2.70931 ; support material
G1 X89.212 Y99.176 E2.72092 ; support material
G1 X89.212 Y99.662 E2.73302 ; support material
G1 X89.678 Y99.662 E2.74462 ; support material
G1 X90.935 Y101.838 E2.80721 ; support material
G1 X91.838 Y101.838 E2.82971 ; support material
G1 E0.82971 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.838 Y108.133 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.838 Y107.112 E2.02542 ; support material
G1 X90.533 Y107.112 E2.05793 ; support material
G1 X91.122 Y108.133 E2.08728 ; support material
G1 X91.838 Y108.133 E2.10511 ; support material
G1 X91.838 Y110.788 F7800.000 ; move to first support material point
G1 F3600.000
G1 X91.838 Y108.618 E2.15915 ; support material
G1 X91.122 Y108.618 E2.17698 ; support material
G1 X89.869 Y110.788 E2.23938 ; support material
G1 X91.838 Y110.788 E2.28841 ; support material
G1 X92.550 Y111.500 F7800.000 ; move to first support material point
G1 F3600.000
G1 X92.550 Y106.400 E2.41544 ; support material
G1 X88.500 Y106.400 E2.51632 ; support material
G1 X88.500 Y111.500 E2.64336 ; support material
G1 X92.550 Y111.500 E2.74424 ; support material
G1 E0.74424 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X92.550 Y92.550 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X92.550 Y88.500 E2.10088 ; support material
G1 X88.500 Y88.500 E2.20176 ; support material
G1 X88.500 Y92.550 E2.30264 ; support material
G1 X92.550 Y92.550 E2.40353 ; support material
G1 X91.838 Y91.838 F7800.000 ; move to first support material point
G1 F3600.000
G1 X91.838 Y90.705 E2.43175 ; support material
G1 X91.122 Y90.705 E2.44958 ; support material
G1 X90.468 Y91.838 E2.48217 ; support material
G1 X91.838 Y91.838 E2.51630 ; support material
G1 X91.838 Y90.219 F7800.000 ; move to first support material point
G1 F3600.000
G1 X91.838 Y89.212 E2.54137 ; support material
G1 X90.540 Y89.212 E2.57369 ; support material
G1 X91.122 Y90.219 E2.60264 ; support material
G1 X91.838 Y90.219 E2.62048 ; support material
G1 Z7.550 F7800.000 ; move to next layer (44)
G1 E0.62048 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F900.000
G1 X99.471 Y100.529 E2.02853 ; small perimeter
G1 X99.471 Y99.471 E2.05706 ; small perimeter
G1 X100.529 Y99.471 E2.08558 ; small perimeter
G1 X100.529 Y100.454 E2.11209 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F900.000
G1 X98.836 Y101.164 E2.17491 ; small perimeter
G1 X98.836 Y98.836 E2.23773 ; small perimeter
G1 X101.164 Y98.836 E2.30056 ; small perimeter
G1 X101.164 Y101.089 E2.36135 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F900.000
G1 X98.275 Y101.725 E2.43246 ; external small perimeter
G1 X98.275 Y98.275 E2.50357 ; external small perimeter
G1 X101.725 Y98.275 E2.57467 ; external small perimeter
G1 X101.725 Y101.650 E2.64423 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z7.675 F7800.000 ; move to next layer (45)
G1 E0.64423 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X104.200 Y104.200 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X104.200 Y94.750 E2.23539 ; support material
G1 X94.750 Y94.750 E2.47078 ; support material
G1 X94.750 Y104.200 E2.70617 ; support material
G1 X104.200 Y104.200 E2.94156 ; support material
G1 E0.94156 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X102.113 Y108.133 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X102.113 Y106.837 E2.03227 ; support material
G1 X100.716 Y106.837 E2.06705 ; support material
G1 X101.464 Y108.133 E2.10431 ; support material
G1 X102.113 Y108.133 E2.12046 ; support material
G1 X102.113 Y110.788 F7800.000 ; move to first support material point
G1 F3600.000
G1 X102.113 Y108.618 E2.17450 ; support material
G1 X101.464 Y108.618 E2.19065 ; support material
G1 X100.212 Y110.788 E2.25305 ; support material
G1 X102.113 Y110.788 E2.30040 ; support material
G1 X102.825 Y111.500 F7800.000 ; move to first support material point
G1 F3600.000
G1 X102.825 Y106.125 E2.43428 ; support material
G1 X96.125 Y106.125 E2.60117 ; support material
G1 X96.125 Y111.500 E2.73506 ; support material
G1 X102.825 Y111.500 E2.90195 ; support material
G1 E0.90195 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.788 Y110.788 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X110.788 Y110.383 E2.01007 ; support material
G1 X110.554 Y110.788 E2.02170 ; support material
G1 X110.788 Y110.788 E2.02752 ; support material
G1 X111.500 Y111.500 F7800.000 ; move to first support material point
G1 F3600.000
G1 X111.500 Y106.125 E2.16141 ; support material
G1 X106.125 Y106.125 E2.29529 ; support material
G1 X106.125 Y111.500 E2.42918 ; support material
G1 X111.500 Y111.500 E2.56306 ; support material
G1 E0.56306 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X111.500 Y102.825 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X111.500 Y96.125 E2.16689 ; support material
G1 X106.125 Y96.125 E2.30078 ; support material
G1 X106.125 Y102.825 E2.46767 ; support material
G1 X111.500 Y102.825 E2.60155 ; support material
G1 X110.788 Y100.397 F7800.000 ; move to first support material point
G1 F3600.000
G1 X110.788 Y98.441 E2.65027 ; support material
G1 X110.363 Y99.176 E2.67141 ; support material
G1 X106.837 Y99.176 E2.75924 ; support material
G1 X106.837 Y99.662 E2.77134 ; support material
G1 X110.363 Y99.662 E2.85916 ; support material
G1 X110.788 Y100.397 E2.88031 ; support material
G1 E0.88031 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X111.500 Y92.825 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X111.500 Y88.500 E2.10773 ; support material
G1 X106.125 Y88.500 E2.24162 ; support material
G1 X106.125 Y92.825 E2.34935 ; support material
G1 X111.500 Y92.825 E2.48324 ; support material
G1 X102.825 Y92.825 F7800.000 ; move to first support material point
G1 F3600.000
G1 X102.825 Y88.500 E2.59097 ; support material
G1 X96.125 Y88.500 E2.75786 ; support material
G1 X96.125 Y92.825 E2.86559 ; support material
G1 X102.825 Y92.825 E3.03248 ; support material
G1 X102.113 Y92.113 F7800.000 ; move to first support material point
G1 F3600.000
G1 X102.113 Y90.705 E3.06755 ; support material
G1 X101.464 Y90.705 E3.08370 ; support material
G1 X100.651 Y92.113 E3.12420 ; support material
G1 X102.113 Y92.113 E3.16060 ; support material
G1 X102.113 Y90.219 F7800.000 ; move to first support material point
G1 F3600.000
G1 X102.113 Y89.212 E3.18568 ; support material
G1 X100.883 Y89.212 E3.21631 ; support material
G1 X101.464 Y90.219 E3.24527 ; support material
G1 X102.113 Y90.219 E3.26142 ; support material
G1 E1.26142 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.488 Y96.190 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X103.488 Y95.462 E2.01813 ; support material
G1 X101.044 Y95.462 E2.07901 ; support material
G1 X101.464 Y96.190 E2.09994 ; support material
G1 X103.488 Y96.190 E2.15035 ; support material
G1 X97.175 Y97.175 F7800.000 ; move to first support material point
G1 F3600.000
G1 X102.825 Y97.175 E2.29108 ; support material
G1 X102.825 Y102.825 E2.43182 ; support material
G1 X97.175 Y102.825 E2.57256 ; support material
G1 X97.175 Y97.175 E2.71329 ; support material
G1 X96.293 Y99.176 F7800.000 ; move to first support material point
G1 F3600.000
G1 X95.462 Y97.737 E2.75467 ; support material
G1 X95.462 Y101.100 E2.83844 ; support material
G1 X96.293 Y99.662 E2.87981 ; support material
G1 X96.463 Y99.662 E2.88404 ; support material
G1 X96.463 Y99.176 E2.89614 ; support material
G1 X96.293 Y99.176 E2.90037 ; support material
G1 E0.90037 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X92.825 Y102.825 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X92.825 Y96.125 E2.16689 ; support material
G1 X88.500 Y96.125 E2.27462 ; support material
G1 X88.500 Y102.825 E2.44151 ; support material
G1 X92.825 Y102.825 E2.54924 ; support material
G1 X92.113 Y102.113 F7800.000 ; move to first support material point
G1 F3600.000
G1 X92.113 Y96.837 E2.68065 ; support material
G1 X91.028 Y96.837 E2.70765 ; support material
G1 X89.678 Y99.176 E2.77492 ; support material
G1 X89.212 Y99.176 E2.78652 ; support material
G1 X89.212 Y99.662 E2.79862 ; support material
G1 X89.678 Y99.662 E2.81023 ; support material
G1 X91.093 Y102.113 E2.88073 ; support material
G1 X92.113 Y102.113 E2.90612 ; support material
G1 E0.90612 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X92.113 Y108.133 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X92.113 Y106.837 E2.03227 ; support material
G1 X90.374 Y106.837 E2.07558 ; support material
G1 X91.122 Y108.133 E2.11284 ; support material
G1 X92.113 Y108.133 E2.13753 ; support material
G1 X92.113 Y110.788 F7800.000 ; move to first support material point
G1 F3600.000
G1 X92.113 Y108.618 E2.19156 ; support material
G1 X91.122 Y108.618 E2.21625 ; support material
G1 X89.869 Y110.788 E2.27864 ; support material
G1 X92.113 Y110.788 E2.33452 ; support material
G1 X92.825 Y111.500 F7800.000 ; move to first support material point
G1 F3600.000
G1 X92.825 Y106.125 E2.46841 ; support material
G1 X88.500 Y106.125 E2.57614 ; support material
G1 X88.500 Y111.500 E2.71002 ; support material
G1 X92.825 Y111.500 E2.81776 ; support material
G1 E0.81776 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X92.825 Y92.825 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X92.825 Y88.500 E2.10773 ; support material
G1 X88.500 Y88.500 E2.21546 ; support material
G1 X88.500 Y92.825 E2.32319 ; support material
G1 X92.825 Y92.825 E2.43093 ; support material
G1 X92.113 Y92.113 F7800.000 ; move to first support material point
G1 F3600.000
G1 X92.113 Y90.705 E2.46600 ; support material
G1 X91.122 Y90.705 E2.49068 ; support material
G1 X90.309 Y92.113 E2.53118 ; support material
G1 X92.113 Y92.113 E2.57611 ; support material
G1 X92.113 Y90.219 F7800.000 ; move to first support material point
G1 F3600.000
G1 X92.113 Y89.212 E2.60119 ; support material
G1 X90.540 Y89.212 E2.64035 ; support material
G1 X91.122 Y90.219 E2.66931 ; support material
G1 X92.113 Y90.219 E2.69399 ; support material
G1 Z7.850 F7800.000 ; move to next layer (46)
G1 E0.69399 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F900.000
G1 X99.471 Y100.529 E2.02853 ; small perimeter
G1 X99.471 Y99.471 E2.05706 ; small perimeter
G1 X100.529 Y99.471 E2.08558 ; small perimeter
G1 X100.529 Y100.454 E2.11209 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F900.000
G1 X98.836 Y101.164 E2.17491 ; small perimeter
G1 X98.836 Y98.836 E2.23773 ; small perimeter
G1 X101.164 Y98.836 E2.30056 ; small perimeter
G1 X101.164 Y101.089 E2.36135 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F900.000
G1 X98.275 Y101.725 E2.43246 ; external small perimeter
G1 X98.275 Y98.275 E2.50357 ; external small perimeter
G1 X101.725 Y98.275 E2.57467 ; external small perimeter
G1 X101.725 Y101.650 E2.64423 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z8.050 F7800.000 ; move to next layer (47)
G1 E0.64423 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X104.200 Y104.200 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X104.200 Y94.750 E2.23539 ; support material
G1 X94.750 Y94.750 E2.47078 ; support material
G1 X94.750 Y104.200 E2.70617 ; support material
G1 X104.200 Y104.200 E2.94156 ; support material
G1 E0.94156 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X102.388 Y108.133 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X102.388 Y106.562 E2.03912 ; support material
G1 X100.557 Y106.562 E2.08471 ; support material
G1 X101.464 Y108.133 E2.12988 ; support material
G1 X102.388 Y108.133 E2.15288 ; support material
G1 X102.388 Y110.788 F7800.000 ; move to first support material point
G1 F3600.000
G1 X102.388 Y108.618 E2.20691 ; support material
G1 X101.464 Y108.618 E2.22992 ; support material
G1 X100.212 Y110.788 E2.29231 ; support material
G1 X102.388 Y110.788 E2.34651 ; support material
G1 X103.100 Y111.500 F7800.000 ; move to first support material point
G1 F3600.000
G1 X103.100 Y105.850 E2.48725 ; support material
G1 X95.850 Y105.850 E2.66784 ; support material
G1 X95.850 Y111.500 E2.80858 ; support material
G1 X103.100 Y111.500 E2.98917 ; support material
G1 E0.98917 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.788 Y110.788 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X110.788 Y110.383 E2.01007 ; support material
G1 X110.554 Y110.788 E2.02170 ; support material
G1 X110.788 Y110.788 E2.02752 ; support material
G1 X111.500 Y111.500 F7800.000 ; move to first support material point
G1 F3600.000
G1 X111.500 Y105.850 E2.16826 ; support material
G1 X105.850 Y105.850 E2.30899 ; support material
G1 X105.850 Y111.500 E2.44973 ; support material
G1 X111.500 Y111.500 E2.59046 ; support material
G1 E0.59046 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X111.500 Y103.100 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X111.500 Y95.850 E2.18059 ; support material
G1 X105.850 Y95.850 E2.32133 ; support material
G1 X105.850 Y103.100 E2.50192 ; support material
G1 X111.500 Y103.100 E2.64265 ; support material
G1 X110.788 Y100.397 F7800.000 ; move to first support material point
G1 F3600.000
G1 X110.788 Y98.441 E2.69137 ; support material
G1 X110.363 Y99.176 E2.71251 ; support material
G1 X106.635 Y99.176 E2.80537 ; support material
G1 X106.562 Y99.049 E2.80901 ; support material
G1 X106.562 Y99.788 E2.82741 ; support material
G1 X106.635 Y99.662 E2.83105 ; support material
G1 X110.363 Y99.662 E2.92391 ; support material
G1 X110.788 Y100.397 E2.94505 ; support material
G1 E0.94505 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X111.500 Y93.100 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X111.500 Y88.500 E2.11458 ; support material
G1 X105.850 Y88.500 E2.25532 ; support material
G1 X105.850 Y93.100 E2.36990 ; support material
G1 X111.500 Y93.100 E2.51064 ; support material
G1 X103.100 Y93.100 F7800.000 ; move to first support material point
G1 F3600.000
G1 X103.100 Y88.500 E2.62522 ; support material
G1 X95.850 Y88.500 E2.80581 ; support material
G1 X95.850 Y93.100 E2.92039 ; support material
G1 X103.100 Y93.100 E3.10098 ; support material
G1 X102.388 Y92.388 F7800.000 ; move to first support material point
G1 F3600.000
G1 X102.388 Y90.705 E3.14290 ; support material
G1 X101.464 Y90.705 E3.16590 ; support material
G1 X100.492 Y92.388 E3.21431 ; support material
G1 X102.388 Y92.388 E3.26152 ; support material
G1 X102.388 Y90.219 F7800.000 ; move to first support material point
G1 F3600.000
G1 X102.388 Y89.212 E3.28660 ; support material
G1 X100.883 Y89.212 E3.32408 ; support material
G1 X101.464 Y90.219 E3.35303 ; support material
G1 X102.388 Y90.219 E3.37604 ; support material
G1 E1.37604 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.488 Y96.190 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X103.488 Y95.462 E2.01813 ; support material
G1 X101.044 Y95.462 E2.07901 ; support material
G1 X101.464 Y96.190 E2.09994 ; support material
G1 X103.488 Y96.190 E2.15035 ; support material
G1 X97.175 Y97.175 F7800.000 ; move to first support material point
G1 F3600.000
G1 X102.825 Y97.175 E2.29108 ; support material
G1 X102.825 Y102.825 E2.43182 ; support material
G1 X97.175 Y102.825 E2.57256 ; support material
G1 X97.175 Y97.175 E2.71329 ; support material
G1 X96.293 Y99.176 F7800.000 ; move to first support material point
G1 F3600.000
G1 X95.462 Y97.737 E2.75467 ; support material
G1 X95.462 Y101.100 E2.83844 ; support material
G1 X96.293 Y99.662 E2.87981 ; support material
G1 X96.463 Y99.662 E2.88404 ; support material
G1 X96.463 Y99.176 E2.89614 ; support material
G1 X96.293 Y99.176 E2.90037 ; support material
G1 E0.90037 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X92.388 Y102.162 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X92.388 Y96.676 E2.13664 ; support material
G1 X91.122 Y96.676 E2.16818 ; support material
G1 X89.678 Y99.176 E2.24008 ; support material
G1 X89.212 Y99.176 E2.25169 ; support material
G1 X89.212 Y99.662 E2.26379 ; support material
G1 X89.678 Y99.662 E2.27539 ; support material
G1 X91.122 Y102.162 E2.34730 ; support material
G1 X92.388 Y102.162 E2.37883 ; support material
G1 X93.100 Y103.100 F7800.000 ; move to first support material point
G1 F3600.000
G1 X93.100 Y95.850 E2.55942 ; support material
G1 X88.500 Y95.850 E2.67400 ; support material
G1 X88.500 Y103.100 E2.85460 ; support material
G1 X93.100 Y103.100 E2.96918 ; support material
G1 E0.96918 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X92.388 Y108.133 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X92.388 Y106.562 E2.03912 ; support material
G1 X90.215 Y106.562 E2.09324 ; support material
G1 X91.122 Y108.133 E2.13841 ; support material
G1 X92.388 Y108.133 E2.16994 ; support material
G1 X92.388 Y110.788 F7800.000 ; move to first support material point
G1 F3600.000
G1 X92.388 Y108.618 E2.22398 ; support material
G1 X91.122 Y108.618 E2.25551 ; support material
G1 X89.869 Y110.788 E2.31790 ; support material
G1 X92.388 Y110.788 E2.38064 ; support material
G1 X93.100 Y111.500 F7800.000 ; move to first support material point
G1 F3600.000
G1 X93.100 Y105.850 E2.52137 ; support material
G1 X88.500 Y105.850 E2.63595 ; support material
G1 X88.500 Y111.500 E2.77669 ; support material
G1 X93.100 Y111.500 E2.89127 ; support material
G1 E0.89127 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X93.100 Y93.100 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X93.100 Y88.500 E2.11458 ; support material
G1 X88.500 Y88.500 E2.22916 ; support material
G1 X88.500 Y93.100 E2.34374 ; support material
G1 X93.100 Y93.100 E2.45833 ; support material
G1 X92.388 Y92.388 F7800.000 ; move to first support material point
G1 F3600.000
G1 X92.388 Y90.705 E2.50025 ; support material
G1 X91.122 Y90.705 E2.53178 ; support material
G1 X90.150 Y92.388 E2.58019 ; support material
G1 X92.388 Y92.388 E2.63593 ; support material
G1 X92.388 Y90.219 F7800.000 ; move to first support material point
G1 F3600.000
G1 X92.388 Y89.212 E2.66100 ; support material
G1 X90.540 Y89.212 E2.70702 ; support material
G1 X91.122 Y90.219 E2.73597 ; support material
G1 X92.388 Y90.219 E2.76751 ; support material
M106 S244.8 ; enable fan
G1 Z8.150 F7800.000 ; move to next layer (48)
G1 E0.76751 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F900.000
G1 X99.471 Y100.529 E2.02853 ; small perimeter
G1 X99.471 Y99.471 E2.05706 ; small perimeter
G1 X100.529 Y99.471 E2.08558 ; small perimeter
G1 X100.529 Y100.454 E2.11209 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F900.000
G1 X98.836 Y101.164 E2.17491 ; small perimeter
G1 X98.836 Y98.836 E2.23773 ; small perimeter
G1 X101.164 Y98.836 E2.30056 ; small perimeter
G1 X101.164 Y101.089 E2.36135 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F900.000
G1 X98.275 Y101.725 E2.43246 ; external small perimeter
G1 X98.275 Y98.275 E2.50357 ; external small perimeter
G1 X101.725 Y98.275 E2.57467 ; external small perimeter
G1 X101.725 Y101.650 E2.64423 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z8.425 F7800.000 ; move to next layer (49)
G1 E0.64423 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X104.200 Y104.200 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X104.200 Y94.750 E2.23539 ; support material
G1 X94.750 Y94.750 E2.47078 ; support material
G1 X94.750 Y104.200 E2.70617 ; support material
G1 X104.200 Y104.200 E2.94156 ; support material
G1 E0.94156 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X102.663 Y108.133 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X102.663 Y106.287 E2.04597 ; support material
G1 X100.399 Y106.287 E2.10236 ; support material
G1 X101.464 Y108.133 E2.15544 ; support material
G1 X102.663 Y108.133 E2.18529 ; support material
G1 X102.663 Y110.788 F7800.000 ; move to first support material point
G1 F3600.000
G1 X102.663 Y108.618 E2.23933 ; support material
G1 X101.464 Y108.618 E2.26918 ; support material
G1 X100.212 Y110.788 E2.33158 ; support material
G1 X102.663 Y110.788 E2.39263 ; support material
G1 X103.375 Y111.500 F7800.000 ; move to first support material point
G1 F3600.000
G1 X103.375 Y105.575 E2.54021 ; support material
G1 X95.575 Y105.575 E2.73450 ; support material
G1 X95.575 Y111.500 E2.88209 ; support material
G1 X103.375 Y111.500 E3.07638 ; support material
G1 E1.07638 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.444 Y110.788 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X106.287 Y110.516 E2.00783 ; support material
G1 X106.287 Y110.788 E2.01461 ; support material
G1 X106.444 Y110.788 E2.01852 ; support material
G1 X110.788 Y110.788 F7800.000 ; move to first support material point
G1 F3600.000
G1 X110.788 Y110.383 E2.02859 ; support material
G1 X110.554 Y110.788 E2.04022 ; support material
G1 X110.788 Y110.788 E2.04604 ; support material
G1 X111.500 Y111.500 F7800.000 ; move to first support material point
G1 F3600.000
G1 X111.500 Y105.575 E2.19363 ; support material
G1 X105.575 Y105.575 E2.34121 ; support material
G1 X105.575 Y111.500 E2.48880 ; support material
G1 X111.500 Y111.500 E2.63638 ; support material
G1 X110.788 Y106.368 F7800.000 ; move to first support material point
G1 F3600.000
G1 X110.788 Y106.287 E2.63839 ; support material
G1 X110.741 Y106.287 E2.63955 ; support material
G1 X110.788 Y106.368 E2.64186 ; support material
G1 E0.64186 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X111.500 Y103.375 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X111.500 Y95.575 E2.19429 ; support material
G1 X105.575 Y95.575 E2.34188 ; support material
G1 X105.575 Y103.375 E2.53617 ; support material
G1 X111.500 Y103.375 E2.68375 ; support material
G1 X110.788 Y100.397 F7800.000 ; move to first support material point
G1 F3600.000
G1 X110.788 Y98.441 E2.73247 ; support material
G1 X110.363 Y99.176 E2.75361 ; support material
G1 X106.635 Y99.176 E2.84647 ; support material
G1 X106.287 Y98.573 E2.86381 ; support material
G1 X106.287 Y100.264 E2.90594 ; support material
G1 X106.635 Y99.662 E2.92328 ; support material
G1 X110.363 Y99.662 E3.01614 ; support material
G1 X110.788 Y100.397 E3.03728 ; support material
G1 E1.03728 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X111.500 Y93.375 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X111.500 Y88.500 E2.12143 ; support material
G1 X105.575 Y88.500 E2.26902 ; support material
G1 X105.575 Y93.375 E2.39045 ; support material
G1 X111.500 Y93.375 E2.53804 ; support material
G1 X110.788 Y92.663 F7800.000 ; move to first support material point
G1 F3600.000
G1 X110.788 Y92.470 E2.54284 ; support material
G1 X110.676 Y92.663 E2.54840 ; support material
G1 X110.788 Y92.663 E2.55117 ; support material
G1 X106.322 Y92.663 F7800.000 ; move to first support material point
G1 F3600.000
G1 X106.287 Y92.602 E2.55292 ; support material
G1 X106.287 Y92.663 E2.55444 ; support material
G1 X106.322 Y92.663 E2.55532 ; support material
G1 E0.55532 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.375 Y93.375 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X103.375 Y88.500 E2.12143 ; support material
G1 X95.575 Y88.500 E2.31572 ; support material
G1 X95.575 Y93.375 E2.43715 ; support material
G1 X103.375 Y93.375 E2.63144 ; support material
G1 X102.663 Y92.663 F7800.000 ; move to first support material point
G1 F3600.000
G1 X102.663 Y90.705 E2.68022 ; support material
G1 X101.464 Y90.705 E2.71007 ; support material
G1 X100.334 Y92.663 E2.76639 ; support material
G1 X102.663 Y92.663 E2.82440 ; support material
G1 X102.663 Y90.219 F7800.000 ; move to first support material point
G1 F3600.000
G1 X102.663 Y89.212 E2.84947 ; support material
G1 X100.883 Y89.212 E2.89381 ; support material
G1 X101.464 Y90.219 E2.92276 ; support material
G1 X102.663 Y90.219 E2.95262 ; support material
G1 E0.95262 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.488 Y96.190 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X103.488 Y95.462 E2.01813 ; support material
G1 X101.044 Y95.462 E2.07901 ; support material
G1 X101.464 Y96.190 E2.09994 ; support material
G1 X103.488 Y96.190 E2.15035 ; support material
G1 X97.175 Y97.175 F7800.000 ; move to first support material point
G1 F3600.000
G1 X102.825 Y97.175 E2.29108 ; support material
G1 X102.825 Y102.825 E2.43182 ; support material
G1 X97.175 Y102.825 E2.57256 ; support material
G1 X97.175 Y97.175 E2.71329 ; support material
G1 X96.293 Y99.176 F7800.000 ; move to first support material point
G1 F3600.000
G1 X95.462 Y97.737 E2.75467 ; support material
G1 X95.462 Y101.100 E2.83844 ; support material
G1 X96.293 Y99.662 E2.87981 ; support material
G1 X96.463 Y99.662 E2.88404 ; support material
G1 X96.463 Y99.176 E2.89614 ; support material
G1 X96.293 Y99.176 E2.90037 ; support material
G1 E0.90037 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X92.663 Y102.162 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X92.663 Y96.676 E2.13664 ; support material
G1 X91.122 Y96.676 E2.17503 ; support material
G1 X89.678 Y99.176 E2.24693 ; support material
G1 X89.212 Y99.176 E2.25854 ; support material
G1 X89.212 Y99.662 E2.27064 ; support material
G1 X89.678 Y99.662 E2.28224 ; support material
G1 X91.122 Y102.162 E2.35415 ; support material
G1 X92.663 Y102.162 E2.39253 ; support material
G1 X92.663 Y102.663 F7800.000 ; move to first support material point
G1 F3600.000
G1 X92.663 Y102.647 E2.39292 ; support material
G1 X91.122 Y102.647 E2.43130 ; support material
G1 X91.113 Y102.663 E2.43175 ; support material
G1 X92.663 Y102.663 E2.47036 ; support material
G1 X93.375 Y103.375 F7800.000 ; move to first support material point
G1 F3600.000
G1 X93.375 Y95.575 E2.66465 ; support material
G1 X88.500 Y95.575 E2.78608 ; support material
G1 X88.500 Y103.375 E2.98037 ; support material
G1 X93.375 Y103.375 E3.10180 ; support material
G1 E1.10180 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X92.663 Y108.133 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X92.663 Y106.287 E2.04597 ; support material
G1 X90.056 Y106.287 E2.11089 ; support material
G1 X91.122 Y108.133 E2.16397 ; support material
G1 X92.663 Y108.133 E2.20236 ; support material
G1 X92.663 Y110.788 F7800.000 ; move to first support material point
G1 F3600.000
G1 X92.663 Y108.618 E2.25639 ; support material
G1 X91.122 Y108.618 E2.29477 ; support material
G1 X89.869 Y110.788 E2.35717 ; support material
G1 X92.663 Y110.788 E2.42675 ; support material
G1 X93.375 Y111.500 F7800.000 ; move to first support material point
G1 F3600.000
G1 X93.375 Y105.575 E2.57434 ; support material
G1 X88.500 Y105.575 E2.69577 ; support material
G1 X88.500 Y111.500 E2.84335 ; support material
G1 X93.375 Y111.500 E2.96479 ; support material
G1 E0.96479 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X93.375 Y93.375 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X93.375 Y88.500 E2.12143 ; support material
G1 X88.500 Y88.500 E2.24286 ; support material
G1 X88.500 Y93.375 E2.36429 ; support material
G1 X93.375 Y93.375 E2.48573 ; support material
G1 X92.663 Y92.663 F7800.000 ; move to first support material point
G1 F3600.000
G1 X92.663 Y90.705 E2.53450 ; support material
G1 X91.122 Y90.705 E2.57288 ; support material
G1 X89.991 Y92.663 E2.62920 ; support material
G1 X92.663 Y92.663 E2.69574 ; support material
G1 X92.663 Y90.219 F7800.000 ; move to first support material point
G1 F3600.000
G1 X92.663 Y89.212 E2.72082 ; support material
G1 X90.540 Y89.212 E2.77368 ; support material
G1 X91.122 Y90.219 E2.80264 ; support material
G1 X92.663 Y90.219 E2.84102 ; support material
M106 S255 ; enable fan
G1 Z8.450 F7800.000 ; move to next layer (50)
G1 E0.84102 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F600.000
G1 X99.471 Y100.529 E2.02853 ; small perimeter
G1 X99.471 Y99.471 E2.05706 ; small perimeter
G1 X100.529 Y99.471 E2.08558 ; small perimeter
G1 X100.529 Y100.454 E2.11209 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X98.836 Y101.164 E2.17491 ; small perimeter
G1 X98.836 Y98.836 E2.23773 ; small perimeter
G1 X101.164 Y98.836 E2.30056 ; small perimeter
G1 X101.164 Y101.089 E2.36135 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F600.000
G1 X98.275 Y101.725 E2.43246 ; external small perimeter
G1 X98.275 Y98.275 E2.50357 ; external small perimeter
G1 X101.725 Y98.275 E2.57467 ; external small perimeter
G1 X101.725 Y101.650 E2.64423 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
M106 S224.4 ; enable fan
G1 Z8.750 F7800.000 ; move to next layer (51)
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 F900.000
G1 X99.471 Y100.529 E2.67276 ; small perimeter
G1 X99.471 Y99.471 E2.70129 ; small perimeter
G1 X100.529 Y99.471 E2.72982 ; small perimeter
G1 X100.529 Y100.454 E2.75632 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F900.000
G1 X98.836 Y101.164 E2.81914 ; small perimeter
G1 X98.836 Y98.836 E2.88197 ; small perimeter
G1 X101.164 Y98.836 E2.94479 ; small perimeter
G1 X101.164 Y101.089 E3.00559 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F900.000
G1 X98.275 Y101.725 E3.07669 ; external small perimeter
G1 X98.275 Y98.275 E3.14780 ; external small perimeter
G1 X101.725 Y98.275 E3.21890 ; external small perimeter
G1 X101.725 Y101.650 E3.28846 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z8.800 F7800.000 ; move to next layer (52)
G1 E1.28846 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.965 Y103.965 F7800.000 ; move to first support material interface point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X103.965 Y94.985 E2.22370 ; support material interface
G1 X103.493 Y94.985 E2.23547 ; support material interface
G1 X103.493 Y103.965 E2.45917 ; support material interface
G1 X103.020 Y103.965 E2.47095 ; support material interface
G1 X103.020 Y103.060 E2.49351 ; support material interface
G1 X102.547 Y103.060 E2.50528 ; support material interface
G1 X102.547 Y103.965 E2.52784 ; support material interface
G1 X102.075 Y103.965 E2.53961 ; support material interface
G1 X102.075 Y103.060 E2.56217 ; support material interface
G1 X101.602 Y103.060 E2.57395 ; support material interface
G1 X101.602 Y103.965 E2.59651 ; support material interface
G1 X101.129 Y103.965 E2.60828 ; support material interface
G1 X101.129 Y103.060 E2.63084 ; support material interface
G1 X100.657 Y103.060 E2.64261 ; support material interface
G1 X100.657 Y103.965 E2.66517 ; support material interface
G1 X100.184 Y103.965 E2.67694 ; support material interface
G1 X100.184 Y103.060 E2.69950 ; support material interface
G1 X99.711 Y103.060 E2.71128 ; support material interface
G1 X99.711 Y103.965 E2.73384 ; support material interface
G1 X99.239 Y103.965 E2.74561 ; support material interface
G1 X99.239 Y103.060 E2.76817 ; support material interface
G1 X98.766 Y103.060 E2.77994 ; support material interface
G1 X98.766 Y103.965 E2.80250 ; support material interface
G1 X98.293 Y103.965 E2.81428 ; support material interface
G1 X98.293 Y103.060 E2.83684 ; support material interface
G1 X97.821 Y103.060 E2.84861 ; support material interface
G1 X97.821 Y103.965 E2.87117 ; support material interface
G1 X97.348 Y103.965 E2.88294 ; support material interface
G1 X97.348 Y103.060 E2.90550 ; support material interface
G1 E0.90550 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.535 Y105.535 F7800.000 ; move to first support material interface point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X95.535 Y111.265 E2.14275 ; support material interface
G1 X96.027 Y111.265 E2.15501 ; support material interface
G1 X96.027 Y105.535 E2.29776 ; support material interface
G1 X96.520 Y105.535 E2.31003 ; support material interface
G1 X96.520 Y111.265 E2.45277 ; support material interface
G1 X97.012 Y111.265 E2.46504 ; support material interface
G1 X97.012 Y105.535 E2.60779 ; support material interface
G1 X97.505 Y105.535 E2.62006 ; support material interface
G1 X97.505 Y111.265 E2.76280 ; support material interface
G1 X97.997 Y111.265 E2.77507 ; support material interface
G1 X97.997 Y105.535 E2.91782 ; support material interface
G1 X98.490 Y105.535 E2.93008 ; support material interface
G1 X98.490 Y111.265 E3.07283 ; support material interface
G1 X98.982 Y111.265 E3.08510 ; support material interface
G1 X98.982 Y105.535 E3.22784 ; support material interface
G1 X99.475 Y105.535 E3.24011 ; support material interface
G1 X99.475 Y111.265 E3.38286 ; support material interface
G1 X99.968 Y111.265 E3.39513 ; support material interface
G1 X99.968 Y105.535 E3.53787 ; support material interface
G1 X100.460 Y105.535 E3.55014 ; support material interface
G1 X100.460 Y111.265 E3.69289 ; support material interface
G1 X100.953 Y111.265 E3.70515 ; support material interface
G1 X100.953 Y105.535 E3.84790 ; support material interface
G1 X101.445 Y105.535 E3.86017 ; support material interface
G1 X101.445 Y111.265 E4.00291 ; support material interface
G1 X101.938 Y111.265 E4.01518 ; support material interface
G1 X101.938 Y105.535 E4.15793 ; support material interface
G1 X102.430 Y105.535 E4.17020 ; support material interface
G1 X102.430 Y111.265 E4.31294 ; support material interface
G1 X102.923 Y111.265 E4.32521 ; support material interface
G1 X102.923 Y105.535 E4.46796 ; support material interface
G1 X103.415 Y105.535 E4.48022 ; support material interface
G1 X103.415 Y111.265 E4.62297 ; support material interface
G1 E2.62297 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X105.535 Y105.535 F7800.000 ; move to first support material interface point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X105.535 Y111.265 E2.14275 ; support material interface
G1 X106.012 Y111.265 E2.15464 ; support material interface
G1 X106.012 Y105.535 E2.29739 ; support material interface
G1 X106.490 Y105.535 E2.30928 ; support material interface
G1 X106.490 Y111.265 E2.45203 ; support material interface
G1 X106.967 Y111.265 E2.46392 ; support material interface
G1 X106.967 Y105.535 E2.60667 ; support material interface
G1 X107.445 Y105.535 E2.61856 ; support material interface
G1 X107.445 Y111.265 E2.76131 ; support material interface
G1 X107.922 Y111.265 E2.77320 ; support material interface
G1 X107.922 Y105.535 E2.91595 ; support material interface
G1 X108.400 Y105.535 E2.92784 ; support material interface
G1 X108.400 Y111.265 E3.07059 ; support material interface
G1 X108.878 Y111.265 E3.08248 ; support material interface
G1 X108.878 Y105.535 E3.22523 ; support material interface
G1 X109.355 Y105.535 E3.23713 ; support material interface
G1 X109.355 Y111.265 E3.37987 ; support material interface
G1 X109.833 Y111.265 E3.39177 ; support material interface
G1 X109.833 Y105.535 E3.53451 ; support material interface
G1 X110.310 Y105.535 E3.54641 ; support material interface
G1 X110.310 Y111.265 E3.68915 ; support material interface
G1 X110.788 Y111.265 E3.70105 ; support material interface
G1 X110.788 Y105.535 E3.84379 ; support material interface
G1 X111.265 Y105.535 E3.85569 ; support material interface
G1 X111.265 Y111.265 E3.99843 ; support material interface
G1 E1.99843 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X111.265 Y103.415 F7800.000 ; move to first support material interface point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X111.265 Y95.535 E2.19630 ; support material interface
G1 X110.788 Y95.535 E2.20820 ; support material interface
G1 X110.788 Y103.415 E2.40450 ; support material interface
G1 X110.310 Y103.415 E2.41639 ; support material interface
G1 X110.310 Y95.535 E2.61269 ; support material interface
G1 X109.833 Y95.535 E2.62459 ; support material interface
G1 X109.833 Y103.415 E2.82089 ; support material interface
G1 X109.355 Y103.415 E2.83278 ; support material interface
G1 X109.355 Y95.535 E3.02908 ; support material interface
G1 X108.878 Y95.535 E3.04098 ; support material interface
G1 X108.878 Y103.415 E3.23728 ; support material interface
G1 X108.400 Y103.415 E3.24917 ; support material interface
G1 X108.400 Y95.535 E3.44547 ; support material interface
G1 X107.922 Y95.535 E3.45737 ; support material interface
G1 X107.922 Y103.415 E3.65367 ; support material interface
G1 X107.445 Y103.415 E3.66556 ; support material interface
G1 X107.445 Y95.535 E3.86186 ; support material interface
G1 X106.967 Y95.535 E3.87376 ; support material interface
G1 X106.967 Y103.415 E4.07006 ; support material interface
G1 X106.490 Y103.415 E4.08195 ; support material interface
G1 X106.490 Y95.535 E4.27825 ; support material interface
G1 X106.012 Y95.535 E4.29015 ; support material interface
G1 X106.012 Y103.415 E4.48645 ; support material interface
G1 X105.535 Y103.415 E4.49834 ; support material interface
G1 X105.535 Y95.535 E4.69464 ; support material interface
G1 E2.69464 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.020 Y96.940 F7800.000 ; move to first support material interface point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X103.020 Y94.985 E2.04871 ; support material interface
G1 X102.547 Y94.985 E2.06049 ; support material interface
G1 X102.547 Y96.940 E2.10920 ; support material interface
G1 X102.075 Y96.940 E2.12097 ; support material interface
G1 X102.075 Y94.985 E2.16969 ; support material interface
G1 X101.602 Y94.985 E2.18146 ; support material interface
G1 X101.602 Y96.940 E2.23018 ; support material interface
G1 X101.129 Y96.940 E2.24195 ; support material interface
G1 X101.129 Y94.985 E2.29066 ; support material interface
G1 X100.657 Y94.985 E2.30244 ; support material interface
G1 X100.657 Y96.940 E2.35115 ; support material interface
G1 X100.184 Y96.940 E2.36292 ; support material interface
G1 X100.184 Y94.985 E2.41164 ; support material interface
G1 X99.711 Y94.985 E2.42341 ; support material interface
G1 X99.711 Y96.940 E2.47213 ; support material interface
G1 X99.239 Y96.940 E2.48390 ; support material interface
G1 X99.239 Y94.985 E2.53261 ; support material interface
G1 X98.766 Y94.985 E2.54439 ; support material interface
G1 X98.766 Y96.940 E2.59310 ; support material interface
G1 X98.293 Y96.940 E2.60487 ; support material interface
G1 X98.293 Y94.985 E2.65359 ; support material interface
G1 X97.821 Y94.985 E2.66536 ; support material interface
G1 X97.821 Y96.940 E2.71408 ; support material interface
G1 X97.348 Y96.940 E2.72585 ; support material interface
G1 X97.348 Y94.985 E2.77456 ; support material interface
G1 X96.875 Y94.985 E2.78634 ; support material interface
G1 X96.875 Y103.965 E3.01004 ; support material interface
G1 X96.403 Y103.965 E3.02181 ; support material interface
G1 X96.403 Y94.985 E3.24551 ; support material interface
G1 X95.930 Y94.985 E3.25728 ; support material interface
G1 X95.930 Y103.965 E3.48098 ; support material interface
G1 X95.457 Y103.965 E3.49276 ; support material interface
G1 X95.457 Y94.985 E3.71646 ; support material interface
G1 X94.985 Y94.985 E3.72823 ; support material interface
G1 X94.985 Y103.965 E3.95193 ; support material interface
G1 X94.985 Y94.985 E4.17563 ; support material interface
G1 E2.17563 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X93.415 Y93.415 F7800.000 ; move to first support material interface point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X93.415 Y88.735 E2.11659 ; support material interface
G1 X92.895 Y88.735 E2.12955 ; support material interface
G1 X92.895 Y93.415 E2.24614 ; support material interface
G1 X92.375 Y93.415 E2.25909 ; support material interface
G1 X92.375 Y88.735 E2.37568 ; support material interface
G1 X91.855 Y88.735 E2.38864 ; support material interface
G1 X91.855 Y93.415 E2.50523 ; support material interface
G1 X91.335 Y93.415 E2.51818 ; support material interface
G1 X91.335 Y88.735 E2.63477 ; support material interface
G1 X90.815 Y88.735 E2.64773 ; support material interface
G1 X90.815 Y93.415 E2.76432 ; support material interface
G1 X90.295 Y93.415 E2.77727 ; support material interface
G1 X90.295 Y88.735 E2.89386 ; support material interface
G1 X89.775 Y88.735 E2.90682 ; support material interface
G1 X89.775 Y93.415 E3.02341 ; support material interface
G1 X89.255 Y93.415 E3.03636 ; support material interface
G1 X89.255 Y88.735 E3.15295 ; support material interface
G1 X88.735 Y88.735 E3.16591 ; support material interface
G1 X88.735 Y93.415 E3.28250 ; support material interface
G1 X88.735 Y88.735 E3.39909 ; support material interface
G1 E1.39909 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X88.735 Y95.535 F7800.000 ; move to first support material interface point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X88.735 Y103.415 E2.19630 ; support material interface
G1 X88.735 Y95.535 E2.39260 ; support material interface
G1 X89.255 Y95.535 E2.40555 ; support material interface
G1 X89.255 Y103.415 E2.60185 ; support material interface
G1 X89.775 Y103.415 E2.61481 ; support material interface
G1 X89.775 Y95.535 E2.81111 ; support material interface
G1 X90.295 Y95.535 E2.82406 ; support material interface
G1 X90.295 Y103.415 E3.02036 ; support material interface
G1 X90.815 Y103.415 E3.03332 ; support material interface
G1 X90.815 Y95.535 E3.22962 ; support material interface
G1 X91.335 Y95.535 E3.24257 ; support material interface
G1 X91.335 Y103.415 E3.43887 ; support material interface
G1 X91.855 Y103.415 E3.45182 ; support material interface
G1 X91.855 Y95.535 E3.64812 ; support material interface
G1 X92.375 Y95.535 E3.66108 ; support material interface
G1 X92.375 Y103.415 E3.85738 ; support material interface
G1 X92.895 Y103.415 E3.87033 ; support material interface
G1 X92.895 Y95.535 E4.06663 ; support material interface
G1 X93.415 Y95.535 E4.07959 ; support material interface
G1 X93.415 Y103.415 E4.27589 ; support material interface
G1 E2.27589 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X88.735 Y105.535 F7800.000 ; move to first support material interface point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X88.735 Y111.265 E2.14275 ; support material interface
G1 X88.735 Y105.535 E2.28549 ; support material interface
G1 X89.255 Y105.535 E2.29845 ; support material interface
G1 X89.255 Y111.265 E2.44119 ; support material interface
G1 X89.775 Y111.265 E2.45414 ; support material interface
G1 X89.775 Y105.535 E2.59689 ; support material interface
G1 X90.295 Y105.535 E2.60984 ; support material interface
G1 X90.295 Y111.265 E2.75259 ; support material interface
G1 X90.815 Y111.265 E2.76554 ; support material interface
G1 X90.815 Y105.535 E2.90829 ; support material interface
G1 X91.335 Y105.535 E2.92124 ; support material interface
G1 X91.335 Y111.265 E3.06399 ; support material interface
G1 X91.855 Y111.265 E3.07694 ; support material interface
G1 X91.855 Y105.535 E3.21969 ; support material interface
G1 X92.375 Y105.535 E3.23264 ; support material interface
G1 X92.375 Y111.265 E3.37539 ; support material interface
G1 X92.895 Y111.265 E3.38834 ; support material interface
G1 X92.895 Y105.535 E3.53109 ; support material interface
G1 X93.415 Y105.535 E3.54404 ; support material interface
G1 X93.415 Y111.265 E3.68679 ; support material interface
G1 E1.68679 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.415 Y93.415 F7800.000 ; move to first support material interface point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X103.415 Y88.735 E2.11659 ; support material interface
G1 X102.923 Y88.735 E2.12886 ; support material interface
G1 X102.923 Y93.415 E2.24545 ; support material interface
G1 X102.430 Y93.415 E2.25772 ; support material interface
G1 X102.430 Y88.735 E2.37431 ; support material interface
G1 X101.938 Y88.735 E2.38658 ; support material interface
G1 X101.938 Y93.415 E2.50317 ; support material interface
G1 X101.445 Y93.415 E2.51544 ; support material interface
G1 X101.445 Y88.735 E2.63203 ; support material interface
G1 X100.953 Y88.735 E2.64430 ; support material interface
G1 X100.953 Y93.415 E2.76089 ; support material interface
G1 X100.460 Y93.415 E2.77316 ; support material interface
G1 X100.460 Y88.735 E2.88975 ; support material interface
G1 X99.968 Y88.735 E2.90202 ; support material interface
G1 X99.968 Y93.415 E3.01861 ; support material interface
G1 X99.475 Y93.415 E3.03088 ; support material interface
G1 X99.475 Y88.735 E3.14747 ; support material interface
G1 X98.982 Y88.735 E3.15974 ; support material interface
G1 X98.982 Y93.415 E3.27633 ; support material interface
G1 X98.490 Y93.415 E3.28860 ; support material interface
G1 X98.490 Y88.735 E3.40519 ; support material interface
G1 X97.997 Y88.735 E3.41746 ; support material interface
G1 X97.997 Y93.415 E3.53405 ; support material interface
G1 X97.505 Y93.415 E3.54631 ; support material interface
G1 X97.505 Y88.735 E3.66291 ; support material interface
G1 X97.012 Y88.735 E3.67517 ; support material interface
G1 X97.012 Y93.415 E3.79177 ; support material interface
G1 X96.520 Y93.415 E3.80403 ; support material interface
G1 X96.520 Y88.735 E3.92062 ; support material interface
G1 X96.027 Y88.735 E3.93289 ; support material interface
G1 X96.027 Y93.415 E4.04948 ; support material interface
G1 X95.535 Y93.415 E4.06175 ; support material interface
G1 X95.535 Y88.735 E4.17834 ; support material interface
G1 E2.17834 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X105.535 Y88.735 F7800.000 ; move to first support material interface point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X105.535 Y93.415 E2.11659 ; support material interface
G1 X106.012 Y93.415 E2.12849 ; support material interface
G1 X106.012 Y88.735 E2.24508 ; support material interface
G1 X106.490 Y88.735 E2.25697 ; support material interface
G1 X106.490 Y93.415 E2.37356 ; support material interface
G1 X106.967 Y93.415 E2.38546 ; support material interface
G1 X106.967 Y88.735 E2.50205 ; support material interface
G1 X107.445 Y88.735 E2.51394 ; support material interface
G1 X107.445 Y93.415 E2.63054 ; support material interface
G1 X107.922 Y93.415 E2.64243 ; support material interface
G1 X107.922 Y88.735 E2.75902 ; support material interface
G1 X108.400 Y88.735 E2.77092 ; support material interface
G1 X108.400 Y93.415 E2.88751 ; support material interface
G1 X108.878 Y93.415 E2.89940 ; support material interface
G1 X108.878 Y88.735 E3.01599 ; support material interface
G1 X109.355 Y88.735 E3.02789 ; support material interface
G1 X109.355 Y93.415 E3.14448 ; support material interface
G1 X109.833 Y93.415 E3.15638 ; support material interface
G1 X109.833 Y88.735 E3.27297 ; support material interface
G1 X110.310 Y88.735 E3.28486 ; support material interface
G1 X110.310 Y93.415 E3.40145 ; support material interface
G1 X110.788 Y93.415 E3.41335 ; support material interface
G1 X110.788 Y88.735 E3.52994 ; support material interface
G1 X111.265 Y88.735 E3.54183 ; support material interface
G1 X111.265 Y93.415 E3.65843 ; support material interface
M106 S221.85 ; enable fan
G1 Z9.050 F7800.000 ; move to next layer (53)
G1 E1.65843 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F900.000
G1 X99.471 Y100.529 E2.02853 ; small perimeter
G1 X99.471 Y99.471 E2.05706 ; small perimeter
G1 X100.529 Y99.471 E2.08558 ; small perimeter
G1 X100.529 Y100.454 E2.11209 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F900.000
G1 X98.836 Y101.164 E2.17491 ; small perimeter
G1 X98.836 Y98.836 E2.23773 ; small perimeter
G1 X101.164 Y98.836 E2.30056 ; small perimeter
G1 X101.164 Y101.089 E2.36135 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F900.000
G1 X98.275 Y101.725 E2.43246 ; external small perimeter
G1 X98.275 Y98.275 E2.50357 ; external small perimeter
G1 X101.725 Y98.275 E2.57467 ; external small perimeter
G1 X101.725 Y101.650 E2.64423 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z9.175 F7800.000 ; move to next layer (54)
G1 X103.060 Y103.020 F7800.000 ; move to first support material interface point
G1 F3600.000
G1 X103.965 Y103.020 E2.66679 ; support material interface
G1 X103.965 Y102.547 E2.67856 ; support material interface
G1 X103.060 Y102.547 E2.70112 ; support material interface
G1 X103.060 Y102.075 E2.71290 ; support material interface
G1 X103.965 Y102.075 E2.73546 ; support material interface
G1 X103.965 Y101.602 E2.74723 ; support material interface
G1 X103.060 Y101.602 E2.76979 ; support material interface
G1 X103.060 Y101.129 E2.78156 ; support material interface
G1 X103.965 Y101.129 E2.80412 ; support material interface
G1 X103.965 Y100.657 E2.81590 ; support material interface
G1 X103.060 Y100.657 E2.83846 ; support material interface
G1 X103.060 Y100.184 E2.85023 ; support material interface
G1 X103.965 Y100.184 E2.87279 ; support material interface
G1 X103.965 Y99.711 E2.88456 ; support material interface
G1 X103.060 Y99.711 E2.90712 ; support material interface
G1 X103.060 Y99.239 E2.91889 ; support material interface
G1 X103.965 Y99.239 E2.94145 ; support material interface
G1 X103.965 Y98.766 E2.95323 ; support material interface
G1 X103.060 Y98.766 E2.97579 ; support material interface
G1 X103.060 Y98.293 E2.98756 ; support material interface
G1 X103.965 Y98.293 E3.01012 ; support material interface
G1 X103.965 Y97.821 E3.02189 ; support material interface
G1 X103.060 Y97.821 E3.04445 ; support material interface
G1 X103.060 Y97.348 E3.05623 ; support material interface
G1 X103.965 Y97.348 E3.07879 ; support material interface
G1 X103.965 Y96.875 E3.09056 ; support material interface
G1 X94.985 Y96.875 E3.31426 ; support material interface
G1 X94.985 Y96.403 E3.32603 ; support material interface
G1 X103.965 Y96.403 E3.54973 ; support material interface
G1 X103.965 Y95.930 E3.56151 ; support material interface
G1 X94.985 Y95.930 E3.78521 ; support material interface
G1 X94.985 Y95.457 E3.79698 ; support material interface
G1 X103.965 Y95.457 E4.02068 ; support material interface
G1 X103.965 Y94.985 E4.03245 ; support material interface
G1 X94.985 Y94.985 E4.25615 ; support material interface
G1 X103.965 Y94.985 E4.47985 ; support material interface
G1 X105.260 Y93.690 F7800.000 ; move to first support material interface point
G1 F3600.000
G1 X111.265 Y93.690 E4.62945 ; support material interface
G1 X111.265 Y93.195 E4.64179 ; support material interface
G1 X105.260 Y93.195 E4.79139 ; support material interface
G1 X105.260 Y92.699 E4.80373 ; support material interface
G1 X111.265 Y92.699 E4.95333 ; support material interface
G1 X111.265 Y92.204 E4.96567 ; support material interface
G1 X105.260 Y92.204 E5.11527 ; support material interface
G1 X105.260 Y91.708 E5.12761 ; support material interface
G1 X111.265 Y91.708 E5.27721 ; support material interface
G1 X111.265 Y91.213 E5.28955 ; support material interface
G1 X105.260 Y91.213 E5.43914 ; support material interface
G1 X105.260 Y90.717 E5.45149 ; support material interface
G1 X111.265 Y90.717 E5.60108 ; support material interface
G1 X111.265 Y90.221 E5.61343 ; support material interface
G1 X105.260 Y90.221 E5.76302 ; support material interface
G1 X105.260 Y89.726 E5.77537 ; support material interface
G1 X111.265 Y89.726 E5.92496 ; support material interface
G1 X111.265 Y89.230 E5.93731 ; support material interface
G1 X105.260 Y89.230 E6.08690 ; support material interface
G1 X105.260 Y88.735 E6.09925 ; support material interface
G1 X111.265 Y88.735 E6.24884 ; support material interface
G1 E4.24884 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X111.265 Y95.260 F7800.000 ; move to first support material interface point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X105.260 Y95.260 E2.14960 ; support material interface
G1 X111.265 Y95.260 E2.29919 ; support material interface
G1 X111.265 Y95.756 E2.31154 ; support material interface
G1 X105.260 Y95.756 E2.46114 ; support material interface
G1 X105.260 Y96.252 E2.47349 ; support material interface
G1 X111.265 Y96.252 E2.62309 ; support material interface
G1 X111.265 Y96.747 E2.63544 ; support material interface
G1 X105.260 Y96.747 E2.78504 ; support material interface
G1 X105.260 Y97.243 E2.79739 ; support material interface
G1 X111.265 Y97.243 E2.94698 ; support material interface
G1 X111.265 Y97.739 E2.95934 ; support material interface
G1 X105.260 Y97.739 E3.10893 ; support material interface
G1 X105.260 Y98.235 E3.12129 ; support material interface
G1 X111.265 Y98.235 E3.27088 ; support material interface
G1 X111.265 Y98.731 E3.28323 ; support material interface
G1 X105.260 Y98.731 E3.43283 ; support material interface
G1 X105.260 Y99.227 E3.44518 ; support material interface
G1 X111.265 Y99.227 E3.59478 ; support material interface
G1 X111.265 Y99.723 E3.60713 ; support material interface
G1 X105.260 Y99.723 E3.75673 ; support material interface
G1 X105.260 Y100.219 E3.76908 ; support material interface
G1 X111.265 Y100.219 E3.91867 ; support material interface
G1 X111.265 Y100.715 E3.93103 ; support material interface
G1 X105.260 Y100.715 E4.08062 ; support material interface
G1 X105.260 Y101.211 E4.09297 ; support material interface
G1 X111.265 Y101.211 E4.24257 ; support material interface
G1 X111.265 Y101.707 E4.25492 ; support material interface
G1 X105.260 Y101.707 E4.40452 ; support material interface
G1 X105.260 Y102.203 E4.41687 ; support material interface
G1 X111.265 Y102.203 E4.56647 ; support material interface
G1 X111.265 Y102.698 E4.57882 ; support material interface
G1 X105.260 Y102.698 E4.72842 ; support material interface
G1 X105.260 Y103.194 E4.74077 ; support material interface
G1 X111.265 Y103.194 E4.89036 ; support material interface
G1 X111.265 Y103.690 E4.90272 ; support material interface
G1 X105.260 Y103.690 E5.05231 ; support material interface
G1 E3.05231 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.690 Y105.260 F7800.000 ; move to first support material interface point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X95.260 Y105.260 E2.21000 ; support material interface
G1 X95.260 Y105.760 E2.22247 ; support material interface
G1 X103.690 Y105.760 E2.43247 ; support material interface
G1 X103.690 Y106.261 E2.44493 ; support material interface
G1 X95.260 Y106.261 E2.65493 ; support material interface
G1 X95.260 Y106.761 E2.66740 ; support material interface
G1 X103.690 Y106.761 E2.87740 ; support material interface
G1 X103.690 Y107.262 E2.88986 ; support material interface
G1 X95.260 Y107.262 E3.09986 ; support material interface
G1 X95.260 Y107.762 E3.11233 ; support material interface
G1 X103.690 Y107.762 E3.32233 ; support material interface
G1 X103.690 Y108.263 E3.33480 ; support material interface
G1 X95.260 Y108.263 E3.54480 ; support material interface
G1 X95.260 Y108.763 E3.55726 ; support material interface
G1 X103.690 Y108.763 E3.76726 ; support material interface
G1 X103.690 Y109.263 E3.77973 ; support material interface
G1 X95.260 Y109.263 E3.98973 ; support material interface
G1 X95.260 Y109.764 E4.00219 ; support material interface
G1 X103.690 Y109.764 E4.21219 ; support material interface
G1 X103.690 Y110.264 E4.22466 ; support material interface
G1 X95.260 Y110.264 E4.43466 ; support material interface
G1 X95.260 Y110.765 E4.44713 ; support material interface
G1 X103.690 Y110.765 E4.65713 ; support material interface
G1 X103.690 Y111.265 E4.66959 ; support material interface
G1 X95.260 Y111.265 E4.87959 ; support material interface
G1 E2.87959 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X93.690 Y105.260 F7800.000 ; move to first support material interface point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X88.735 Y105.260 E2.12344 ; support material interface
G1 X88.735 Y105.760 E2.13591 ; support material interface
G1 X93.690 Y105.760 E2.25935 ; support material interface
G1 X93.690 Y106.261 E2.27181 ; support material interface
G1 X88.735 Y106.261 E2.39526 ; support material interface
G1 X88.735 Y106.761 E2.40772 ; support material interface
G1 X93.690 Y106.761 E2.53116 ; support material interface
G1 X93.690 Y107.262 E2.54363 ; support material interface
G1 X88.735 Y107.262 E2.66707 ; support material interface
G1 X88.735 Y107.762 E2.67954 ; support material interface
G1 X93.690 Y107.762 E2.80298 ; support material interface
G1 X93.690 Y108.263 E2.81544 ; support material interface
G1 X88.735 Y108.263 E2.93888 ; support material interface
G1 X88.735 Y108.763 E2.95135 ; support material interface
G1 X93.690 Y108.763 E3.07479 ; support material interface
G1 X93.690 Y109.263 E3.08726 ; support material interface
G1 X88.735 Y109.263 E3.21070 ; support material interface
G1 X88.735 Y109.764 E3.22316 ; support material interface
G1 X93.690 Y109.764 E3.34660 ; support material interface
G1 X93.690 Y110.264 E3.35907 ; support material interface
G1 X88.735 Y110.264 E3.48251 ; support material interface
G1 X88.735 Y110.765 E3.49498 ; support material interface
G1 X93.690 Y110.765 E3.61842 ; support material interface
G1 X93.690 Y111.265 E3.63088 ; support material interface
G1 X88.735 Y111.265 E3.75433 ; support material interface
G1 E1.75433 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X88.735 Y103.690 F7800.000 ; move to first support material interface point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X93.690 Y103.690 E2.12344 ; support material interface
G1 X93.690 Y103.194 E2.13579 ; support material interface
G1 X88.735 Y103.194 E2.25923 ; support material interface
G1 X88.735 Y102.698 E2.27159 ; support material interface
G1 X93.690 Y102.698 E2.39503 ; support material interface
G1 X93.690 Y102.203 E2.40738 ; support material interface
G1 X88.735 Y102.203 E2.53082 ; support material interface
G1 X88.735 Y101.707 E2.54318 ; support material interface
G1 X93.690 Y101.707 E2.66662 ; support material interface
G1 X93.690 Y101.211 E2.67897 ; support material interface
G1 X88.735 Y101.211 E2.80241 ; support material interface
G1 X88.735 Y100.715 E2.81476 ; support material interface
G1 X93.690 Y100.715 E2.93820 ; support material interface
G1 X93.690 Y100.219 E2.95056 ; support material interface
G1 X88.735 Y100.219 E3.07400 ; support material interface
G1 X88.735 Y99.723 E3.08635 ; support material interface
G1 X93.690 Y99.723 E3.20979 ; support material interface
G1 X93.690 Y99.227 E3.22214 ; support material interface
G1 X88.735 Y99.227 E3.34559 ; support material interface
G1 X88.735 Y98.731 E3.35794 ; support material interface
G1 X93.690 Y98.731 E3.48138 ; support material interface
G1 X93.690 Y98.235 E3.49373 ; support material interface
G1 X88.735 Y98.235 E3.61717 ; support material interface
G1 X88.735 Y97.739 E3.62953 ; support material interface
G1 X93.690 Y97.739 E3.75297 ; support material interface
G1 X93.690 Y97.243 E3.76532 ; support material interface
G1 X88.735 Y97.243 E3.88876 ; support material interface
G1 X88.735 Y96.747 E3.90111 ; support material interface
G1 X93.690 Y96.747 E4.02455 ; support material interface
G1 X93.690 Y96.252 E4.03691 ; support material interface
G1 X88.735 Y96.252 E4.16035 ; support material interface
G1 X88.735 Y95.756 E4.17270 ; support material interface
G1 X93.690 Y95.756 E4.29614 ; support material interface
G1 X93.690 Y95.260 E4.30849 ; support material interface
G1 X88.735 Y95.260 E4.43194 ; support material interface
G1 X93.690 Y95.260 E4.55538 ; support material interface
G1 E2.55538 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.260 Y93.690 F7800.000 ; move to first support material interface point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X103.690 Y93.690 E2.21000 ; support material interface
G1 X103.690 Y93.195 E2.22234 ; support material interface
G1 X95.260 Y93.195 E2.43234 ; support material interface
G1 X95.260 Y92.699 E2.44469 ; support material interface
G1 X103.690 Y92.699 E2.65469 ; support material interface
G1 X103.690 Y92.204 E2.66703 ; support material interface
G1 X95.260 Y92.204 E2.87703 ; support material interface
G1 X95.260 Y91.708 E2.88937 ; support material interface
G1 X103.690 Y91.708 E3.09937 ; support material interface
G1 X103.690 Y91.213 E3.11172 ; support material interface
G1 X95.260 Y91.213 E3.32172 ; support material interface
G1 X95.260 Y90.717 E3.33406 ; support material interface
G1 X103.690 Y90.717 E3.54406 ; support material interface
G1 X103.690 Y90.221 E3.55641 ; support material interface
G1 X95.260 Y90.221 E3.76641 ; support material interface
G1 X95.260 Y89.726 E3.77875 ; support material interface
G1 X103.690 Y89.726 E3.98875 ; support material interface
G1 X103.690 Y89.230 E4.00109 ; support material interface
G1 X95.260 Y89.230 E4.21109 ; support material interface
G1 X95.260 Y88.735 E4.22344 ; support material interface
G1 X103.690 Y88.735 E4.43344 ; support material interface
G1 E2.43344 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X93.690 Y88.735 F7800.000 ; move to first support material interface point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X88.735 Y88.735 E2.12344 ; support material interface
G1 X88.735 Y89.230 E2.13578 ; support material interface
G1 X93.690 Y89.230 E2.25923 ; support material interface
G1 X93.690 Y89.726 E2.27157 ; support material interface
G1 X88.735 Y89.726 E2.39501 ; support material interface
G1 X88.735 Y90.221 E2.40735 ; support material interface
G1 X93.690 Y90.221 E2.53080 ; support material interface
G1 X93.690 Y90.717 E2.54314 ; support material interface
G1 X88.735 Y90.717 E2.66658 ; support material interface
G1 X88.735 Y91.213 E2.67892 ; support material interface
G1 X93.690 Y91.213 E2.80236 ; support material interface
G1 X93.690 Y91.708 E2.81471 ; support material interface
G1 X88.735 Y91.708 E2.93815 ; support material interface
G1 X88.735 Y92.204 E2.95049 ; support material interface
G1 X93.690 Y92.204 E3.07393 ; support material interface
G1 X93.690 Y92.699 E3.08628 ; support material interface
G1 X88.735 Y92.699 E3.20972 ; support material interface
G1 X88.735 Y93.195 E3.22206 ; support material interface
G1 X93.690 Y93.195 E3.34550 ; support material interface
G1 X93.690 Y93.690 E3.35785 ; support material interface
G1 X88.735 Y93.690 E3.48129 ; support material interface
G1 E1.48129 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X96.940 Y97.348 F7800.000 ; move to first support material interface point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.985 Y97.348 E2.04871 ; support material interface
G1 X94.985 Y97.821 E2.06049 ; support material interface
G1 X96.940 Y97.821 E2.10920 ; support material interface
G1 X96.940 Y98.293 E2.12097 ; support material interface
G1 X94.985 Y98.293 E2.16969 ; support material interface
G1 X94.985 Y98.766 E2.18146 ; support material interface
G1 X96.940 Y98.766 E2.23018 ; support material interface
G1 X96.940 Y99.239 E2.24195 ; support material interface
G1 X94.985 Y99.239 E2.29066 ; support material interface
G1 X94.985 Y99.711 E2.30244 ; support material interface
G1 X96.940 Y99.711 E2.35115 ; support material interface
G1 X96.940 Y100.184 E2.36292 ; support material interface
G1 X94.985 Y100.184 E2.41164 ; support material interface
G1 X94.985 Y100.657 E2.42341 ; support material interface
G1 X96.940 Y100.657 E2.47213 ; support material interface
G1 X96.940 Y101.129 E2.48390 ; support material interface
G1 X94.985 Y101.129 E2.53261 ; support material interface
G1 X94.985 Y101.602 E2.54439 ; support material interface
G1 X96.940 Y101.602 E2.59310 ; support material interface
G1 X96.940 Y102.075 E2.60487 ; support material interface
G1 X94.985 Y102.075 E2.65359 ; support material interface
G1 X94.985 Y102.547 E2.66536 ; support material interface
G1 X96.940 Y102.547 E2.71408 ; support material interface
G1 X96.940 Y103.020 E2.72585 ; support material interface
G1 X94.985 Y103.020 E2.77456 ; support material interface
G1 X94.985 Y103.493 E2.78634 ; support material interface
G1 X103.965 Y103.493 E3.01004 ; support material interface
G1 X103.965 Y103.965 E3.02181 ; support material interface
G1 X94.985 Y103.965 E3.24551 ; support material interface
G1 E1.24551 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X105.260 Y111.265 F7800.000 ; move to first support material interface point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X111.265 Y111.265 E2.14960 ; support material interface
G1 X111.265 Y110.765 E2.16206 ; support material interface
G1 X105.260 Y110.765 E2.31166 ; support material interface
G1 X105.260 Y110.264 E2.32412 ; support material interface
G1 X111.265 Y110.264 E2.47372 ; support material interface
G1 X111.265 Y109.764 E2.48618 ; support material interface
G1 X105.260 Y109.764 E2.63578 ; support material interface
G1 X105.260 Y109.263 E2.64825 ; support material interface
G1 X111.265 Y109.263 E2.79784 ; support material interface
G1 X111.265 Y108.763 E2.81031 ; support material interface
G1 X105.260 Y108.763 E2.95990 ; support material interface
G1 X105.260 Y108.263 E2.97237 ; support material interface
G1 X111.265 Y108.263 E3.12196 ; support material interface
G1 X111.265 Y107.762 E3.13443 ; support material interface
G1 X105.260 Y107.762 E3.28403 ; support material interface
G1 X105.260 Y107.262 E3.29649 ; support material interface
G1 X111.265 Y107.262 E3.44609 ; support material interface
G1 X111.265 Y106.761 E3.45855 ; support material interface
G1 X105.260 Y106.761 E3.60815 ; support material interface
G1 X105.260 Y106.261 E3.62062 ; support material interface
G1 X111.265 Y106.261 E3.77021 ; support material interface
G1 X111.265 Y105.760 E3.78268 ; support material interface
G1 X105.260 Y105.760 E3.93227 ; support material interface
G1 X105.260 Y105.260 E3.94474 ; support material interface
G1 X111.265 Y105.260 E4.09433 ; support material interface
M106 S209.1 ; enable fan
G1 Z9.350 F7800.000 ; move to next layer (55)
G1 E2.09433 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F900.000
G1 X99.471 Y100.529 E2.02853 ; small perimeter
G1 X99.471 Y99.471 E2.05706 ; small perimeter
G1 X100.529 Y99.471 E2.08558 ; small perimeter
G1 X100.529 Y100.454 E2.11209 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F900.000
G1 X98.836 Y101.164 E2.17491 ; small perimeter
G1 X98.836 Y98.836 E2.23773 ; small perimeter
G1 X101.164 Y98.836 E2.30056 ; small perimeter
G1 X101.164 Y101.089 E2.36135 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F900.000
G1 X98.275 Y101.725 E2.43246 ; external small perimeter
G1 X98.275 Y98.275 E2.50357 ; external small perimeter
G1 X101.725 Y98.275 E2.57467 ; external small perimeter
G1 X101.725 Y101.650 E2.64423 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z9.550 F7800.000 ; move to next layer (56)
G1 E0.64423 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.595 Y100.520 F7800.000 ; move to first support material interface point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X103.595 Y100.230 E2.00720 ; support material interface
G1 X103.692 Y100.134 E2.01061 ; support material interface
G1 X103.692 Y98.141 E2.06024 ; support material interface
G1 X103.595 Y98.045 E2.06365 ; support material interface
G1 X103.595 Y88.735 E2.29555 ; support material interface
G1 X103.116 Y88.735 E2.30749 ; support material interface
G1 X103.116 Y97.125 E2.51648 ; support material interface
G1 X102.637 Y96.308 E2.54008 ; support material interface
G1 X102.637 Y88.735 E2.72872 ; support material interface
G1 X102.157 Y88.735 E2.74066 ; support material interface
G1 X102.157 Y96.308 E2.92930 ; support material interface
G1 X101.678 Y96.308 E2.94124 ; support material interface
G1 X101.678 Y88.735 E3.12988 ; support material interface
G1 X101.198 Y88.735 E3.14182 ; support material interface
G1 X101.198 Y96.308 E3.33046 ; support material interface
G1 X101.044 Y96.308 E3.33431 ; support material interface
G1 X100.719 Y96.495 E3.34365 ; support material interface
G1 X100.719 Y88.735 E3.53696 ; support material interface
G1 X100.240 Y88.735 E3.54891 ; support material interface
G1 X100.240 Y96.443 E3.74091 ; support material interface
G1 X100.006 Y96.308 E3.74763 ; support material interface
G1 X99.760 Y96.308 E3.75375 ; support material interface
G1 X99.760 Y88.735 E3.94239 ; support material interface
G1 X99.281 Y88.735 E3.95433 ; support material interface
G1 X99.281 Y96.308 E4.14297 ; support material interface
G1 X98.802 Y96.308 E4.15491 ; support material interface
G1 X98.802 Y88.735 E4.34355 ; support material interface
G1 X98.322 Y88.735 E4.35549 ; support material interface
G1 X98.322 Y96.860 E4.55788 ; support material interface
G1 X98.003 Y96.676 E4.56706 ; support material interface
G1 X97.843 Y96.953 E4.57505 ; support material interface
G1 X97.843 Y88.735 E4.77977 ; support material interface
G1 X97.363 Y88.735 E4.79171 ; support material interface
G1 X97.363 Y97.022 E4.99815 ; support material interface
G1 X96.977 Y97.022 E5.00777 ; support material interface
G1 X96.884 Y97.115 E5.01104 ; support material interface
G1 X96.884 Y88.735 E5.21979 ; support material interface
G1 X96.405 Y88.735 E5.23173 ; support material interface
G1 X96.405 Y97.594 E5.45242 ; support material interface
G1 X96.308 Y97.691 E5.45584 ; support material interface
G1 X96.308 Y99.684 E5.50546 ; support material interface
G1 X96.405 Y99.781 E5.50887 ; support material interface
G1 X96.405 Y100.069 E5.51607 ; support material interface
G1 X96.308 Y100.166 E5.51948 ; support material interface
G1 X96.308 Y102.159 E5.56911 ; support material interface
G1 X96.405 Y102.256 E5.57252 ; support material interface
G1 E3.57252 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X98.875 Y97.450 F7800.000 ; move to first support material interface point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X98.463 Y98.164 E2.02055 ; support material interface
G1 X97.450 Y98.164 E2.04577 ; support material interface
G1 X97.450 Y99.211 E2.07183 ; support material interface
G1 X97.862 Y99.211 E2.08210 ; support material interface
G1 X98.275 Y99.925 E2.10265 ; support material interface
G1 X97.862 Y100.639 E2.12320 ; support material interface
G1 X97.450 Y100.639 E2.13348 ; support material interface
G1 X97.450 Y101.686 E2.15953 ; support material interface
G1 X97.862 Y101.686 E2.16981 ; support material interface
G1 X98.275 Y102.400 E2.19036 ; support material interface
G1 X98.188 Y102.550 E2.19467 ; support material interface
G1 X98.950 Y102.550 E2.21364 ; support material interface
G1 X99.362 Y101.836 E2.23419 ; support material interface
G1 X100.188 Y101.836 E2.25474 ; support material interface
G1 X100.600 Y102.550 E2.27529 ; support material interface
G1 X101.425 Y102.550 E2.29584 ; support material interface
G1 X101.838 Y101.836 E2.31639 ; support material interface
G1 X102.550 Y101.836 E2.33414 ; support material interface
G1 X102.550 Y101.089 E2.35272 ; support material interface
G1 X102.138 Y101.089 E2.36300 ; support material interface
G1 X101.725 Y100.375 E2.38355 ; support material interface
G1 X102.138 Y99.661 E2.40410 ; support material interface
G1 X102.550 Y99.661 E2.41437 ; support material interface
G1 X102.550 Y98.614 E2.44043 ; support material interface
G1 X102.138 Y98.614 E2.45071 ; support material interface
G1 X101.725 Y97.900 E2.47126 ; support material interface
G1 X101.985 Y97.450 E2.48420 ; support material interface
G1 X101.350 Y97.450 E2.50001 ; support material interface
G1 X100.938 Y98.164 E2.52056 ; support material interface
G1 X100.112 Y98.164 E2.54111 ; support material interface
G1 X99.700 Y97.450 E2.56166 ; support material interface
G1 X98.875 Y97.450 E2.58221 ; support material interface
G1 E0.58221 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X88.735 Y88.735 F7800.000 ; move to first support material interface point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X88.735 Y111.265 E2.56122 ; support material interface
G1 X88.735 Y88.735 E3.12243 ; support material interface
G1 X89.214 Y88.735 E3.13438 ; support material interface
G1 X89.214 Y111.265 E3.69559 ; support material interface
G1 X89.694 Y111.265 E3.70753 ; support material interface
G1 X89.694 Y88.735 E4.26875 ; support material interface
G1 X90.173 Y88.735 E4.28069 ; support material interface
G1 X90.173 Y111.265 E4.84191 ; support material interface
G1 X90.652 Y111.265 E4.85385 ; support material interface
G1 X90.652 Y88.735 E5.41507 ; support material interface
G1 X91.132 Y88.735 E5.42701 ; support material interface
G1 X91.132 Y111.265 E5.98823 ; support material interface
G1 X91.611 Y111.265 E6.00017 ; support material interface
G1 X91.611 Y88.735 E6.56138 ; support material interface
G1 X92.090 Y88.735 E6.57332 ; support material interface
G1 X92.090 Y111.265 E7.13454 ; support material interface
G1 X92.570 Y111.265 E7.14648 ; support material interface
G1 X92.570 Y88.735 E7.70770 ; support material interface
G1 X93.049 Y88.735 E7.71964 ; support material interface
G1 X93.049 Y111.265 E8.28086 ; support material interface
G1 X93.529 Y111.265 E8.29280 ; support material interface
G1 X93.529 Y88.735 E8.85402 ; support material interface
G1 X94.008 Y88.735 E8.86596 ; support material interface
G1 X94.008 Y111.265 E9.42717 ; support material interface
G1 X94.487 Y111.265 E9.43912 ; support material interface
G1 X94.487 Y88.735 E10.00033 ; support material interface
G1 X94.967 Y88.735 E10.01227 ; support material interface
G1 X94.967 Y111.265 E10.57349 ; support material interface
G1 X95.446 Y111.265 E10.58543 ; support material interface
G1 X95.446 Y88.735 E11.14665 ; support material interface
G1 X95.925 Y88.735 E11.15859 ; support material interface
G1 X95.925 Y111.265 E11.71981 ; support material interface
G1 X96.405 Y111.265 E11.73175 ; support material interface
G1 X96.405 Y102.256 E11.95617 ; support material interface
G1 X96.884 Y102.735 E11.97306 ; support material interface
G1 X96.884 Y111.265 E12.18555 ; support material interface
G1 X97.363 Y111.265 E12.19749 ; support material interface
G1 X97.363 Y103.406 E12.39327 ; support material interface
G1 X97.529 Y103.692 E12.40151 ; support material interface
G1 X97.843 Y103.692 E12.40933 ; support material interface
G1 X97.843 Y111.265 E12.59797 ; support material interface
G1 X98.322 Y111.265 E12.60991 ; support material interface
G1 X98.322 Y103.692 E12.79855 ; support material interface
G1 X98.802 Y103.692 E12.81049 ; support material interface
G1 X98.802 Y111.265 E12.99913 ; support material interface
G1 X99.281 Y111.265 E13.01107 ; support material interface
G1 X99.281 Y103.678 E13.20007 ; support material interface
G1 X99.760 Y103.401 E13.21386 ; support material interface
G1 X99.760 Y111.265 E13.40975 ; support material interface
G1 X100.240 Y111.265 E13.42169 ; support material interface
G1 X100.240 Y103.661 E13.61111 ; support material interface
G1 X100.294 Y103.692 E13.61267 ; support material interface
G1 X100.719 Y103.692 E13.62326 ; support material interface
G1 X100.719 Y111.265 E13.81190 ; support material interface
G1 X101.198 Y111.265 E13.82384 ; support material interface
G1 X101.198 Y103.692 E14.01249 ; support material interface
G1 X101.678 Y103.692 E14.02443 ; support material interface
G1 X101.678 Y111.265 E14.21307 ; support material interface
G1 X102.157 Y111.265 E14.22501 ; support material interface
G1 X102.157 Y103.446 E14.41978 ; support material interface
G1 X102.261 Y103.386 E14.42277 ; support material interface
G1 X102.497 Y102.978 E14.43451 ; support material interface
G1 X102.637 Y102.978 E14.43799 ; support material interface
G1 X102.637 Y111.265 E14.64443 ; support material interface
G1 X103.116 Y111.265 E14.65637 ; support material interface
G1 X103.116 Y102.885 E14.86512 ; support material interface
G1 X103.595 Y102.405 E14.88201 ; support material interface
G1 X103.595 Y111.265 E15.10270 ; support material interface
G1 X104.075 Y111.265 E15.11464 ; support material interface
G1 X104.075 Y88.735 E15.67585 ; support material interface
G1 X104.554 Y88.735 E15.68779 ; support material interface
G1 X104.554 Y111.265 E16.24901 ; support material interface
G1 X105.033 Y111.265 E16.26095 ; support material interface
G1 X105.033 Y88.735 E16.82217 ; support material interface
G1 X105.513 Y88.735 E16.83411 ; support material interface
G1 X105.513 Y111.265 E17.39533 ; support material interface
G1 X105.992 Y111.265 E17.40727 ; support material interface
G1 X105.992 Y88.735 E17.96849 ; support material interface
G1 X106.472 Y88.735 E17.98043 ; support material interface
G1 X106.472 Y111.265 E18.54164 ; support material interface
G1 X106.951 Y111.265 E18.55359 ; support material interface
G1 X106.951 Y88.735 E19.11480 ; support material interface
G1 X107.430 Y88.735 E19.12674 ; support material interface
G1 X107.430 Y111.265 E19.68796 ; support material interface
G1 X107.910 Y111.265 E19.69990 ; support material interface
G1 X107.910 Y88.735 E20.26112 ; support material interface
G1 X108.389 Y88.735 E20.27306 ; support material interface
G1 X108.389 Y111.265 E20.83428 ; support material interface
G1 X108.868 Y111.265 E20.84622 ; support material interface
G1 X108.868 Y88.735 E21.40744 ; support material interface
G1 X109.348 Y88.735 E21.41938 ; support material interface
G1 X109.348 Y111.265 E21.98059 ; support material interface
G1 X109.827 Y111.265 E21.99253 ; support material interface
G1 X109.827 Y88.735 E22.55375 ; support material interface
G1 X110.306 Y88.735 E22.56569 ; support material interface
G1 X110.306 Y111.265 E23.12691 ; support material interface
G1 X110.786 Y111.265 E23.13885 ; support material interface
G1 X110.786 Y88.735 E23.70007 ; support material interface
G1 X111.265 Y88.735 E23.71201 ; support material interface
G1 X111.265 Y111.265 E24.27323 ; support material interface
M106 S255 ; enable fan
G1 Z9.650 F7800.000 ; move to next layer (57)
G1 E22.27323 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F600.000
G1 X99.471 Y100.529 E2.02853 ; small perimeter
G1 X99.471 Y99.471 E2.05706 ; small perimeter
G1 X100.529 Y99.471 E2.08558 ; small perimeter
G1 X100.529 Y100.454 E2.11209 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X98.836 Y101.164 E2.17491 ; small perimeter
G1 X98.836 Y98.836 E2.23773 ; small perimeter
G1 X101.164 Y98.836 E2.30056 ; small perimeter
G1 X101.164 Y101.089 E2.36135 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F600.000
G1 X98.275 Y101.725 E2.43246 ; external small perimeter
G1 X98.275 Y98.275 E2.50357 ; external small perimeter
G1 X101.725 Y98.275 E2.57467 ; external small perimeter
G1 X101.725 Y101.650 E2.64423 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z9.950 F7800.000 ; move to next layer (58)
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X99.471 Y100.529 E2.67276 ; small perimeter
G1 X99.471 Y99.471 E2.70129 ; small perimeter
G1 X100.529 Y99.471 E2.72982 ; small perimeter
G1 X100.529 Y100.454 E2.75632 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X98.836 Y101.164 E2.81914 ; small perimeter
G1 X98.836 Y98.836 E2.88197 ; small perimeter
G1 X101.164 Y98.836 E2.94479 ; small perimeter
G1 X101.164 Y101.089 E3.00559 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F600.000
G1 X98.275 Y101.725 E3.07669 ; external small perimeter
G1 X98.275 Y98.275 E3.14780 ; external small perimeter
G1 X101.725 Y98.275 E3.21890 ; external small perimeter
G1 X101.725 Y101.650 E3.28846 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
M106 S232.05 ; enable fan
G1 Z10.250 F7800.000 ; move to next layer (59)
G1 E1.28846 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X108.529 Y108.529 F7800.000 ; move to first perimeter (bridge) point
G1 E2.00000 F2400.00000 ; unretract extruder 0
M106 S255 ; enable fan

G1 F3600.000
G1 X91.471 Y108.529 E2.47382 ; perimeter (bridge)
G1 X91.471 Y91.471 E2.94764 ; perimeter (bridge)
G1 X108.529 Y91.471 E3.42146 ; perimeter (bridge)
G1 X108.529 Y108.454 E3.89320 ; perimeter (bridge)
M106 S232.05 ; enable fan

G1 X109.164 Y109.164 F7800.000 ; move to first perimeter (bridge) point
M106 S255 ; enable fan

G1 F3600.000
G1 X90.836 Y109.164 E4.40233 ; perimeter (bridge)
G1 X90.836 Y90.836 E4.91146 ; perimeter (bridge)
G1 X109.164 Y90.836 E5.42059 ; perimeter (bridge)
G1 X109.164 Y109.089 E5.92764 ; perimeter (bridge)
M106 S232.05 ; enable fan

G1 X109.725 Y109.725 F7800.000 ; move to first perimeter (bridge) point
M106 S255 ; enable fan

G1 F3600.000
G1 X90.275 Y109.725 E6.46792 ; perimeter (bridge)
G1 X90.275 Y90.275 E7.00820 ; perimeter (bridge)
G1 X109.725 Y90.275 E7.54848 ; perimeter (bridge)
G1 X109.725 Y109.650 E8.08667 ; perimeter (bridge)
M106 S232.05 ; enable fan

G1 E6.08667 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X108.167 Y92.295 F7800.000 ; move to first infill (bridge) point
G1 E2.00000 F2400.00000 ; unretract extruder 0
M106 S255 ; enable fan

G1 F3600.000
G1 X107.705 Y91.833 E2.01894 ; infill (bridge)
G1 X106.912 Y91.833 E2.04198 ; infill (bridge)
G1 X108.167 Y93.088 E2.09349 ; infill (bridge)
G1 X108.167 Y93.882 E2.11653 ; infill (bridge)
G1 X106.118 Y91.833 E2.20063 ; infill (bridge)
G1 X105.325 Y91.833 E2.22367 ; infill (bridge)
G1 X108.167 Y94.675 E2.34035 ; infill (bridge)
G1 X108.167 Y95.469 E2.36339 ; infill (bridge)
G1 X104.531 Y91.833 E2.51265 ; infill (bridge)
G1 X103.737 Y91.833 E2.53569 ; infill (bridge)
G1 X108.167 Y96.263 E2.71753 ; infill (bridge)
G1 X108.167 Y97.056 E2.74057 ; infill (bridge)
G1 X102.944 Y91.833 E2.95500 ; infill (bridge)
G1 X102.150 Y91.833 E2.97804 ; infill (bridge)
G1 X108.167 Y97.850 E3.22504 ; infill (bridge)
G1 X108.167 Y98.643 E3.24808 ; infill (bridge)
G1 X101.357 Y91.833 E3.52767 ; infill (bridge)
G1 X100.563 Y91.833 E3.55071 ; infill (bridge)
G1 X108.167 Y99.437 E3.86288 ; infill (bridge)
G1 X108.167 Y100.231 E3.88592 ; infill (bridge)
G1 X99.769 Y91.833 E4.23067 ; infill (bridge)
G1 X98.976 Y91.833 E4.25371 ; infill (bridge)
G1 X108.167 Y101.024 E4.63104 ; infill (bridge)
G1 X108.167 Y101.818 E4.65408 ; infill (bridge)
G1 X98.182 Y91.833 E5.06399 ; infill (bridge)
G1 X97.389 Y91.833 E5.08703 ; infill (bridge)
G1 X108.167 Y102.611 E5.52953 ; infill (bridge)
G1 X108.167 Y103.405 E5.55256 ; infill (bridge)
G1 X96.595 Y91.833 E6.02764 ; infill (bridge)
G1 X95.801 Y91.833 E6.05068 ; infill (bridge)
G1 X108.167 Y104.199 E6.55834 ; infill (bridge)
G1 X108.167 Y104.992 E6.58138 ; infill (bridge)
G1 X95.008 Y91.833 E7.12162 ; infill (bridge)
G1 X94.214 Y91.833 E7.14465 ; infill (bridge)
G1 X108.167 Y105.786 E7.71748 ; infill (bridge)
G1 X108.167 Y106.579 E7.74051 ; infill (bridge)
G1 X93.421 Y91.833 E8.34592 ; infill (bridge)
G1 X92.627 Y91.833 E8.36896 ; infill (bridge)
G1 X108.167 Y107.373 E9.00694 ; infill (bridge)
G1 X108.167 Y108.167 E9.02998 ; infill (bridge)
G1 X91.833 Y91.833 E9.70054 ; infill (bridge)
G1 X91.833 Y92.627 E9.72358 ; infill (bridge)
G1 X107.373 Y108.167 E10.36157 ; infill (bridge)
G1 X106.579 Y108.167 E10.38461 ; infill (bridge)
G1 X91.833 Y93.421 E10.99001 ; infill (bridge)
G1 X91.833 Y94.214 E11.01305 ; infill (bridge)
G1 X105.786 Y108.167 E11.58587 ; infill (bridge)
G1 X104.992 Y108.167 E11.60891 ; infill (bridge)
G1 X91.833 Y95.008 E12.14915 ; infill (bridge)
G1 X91.833 Y95.801 E12.17219 ; infill (bridge)
G1 X104.199 Y108.167 E12.67984 ; infill (bridge)
G1 X103.405 Y108.167 E12.70288 ; infill (bridge)
G1 X91.833 Y96.595 E13.17796 ; infill (bridge)
G1 X91.833 Y97.389 E13.20100 ; infill (bridge)
G1 X102.611 Y108.167 E13.64349 ; infill (bridge)
G1 X101.818 Y108.167 E13.66653 ; infill (bridge)
G1 X91.833 Y98.182 E14.07645 ; infill (bridge)
G1 X91.833 Y98.976 E14.09949 ; infill (bridge)
G1 X101.024 Y108.167 E14.47682 ; infill (bridge)
G1 X100.231 Y108.167 E14.49986 ; infill (bridge)
G1 X91.833 Y99.769 E14.84461 ; infill (bridge)
G1 X91.833 Y100.563 E14.86765 ; infill (bridge)
G1 X99.437 Y108.167 E15.17982 ; infill (bridge)
G1 X98.643 Y108.167 E15.20286 ; infill (bridge)
G1 X91.833 Y101.357 E15.48244 ; infill (bridge)
G1 X91.833 Y102.150 E15.50548 ; infill (bridge)
G1 X97.850 Y108.167 E15.75249 ; infill (bridge)
G1 X97.056 Y108.167 E15.77553 ; infill (bridge)
G1 X91.833 Y102.944 E15.98995 ; infill (bridge)
G1 X91.833 Y103.737 E16.01299 ; infill (bridge)
G1 X96.263 Y108.167 E16.19484 ; infill (bridge)
G1 X95.469 Y108.167 E16.21787 ; infill (bridge)
G1 X91.833 Y104.531 E16.36714 ; infill (bridge)
G1 X91.833 Y105.325 E16.39018 ; infill (bridge)
G1 X94.675 Y108.167 E16.50686 ; infill (bridge)
G1 X93.882 Y108.167 E16.52989 ; infill (bridge)
G1 X91.833 Y106.118 E16.61399 ; infill (bridge)
G1 X91.833 Y106.912 E16.63703 ; infill (bridge)
G1 X93.088 Y108.167 E16.68855 ; infill (bridge)
G1 X92.295 Y108.167 E16.71159 ; infill (bridge)
G1 X91.833 Y107.705 E16.73053 ; infill (bridge)
M106 S232.05 ; enable fan

M106 S186.15 ; enable fan
G1 Z10.550 F7800.000 ; move to next layer (60)
G1 X108.529 Y108.529 F7800.000 ; move to first perimeter point
G1 F3600.000
G1 X91.471 Y108.529 E17.19068 ; perimeter
G1 X91.471 Y91.471 E17.65083 ; perimeter
G1 X108.529 Y91.471 E18.11098 ; perimeter
G1 X108.529 Y108.454 E18.56911 ; perimeter
G1 X109.164 Y109.164 F7800.000 ; move to first perimeter point
G1 F3600.000
G1 X90.836 Y109.164 E19.06356 ; perimeter
G1 X90.836 Y90.836 E19.55801 ; perimeter
G1 X109.164 Y90.836 E20.05245 ; perimeter
G1 X109.164 Y109.089 E20.54488 ; perimeter
G1 X109.725 Y109.725 F7800.000 ; move to first external perimeter point
G1 F1800.000
G1 X90.275 Y109.725 E20.94575 ; external perimeter
G1 X90.275 Y90.275 E21.34662 ; external perimeter
G1 X109.725 Y90.275 E21.74749 ; external perimeter
G1 X109.725 Y109.650 E22.14681 ; external perimeter
G1 X109.242 Y109.596 F7800.000 ; move inwards before travel
G1 X107.646 Y108.140 F7800.000 ; move to first infill point
G1 F1200.000
G1 X108.140 Y107.646 E22.16575 ; infill
G1 X108.140 Y106.744 E22.19017 ; infill
G1 X106.744 Y108.140 E22.24364 ; infill
G1 X105.842 Y108.140 E22.26806 ; infill
G1 X108.140 Y105.842 E22.35606 ; infill
G1 X108.140 Y104.940 E22.38048 ; infill
G1 X104.940 Y108.140 E22.50302 ; infill
G1 X104.038 Y108.140 E22.52744 ; infill
G1 X108.140 Y104.038 E22.68452 ; infill
G1 X108.140 Y103.135 E22.70894 ; infill
G1 X103.135 Y108.140 E22.90055 ; infill
G1 X102.233 Y108.140 E22.92497 ; infill
G1 X108.140 Y102.233 E23.15112 ; infill
G1 X108.140 Y101.331 E23.17554 ; infill
G1 X101.331 Y108.140 E23.43622 ; infill
G1 X100.429 Y108.140 E23.46064 ; infill
G1 X108.140 Y100.429 E23.75586 ; infill
G1 X108.140 Y99.527 E23.78028 ; infill
G1 X99.527 Y108.140 E24.11003 ; infill
G1 X98.625 Y108.140 E24.13445 ; infill
G1 X108.140 Y98.625 E24.49874 ; infill
G1 X108.140 Y97.723 E24.52316 ; infill
G1 X97.723 Y108.140 E24.92199 ; infill
G1 X96.821 Y108.140 E24.94641 ; infill
G1 X108.140 Y96.821 E25.37977 ; infill
G1 X108.140 Y95.919 E25.40419 ; infill
G1 X95.919 Y108.140 E25.87208 ; infill
G1 X95.017 Y108.140 E25.89650 ; infill
G1 X108.140 Y95.017 E26.39893 ; infill
G1 X108.140 Y94.115 E26.42336 ; infill
G1 X94.115 Y108.140 E26.96032 ; infill
G1 X93.213 Y108.140 E26.98474 ; infill
G1 X108.140 Y93.213 E27.55625 ; infill
G1 X108.140 Y92.311 E27.58067 ; infill
G1 X92.311 Y108.140 E28.18670 ; infill
G1 X91.860 Y108.140 E28.19891 ; infill
G1 X91.860 Y107.689 E28.21112 ; infill
G1 X107.689 Y91.860 E28.81716 ; infill
G1 X106.787 Y91.860 E28.84158 ; infill
G1 X91.860 Y106.787 E29.41309 ; infill
G1 X91.860 Y105.885 E29.43751 ; infill
G1 X105.885 Y91.860 E29.97447 ; infill
G1 X104.983 Y91.860 E29.99889 ; infill
G1 X91.860 Y104.983 E30.50133 ; infill
G1 X91.860 Y104.081 E30.52575 ; infill
G1 X104.081 Y91.860 E30.99364 ; infill
G1 X103.179 Y91.860 E31.01806 ; infill
G1 X91.860 Y103.179 E31.45142 ; infill
G1 X91.860 Y102.277 E31.47584 ; infill
G1 X102.277 Y91.860 E31.87467 ; infill
G1 X101.375 Y91.860 E31.89909 ; infill
G1 X91.860 Y101.375 E32.26338 ; infill
G1 X91.860 Y100.473 E32.28780 ; infill
G1 X100.473 Y91.860 E32.61755 ; infill
G1 X99.571 Y91.860 E32.64197 ; infill
G1 X91.860 Y99.571 E32.93719 ; infill
G1 X91.860 Y98.669 E32.96161 ; infill
G1 X98.669 Y91.860 E33.22230 ; infill
G1 X97.767 Y91.860 E33.24672 ; infill
G1 X91.860 Y97.767 E33.47286 ; infill
G1 X91.860 Y96.865 E33.49728 ; infill
G1 X96.865 Y91.860 E33.68890 ; infill
G1 X95.962 Y91.860 E33.71332 ; infill
G1 X91.860 Y95.962 E33.87039 ; infill
G1 X91.860 Y95.060 E33.89481 ; infill
G1 X95.060 Y91.860 E34.01735 ; infill
G1 X94.158 Y91.860 E34.04177 ; infill
G1 X91.860 Y94.158 E34.12978 ; infill
G1 X91.860 Y93.256 E34.15420 ; infill
G1 X93.256 Y91.860 E34.20767 ; infill
G1 X92.354 Y91.860 E34.23209 ; infill
G1 X91.860 Y92.354 E34.25102 ; infill
G1 Z10.850 F7800.000 ; move to next layer (61)
G1 X108.529 Y108.529 F7800.000 ; move to first perimeter point
G1 F3600.000
G1 X91.471 Y108.529 E34.71117 ; perimeter
G1 X91.471 Y91.471 E35.17132 ; perimeter
G1 X108.529 Y91.471 E35.63147 ; perimeter
G1 X108.529 Y108.454 E36.08960 ; perimeter
G1 X109.164 Y109.164 F7800.000 ; move to first perimeter point
G1 F3600.000
G1 X90.836 Y109.164 E36.58405 ; perimeter
G1 X90.836 Y90.836 E37.07850 ; perimeter
G1 X109.164 Y90.836 E37.57294 ; perimeter
G1 X109.164 Y109.089 E38.06537 ; perimeter
G1 X109.725 Y109.725 F7800.000 ; move to first external perimeter point
G1 F1800.000
G1 X90.275 Y109.725 E38.46624 ; external perimeter
G1 X90.275 Y90.275 E38.86711 ; external perimeter
G1 X109.725 Y90.275 E39.26798 ; external perimeter
G1 X109.725 Y109.650 E39.66730 ; external perimeter
G1 X109.242 Y109.596 F7800.000 ; move inwards before travel
G1 X108.140 Y92.354 F7800.000 ; move to first infill point
G1 F1200.000
G1 X107.646 Y91.860 E39.68624 ; infill
G1 X106.744 Y91.860 E39.71066 ; infill
G1 X108.140 Y93.256 E39.76413 ; infill
G1 X108.140 Y94.158 E39.78855 ; infill
G1 X105.842 Y91.860 E39.87655 ; infill
G1 X104.940 Y91.860 E39.90097 ; infill
G1 X108.140 Y95.060 E40.02351 ; infill
G1 X108.140 Y95.962 E40.04793 ; infill
G1 X104.038 Y91.860 E40.20501 ; infill
G1 X103.135 Y91.860 E40.22943 ; infill
G1 X108.140 Y96.865 E40.42104 ; infill
G1 X108.140 Y97.767 E40.44546 ; infill
G1 X102.233 Y91.860 E40.67161 ; infill
G1 X101.331 Y91.860 E40.69603 ; infill
G1 X108.140 Y98.669 E40.95671 ; infill
G1 X108.140 Y99.571 E40.98113 ; infill
G1 X100.429 Y91.860 E41.27635 ; infill
G1 X99.527 Y91.860 E41.30077 ; infill
G1 X108.140 Y100.473 E41.63052 ; infill
G1 X108.140 Y101.375 E41.65494 ; infill
G1 X98.625 Y91.860 E42.01923 ; infill
G1 X97.723 Y91.860 E42.04365 ; infill
G1 X108.140 Y102.277 E42.44248 ; infill
G1 X108.140 Y103.179 E42.46690 ; infill
G1 X96.821 Y91.860 E42.90026 ; infill
G1 X95.919 Y91.860 E42.92468 ; infill
G1 X108.140 Y104.081 E43.39257 ; infill
G1 X108.140 Y104.983 E43.41699 ; infill
G1 X95.017 Y91.860 E43.91943 ; infill
G1 X94.115 Y91.860 E43.94385 ; infill
G1 X108.140 Y105.885 E44.48081 ; infill
G1 X108.140 Y106.787 E44.50523 ; infill
G1 X93.213 Y91.860 E45.07674 ; infill
G1 X92.311 Y91.860 E45.10116 ; infill
G1 X108.140 Y107.689 E45.70719 ; infill
G1 X108.140 Y108.140 E45.71940 ; infill
G1 X107.689 Y108.140 E45.73161 ; infill
G1 X91.860 Y92.311 E46.33765 ; infill
G1 X91.860 Y93.213 E46.36207 ; infill
G1 X106.787 Y108.140 E46.93358 ; infill
G1 X105.885 Y108.140 E46.95800 ; infill
G1 X91.860 Y94.115 E47.49496 ; infill
G1 X91.860 Y95.017 E47.51939 ; infill
G1 X104.983 Y108.140 E48.02182 ; infill
G1 X104.081 Y108.140 E48.04624 ; infill
G1 X91.860 Y95.919 E48.51413 ; infill
G1 X91.860 Y96.821 E48.53855 ; infill
G1 X103.179 Y108.140 E48.97192 ; infill
G1 X102.277 Y108.140 E48.99634 ; infill
G1 X91.860 Y97.723 E49.39516 ; infill
G1 X91.860 Y98.625 E49.41958 ; infill
G1 X101.375 Y108.140 E49.78387 ; infill
G1 X100.473 Y108.140 E49.80829 ; infill
G1 X91.860 Y99.527 E50.13805 ; infill
G1 X91.860 Y100.429 E50.16247 ; infill
G1 X99.571 Y108.140 E50.45768 ; infill
G1 X98.669 Y108.140 E50.48210 ; infill
G1 X91.860 Y101.331 E50.74279 ; infill
G1 X91.860 Y102.233 E50.76721 ; infill
G1 X97.767 Y108.140 E50.99336 ; infill
G1 X96.865 Y108.140 E51.01778 ; infill
G1 X91.860 Y103.135 E51.20939 ; infill
G1 X91.860 Y104.038 E51.23381 ; infill
G1 X95.962 Y108.140 E51.39088 ; infill
G1 X95.060 Y108.140 E51.41530 ; infill
G1 X91.860 Y104.940 E51.53784 ; infill
G1 X91.860 Y105.842 E51.56227 ; infill
G1 X94.158 Y108.140 E51.65027 ; infill
G1 X93.256 Y108.140 E51.67469 ; infill
G1 X91.860 Y106.744 E51.72816 ; infill
G1 X91.860 Y107.646 E51.75258 ; infill
G1 X92.354 Y108.140 E51.77151 ; infill
M106 S249.9 ; enable fan
G1 Z11.150 F7800.000 ; move to next layer (62)
G1 X108.529 Y108.529 F7800.000 ; move to first perimeter point
G1 F3600.000
G1 X91.471 Y108.529 E52.23166 ; perimeter
G1 X91.471 Y91.471 E52.69181 ; perimeter
G1 X108.529 Y91.471 E53.15197 ; perimeter
G1 X108.529 Y108.454 E53.61010 ; perimeter
G1 X109.164 Y109.164 F7800.000 ; move to first perimeter point
G1 F3600.000
G1 X90.836 Y109.164 E54.10454 ; perimeter
G1 X90.836 Y90.836 E54.59899 ; perimeter
G1 X109.164 Y90.836 E55.09343 ; perimeter
G1 X109.164 Y109.089 E55.58586 ; perimeter
G1 X109.725 Y109.725 F7800.000 ; move to first external perimeter point
G1 F1800.000
G1 X90.275 Y109.725 E55.98673 ; external perimeter
G1 X90.275 Y90.275 E56.38760 ; external perimeter
G1 X109.725 Y90.275 E56.78847 ; external perimeter
G1 X109.725 Y109.650 E57.18780 ; external perimeter
G1 X109.242 Y109.596 F7800.000 ; move inwards before travel
G1 X106.496 Y108.248 F7800.000 ; move to first infill point
G1 F4800.000
G1 X108.016 Y102.576 E57.32753 ; infill
G1 X108.248 Y102.143 F7800.000 ; move to first infill point
G1 F4800.000
G1 X91.752 Y106.563 E57.73389 ; infill
G1 X91.837 Y103.729 F7800.000 ; move to first infill point
G1 F4800.000
G1 X96.271 Y108.163 E57.88309 ; infill
G1 X108.163 Y108.163 E58.16606 ; infill
G1 X91.837 Y91.837 E58.71543 ; infill
G1 X103.729 Y91.837 E58.99839 ; infill
G1 X108.163 Y96.271 E59.14759 ; infill
G1 X108.248 Y93.437 F7800.000 ; move to first infill point
G1 F4800.000
G1 X91.752 Y97.857 E59.55396 ; infill
G1 X91.984 Y97.424 F7800.000 ; move to first infill point
G1 F4800.000
G1 X93.504 Y91.752 E59.69369 ; infill
G1 X102.210 Y91.752 F7800.000 ; move to first infill point
G1 F4800.000
G1 X97.790 Y108.248 E60.10006 ; infill
M106 S229.5 ; enable fan
G1 Z11.450 F7800.000 ; move to next layer (63)
G1 X108.529 Y108.529 F7800.000 ; move to first perimeter point
G1 F3600.000
G1 X91.471 Y108.529 E60.56021 ; perimeter
G1 X91.471 Y91.471 E61.02036 ; perimeter
G1 X108.529 Y91.471 E61.48051 ; perimeter
G1 X108.529 Y108.454 E61.93864 ; perimeter
G1 X109.164 Y109.164 F7800.000 ; move to first perimeter point
G1 F3600.000
G1 X90.836 Y109.164 E62.43309 ; perimeter
G1 X90.836 Y90.836 E62.92754 ; perimeter
G1 X109.164 Y90.836 E63.42198 ; perimeter
G1 X109.164 Y109.089 E63.91441 ; perimeter
G1 X109.725 Y109.725 F7800.000 ; move to first external perimeter point
G1 F1800.000
G1 X90.275 Y109.725 E64.31528 ; external perimeter
G1 X90.275 Y90.275 E64.71615 ; external perimeter
G1 X109.725 Y90.275 E65.11702 ; external perimeter
G1 X109.725 Y109.650 E65.51634 ; external perimeter
G1 X109.242 Y109.596 F7800.000 ; move inwards before travel
G1 X108.167 Y92.295 F7800.000 ; move to first infill (bridge) point
M106 S255 ; enable fan

G1 F3600.000
G1 X107.705 Y91.833 E65.53528 ; infill (bridge)
G1 X106.912 Y91.833 E65.55832 ; infill (bridge)
G1 X108.167 Y93.088 E65.60984 ; infill (bridge)
G1 X108.167 Y93.882 E65.63287 ; infill (bridge)
G1 X106.118 Y91.833 E65.71697 ; infill (bridge)
G1 X105.325 Y91.833 E65.74001 ; infill (bridge)
G1 X108.167 Y94.675 E65.85669 ; infill (bridge)
G1 X108.167 Y95.469 E65.87973 ; infill (bridge)
G1 X104.531 Y91.833 E66.02899 ; infill (bridge)
G1 X103.737 Y91.833 E66.05203 ; infill (bridge)
G1 X108.167 Y96.263 E66.23387 ; infill (bridge)
G1 X108.167 Y97.056 E66.25691 ; infill (bridge)
G1 X102.944 Y91.833 E66.47134 ; infill (bridge)
G1 X102.150 Y91.833 E66.49437 ; infill (bridge)
G1 X108.167 Y97.850 E66.74138 ; infill (bridge)
G1 X108.167 Y98.643 E66.76442 ; infill (bridge)
G1 X101.357 Y91.833 E67.04400 ; infill (bridge)
G1 X100.563 Y91.833 E67.06704 ; infill (bridge)
G1 X108.167 Y99.437 E67.37921 ; infill (bridge)
G1 X108.167 Y100.231 E67.40225 ; infill (bridge)
G1 X99.769 Y91.833 E67.74700 ; infill (bridge)
G1 X98.976 Y91.833 E67.77004 ; infill (bridge)
G1 X108.167 Y101.024 E68.14737 ; infill (bridge)
G1 X108.167 Y101.818 E68.17041 ; infill (bridge)
G1 X98.182 Y91.833 E68.58032 ; infill (bridge)
G1 X97.389 Y91.833 E68.60336 ; infill (bridge)
G1 X108.167 Y102.611 E69.04585 ; infill (bridge)
G1 X108.167 Y103.405 E69.06889 ; infill (bridge)
G1 X96.595 Y91.833 E69.54396 ; infill (bridge)
G1 X95.801 Y91.833 E69.56700 ; infill (bridge)
G1 X108.167 Y104.199 E70.07466 ; infill (bridge)
G1 X108.167 Y104.992 E70.09769 ; infill (bridge)
G1 X95.008 Y91.833 E70.63793 ; infill (bridge)
G1 X94.214 Y91.833 E70.66097 ; infill (bridge)
G1 X108.167 Y105.786 E71.23379 ; infill (bridge)
G1 X108.167 Y106.579 E71.25683 ; infill (bridge)
G1 X93.421 Y91.833 E71.86223 ; infill (bridge)
G1 X92.627 Y91.833 E71.88526 ; infill (bridge)
G1 X108.167 Y107.373 E72.52324 ; infill (bridge)
G1 X108.167 Y108.167 E72.54628 ; infill (bridge)
G1 X91.833 Y91.833 E73.21684 ; infill (bridge)
G1 X91.833 Y92.627 E73.23988 ; infill (bridge)
G1 X107.373 Y108.167 E73.87786 ; infill (bridge)
G1 X106.579 Y108.167 E73.90090 ; infill (bridge)
G1 X91.833 Y93.421 E74.50630 ; infill (bridge)
G1 X91.833 Y94.214 E74.52934 ; infill (bridge)
G1 X105.786 Y108.167 E75.10216 ; infill (bridge)
G1 X104.992 Y108.167 E75.12520 ; infill (bridge)
G1 X91.833 Y95.008 E75.66544 ; infill (bridge)
G1 X91.833 Y95.801 E75.68847 ; infill (bridge)
G1 X104.199 Y108.167 E76.19613 ; infill (bridge)
G1 X103.405 Y108.167 E76.21917 ; infill (bridge)
G1 X91.833 Y96.595 E76.69424 ; infill (bridge)
G1 X91.833 Y97.389 E76.71728 ; infill (bridge)
G1 X102.611 Y108.167 E77.15978 ; infill (bridge)
G1 X101.818 Y108.167 E77.18281 ; infill (bridge)
G1 X91.833 Y98.182 E77.59273 ; infill (bridge)
G1 X91.833 Y98.976 E77.61577 ; infill (bridge)
G1 X101.024 Y108.167 E77.99310 ; infill (bridge)
G1 X100.231 Y108.167 E78.01614 ; infill (bridge)
G1 X91.833 Y99.769 E78.36089 ; infill (bridge)
G1 X91.833 Y100.563 E78.38392 ; infill (bridge)
G1 X99.437 Y108.167 E78.69609 ; infill (bridge)
G1 X98.643 Y108.167 E78.71913 ; infill (bridge)
G1 X91.833 Y101.357 E78.99872 ; infill (bridge)
G1 X91.833 Y102.150 E79.02176 ; infill (bridge)
G1 X97.850 Y108.167 E79.26876 ; infill (bridge)
G1 X97.056 Y108.167 E79.29180 ; infill (bridge)
G1 X91.833 Y102.944 E79.50623 ; infill (bridge)
G1 X91.833 Y103.737 E79.52926 ; infill (bridge)
G1 X96.263 Y108.167 E79.71111 ; infill (bridge)
G1 X95.469 Y108.167 E79.73415 ; infill (bridge)
G1 X91.833 Y104.531 E79.88341 ; infill (bridge)
G1 X91.833 Y105.324 E79.90645 ; infill (bridge)
G1 X94.676 Y108.167 E80.02313 ; infill (bridge)
G1 X93.882 Y108.167 E80.04617 ; infill (bridge)
G1 X91.833 Y106.118 E80.13027 ; infill (bridge)
G1 X91.833 Y106.912 E80.15330 ; infill (bridge)
G1 X93.088 Y108.167 E80.20482 ; infill (bridge)
G1 X92.295 Y108.167 E80.22786 ; infill (bridge)
G1 X91.833 Y107.705 E80.24680 ; infill (bridge)
M106 S229.5 ; enable fan

M106 S186.15 ; enable fan
G1 Z11.750 F7800.000 ; move to next layer (64)
G1 X108.529 Y108.529 F7800.000 ; move to first perimeter point
G1 F3600.000
G1 X91.471 Y108.529 E80.70695 ; perimeter
G1 X91.471 Y91.471 E81.16710 ; perimeter
G1 X108.529 Y91.471 E81.62726 ; perimeter
G1 X108.529 Y108.454 E82.08539 ; perimeter
G1 X109.164 Y109.164 F7800.000 ; move to first perimeter point
G1 F3600.000
G1 X90.836 Y109.164 E82.57983 ; perimeter
G1 X90.836 Y90.836 E83.07428 ; perimeter
G1 X109.164 Y90.836 E83.56873 ; perimeter
G1 X109.164 Y109.089 E84.06115 ; perimeter
G1 X109.725 Y109.725 F7800.000 ; move to first external perimeter point
G1 F1800.000
G1 X90.275 Y109.725 E84.46202 ; external perimeter
G1 X90.275 Y90.275 E84.86289 ; external perimeter
G1 X109.725 Y90.275 E85.26376 ; external perimeter
G1 X109.725 Y109.650 E85.66309 ; external perimeter
G1 X109.242 Y109.596 F7800.000 ; move inwards before travel
G1 X107.646 Y108.140 F7800.000 ; move to first infill point
G1 F1200.000
G1 X108.140 Y107.646 E85.68202 ; infill
G1 X108.140 Y106.744 E85.70644 ; infill
G1 X106.744 Y108.140 E85.75991 ; infill
G1 X105.842 Y108.140 E85.78433 ; infill
G1 X108.140 Y105.842 E85.87233 ; infill
G1 X108.140 Y104.940 E85.89675 ; infill
G1 X104.940 Y108.140 E86.01929 ; infill
G1 X104.038 Y108.140 E86.04371 ; infill
G1 X108.140 Y104.038 E86.20079 ; infill
G1 X108.140 Y103.135 E86.22521 ; infill
G1 X103.135 Y108.140 E86.41682 ; infill
G1 X102.233 Y108.140 E86.44124 ; infill
G1 X108.140 Y102.233 E86.66739 ; infill
G1 X108.140 Y101.331 E86.69181 ; infill
G1 X101.331 Y108.140 E86.95249 ; infill
G1 X100.429 Y108.140 E86.97691 ; infill
G1 X108.140 Y100.429 E87.27213 ; infill
G1 X108.140 Y99.527 E87.29655 ; infill
G1 X99.527 Y108.140 E87.62630 ; infill
G1 X98.625 Y108.140 E87.65072 ; infill
G1 X108.140 Y98.625 E88.01501 ; infill
G1 X108.140 Y97.723 E88.03943 ; infill
G1 X97.723 Y108.140 E88.43826 ; infill
G1 X96.821 Y108.140 E88.46268 ; infill
G1 X108.140 Y96.821 E88.89604 ; infill
G1 X108.140 Y95.919 E88.92046 ; infill
G1 X95.919 Y108.140 E89.38836 ; infill
G1 X95.017 Y108.140 E89.41278 ; infill
G1 X108.140 Y95.017 E89.91521 ; infill
G1 X108.140 Y94.115 E89.93963 ; infill
G1 X94.115 Y108.140 E90.47660 ; infill
G1 X93.213 Y108.140 E90.50102 ; infill
G1 X108.140 Y93.213 E91.07252 ; infill
G1 X108.140 Y92.311 E91.09694 ; infill
G1 X92.311 Y108.140 E91.70298 ; infill
G1 X91.860 Y108.140 E91.71519 ; infill
G1 X91.860 Y107.689 E91.72740 ; infill
G1 X107.689 Y91.860 E92.33344 ; infill
G1 X106.787 Y91.860 E92.35786 ; infill
G1 X91.860 Y106.787 E92.92936 ; infill
G1 X91.860 Y105.885 E92.95378 ; infill
G1 X105.885 Y91.860 E93.49075 ; infill
G1 X104.983 Y91.860 E93.51517 ; infill
G1 X91.860 Y104.983 E94.01760 ; infill
G1 X91.860 Y104.081 E94.04202 ; infill
G1 X104.081 Y91.860 E94.50992 ; infill
G1 X103.179 Y91.860 E94.53434 ; infill
G1 X91.860 Y103.179 E94.96770 ; infill
G1 X91.860 Y102.277 E94.99212 ; infill
G1 X102.277 Y91.860 E95.39094 ; infill
G1 X101.375 Y91.860 E95.41536 ; infill
G1 X91.860 Y101.375 E95.77965 ; infill
G1 X91.860 Y100.473 E95.80407 ; infill
G1 X100.473 Y91.860 E96.13383 ; infill
G1 X99.571 Y91.860 E96.15825 ; infill
G1 X91.860 Y99.571 E96.45347 ; infill
G1 X91.860 Y98.669 E96.47789 ; infill
G1 X98.669 Y91.860 E96.73857 ; infill
G1 X97.767 Y91.860 E96.76299 ; infill
G1 X91.860 Y97.767 E96.98914 ; infill
G1 X91.860 Y96.865 E97.01356 ; infill
G1 X96.865 Y91.860 E97.20517 ; infill
G1 X95.962 Y91.860 E97.22959 ; infill
G1 X91.860 Y95.962 E97.38667 ; infill
G1 X91.860 Y95.060 E97.41109 ; infill
G1 X95.060 Y91.860 E97.53363 ; infill
G1 X94.158 Y91.860 E97.55805 ; infill
G1 X91.860 Y94.158 E97.64605 ; infill
G1 X91.860 Y93.256 E97.67047 ; infill
G1 X93.256 Y91.860 E97.72394 ; infill
G1 X92.354 Y91.860 E97.74836 ; infill
G1 X91.860 Y92.354 E97.76729 ; infill
M106 S163.2 ; enable fan
G1 Z12.050 F7800.000 ; move to next layer (65)
G1 E95.76729 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X108.529 Y108.529 F7800.000 ; move to first perimeter point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.471 Y108.529 E2.46015 ; perimeter
G1 X91.471 Y91.471 E2.92031 ; perimeter
G1 X108.529 Y91.471 E3.38046 ; perimeter
G1 X108.529 Y108.454 E3.83859 ; perimeter
G1 X109.164 Y109.164 F7800.000 ; move to first perimeter point
G1 F3600.000
G1 X90.836 Y109.164 E4.33303 ; perimeter
G1 X90.836 Y90.836 E4.82748 ; perimeter
G1 X109.164 Y90.836 E5.32193 ; perimeter
G1 X109.164 Y109.089 E5.81435 ; perimeter
G1 X109.725 Y109.725 F7800.000 ; move to first external perimeter point
G1 F1800.000
G1 X90.275 Y109.725 E6.21522 ; external perimeter
G1 X90.275 Y90.275 E6.61609 ; external perimeter
G1 X109.725 Y90.275 E7.01696 ; external perimeter
G1 X109.725 Y109.650 E7.41629 ; external perimeter
G1 X109.242 Y109.596 F7800.000 ; move inwards before travel
G1 E5.41629 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X108.140 Y92.354 F7800.000 ; move to first infill point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F900.000
G1 X107.646 Y91.860 E2.01893 ; infill
G1 X106.744 Y91.860 E2.04335 ; infill
G1 X108.140 Y93.256 E2.09682 ; infill
G1 X108.140 Y94.158 E2.12124 ; infill
G1 X105.842 Y91.860 E2.20925 ; infill
G1 X104.940 Y91.860 E2.23367 ; infill
G1 X108.140 Y95.060 E2.35621 ; infill
G1 X108.140 Y95.962 E2.38063 ; infill
G1 X104.038 Y91.860 E2.53770 ; infill
G1 X103.135 Y91.860 E2.56212 ; infill
G1 X108.140 Y96.865 E2.75374 ; infill
G1 X108.140 Y97.767 E2.77816 ; infill
G1 X102.233 Y91.860 E3.00430 ; infill
G1 X101.331 Y91.860 E3.02872 ; infill
G1 X108.140 Y98.669 E3.28940 ; infill
G1 X108.140 Y99.571 E3.31383 ; infill
G1 X100.429 Y91.860 E3.60904 ; infill
G1 X99.527 Y91.860 E3.63346 ; infill
G1 X108.140 Y100.473 E3.96322 ; infill
G1 X108.140 Y101.375 E3.98764 ; infill
G1 X98.625 Y91.860 E4.35193 ; infill
G1 X97.723 Y91.860 E4.37635 ; infill
G1 X108.140 Y102.277 E4.77517 ; infill
G1 X108.140 Y103.179 E4.79959 ; infill
G1 X96.821 Y91.860 E5.23295 ; infill
G1 X95.919 Y91.860 E5.25737 ; infill
G1 X108.140 Y104.081 E5.72527 ; infill
G1 X108.140 Y104.983 E5.74969 ; infill
G1 X95.017 Y91.860 E6.25212 ; infill
G1 X94.115 Y91.860 E6.27654 ; infill
G1 X108.140 Y105.885 E6.81351 ; infill
G1 X108.140 Y106.787 E6.83793 ; infill
G1 X93.213 Y91.860 E7.40943 ; infill
G1 X92.311 Y91.860 E7.43385 ; infill
G1 X108.140 Y107.689 E8.03989 ; infill
G1 X108.140 Y108.140 E8.05210 ; infill
G1 X107.689 Y108.140 E8.06431 ; infill
G1 X91.860 Y92.311 E8.67035 ; infill
G1 X91.860 Y93.213 E8.69477 ; infill
G1 X106.787 Y108.140 E9.26627 ; infill
G1 X105.885 Y108.140 E9.29069 ; infill
G1 X91.860 Y94.115 E9.82766 ; infill
G1 X91.860 Y95.017 E9.85208 ; infill
G1 X104.983 Y108.140 E10.35451 ; infill
G1 X104.081 Y108.140 E10.37893 ; infill
G1 X91.860 Y95.919 E10.84683 ; infill
G1 X91.860 Y96.821 E10.87125 ; infill
G1 X103.179 Y108.140 E11.30461 ; infill
G1 X102.277 Y108.140 E11.32903 ; infill
G1 X91.860 Y97.723 E11.72786 ; infill
G1 X91.860 Y98.625 E11.75228 ; infill
G1 X101.375 Y108.140 E12.11657 ; infill
G1 X100.473 Y108.140 E12.14099 ; infill
G1 X91.860 Y99.527 E12.47074 ; infill
G1 X91.860 Y100.429 E12.49516 ; infill
G1 X99.571 Y108.140 E12.79038 ; infill
G1 X98.669 Y108.140 E12.81480 ; infill
G1 X91.860 Y101.331 E13.07548 ; infill
G1 X91.860 Y102.233 E13.09990 ; infill
G1 X97.767 Y108.140 E13.32605 ; infill
G1 X96.865 Y108.140 E13.35047 ; infill
G1 X91.860 Y103.135 E13.54208 ; infill
G1 X91.860 Y104.038 E13.56650 ; infill
G1 X95.962 Y108.140 E13.72358 ; infill
G1 X95.060 Y108.140 E13.74800 ; infill
G1 X91.860 Y104.940 E13.87054 ; infill
G1 X91.860 Y105.842 E13.89496 ; infill
G1 X94.158 Y108.140 E13.98297 ; infill
G1 X93.256 Y108.140 E14.00739 ; infill
G1 X91.860 Y106.744 E14.06086 ; infill
G1 X91.860 Y107.646 E14.08528 ; infill
G1 X92.354 Y108.140 E14.10420 ; infill
G1 E12.10420 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
M107 ; disable fan
; Filament-specific end gcode 
;END gcode for filament
M104 S0 ; turn off temperature
G28 X0  ; home X axis
M84     ; disable motors
M140 S0 ; set bed temperature
; cog_x = 99.802584
; cog_y = 99.908501
; cog_z = 7.968253
; material used = 327.94mm (2.32327.94cm3)
; total filament cost = 0.00

; avoid_crossing_perimeters = 0
; bed_shape = 0x0,200x0,200x200,0x200
; bed_temperature = 0
; before_layer_gcode = 
; between_objects_gcode = 
; bridge_acceleration = 0
; bridge_fan_speed = 100
; brim_connections_width = 0
; brim_ears = 0
; brim_ears_max_angle = 125
; brim_width = 0
; complete_objects = 0
; cooling = 1
; default_acceleration = 0
; disable_fan_first_layers = 3
; duplicate_distance = 6
; end_filament_gcode = "; Filament-specific end gcode \n;END gcode for filament\n"
; end_gcode = M104 S0 ; turn off temperature\nG28 X0  ; home X axis\nM84     ; disable motors\n
; extruder_clearance_height = 20
; extruder_clearance_radius = 20
; extruder_offset = 0x0
; extrusion_axis = E
; extrusion_multiplier = 1
; fan_always_on = 0
; fan_below_layer_time = 60
; fan_percentage = 0
; filament_colour = #FFFFFF
; filament_cost = 0
; filament_density = 0
; filament_diameter = 3
; filament_max_volumetric_speed = 0
; filament_notes = ""
; first_layer_acceleration = 0
; first_layer_bed_temperature = 0
; first_layer_extrusion_width = 200%
; first_layer_speed = 30
; first_layer_temperature = 200
; gcode_arcs = 0
; gcode_comments = 1
; gcode_flavor = reprap
; has_heatbed = 1
; infill_acceleration = 0
; infill_first = 0
; interior_brim_width = 0
; label_printed_objects = 0
; layer_gcode = 
; max_fan_speed = 100
; max_layer_height = 0.3
; max_print_speed = 80
; max_volumetric_speed = 0
; min_fan_speed = 35
; min_layer_height = 0.15
; min_print_speed = 10
; min_skirt_length = 0
; notes = 
; nozzle_diameter = 0.5
; only_retract_when_crossing_perimeters = 1
; ooze_prevention = 0
; output_filename_format = [input_filename_base].gcode
; perimeter_acceleration = 0
; post_process = 
; pressure_advance = 0
; printer_notes = 
; resolution = 0
; retract_before_travel = 2
; retract_layer_change = 0
; retract_length = 2
; retract_length_toolchange = 10
; retract_lift = 0
; retract_lift_above = 0
; retract_lift_below = 0
; retract_restart_extra = 0
; retract_restart_extra_toolchange = 0
; retract_speed = 40
; skirt_distance = 6
; skirt_height = 1
; skirts = 1
; slowdown_below_layer_time = 5
; spiral_vase = 0
; standby_temperature_delta = -5
; start_filament_gcode = "; Filament gcode\n"
; start_gcode = G28 ; home all axes\nG1 Z5 F5000 ; lift nozzle\n
; temperature = 200
; threads = 4
; toolchange_gcode = 
; travel_speed = 130
; use_firmware_retraction = 0
; use_relative_e_distances = 0
; use_set_and_wait_bed = 0
; use_set_and_wait_extruder = 0
; use_volumetric_e = 0
; vibration_limit = 0
; wipe = 0
; z_offset = 0
; z_steps_per_mm = 0
; adaptive_slicing = 0
; adaptive_slicing_quality = 75%
; dont_support_bridges = 1
; extrusion_width = 0
; first_layer_height = 0.35
; infill_only_where_needed = 0
; interface_shells = 0
; layer_height = 0.3
; match_horizontal_surfaces = 0
; raft_layers = 0
; regions_overlap = 0
; seam_position = aligned
; sequential_print_priority = 0
; support_material = 1
; support_material_angle = 0
; support_material_buildplate_only = 0
; support_material_contact_distance = 0.2
; support_material_enforce_layers = 0
; support_material_extruder = 1
; support_material_extrusion_width = 0
; support_material_interface_extruder = 1
; support_material_interface_extrusion_width = 0
; support_material_interface_layers = 3
; support_material_interface_spacing = 0
; support_material_interface_speed = 100%
; support_material_max_layers = 0
; support_material_pattern = pillars
; support_material_pillar_size = 2.5
; support_material_pillar_spacing = 10
; support_material_spacing = 2.5
; support_material_speed = 60
; support_material_threshold = 60%
; xy_size_compensation = 0
; bottom_infill_pattern = rectilinear
; bottom_solid_layers = 3
; bridge_flow_ratio = 1
; bridge_speed = 60
; external_perimeter_extrusion_width = 0
; external_perimeter_speed = 50%
; external_perimeters_first = 0
; extra_perimeters = 1
; fill_angle = 45
; fill_density = 20%
; fill_gaps = 1
; fill_pattern = stars
; gap_fill_speed = 20
; infill_every_layers = 1
; infill_extruder = 1
; infill_extrusion_width = 0
; infill_overlap = 55%
; infill_speed = 80
; min_shell_thickness = 0
; min_top_bottom_shell_thickness = 0
; overhangs = 1
; perimeter_extruder = 1
; perimeter_extrusion_width = 0
; perimeter_speed = 60
; perimeters = 3
; small_perimeter_speed = 15
; solid_infill_below_area = 70
; solid_infill_every_layers = 0
; solid_infill_extruder = 1
; solid_infill_extrusion_width = 0
; solid_infill_speed = 20
; thin_walls = 1
; top_infill_extrusion_width = 0
; top_infill_pattern = rectilinear
; top_solid_infill_speed = 15
; top_solid_layers = 3
