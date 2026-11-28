

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
G1 X87.171 Y86.169 F7800.000 ; move to first skirt point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F1800.000
G1 X88.468 Y84.847 E2.05729 ; skirt
G1 X89.034 Y84.413 E2.07936 ; skirt
G1 X90.532 Y83.548 E2.13287 ; skirt
G1 X91.216 Y83.265 E2.15577 ; skirt
G1 X92.998 Y82.804 E2.21273 ; skirt
G1 X104.305 Y81.600 E2.56455 ; skirt
G1 X106.338 Y81.701 E2.62753 ; skirt
G1 X107.587 Y81.958 E2.66701 ; skirt
G1 X108.784 Y82.326 E2.70575 ; skirt
G1 X109.243 Y82.516 E2.72111 ; skirt
G1 X110.741 Y83.381 E2.77462 ; skirt
G1 X111.438 Y83.916 E2.80182 ; skirt
G1 X112.661 Y85.139 E2.85534 ; skirt
G1 X113.251 Y86.007 E2.88780 ; skirt
G1 X115.436 Y89.832 E3.02411 ; skirt
G1 X115.805 Y90.583 E3.05001 ; skirt
G1 X116.119 Y91.341 E3.07539 ; skirt
G1 X116.623 Y93.876 E3.15537 ; skirt
G1 X116.623 Y95.768 E3.21391 ; skirt
G1 X116.594 Y96.387 E3.23306 ; skirt
G1 X115.317 Y109.928 E3.65389 ; skirt
G1 X114.685 Y112.003 E3.72103 ; skirt
G1 X113.435 Y114.526 E3.80815 ; skirt
G1 X111.532 Y116.842 E3.90089 ; skirt
G1 X111.089 Y117.181 E3.91814 ; skirt
G1 X109.592 Y118.046 E3.97165 ; skirt
G1 X108.784 Y118.380 E3.99870 ; skirt
G1 X106.648 Y118.873 E4.06651 ; skirt
G1 X105.399 Y118.948 E4.10525 ; skirt
G1 X104.134 Y118.903 E4.14439 ; skirt
G1 X103.319 Y118.790 E4.16986 ; skirt
G1 X92.314 Y116.847 E4.51565 ; skirt
G1 X90.930 Y116.444 E4.56025 ; skirt
G1 X90.108 Y116.103 E4.58777 ; skirt
G1 X88.610 Y115.239 E4.64128 ; skirt
G1 X88.196 Y114.909 E4.65768 ; skirt
G1 X85.558 Y112.650 E4.76514 ; skirt
G1 X84.308 Y111.519 E4.81728 ; skirt
G1 X83.496 Y110.639 E4.85433 ; skirt
G1 X82.622 Y109.129 E4.90830 ; skirt
G1 X82.333 Y108.431 E4.93168 ; skirt
G1 X81.886 Y106.761 E4.98520 ; skirt
G1 X81.787 Y106.011 E5.00858 ; skirt
G1 X81.730 Y105.147 E5.03539 ; skirt
G1 X81.730 Y104.517 E5.05488 ; skirt
G1 X81.787 Y103.652 E5.08169 ; skirt
G1 X81.886 Y102.903 E5.10507 ; skirt
G1 X82.102 Y101.886 E5.13724 ; skirt
G1 X86.149 Y88.222 E5.57820 ; skirt
G1 X87.138 Y86.236 E5.64684 ; skirt
G1 E3.64684 F2400.00000 ; retract extruder 0
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
G1 X101.250 Y106.924 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F1800.000
G1 X101.250 Y108.774 E2.05722 ; support material
G1 X101.526 Y109.441 E2.07956 ; support material
G1 X102.032 Y110.100 E2.10527 ; support material
G1 X102.223 Y110.246 E2.11272 ; support material
G1 X102.402 Y110.678 E2.12717 ; support material
G1 X102.500 Y110.806 E2.13215 ; support material
G1 X102.500 Y105.239 E2.30438 ; support material
G1 X102.691 Y105.092 E2.31187 ; support material
G1 X103.113 Y104.917 E2.32599 ; support material
G1 X103.155 Y104.600 E2.33588 ; support material
G1 X103.491 Y103.789 E2.36305 ; support material
G1 X103.749 Y103.452 E2.37618 ; support material
G1 X103.749 Y111.967 E2.63963 ; support material
G1 X104.471 Y112.266 E2.66379 ; support material
G1 X104.999 Y112.335 E2.68028 ; support material
G1 X104.999 Y102.443 E2.98635 ; support material
G1 X105.533 Y102.222 E3.00422 ; support material
G1 X106.249 Y102.128 E3.02657 ; support material
G1 X106.249 Y112.260 E3.34006 ; support material
G1 X107.056 Y111.925 E3.36710 ; support material
G1 X107.499 Y111.586 E3.38435 ; support material
G1 X107.499 Y102.316 E3.67119 ; support material
G1 X108.085 Y102.558 E3.69081 ; support material
G1 X108.748 Y103.068 E3.71670 ; support material
G1 X108.748 Y107.891 E3.86595 ; support material
G1 X108.748 Y109.063 F7800.000 ; move to first support material point
G1 F1800.000
G1 X108.748 Y108.886 E3.87143 ; support material
G1 X108.748 Y109.063 E3.87691 ; support material
G1 E1.87691 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X97.500 Y108.247 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F1800.000
G1 X97.500 Y105.817 E2.07518 ; support material
G1 X97.298 Y105.328 E2.09155 ; support material
G1 X96.756 Y104.622 E2.11907 ; support material
G1 X96.251 Y104.234 E2.13880 ; support material
G1 X96.251 Y109.829 E2.31192 ; support material
G1 X96.051 Y109.983 E2.31972 ; support material
G1 X95.229 Y110.323 E2.34724 ; support material
G1 X95.001 Y110.353 E2.35435 ; support material
G1 X95.001 Y103.710 E2.55989 ; support material
G1 X93.966 Y103.574 E2.59218 ; support material
G1 X93.751 Y103.061 E2.60938 ; support material
G1 X93.751 Y110.361 E2.83524 ; support material
G1 X93.465 Y110.323 E2.84417 ; support material
G1 X92.643 Y109.983 E2.87169 ; support material
G1 X92.501 Y109.874 E2.87722 ; support material
G1 X92.501 Y101.929 E3.12307 ; support material
G1 X91.999 Y101.721 E3.13988 ; support material
G1 X91.252 Y101.622 E3.16322 ; support material
G1 X91.252 Y108.387 E3.37253 ; support material
G1 X91.100 Y108.022 E3.38475 ; support material
G1 X90.501 Y107.943 E3.40346 ; support material
G1 X90.002 Y107.736 E3.42018 ; support material
G1 X90.002 Y101.927 E3.59992 ; support material
G1 X89.803 Y102.010 E3.60659 ; support material
G1 X89.203 Y102.470 E3.62997 ; support material
G1 X88.752 Y103.058 E3.65289 ; support material
G1 X88.752 Y106.606 E3.76268 ; support material
G1 X88.454 Y105.896 E3.78651 ; support material
G1 X88.355 Y105.147 E3.80990 ; support material
G1 X88.397 Y104.832 E3.81972 ; support material
G1 X88.355 Y104.517 E3.82955 ; support material
G1 X88.454 Y103.768 E3.85293 ; support material
G1 X88.752 Y103.058 E3.87676 ; support material
G1 E1.87676 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.252 Y96.759 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F1800.000
G1 X91.252 Y97.085 E2.01007 ; support material
G1 X91.344 Y97.786 E2.03195 ; support material
G1 X91.677 Y98.591 E2.05891 ; support material
G1 X92.208 Y99.282 E2.08587 ; support material
G1 X92.501 Y99.508 E2.09732 ; support material
G1 X92.501 Y90.103 E2.38831 ; support material
G1 X93.067 Y89.669 E2.41038 ; support material
G1 X93.751 Y89.386 E2.43328 ; support material
G1 X93.751 Y100.152 E2.76642 ; support material
G1 X94.568 Y100.260 E2.79191 ; support material
G1 X95.001 Y100.203 E2.80542 ; support material
G1 X95.001 Y89.243 E3.14455 ; support material
G1 X95.653 Y89.329 E3.16490 ; support material
G1 X96.251 Y89.576 E3.18492 ; support material
G1 X96.251 Y99.802 E3.50132 ; support material
G1 X96.863 Y99.333 E3.52519 ; support material
G1 X96.863 Y96.863 E3.60162 ; support material
G1 X97.500 Y96.863 E3.62135 ; support material
G1 X97.500 Y90.628 E3.81427 ; support material
G1 X97.722 Y90.916 E3.82553 ; support material
G1 X98.062 Y91.738 E3.85305 ; support material
G1 X98.178 Y92.620 E3.88058 ; support material
G1 X98.079 Y93.377 E3.90420 ; support material
G1 X98.536 Y93.728 E3.92205 ; support material
G1 X98.750 Y94.007 E3.93292 ; support material
G1 X98.750 Y96.863 E4.02128 ; support material
G1 E2.02128 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X101.250 Y89.496 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F1800.000
G1 X100.818 Y90.058 E2.02192 ; support material
G1 X100.478 Y90.880 E2.04945 ; support material
G1 X100.362 Y91.762 E2.07697 ; support material
G1 X100.478 Y92.643 E2.10449 ; support material
G1 X100.818 Y93.465 E2.13202 ; support material
G1 X101.250 Y94.027 E2.15394 ; support material
G1 X101.250 Y89.496 E2.29416 ; support material
G1 X101.360 Y89.352 E2.29976 ; support material
G1 X102.066 Y88.811 E2.32728 ; support material
G1 X102.500 Y88.631 E2.34181 ; support material
G1 X102.500 Y94.892 E2.53555 ; support material
G1 X102.888 Y95.053 E2.54854 ; support material
G1 X103.364 Y95.116 E2.56342 ; support material
G1 X103.442 Y95.704 E2.58179 ; support material
G1 X103.749 Y96.446 E2.60664 ; support material
G1 X103.749 Y88.357 E2.85695 ; support material
G1 X103.962 Y88.379 E2.86356 ; support material
G1 X104.152 Y88.300 E2.86994 ; support material
G1 X104.999 Y88.189 E2.89637 ; support material
G1 X104.999 Y97.750 E3.19220 ; support material
G1 X105.030 Y97.773 E3.19339 ; support material
G1 X105.851 Y98.114 E3.22091 ; support material
G1 X106.249 Y98.166 E3.23332 ; support material
G1 X106.249 Y88.447 E3.53405 ; support material
G1 X106.708 Y88.637 E3.54942 ; support material
G1 X107.405 Y89.172 E3.57662 ; support material
G1 X107.499 Y89.294 E3.58137 ; support material
G1 X107.499 Y98.129 E3.85475 ; support material
G1 X107.615 Y98.114 E3.85839 ; support material
G1 X108.437 Y97.773 E3.88591 ; support material
G1 X108.748 Y97.535 E3.89805 ; support material
G1 X108.748 Y92.110 E4.06588 ; support material
G1 X109.143 Y92.413 E4.08126 ; support material
G1 X109.684 Y93.119 E4.10879 ; support material
G1 X109.998 Y93.876 E4.13417 ; support material
G1 X109.998 Y95.768 E4.19270 ; support material
G1 Z0.550 F7800.000 ; move to next layer (2)
G1 E2.19270 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X105.725 Y89.411 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2265.305
G1 X105.009 Y89.352 E2.01030 ; support material
G1 X104.313 Y89.528 E2.02060 ; support material
G1 X104.126 Y89.650 E2.02381 ; support material
G1 X103.604 Y89.567 E2.03140 ; support material
G1 X102.917 Y89.676 E2.04137 ; support material
G1 X102.298 Y89.992 E2.05134 ; support material
G1 X101.807 Y90.483 E2.06132 ; support material
G1 X101.491 Y91.103 E2.07129 ; support material
G1 X101.382 Y91.789 E2.08126 ; support material
G1 X101.491 Y92.476 E2.09123 ; support material
G1 X101.807 Y93.095 E2.10120 ; support material
G1 X102.298 Y93.586 E2.11118 ; support material
G1 X102.917 Y93.902 E2.12115 ; support material
G1 X103.604 Y94.011 E2.13112 ; support material
G1 X104.290 Y93.902 E2.14109 ; support material
G1 X104.522 Y93.784 E2.14482 ; support material
G1 X104.804 Y94.067 E2.15055 ; support material
G1 X104.692 Y94.288 E2.15412 ; support material
G1 X104.583 Y94.974 E2.16409 ; support material
G1 X104.692 Y95.661 E2.17406 ; support material
G1 X105.007 Y96.280 E2.18403 ; support material
G1 X105.499 Y96.772 E2.19401 ; support material
G1 X106.118 Y97.087 E2.20398 ; support material
G1 X106.805 Y97.196 E2.21395 ; support material
G1 X107.491 Y97.087 E2.22392 ; support material
G1 X108.110 Y96.772 E2.23390 ; support material
G1 X108.602 Y96.280 E2.24387 ; support material
G1 X108.917 Y95.661 E2.25384 ; support material
G1 X109.026 Y94.974 E2.26381 ; support material
G1 X108.917 Y94.288 E2.27379 ; support material
G1 X108.602 Y93.669 E2.28376 ; support material
G1 X108.110 Y93.177 E2.29373 ; support material
G1 X107.491 Y92.862 E2.30370 ; support material
G1 X106.958 Y92.777 E2.31144 ; support material
G1 X107.253 Y92.234 E2.32030 ; support material
G1 X107.371 Y91.526 E2.33061 ; support material
G1 X107.253 Y90.817 E2.34091 ; support material
G1 X106.911 Y90.186 E2.35121 ; support material
G1 X106.383 Y89.700 E2.36151 ; support material
G1 X105.725 Y89.411 E2.37181 ; support material
G1 E0.37181 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.364 Y90.368 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2265.305
G1 X94.677 Y90.259 E2.00997 ; support material
G1 X93.991 Y90.368 E2.01994 ; support material
G1 X93.372 Y90.683 E2.02992 ; support material
G1 X92.880 Y91.175 E2.03989 ; support material
G1 X92.564 Y91.794 E2.04986 ; support material
G1 X92.456 Y92.481 E2.05983 ; support material
G1 X92.564 Y93.167 E2.06981 ; support material
G1 X92.880 Y93.786 E2.07978 ; support material
G1 X93.372 Y94.278 E2.08975 ; support material
G1 X94.457 Y94.831 E2.10723 ; support material
G1 X93.572 Y95.055 E2.12034 ; support material
G1 X92.979 Y95.443 E2.13050 ; support material
G1 X92.544 Y96.002 E2.14066 ; support material
G1 X92.314 Y96.671 E2.15082 ; support material
G1 X92.314 Y97.380 E2.16098 ; support material
G1 X92.544 Y98.050 E2.17114 ; support material
G1 X92.979 Y98.609 E2.18131 ; support material
G1 X93.572 Y98.996 E2.19147 ; support material
G1 X94.258 Y99.170 E2.20163 ; support material
G1 X94.964 Y99.111 E2.21179 ; support material
G1 X95.613 Y98.827 E2.22195 ; support material
G1 X96.134 Y98.347 E2.23212 ; support material
G1 X96.471 Y97.724 E2.24228 ; support material
G1 X96.545 Y97.282 E2.24871 ; support material
G1 X96.880 Y96.862 E2.25642 ; support material
G1 X97.422 Y96.717 E2.26447 ; support material
G1 X97.879 Y96.259 E2.27375 ; support material
G1 X98.046 Y95.635 E2.28303 ; support material
G1 X97.879 Y95.010 E2.29230 ; support material
G1 X97.422 Y94.553 E2.30158 ; support material
G1 X96.797 Y94.386 E2.31086 ; support material
G1 X96.326 Y94.512 E2.31787 ; support material
G1 X96.114 Y94.147 E2.32392 ; support material
G1 X96.475 Y93.786 E2.33123 ; support material
G1 X96.790 Y93.167 E2.34120 ; support material
G1 X96.899 Y92.481 E2.35117 ; support material
G1 X96.790 Y91.794 E2.36115 ; support material
G1 X96.475 Y91.175 E2.37112 ; support material
G1 X95.983 Y90.683 E2.38109 ; support material
G1 X95.364 Y90.368 E2.39106 ; support material
G1 E0.39106 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.903 Y102.772 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2265.305
G1 X91.250 Y102.642 E2.00956 ; support material
G1 X90.597 Y102.772 E2.01911 ; support material
G1 X90.043 Y103.142 E2.02867 ; support material
G1 X89.673 Y103.696 E2.03823 ; support material
G1 X89.543 Y104.349 E2.04778 ; support material
G1 X89.639 Y104.832 E2.05484 ; support material
G1 X89.543 Y105.315 E2.06191 ; support material
G1 X89.673 Y105.968 E2.07146 ; support material
G1 X90.043 Y106.522 E2.08102 ; support material
G1 X90.597 Y106.892 E2.09057 ; support material
G1 X91.250 Y107.022 E2.10013 ; support material
G1 X92.227 Y106.827 E2.11442 ; support material
G1 X92.381 Y107.800 E2.12855 ; support material
G1 X92.696 Y108.419 E2.13852 ; support material
G1 X93.188 Y108.911 E2.14849 ; support material
G1 X93.807 Y109.226 E2.15846 ; support material
G1 X94.494 Y109.335 E2.16844 ; support material
G1 X95.180 Y109.226 E2.17841 ; support material
G1 X95.800 Y108.911 E2.18838 ; support material
G1 X96.291 Y108.419 E2.19835 ; support material
G1 X96.607 Y107.800 E2.20832 ; support material
G1 X96.715 Y107.113 E2.21830 ; support material
G1 X96.607 Y106.427 E2.22827 ; support material
G1 X96.291 Y105.807 E2.23824 ; support material
G1 X95.800 Y105.316 E2.24821 ; support material
G1 X95.180 Y105.000 E2.25819 ; support material
G1 X94.494 Y104.892 E2.26816 ; support material
G1 X93.807 Y105.000 E2.27813 ; support material
G1 X92.979 Y105.423 E2.29147 ; support material
G1 X92.861 Y104.832 E2.30011 ; support material
G1 X92.957 Y104.349 E2.30718 ; support material
G1 X92.827 Y103.696 E2.31673 ; support material
G1 X92.457 Y103.142 E2.32629 ; support material
G1 X91.903 Y102.772 E2.33584 ; support material
G1 E0.33584 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X107.056 Y103.241 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2265.305
G1 X106.342 Y103.182 E2.01028 ; support material
G1 X105.647 Y103.358 E2.02056 ; support material
G1 X105.047 Y103.750 E2.03084 ; support material
G1 X104.607 Y104.316 E2.04112 ; support material
G1 X104.374 Y104.993 E2.05140 ; support material
G1 X104.374 Y105.761 E2.06241 ; support material
G1 X103.821 Y105.761 E2.07036 ; support material
G1 X103.169 Y105.998 E2.08031 ; support material
G1 X102.638 Y106.444 E2.09026 ; support material
G1 X102.291 Y107.044 E2.10021 ; support material
G1 X102.171 Y107.727 E2.11016 ; support material
G1 X102.291 Y108.410 E2.12011 ; support material
G1 X102.638 Y109.011 E2.13006 ; support material
G1 X103.169 Y109.457 E2.14001 ; support material
G1 X103.312 Y109.509 E2.14219 ; support material
G1 X103.355 Y109.782 E2.14617 ; support material
G1 X103.671 Y110.402 E2.15614 ; support material
G1 X104.162 Y110.893 E2.16611 ; support material
G1 X104.782 Y111.209 E2.17608 ; support material
G1 X105.468 Y111.318 E2.18605 ; support material
G1 X106.155 Y111.209 E2.19603 ; support material
G1 X106.774 Y110.893 E2.20600 ; support material
G1 X107.266 Y110.402 E2.21597 ; support material
G1 X107.581 Y109.782 E2.22594 ; support material
G1 X107.690 Y109.096 E2.23592 ; support material
G1 X107.581 Y108.409 E2.24589 ; support material
G1 X107.266 Y107.790 E2.25586 ; support material
G1 X106.973 Y107.498 E2.26179 ; support material
G1 X107.712 Y107.174 E2.27337 ; support material
G1 X108.239 Y106.688 E2.28365 ; support material
G1 X108.580 Y106.058 E2.29393 ; support material
G1 X108.698 Y105.351 E2.30421 ; support material
G1 X108.580 Y104.645 E2.31449 ; support material
G1 X108.239 Y104.015 E2.32477 ; support material
G1 X107.712 Y103.529 E2.33505 ; support material
G1 X107.056 Y103.241 E2.34533 ; support material
G1 Z0.650 F7800.000 ; move to next layer (3)
G1 E0.34533 F2400.00000 ; retract extruder 0
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
G1 F900.000
G1 X98.275 Y101.725 E2.43246 ; external small perimeter
G1 X98.275 Y98.275 E2.50357 ; external small perimeter
G1 X101.725 Y98.275 E2.57467 ; external small perimeter
G1 X101.725 Y101.650 E2.64423 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z0.925 F7800.000 ; move to next layer (4)
G1 E0.64423 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X107.297 Y103.040 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2422.145
G1 X106.583 Y102.981 E2.01785 ; support material
G1 X105.889 Y103.156 E2.03570 ; support material
G1 X105.289 Y103.548 E2.05354 ; support material
G1 X104.849 Y104.114 E2.07139 ; support material
G1 X104.616 Y104.791 E2.08924 ; support material
G1 X104.616 Y105.533 E2.10770 ; support material
G1 X103.604 Y105.533 E2.13291 ; support material
G1 X102.952 Y105.770 E2.15018 ; support material
G1 X102.421 Y106.216 E2.16746 ; support material
G1 X102.074 Y106.816 E2.18473 ; support material
G1 X101.954 Y107.499 E2.20200 ; support material
G1 X102.074 Y108.182 E2.21928 ; support material
G1 X102.421 Y108.783 E2.23655 ; support material
G1 X102.952 Y109.228 E2.25383 ; support material
G1 X103.479 Y109.420 E2.26777 ; support material
G1 X103.572 Y110.011 E2.28267 ; support material
G1 X103.888 Y110.630 E2.29998 ; support material
G1 X104.379 Y111.121 E2.31729 ; support material
G1 X104.998 Y111.437 E2.33461 ; support material
G1 X105.685 Y111.546 E2.35192 ; support material
G1 X106.371 Y111.437 E2.36923 ; support material
G1 X106.991 Y111.121 E2.38655 ; support material
G1 X107.482 Y110.630 E2.40386 ; support material
G1 X107.798 Y110.011 E2.42117 ; support material
G1 X107.907 Y109.324 E2.43849 ; support material
G1 X107.798 Y108.638 E2.45580 ; support material
G1 X107.482 Y108.018 E2.47311 ; support material
G1 X106.899 Y107.435 E2.49367 ; support material
G1 X107.953 Y106.972 E2.52236 ; support material
G1 X108.481 Y106.487 E2.54021 ; support material
G1 X108.822 Y105.856 E2.55806 ; support material
G1 X108.940 Y105.150 E2.57591 ; support material
G1 X108.822 Y104.443 E2.59376 ; support material
G1 X108.481 Y103.813 E2.61160 ; support material
G1 X107.953 Y103.328 E2.62945 ; support material
G1 X107.297 Y103.040 E2.64730 ; support material
G1 E0.64730 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.035 Y89.360 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2422.145
G1 X105.320 Y89.300 E2.01789 ; support material
G1 X104.624 Y89.477 E2.03577 ; support material
G1 X104.126 Y89.802 E2.05059 ; support material
G1 X103.980 Y89.728 E2.05466 ; support material
G1 X103.293 Y89.619 E2.07198 ; support material
G1 X102.607 Y89.728 E2.08929 ; support material
G1 X101.988 Y90.043 E2.10660 ; support material
G1 X101.496 Y90.535 E2.12392 ; support material
G1 X101.181 Y91.154 E2.14123 ; support material
G1 X101.072 Y91.841 E2.15854 ; support material
G1 X101.181 Y92.527 E2.17586 ; support material
G1 X101.496 Y93.146 E2.19317 ; support material
G1 X101.988 Y93.638 E2.21048 ; support material
G1 X102.607 Y93.953 E2.22780 ; support material
G1 X103.293 Y94.062 E2.24511 ; support material
G1 X103.980 Y93.953 E2.26242 ; support material
G1 X104.599 Y93.638 E2.27974 ; support material
G1 X104.737 Y93.500 E2.28459 ; support material
G1 X105.283 Y93.638 E2.29861 ; support material
G1 X104.802 Y94.583 E2.32501 ; support material
G1 X104.693 Y95.269 E2.34233 ; support material
G1 X104.802 Y95.956 E2.35964 ; support material
G1 X105.117 Y96.575 E2.37695 ; support material
G1 X105.609 Y97.067 E2.39427 ; support material
G1 X106.228 Y97.382 E2.41158 ; support material
G1 X106.914 Y97.491 E2.42889 ; support material
G1 X107.601 Y97.382 E2.44621 ; support material
G1 X108.220 Y97.067 E2.46352 ; support material
G1 X108.712 Y96.575 E2.48083 ; support material
G1 X109.027 Y95.956 E2.49815 ; support material
G1 X109.136 Y95.269 E2.51546 ; support material
G1 X109.027 Y94.583 E2.53277 ; support material
G1 X108.712 Y93.963 E2.55009 ; support material
G1 X108.220 Y93.472 E2.56740 ; support material
G1 X107.601 Y93.156 E2.58471 ; support material
G1 X107.080 Y93.074 E2.59784 ; support material
G1 X107.563 Y92.182 E2.62310 ; support material
G1 X107.681 Y91.474 E2.64098 ; support material
G1 X107.563 Y90.766 E2.65887 ; support material
G1 X107.221 Y90.134 E2.67675 ; support material
G1 X106.693 Y89.648 E2.69464 ; support material
G1 X106.035 Y89.360 E2.71252 ; support material
G1 E0.71252 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.301 Y90.059 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2422.145
G1 X94.615 Y89.951 E2.01731 ; support material
G1 X93.928 Y90.059 E2.03463 ; support material
G1 X93.309 Y90.375 E2.05194 ; support material
G1 X92.817 Y90.866 E2.06925 ; support material
G1 X92.502 Y91.486 E2.08657 ; support material
G1 X92.393 Y92.172 E2.10388 ; support material
G1 X92.502 Y92.859 E2.12119 ; support material
G1 X92.817 Y93.478 E2.13851 ; support material
G1 X93.309 Y93.970 E2.15582 ; support material
G1 X93.928 Y94.285 E2.17313 ; support material
G1 X94.824 Y94.427 E2.19572 ; support material
G1 X94.883 Y94.827 E2.20579 ; support material
G1 X94.472 Y95.025 E2.21715 ; support material
G1 X94.405 Y95.108 E2.21980 ; support material
G1 X94.010 Y95.075 E2.22967 ; support material
G1 X93.324 Y95.249 E2.24731 ; support material
G1 X92.731 Y95.637 E2.26496 ; support material
G1 X92.296 Y96.196 E2.28260 ; support material
G1 X92.066 Y96.866 E2.30024 ; support material
G1 X92.066 Y97.574 E2.31788 ; support material
G1 X92.296 Y98.244 E2.33553 ; support material
G1 X92.731 Y98.803 E2.35317 ; support material
G1 X93.324 Y99.190 E2.37081 ; support material
G1 X94.010 Y99.364 E2.38845 ; support material
G1 X94.716 Y99.305 E2.40610 ; support material
G1 X95.365 Y99.021 E2.42374 ; support material
G1 X95.886 Y98.541 E2.44138 ; support material
G1 X96.223 Y97.918 E2.45902 ; support material
G1 X96.291 Y97.509 E2.46935 ; support material
G1 X96.408 Y97.453 E2.47258 ; support material
G1 X96.666 Y97.130 E2.48288 ; support material
G1 X96.797 Y97.165 E2.48627 ; support material
G1 X97.405 Y97.002 E2.50194 ; support material
G1 X97.850 Y96.557 E2.51761 ; support material
G1 X98.013 Y95.950 E2.53328 ; support material
G1 X97.850 Y95.342 E2.54895 ; support material
G1 X97.405 Y94.897 E2.56462 ; support material
G1 X96.797 Y94.734 E2.58029 ; support material
G1 X96.159 Y94.905 E2.59674 ; support material
G1 X95.786 Y94.725 E2.60708 ; support material
G1 X95.367 Y94.725 E2.61751 ; support material
G1 X95.266 Y94.303 E2.62831 ; support material
G1 X95.921 Y93.970 E2.64663 ; support material
G1 X96.412 Y93.478 E2.66394 ; support material
G1 X96.728 Y92.859 E2.68125 ; support material
G1 X96.836 Y92.172 E2.69857 ; support material
G1 X96.728 Y91.486 E2.71588 ; support material
G1 X96.412 Y90.866 E2.73319 ; support material
G1 X95.921 Y90.375 E2.75051 ; support material
G1 X95.301 Y90.059 E2.76782 ; support material
G1 E0.76782 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.903 Y102.457 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2422.145
G1 X91.250 Y102.327 E2.01659 ; support material
G1 X90.597 Y102.457 E2.03318 ; support material
G1 X90.043 Y102.827 E2.04977 ; support material
G1 X89.673 Y103.381 E2.06637 ; support material
G1 X89.543 Y104.034 E2.08296 ; support material
G1 X89.673 Y104.688 E2.09955 ; support material
G1 X89.769 Y104.832 E2.10387 ; support material
G1 X89.673 Y104.976 E2.10818 ; support material
G1 X89.543 Y105.629 E2.12477 ; support material
G1 X89.673 Y106.282 E2.14136 ; support material
G1 X90.043 Y106.836 E2.15796 ; support material
G1 X90.597 Y107.206 E2.17455 ; support material
G1 X91.250 Y107.336 E2.19114 ; support material
G1 X91.903 Y107.206 E2.20773 ; support material
G1 X92.490 Y106.814 E2.22531 ; support material
G1 X92.667 Y107.931 E2.25347 ; support material
G1 X92.983 Y108.550 E2.27078 ; support material
G1 X93.474 Y109.041 E2.28809 ; support material
G1 X94.093 Y109.357 E2.30541 ; support material
G1 X94.780 Y109.466 E2.32272 ; support material
G1 X95.466 Y109.357 E2.34003 ; support material
G1 X96.086 Y109.041 E2.35735 ; support material
G1 X96.577 Y108.550 E2.37466 ; support material
G1 X96.893 Y107.931 E2.39197 ; support material
G1 X97.001 Y107.244 E2.40929 ; support material
G1 X96.893 Y106.558 E2.42660 ; support material
G1 X96.577 Y105.938 E2.44391 ; support material
G1 X96.086 Y105.447 E2.46123 ; support material
G1 X95.466 Y105.131 E2.47854 ; support material
G1 X94.780 Y105.023 E2.49585 ; support material
G1 X94.093 Y105.131 E2.51317 ; support material
G1 X93.474 Y105.447 E2.53048 ; support material
G1 X93.013 Y105.908 E2.54673 ; support material
G1 X92.827 Y104.976 E2.57041 ; support material
G1 X92.731 Y104.832 E2.57472 ; support material
G1 X92.827 Y104.688 E2.57904 ; support material
G1 X92.957 Y104.034 E2.59563 ; support material
G1 X92.827 Y103.381 E2.61222 ; support material
G1 X92.457 Y102.827 E2.62882 ; support material
G1 X91.903 Y102.457 E2.64541 ; support material
G1 Z0.950 F7800.000 ; move to next layer (5)
G1 E0.64541 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F605.536
G1 X99.471 Y100.529 E2.02853 ; small perimeter
G1 X99.471 Y99.471 E2.05706 ; small perimeter
G1 X100.529 Y99.471 E2.08558 ; small perimeter
G1 X100.529 Y100.454 E2.11209 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F605.536
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
G1 F635.311
G1 X99.471 Y100.529 E2.67276 ; small perimeter
G1 X99.471 Y99.471 E2.70129 ; small perimeter
G1 X100.529 Y99.471 E2.72982 ; small perimeter
G1 X100.529 Y100.454 E2.75632 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F635.311
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
G1 X107.555 Y102.859 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2541.243
G1 X106.840 Y102.799 E2.01785 ; support material
G1 X106.146 Y102.975 E2.03570 ; support material
G1 X105.546 Y103.367 E2.05354 ; support material
G1 X105.106 Y103.933 E2.07139 ; support material
G1 X104.873 Y104.610 E2.08924 ; support material
G1 X104.873 Y105.632 E2.11468 ; support material
G1 X104.054 Y105.333 E2.13639 ; support material
G1 X103.361 Y105.333 E2.15367 ; support material
G1 X102.709 Y105.571 E2.17094 ; support material
G1 X102.178 Y106.016 E2.18822 ; support material
G1 X101.831 Y106.617 E2.20549 ; support material
G1 X101.710 Y107.300 E2.22276 ; support material
G1 X101.831 Y107.983 E2.24004 ; support material
G1 X102.178 Y108.583 E2.25731 ; support material
G1 X102.709 Y109.029 E2.27459 ; support material
G1 X103.361 Y109.266 E2.29186 ; support material
G1 X103.682 Y109.266 E2.29987 ; support material
G1 X103.770 Y109.820 E2.31382 ; support material
G1 X103.676 Y109.997 E2.31881 ; support material
G1 X103.676 Y110.626 E2.33447 ; support material
G1 X103.968 Y111.182 E2.35012 ; support material
G1 X104.486 Y111.539 E2.36578 ; support material
G1 X105.110 Y111.615 E2.38143 ; support material
G1 X105.697 Y111.392 E2.39709 ; support material
G1 X105.770 Y111.309 E2.39984 ; support material
G1 X106.559 Y111.184 E2.41973 ; support material
G1 X107.178 Y110.869 E2.43705 ; support material
G1 X107.670 Y110.377 E2.45436 ; support material
G1 X107.985 Y109.758 E2.47167 ; support material
G1 X108.094 Y109.071 E2.48899 ; support material
G1 X107.985 Y108.385 E2.50630 ; support material
G1 X107.670 Y107.766 E2.52361 ; support material
G1 X107.157 Y107.253 E2.54167 ; support material
G1 X108.211 Y106.791 E2.57033 ; support material
G1 X108.738 Y106.306 E2.58818 ; support material
G1 X109.079 Y105.675 E2.60603 ; support material
G1 X109.197 Y104.969 E2.62387 ; support material
G1 X109.079 Y104.262 E2.64172 ; support material
G1 X108.738 Y103.632 E2.65957 ; support material
G1 X108.211 Y103.146 E2.67742 ; support material
G1 X107.555 Y102.859 E2.69527 ; support material
G1 E0.69527 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.346 Y89.308 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2541.243
G1 X105.630 Y89.249 E2.01789 ; support material
G1 X104.934 Y89.425 E2.03577 ; support material
G1 X104.333 Y89.818 E2.05366 ; support material
G1 X104.166 Y90.032 E2.06043 ; support material
G1 X103.670 Y89.779 E2.07431 ; support material
G1 X102.983 Y89.671 E2.09162 ; support material
G1 X102.297 Y89.779 E2.10894 ; support material
G1 X101.677 Y90.095 E2.12625 ; support material
G1 X101.186 Y90.586 E2.14356 ; support material
G1 X100.870 Y91.206 E2.16088 ; support material
G1 X100.761 Y91.892 E2.17819 ; support material
G1 X100.870 Y92.579 E2.19550 ; support material
G1 X101.186 Y93.198 E2.21282 ; support material
G1 X101.677 Y93.690 E2.23013 ; support material
G1 X102.297 Y94.005 E2.24744 ; support material
G1 X102.983 Y94.114 E2.26476 ; support material
G1 X103.670 Y94.005 E2.28207 ; support material
G1 X104.289 Y93.690 E2.29938 ; support material
G1 X104.707 Y93.271 E2.31411 ; support material
G1 X104.934 Y93.420 E2.32087 ; support material
G1 X105.824 Y93.645 E2.34375 ; support material
G1 X105.204 Y94.266 E2.36561 ; support material
G1 X104.888 Y94.885 E2.38292 ; support material
G1 X104.780 Y95.572 E2.40023 ; support material
G1 X104.888 Y96.258 E2.41755 ; support material
G1 X105.204 Y96.878 E2.43486 ; support material
G1 X105.695 Y97.369 E2.45217 ; support material
G1 X106.315 Y97.685 E2.46949 ; support material
G1 X107.001 Y97.793 E2.48680 ; support material
G1 X107.688 Y97.685 E2.50411 ; support material
G1 X108.307 Y97.369 E2.52143 ; support material
G1 X108.799 Y96.878 E2.53874 ; support material
G1 X109.114 Y96.258 E2.55605 ; support material
G1 X109.223 Y95.572 E2.57337 ; support material
G1 X109.114 Y94.885 E2.59068 ; support material
G1 X108.799 Y94.266 E2.60799 ; support material
G1 X108.307 Y93.774 E2.62531 ; support material
G1 X107.688 Y93.459 E2.64262 ; support material
G1 X106.909 Y93.336 E2.66226 ; support material
G1 X107.532 Y92.762 E2.68335 ; support material
G1 X107.873 Y92.131 E2.70124 ; support material
G1 X107.992 Y91.422 E2.71912 ; support material
G1 X107.873 Y90.714 E2.73701 ; support material
G1 X107.532 Y90.083 E2.75489 ; support material
G1 X107.003 Y89.596 E2.77278 ; support material
G1 X106.346 Y89.308 E2.79066 ; support material
G1 E0.79066 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.239 Y89.751 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2541.243
G1 X94.552 Y89.642 E2.01731 ; support material
G1 X93.866 Y89.751 E2.03463 ; support material
G1 X93.246 Y90.067 E2.05194 ; support material
G1 X92.755 Y90.558 E2.06925 ; support material
G1 X92.439 Y91.177 E2.08657 ; support material
G1 X92.331 Y91.864 E2.10388 ; support material
G1 X92.439 Y92.550 E2.12119 ; support material
G1 X92.755 Y93.170 E2.13851 ; support material
G1 X93.246 Y93.661 E2.15582 ; support material
G1 X93.866 Y93.977 E2.17313 ; support material
G1 X94.552 Y94.085 E2.19045 ; support material
G1 X95.239 Y93.977 E2.20776 ; support material
G1 X95.858 Y93.661 E2.22507 ; support material
G1 X96.349 Y93.170 E2.24239 ; support material
G1 X96.665 Y92.550 E2.25970 ; support material
G1 X96.774 Y91.864 E2.27701 ; support material
G1 X96.665 Y91.177 E2.29433 ; support material
G1 X96.349 Y90.558 E2.31164 ; support material
G1 X95.858 Y90.067 E2.32895 ; support material
G1 X95.239 Y89.751 E2.34627 ; support material
G1 E0.34627 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X96.204 Y94.927 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2541.243
G1 X95.786 Y94.725 E2.01158 ; support material
G1 X95.094 Y94.725 E2.02880 ; support material
G1 X94.472 Y95.025 E2.04601 ; support material
G1 X94.245 Y95.309 E2.05507 ; support material
G1 X93.763 Y95.269 E2.06713 ; support material
G1 X93.076 Y95.443 E2.08477 ; support material
G1 X92.483 Y95.831 E2.10241 ; support material
G1 X92.048 Y96.390 E2.12005 ; support material
G1 X91.818 Y97.060 E2.13769 ; support material
G1 X91.818 Y97.768 E2.15534 ; support material
G1 X92.048 Y98.438 E2.17298 ; support material
G1 X92.483 Y98.997 E2.19062 ; support material
G1 X93.076 Y99.384 E2.20826 ; support material
G1 X93.763 Y99.558 E2.22591 ; support material
G1 X94.469 Y99.499 E2.24355 ; support material
G1 X95.117 Y99.215 E2.26119 ; support material
G1 X95.638 Y98.735 E2.27883 ; support material
G1 X95.975 Y98.112 E2.29648 ; support material
G1 X96.057 Y97.622 E2.30885 ; support material
G1 X96.408 Y97.453 E2.31856 ; support material
G1 X96.688 Y97.102 E2.32975 ; support material
G1 X96.797 Y97.131 E2.33256 ; support material
G1 X97.388 Y96.973 E2.34780 ; support material
G1 X97.821 Y96.540 E2.36303 ; support material
G1 X97.979 Y95.950 E2.37827 ; support material
G1 X97.821 Y95.359 E2.39350 ; support material
G1 X97.388 Y94.926 E2.40874 ; support material
G1 X96.797 Y94.768 E2.42397 ; support material
G1 X96.204 Y94.927 E2.43926 ; support material
G1 E0.43926 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.903 Y102.143 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2541.243
G1 X91.250 Y102.013 E2.01659 ; support material
G1 X90.597 Y102.143 E2.03318 ; support material
G1 X90.043 Y102.513 E2.04977 ; support material
G1 X89.673 Y103.067 E2.06637 ; support material
G1 X89.543 Y103.720 E2.08296 ; support material
G1 X89.673 Y104.373 E2.09955 ; support material
G1 X89.979 Y104.832 E2.11329 ; support material
G1 X89.673 Y105.291 E2.12703 ; support material
G1 X89.543 Y105.944 E2.14363 ; support material
G1 X89.673 Y106.597 E2.16022 ; support material
G1 X90.043 Y107.151 E2.17681 ; support material
G1 X90.597 Y107.521 E2.19340 ; support material
G1 X91.250 Y107.651 E2.20999 ; support material
G1 X91.903 Y107.521 E2.22658 ; support material
G1 X92.787 Y106.931 E2.25305 ; support material
G1 X92.962 Y108.039 E2.28101 ; support material
G1 X93.278 Y108.659 E2.29832 ; support material
G1 X93.769 Y109.150 E2.31563 ; support material
G1 X94.389 Y109.466 E2.33295 ; support material
G1 X95.075 Y109.575 E2.35026 ; support material
G1 X95.762 Y109.466 E2.36757 ; support material
G1 X96.381 Y109.150 E2.38489 ; support material
G1 X96.872 Y108.659 E2.40220 ; support material
G1 X97.188 Y108.039 E2.41951 ; support material
G1 X97.297 Y107.353 E2.43683 ; support material
G1 X97.188 Y106.666 E2.45414 ; support material
G1 X96.872 Y106.047 E2.47145 ; support material
G1 X96.381 Y105.556 E2.48877 ; support material
G1 X95.762 Y105.240 E2.50608 ; support material
G1 X95.075 Y105.131 E2.52339 ; support material
G1 X94.389 Y105.240 E2.54070 ; support material
G1 X93.769 Y105.556 E2.55802 ; support material
G1 X93.028 Y106.297 E2.58415 ; support material
G1 X92.827 Y105.291 E2.60972 ; support material
G1 X92.521 Y104.832 E2.62346 ; support material
G1 X92.827 Y104.373 E2.63721 ; support material
G1 X92.957 Y103.720 E2.65380 ; support material
G1 X92.827 Y103.067 E2.67039 ; support material
G1 X92.457 Y102.513 E2.68698 ; support material
G1 X91.903 Y102.143 E2.70357 ; support material
G1 Z1.550 F7800.000 ; move to next layer (8)
G1 E0.70357 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F668.682
G1 X99.471 Y100.529 E2.02853 ; small perimeter
G1 X99.471 Y99.471 E2.05706 ; small perimeter
G1 X100.529 Y99.471 E2.08558 ; small perimeter
G1 X100.529 Y100.454 E2.11209 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F668.682
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
G1 X107.631 Y102.553 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2674.728
G1 X106.917 Y102.494 E2.01785 ; support material
G1 X106.222 Y102.670 E2.03570 ; support material
G1 X105.622 Y103.062 E2.05354 ; support material
G1 X105.182 Y103.627 E2.07139 ; support material
G1 X104.949 Y104.305 E2.08924 ; support material
G1 X104.949 Y105.022 E2.10709 ; support material
G1 X105.084 Y105.413 E2.11740 ; support material
G1 X104.739 Y105.650 E2.12781 ; support material
G1 X104.441 Y105.400 E2.13749 ; support material
G1 X103.790 Y105.163 E2.15477 ; support material
G1 X103.096 Y105.163 E2.17204 ; support material
G1 X102.445 Y105.400 E2.18931 ; support material
G1 X101.913 Y105.846 E2.20659 ; support material
G1 X101.567 Y106.446 E2.22386 ; support material
G1 X101.446 Y107.129 E2.24114 ; support material
G1 X101.567 Y107.812 E2.25841 ; support material
G1 X101.913 Y108.413 E2.27569 ; support material
G1 X102.445 Y108.859 E2.29296 ; support material
G1 X103.096 Y109.096 E2.31023 ; support material
G1 X103.883 Y109.096 E2.32982 ; support material
G1 X103.958 Y109.571 E2.34181 ; support material
G1 X103.781 Y109.693 E2.34717 ; support material
G1 X103.489 Y110.250 E2.36283 ; support material
G1 X103.489 Y110.878 E2.37848 ; support material
G1 X103.781 Y111.435 E2.39413 ; support material
G1 X104.298 Y111.792 E2.40979 ; support material
G1 X104.922 Y111.867 E2.42544 ; support material
G1 X105.509 Y111.645 E2.44110 ; support material
G1 X105.926 Y111.174 E2.45675 ; support material
G1 X105.955 Y111.057 E2.45976 ; support material
G1 X106.747 Y110.932 E2.47972 ; support material
G1 X107.366 Y110.616 E2.49704 ; support material
G1 X107.858 Y110.125 E2.51435 ; support material
G1 X108.173 Y109.505 E2.53166 ; support material
G1 X108.282 Y108.819 E2.54898 ; support material
G1 X108.173 Y108.132 E2.56629 ; support material
G1 X107.858 Y107.513 E2.58360 ; support material
G1 X107.274 Y106.930 E2.60416 ; support material
G1 X108.287 Y106.486 E2.63170 ; support material
G1 X108.814 Y106.000 E2.64955 ; support material
G1 X109.155 Y105.370 E2.66739 ; support material
G1 X109.273 Y104.663 E2.68524 ; support material
G1 X109.155 Y103.957 E2.70309 ; support material
G1 X108.814 Y103.326 E2.72094 ; support material
G1 X108.287 Y102.841 E2.73879 ; support material
G1 X107.631 Y102.553 E2.75663 ; support material
G1 E0.75663 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.656 Y89.256 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2674.728
G1 X105.941 Y89.197 E2.01789 ; support material
G1 X105.245 Y89.373 E2.03577 ; support material
G1 X104.643 Y89.766 E2.05366 ; support material
G1 X104.186 Y90.354 E2.07221 ; support material
G1 X103.978 Y90.147 E2.07952 ; support material
G1 X103.359 Y89.831 E2.09683 ; support material
G1 X102.673 Y89.722 E2.11415 ; support material
G1 X101.986 Y89.831 E2.13146 ; support material
G1 X101.367 Y90.147 E2.14877 ; support material
G1 X100.875 Y90.638 E2.16609 ; support material
G1 X100.560 Y91.257 E2.18340 ; support material
G1 X100.451 Y91.944 E2.20071 ; support material
G1 X100.560 Y92.630 E2.21803 ; support material
G1 X100.875 Y93.250 E2.23534 ; support material
G1 X101.367 Y93.741 E2.25265 ; support material
G1 X101.986 Y94.057 E2.26997 ; support material
G1 X102.673 Y94.165 E2.28728 ; support material
G1 X103.359 Y94.057 E2.30459 ; support material
G1 X103.978 Y93.741 E2.32191 ; support material
G1 X104.470 Y93.250 E2.33922 ; support material
G1 X104.618 Y92.959 E2.34734 ; support material
G1 X105.245 Y93.368 E2.36599 ; support material
G1 X106.525 Y93.693 E2.39889 ; support material
G1 X105.760 Y94.082 E2.42027 ; support material
G1 X105.268 Y94.574 E2.43759 ; support material
G1 X104.953 Y95.193 E2.45490 ; support material
G1 X104.844 Y95.880 E2.47221 ; support material
G1 X104.953 Y96.566 E2.48953 ; support material
G1 X105.268 Y97.185 E2.50684 ; support material
G1 X105.760 Y97.677 E2.52415 ; support material
G1 X106.379 Y97.993 E2.54147 ; support material
G1 X107.066 Y98.101 E2.55878 ; support material
G1 X107.752 Y97.993 E2.57609 ; support material
G1 X108.372 Y97.677 E2.59341 ; support material
G1 X108.863 Y97.185 E2.61072 ; support material
G1 X109.179 Y96.566 E2.62803 ; support material
G1 X109.287 Y95.880 E2.64535 ; support material
G1 X109.179 Y95.193 E2.66266 ; support material
G1 X108.863 Y94.574 E2.67997 ; support material
G1 X108.372 Y94.082 E2.69729 ; support material
G1 X107.752 Y93.767 E2.71460 ; support material
G1 X107.199 Y93.679 E2.72857 ; support material
G1 X107.146 Y93.270 E2.73883 ; support material
G1 X107.314 Y93.197 E2.74339 ; support material
G1 X107.842 Y92.711 E2.76128 ; support material
G1 X108.184 Y92.079 E2.77916 ; support material
G1 X108.302 Y91.371 E2.79705 ; support material
G1 X108.184 Y90.663 E2.81493 ; support material
G1 X107.842 Y90.031 E2.83282 ; support material
G1 X107.314 Y89.545 E2.85071 ; support material
G1 X106.656 Y89.256 E2.86859 ; support material
G1 E0.86859 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.176 Y89.443 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2674.728
G1 X94.490 Y89.334 E2.01731 ; support material
G1 X93.803 Y89.443 E2.03463 ; support material
G1 X93.184 Y89.758 E2.05194 ; support material
G1 X92.692 Y90.250 E2.06925 ; support material
G1 X92.377 Y90.869 E2.08657 ; support material
G1 X92.268 Y91.556 E2.10388 ; support material
G1 X92.377 Y92.242 E2.12119 ; support material
G1 X92.692 Y92.861 E2.13851 ; support material
G1 X93.184 Y93.353 E2.15582 ; support material
G1 X93.803 Y93.668 E2.17313 ; support material
G1 X94.490 Y93.777 E2.19045 ; support material
G1 X95.176 Y93.668 E2.20776 ; support material
G1 X95.795 Y93.353 E2.22507 ; support material
G1 X96.287 Y92.861 E2.24239 ; support material
G1 X96.602 Y92.242 E2.25970 ; support material
G1 X96.711 Y91.556 E2.27701 ; support material
G1 X96.602 Y90.869 E2.29433 ; support material
G1 X96.287 Y90.250 E2.31164 ; support material
G1 X95.795 Y89.758 E2.32895 ; support material
G1 X95.176 Y89.443 E2.34627 ; support material
G1 E0.34627 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X96.295 Y94.970 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2674.728
G1 X95.786 Y94.725 E2.01408 ; support material
G1 X95.094 Y94.725 E2.03129 ; support material
G1 X94.472 Y95.025 E2.04851 ; support material
G1 X94.084 Y95.511 E2.06398 ; support material
G1 X93.515 Y95.464 E2.07822 ; support material
G1 X92.828 Y95.637 E2.09586 ; support material
G1 X92.236 Y96.025 E2.11350 ; support material
G1 X91.800 Y96.584 E2.13114 ; support material
G1 X91.571 Y97.254 E2.14878 ; support material
G1 X91.571 Y97.962 E2.16643 ; support material
G1 X91.800 Y98.632 E2.18407 ; support material
G1 X92.236 Y99.191 E2.20171 ; support material
G1 X92.828 Y99.578 E2.21935 ; support material
G1 X93.515 Y99.752 E2.23700 ; support material
G1 X94.221 Y99.693 E2.25464 ; support material
G1 X94.870 Y99.409 E2.27228 ; support material
G1 X95.391 Y98.929 E2.28992 ; support material
G1 X95.728 Y98.306 E2.30757 ; support material
G1 X95.823 Y97.735 E2.32200 ; support material
G1 X96.408 Y97.453 E2.33817 ; support material
G1 X96.712 Y97.073 E2.35030 ; support material
G1 X97.273 Y96.992 E2.36443 ; support material
G1 X97.761 Y96.569 E2.38052 ; support material
G1 X97.943 Y95.950 E2.39660 ; support material
G1 X97.761 Y95.330 E2.41268 ; support material
G1 X97.273 Y94.907 E2.42877 ; support material
G1 X96.634 Y94.815 E2.44485 ; support material
G1 X96.295 Y94.970 E2.45415 ; support material
G1 E0.45415 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.903 Y101.828 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2674.728
G1 X91.250 Y101.698 E2.01659 ; support material
G1 X90.597 Y101.828 E2.03318 ; support material
G1 X90.043 Y102.198 E2.04977 ; support material
G1 X89.673 Y102.752 E2.06637 ; support material
G1 X89.543 Y103.405 E2.08296 ; support material
G1 X89.673 Y104.058 E2.09955 ; support material
G1 X90.043 Y104.612 E2.11614 ; support material
G1 X90.372 Y104.832 E2.12599 ; support material
G1 X90.043 Y105.051 E2.13583 ; support material
G1 X89.673 Y105.605 E2.15242 ; support material
G1 X89.543 Y106.259 E2.16901 ; support material
G1 X89.673 Y106.912 E2.18560 ; support material
G1 X90.043 Y107.466 E2.20220 ; support material
G1 X90.597 Y107.836 E2.21879 ; support material
G1 X91.250 Y107.966 E2.23538 ; support material
G1 X91.903 Y107.836 E2.25197 ; support material
G1 X92.457 Y107.466 E2.26856 ; support material
G1 X92.794 Y106.961 E2.28367 ; support material
G1 X93.206 Y107.123 E2.29469 ; support material
G1 X93.156 Y107.440 E2.30268 ; support material
G1 X93.265 Y108.126 E2.32000 ; support material
G1 X93.580 Y108.745 E2.33731 ; support material
G1 X94.072 Y109.237 E2.35462 ; support material
G1 X94.691 Y109.552 E2.37194 ; support material
G1 X95.378 Y109.661 E2.38925 ; support material
G1 X96.064 Y109.552 E2.40656 ; support material
G1 X96.683 Y109.237 E2.42387 ; support material
G1 X97.175 Y108.745 E2.44119 ; support material
G1 X97.490 Y108.126 E2.45850 ; support material
G1 X97.599 Y107.440 E2.47581 ; support material
G1 X97.490 Y106.753 E2.49313 ; support material
G1 X97.175 Y106.134 E2.51044 ; support material
G1 X96.683 Y105.642 E2.52775 ; support material
G1 X96.064 Y105.327 E2.54507 ; support material
G1 X95.378 Y105.218 E2.56238 ; support material
G1 X94.691 Y105.327 E2.57969 ; support material
G1 X94.072 Y105.642 E2.59701 ; support material
G1 X93.580 Y106.134 E2.61432 ; support material
G1 X93.386 Y106.516 E2.62501 ; support material
G1 X92.998 Y106.462 E2.63476 ; support material
G1 X92.827 Y105.605 E2.65653 ; support material
G1 X92.457 Y105.051 E2.67312 ; support material
G1 X92.129 Y104.832 E2.68296 ; support material
G1 X92.457 Y104.612 E2.69281 ; support material
G1 X92.827 Y104.058 E2.70940 ; support material
G1 X92.957 Y103.405 E2.72599 ; support material
G1 X92.827 Y102.752 E2.74258 ; support material
G1 X92.457 Y102.198 E2.75917 ; support material
G1 X91.903 Y101.828 E2.77577 ; support material
G1 Z1.850 F7800.000 ; move to next layer (10)
G1 E0.77577 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F722.832
G1 X99.471 Y100.529 E2.02853 ; small perimeter
G1 X99.471 Y99.471 E2.05706 ; small perimeter
G1 X100.529 Y99.471 E2.08558 ; small perimeter
G1 X100.529 Y100.454 E2.11209 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F722.832
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
G1 X104.165 Y105.249 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2891.330
G1 X103.514 Y105.012 E2.01727 ; support material
G1 X102.820 Y105.012 E2.03455 ; support material
G1 X102.168 Y105.249 E2.05182 ; support material
G1 X101.637 Y105.695 E2.06910 ; support material
G1 X101.290 Y106.295 E2.08637 ; support material
G1 X101.170 Y106.978 E2.10364 ; support material
G1 X101.290 Y107.661 E2.12092 ; support material
G1 X101.637 Y108.262 E2.13819 ; support material
G1 X102.168 Y108.707 E2.15547 ; support material
G1 X102.820 Y108.945 E2.17274 ; support material
G1 X103.514 Y108.945 E2.19002 ; support material
G1 X104.321 Y108.651 E2.21142 ; support material
G1 X104.656 Y109.404 E2.23195 ; support material
G1 X104.019 Y109.481 E2.24796 ; support material
G1 X103.501 Y109.838 E2.26361 ; support material
G1 X103.209 Y110.395 E2.27927 ; support material
G1 X103.209 Y111.023 E2.29492 ; support material
G1 X103.501 Y111.580 E2.31058 ; support material
G1 X104.019 Y111.937 E2.32623 ; support material
G1 X104.643 Y112.012 E2.34188 ; support material
G1 X105.230 Y111.790 E2.35754 ; support material
G1 X105.808 Y111.137 E2.37925 ; support material
G1 X105.986 Y111.223 E2.38418 ; support material
G1 X106.656 Y111.223 E2.40086 ; support material
G1 X107.260 Y110.932 E2.41755 ; support material
G1 X107.677 Y110.409 E2.43423 ; support material
G1 X107.826 Y109.756 E2.45092 ; support material
G1 X107.677 Y109.102 E2.46761 ; support material
G1 X107.500 Y108.880 E2.47469 ; support material
G1 X107.577 Y108.516 E2.48397 ; support material
G1 X107.439 Y107.864 E2.50056 ; support material
G1 X107.048 Y107.326 E2.51714 ; support material
G1 X106.471 Y106.993 E2.53373 ; support material
G1 X105.808 Y106.923 E2.55032 ; support material
G1 X105.189 Y107.124 E2.56653 ; support material
G1 X105.043 Y106.295 E2.58750 ; support material
G1 X104.697 Y105.695 E2.60477 ; support material
G1 X104.165 Y105.249 E2.62205 ; support material
G1 E0.62205 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X107.719 Y102.251 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2891.330
G1 X107.004 Y102.192 E2.01785 ; support material
G1 X106.310 Y102.368 E2.03570 ; support material
G1 X105.710 Y102.760 E2.05354 ; support material
G1 X105.270 Y103.325 E2.07139 ; support material
G1 X105.037 Y104.003 E2.08924 ; support material
G1 X105.037 Y104.719 E2.10709 ; support material
G1 X105.270 Y105.397 E2.12494 ; support material
G1 X105.710 Y105.963 E2.14279 ; support material
G1 X106.310 Y106.355 E2.16063 ; support material
G1 X107.004 Y106.530 E2.17848 ; support material
G1 X107.719 Y106.471 E2.19633 ; support material
G1 X108.375 Y106.183 E2.21418 ; support material
G1 X108.902 Y105.698 E2.23203 ; support material
G1 X109.243 Y105.068 E2.24987 ; support material
G1 X109.361 Y104.361 E2.26772 ; support material
G1 X109.243 Y103.654 E2.28557 ; support material
G1 X108.902 Y103.024 E2.30342 ; support material
G1 X108.375 Y102.539 E2.32127 ; support material
G1 X107.719 Y102.251 E2.33911 ; support material
G1 E0.33911 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X107.796 Y94.079 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2891.330
G1 X107.109 Y93.970 E2.01731 ; support material
G1 X106.423 Y94.079 E2.03463 ; support material
G1 X105.803 Y94.394 E2.05194 ; support material
G1 X105.312 Y94.886 E2.06925 ; support material
G1 X104.996 Y95.505 E2.08657 ; support material
G1 X104.888 Y96.191 E2.10388 ; support material
G1 X104.996 Y96.878 E2.12119 ; support material
G1 X105.312 Y97.497 E2.13851 ; support material
G1 X105.803 Y97.989 E2.15582 ; support material
G1 X106.423 Y98.304 E2.17313 ; support material
G1 X107.109 Y98.413 E2.19045 ; support material
G1 X107.796 Y98.304 E2.20776 ; support material
G1 X108.415 Y97.989 E2.22507 ; support material
G1 X108.906 Y97.497 E2.24239 ; support material
G1 X109.222 Y96.878 E2.25970 ; support material
G1 X109.331 Y96.191 E2.27701 ; support material
G1 X109.222 Y95.505 E2.29433 ; support material
G1 X108.906 Y94.886 E2.31164 ; support material
G1 X108.415 Y94.394 E2.32895 ; support material
G1 X107.796 Y94.079 E2.34627 ; support material
G1 E0.34627 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.967 Y89.205 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2891.330
G1 X106.251 Y89.146 E2.01789 ; support material
G1 X105.555 Y89.322 E2.03577 ; support material
G1 X104.954 Y89.715 E2.05366 ; support material
G1 X104.513 Y90.281 E2.07154 ; support material
G1 X104.318 Y90.848 E2.08648 ; support material
G1 X103.668 Y90.198 E2.10938 ; support material
G1 X103.049 Y89.883 E2.12669 ; support material
G1 X102.362 Y89.774 E2.14400 ; support material
G1 X101.676 Y89.883 E2.16132 ; support material
G1 X101.056 Y90.198 E2.17863 ; support material
G1 X100.565 Y90.690 E2.19594 ; support material
G1 X100.249 Y91.309 E2.21326 ; support material
G1 X100.141 Y91.995 E2.23057 ; support material
G1 X100.249 Y92.682 E2.24788 ; support material
G1 X100.565 Y93.301 E2.26520 ; support material
G1 X101.056 Y93.793 E2.28251 ; support material
G1 X101.676 Y94.108 E2.29982 ; support material
G1 X102.362 Y94.217 E2.31714 ; support material
G1 X103.049 Y94.108 E2.33445 ; support material
G1 X103.668 Y93.793 E2.35176 ; support material
G1 X104.160 Y93.301 E2.36908 ; support material
G1 X104.590 Y92.456 E2.39269 ; support material
G1 X104.954 Y92.924 E2.40745 ; support material
G1 X105.555 Y93.317 E2.42534 ; support material
G1 X106.251 Y93.493 E2.44322 ; support material
G1 X106.967 Y93.434 E2.46111 ; support material
G1 X107.624 Y93.145 E2.47899 ; support material
G1 X108.152 Y92.659 E2.49688 ; support material
G1 X108.494 Y92.028 E2.51476 ; support material
G1 X108.612 Y91.319 E2.53265 ; support material
G1 X108.494 Y90.611 E2.55053 ; support material
G1 X108.152 Y89.980 E2.56842 ; support material
G1 X107.624 Y89.493 E2.58630 ; support material
G1 X106.967 Y89.205 E2.60419 ; support material
G1 E0.60419 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.114 Y89.134 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2891.330
G1 X94.427 Y89.026 E2.01731 ; support material
G1 X93.741 Y89.134 E2.03463 ; support material
G1 X93.121 Y89.450 E2.05194 ; support material
G1 X92.630 Y89.941 E2.06925 ; support material
G1 X92.314 Y90.561 E2.08657 ; support material
G1 X92.205 Y91.247 E2.10388 ; support material
G1 X92.314 Y91.934 E2.12119 ; support material
G1 X92.630 Y92.553 E2.13851 ; support material
G1 X93.121 Y93.044 E2.15582 ; support material
G1 X93.741 Y93.360 E2.17313 ; support material
G1 X94.427 Y93.469 E2.19045 ; support material
G1 X95.114 Y93.360 E2.20776 ; support material
G1 X95.733 Y93.044 E2.22507 ; support material
G1 X96.224 Y92.553 E2.24239 ; support material
G1 X96.540 Y91.934 E2.25970 ; support material
G1 X96.649 Y91.247 E2.27701 ; support material
G1 X96.540 Y90.561 E2.29433 ; support material
G1 X96.224 Y89.941 E2.31164 ; support material
G1 X95.733 Y89.450 E2.32895 ; support material
G1 X95.114 Y89.134 E2.34627 ; support material
G1 E0.34627 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X96.333 Y94.989 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2891.330
G1 X95.786 Y94.725 E2.01513 ; support material
G1 X95.094 Y94.725 E2.03234 ; support material
G1 X94.472 Y95.025 E2.04956 ; support material
G1 X93.924 Y95.712 E2.07145 ; support material
G1 X93.267 Y95.658 E2.08786 ; support material
G1 X92.581 Y95.831 E2.10550 ; support material
G1 X91.988 Y96.219 E2.12314 ; support material
G1 X91.553 Y96.778 E2.14078 ; support material
G1 X91.323 Y97.448 E2.15843 ; support material
G1 X91.323 Y98.156 E2.17607 ; support material
G1 X91.553 Y98.826 E2.19371 ; support material
G1 X91.988 Y99.385 E2.21135 ; support material
G1 X92.581 Y99.772 E2.22899 ; support material
G1 X93.267 Y99.946 E2.24664 ; support material
G1 X93.973 Y99.888 E2.26428 ; support material
G1 X94.622 Y99.603 E2.28192 ; support material
G1 X95.143 Y99.123 E2.29956 ; support material
G1 X95.480 Y98.500 E2.31721 ; support material
G1 X95.605 Y97.753 E2.33608 ; support material
G1 X95.786 Y97.753 E2.34058 ; support material
G1 X96.408 Y97.453 E2.35780 ; support material
G1 X96.741 Y97.036 E2.37110 ; support material
G1 X97.259 Y96.961 E2.38414 ; support material
G1 X97.733 Y96.551 E2.39975 ; support material
G1 X97.910 Y95.950 E2.41536 ; support material
G1 X97.733 Y95.348 E2.43097 ; support material
G1 X97.259 Y94.938 E2.44658 ; support material
G1 X96.639 Y94.849 E2.46219 ; support material
G1 X96.333 Y94.989 E2.47058 ; support material
G1 E0.47058 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.903 Y101.513 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2891.330
G1 X91.250 Y101.383 E2.01659 ; support material
G1 X90.597 Y101.513 E2.03318 ; support material
G1 X90.043 Y101.883 E2.04977 ; support material
G1 X89.673 Y102.437 E2.06637 ; support material
G1 X89.543 Y103.090 E2.08296 ; support material
G1 X89.673 Y103.744 E2.09955 ; support material
G1 X90.043 Y104.298 E2.11614 ; support material
G1 X90.843 Y104.832 E2.14009 ; support material
G1 X90.043 Y105.366 E2.16405 ; support material
G1 X89.673 Y105.920 E2.18064 ; support material
G1 X89.543 Y106.573 E2.19723 ; support material
G1 X89.673 Y107.226 E2.21382 ; support material
G1 X90.043 Y107.780 E2.23041 ; support material
G1 X90.597 Y108.150 E2.24700 ; support material
G1 X91.250 Y108.280 E2.26359 ; support material
G1 X91.903 Y108.150 E2.28019 ; support material
G1 X92.457 Y107.780 E2.29678 ; support material
G1 X92.827 Y107.226 E2.31337 ; support material
G1 X92.957 Y106.573 E2.32996 ; support material
G1 X92.827 Y105.920 E2.34655 ; support material
G1 X92.457 Y105.366 E2.36314 ; support material
G1 X91.658 Y104.832 E2.38710 ; support material
G1 X92.457 Y104.298 E2.41105 ; support material
G1 X92.827 Y103.744 E2.42764 ; support material
G1 X92.957 Y103.090 E2.44423 ; support material
G1 X92.827 Y102.437 E2.46082 ; support material
G1 X92.457 Y101.883 E2.47741 ; support material
G1 X91.903 Y101.513 E2.49401 ; support material
G1 E0.49401 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X96.372 Y105.391 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2891.330
G1 X95.686 Y105.283 E2.01731 ; support material
G1 X94.999 Y105.391 E2.03463 ; support material
G1 X94.380 Y105.707 E2.05194 ; support material
G1 X93.888 Y106.198 E2.06925 ; support material
G1 X93.573 Y106.818 E2.08657 ; support material
G1 X93.464 Y107.504 E2.10388 ; support material
G1 X93.573 Y108.191 E2.12119 ; support material
G1 X93.888 Y108.810 E2.13851 ; support material
G1 X94.380 Y109.301 E2.15582 ; support material
G1 X94.999 Y109.617 E2.17313 ; support material
G1 X95.686 Y109.726 E2.19045 ; support material
G1 X96.372 Y109.617 E2.20776 ; support material
G1 X96.991 Y109.301 E2.22507 ; support material
G1 X97.483 Y108.810 E2.24239 ; support material
G1 X97.798 Y108.191 E2.25970 ; support material
G1 X97.907 Y107.504 E2.27701 ; support material
G1 X97.798 Y106.818 E2.29433 ; support material
G1 X97.483 Y106.198 E2.31164 ; support material
G1 X96.991 Y105.707 E2.32895 ; support material
G1 X96.372 Y105.391 E2.34627 ; support material
G1 Z2.150 F7800.000 ; move to next layer (12)
G1 E0.34627 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F742.096
G1 X99.471 Y100.529 E2.02853 ; small perimeter
G1 X99.471 Y99.471 E2.05706 ; small perimeter
G1 X100.529 Y99.471 E2.08558 ; small perimeter
G1 X100.529 Y100.454 E2.11209 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F742.096
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
G1 X103.879 Y105.119 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2968.385
G1 X103.227 Y104.882 E2.01727 ; support material
G1 X102.534 Y104.882 E2.03455 ; support material
G1 X101.882 Y105.119 E2.05182 ; support material
G1 X101.351 Y105.565 E2.06910 ; support material
G1 X101.004 Y106.165 E2.08637 ; support material
G1 X100.883 Y106.848 E2.10364 ; support material
G1 X101.004 Y107.531 E2.12092 ; support material
G1 X101.351 Y108.132 E2.13819 ; support material
G1 X101.882 Y108.578 E2.15547 ; support material
G1 X102.534 Y108.815 E2.17274 ; support material
G1 X103.227 Y108.815 E2.19002 ; support material
G1 X103.879 Y108.578 E2.20729 ; support material
G1 X104.214 Y108.296 E2.21819 ; support material
G1 X104.732 Y109.459 E2.24990 ; support material
G1 X103.721 Y109.582 E2.27527 ; support material
G1 X103.203 Y109.939 E2.29092 ; support material
G1 X102.911 Y110.496 E2.30658 ; support material
G1 X102.911 Y111.124 E2.32223 ; support material
G1 X103.203 Y111.681 E2.33789 ; support material
G1 X103.721 Y112.038 E2.35354 ; support material
G1 X104.344 Y112.113 E2.36920 ; support material
G1 X104.932 Y111.890 E2.38485 ; support material
G1 X105.499 Y111.251 E2.40614 ; support material
G1 X106.071 Y111.526 E2.42195 ; support material
G1 X106.741 Y111.526 E2.43864 ; support material
G1 X107.344 Y111.235 E2.45532 ; support material
G1 X107.762 Y110.712 E2.47201 ; support material
G1 X107.911 Y110.059 E2.48870 ; support material
G1 X107.762 Y109.406 E2.50538 ; support material
G1 X107.349 Y108.888 E2.52186 ; support material
G1 X107.493 Y108.213 E2.53907 ; support material
G1 X107.354 Y107.561 E2.55565 ; support material
G1 X106.963 Y107.023 E2.57224 ; support material
G1 X106.386 Y106.690 E2.58883 ; support material
G1 X105.724 Y106.620 E2.60542 ; support material
G1 X104.885 Y106.893 E2.62740 ; support material
G1 X104.757 Y106.165 E2.64579 ; support material
G1 X104.410 Y105.565 E2.66306 ; support material
G1 X103.879 Y105.119 E2.68034 ; support material
G1 E0.68034 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X107.819 Y101.953 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2968.385
G1 X107.105 Y101.894 E2.01785 ; support material
G1 X106.410 Y102.070 E2.03570 ; support material
G1 X105.810 Y102.461 E2.05354 ; support material
G1 X105.370 Y103.027 E2.07139 ; support material
G1 X105.137 Y103.705 E2.08924 ; support material
G1 X105.137 Y104.421 E2.10709 ; support material
G1 X105.370 Y105.099 E2.12494 ; support material
G1 X105.810 Y105.664 E2.14279 ; support material
G1 X106.410 Y106.056 E2.16063 ; support material
G1 X107.105 Y106.232 E2.17848 ; support material
G1 X107.819 Y106.173 E2.19633 ; support material
G1 X108.475 Y105.885 E2.21418 ; support material
G1 X109.002 Y105.400 E2.23203 ; support material
G1 X109.343 Y104.770 E2.24987 ; support material
G1 X109.461 Y104.063 E2.26772 ; support material
G1 X109.343 Y103.356 E2.28557 ; support material
G1 X109.002 Y102.726 E2.30342 ; support material
G1 X108.475 Y102.241 E2.32127 ; support material
G1 X107.819 Y101.953 E2.33911 ; support material
G1 E0.33911 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X107.819 Y94.392 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2968.385
G1 X107.133 Y94.284 E2.01731 ; support material
G1 X106.446 Y94.392 E2.03463 ; support material
G1 X105.827 Y94.708 E2.05194 ; support material
G1 X105.335 Y95.199 E2.06925 ; support material
G1 X105.020 Y95.819 E2.08657 ; support material
G1 X104.911 Y96.505 E2.10388 ; support material
G1 X105.020 Y97.192 E2.12119 ; support material
G1 X105.335 Y97.811 E2.13851 ; support material
G1 X105.827 Y98.302 E2.15582 ; support material
G1 X106.446 Y98.618 E2.17313 ; support material
G1 X107.133 Y98.727 E2.19045 ; support material
G1 X107.819 Y98.618 E2.20776 ; support material
G1 X108.438 Y98.302 E2.22507 ; support material
G1 X108.930 Y97.811 E2.24239 ; support material
G1 X109.245 Y97.192 E2.25970 ; support material
G1 X109.354 Y96.505 E2.27701 ; support material
G1 X109.245 Y95.819 E2.29433 ; support material
G1 X108.930 Y95.199 E2.31164 ; support material
G1 X108.438 Y94.708 E2.32895 ; support material
G1 X107.819 Y94.392 E2.34627 ; support material
G1 E0.34627 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X107.277 Y89.153 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2968.385
G1 X106.561 Y89.094 E2.01789 ; support material
G1 X105.865 Y89.270 E2.03577 ; support material
G1 X105.264 Y89.663 E2.05366 ; support material
G1 X104.823 Y90.230 E2.07154 ; support material
G1 X104.590 Y90.909 E2.08943 ; support material
G1 X104.590 Y91.266 E2.09834 ; support material
G1 X104.168 Y91.368 E2.10914 ; support material
G1 X103.849 Y90.741 E2.12666 ; support material
G1 X103.358 Y90.250 E2.14397 ; support material
G1 X102.738 Y89.934 E2.16128 ; support material
G1 X102.052 Y89.825 E2.17860 ; support material
G1 X101.365 Y89.934 E2.19591 ; support material
G1 X100.746 Y90.250 E2.21322 ; support material
G1 X100.255 Y90.741 E2.23054 ; support material
G1 X99.939 Y91.360 E2.24785 ; support material
G1 X99.830 Y92.047 E2.26516 ; support material
G1 X99.939 Y92.733 E2.28248 ; support material
G1 X100.255 Y93.353 E2.29979 ; support material
G1 X100.746 Y93.844 E2.31710 ; support material
G1 X101.365 Y94.160 E2.33442 ; support material
G1 X102.052 Y94.269 E2.35173 ; support material
G1 X102.738 Y94.160 E2.36904 ; support material
G1 X103.358 Y93.844 E2.38636 ; support material
G1 X103.849 Y93.353 E2.40367 ; support material
G1 X104.165 Y92.733 E2.42098 ; support material
G1 X104.280 Y92.008 E2.43929 ; support material
G1 X104.708 Y91.970 E2.45000 ; support material
G1 X104.823 Y92.306 E2.45883 ; support material
G1 X105.264 Y92.872 E2.47672 ; support material
G1 X105.865 Y93.265 E2.49461 ; support material
G1 X106.561 Y93.441 E2.51249 ; support material
G1 X107.277 Y93.382 E2.53038 ; support material
G1 X107.935 Y93.094 E2.54826 ; support material
G1 X108.463 Y92.607 E2.56615 ; support material
G1 X108.805 Y91.976 E2.58403 ; support material
G1 X108.923 Y91.268 E2.60192 ; support material
G1 X108.805 Y90.559 E2.61980 ; support material
G1 X108.463 Y89.928 E2.63769 ; support material
G1 X107.935 Y89.442 E2.65557 ; support material
G1 X107.277 Y89.153 E2.67346 ; support material
G1 E0.67346 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.593 Y89.541 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2968.385
G1 X94.918 Y89.349 E2.01749 ; support material
G1 X94.219 Y89.414 E2.03497 ; support material
G1 X93.885 Y89.580 E2.04425 ; support material
G1 X93.531 Y89.510 E2.05326 ; support material
G1 X92.870 Y89.641 E2.07003 ; support material
G1 X92.311 Y90.015 E2.08680 ; support material
G1 X91.936 Y90.575 E2.10358 ; support material
G1 X91.805 Y91.235 E2.12035 ; support material
G1 X91.936 Y91.896 E2.13713 ; support material
G1 X92.311 Y92.456 E2.15390 ; support material
G1 X92.870 Y92.830 E2.17067 ; support material
G1 X93.531 Y92.961 E2.18745 ; support material
G1 X93.840 Y92.900 E2.19530 ; support material
G1 X94.219 Y93.089 E2.20584 ; support material
G1 X94.918 Y93.153 E2.22333 ; support material
G1 X95.593 Y92.961 E2.24081 ; support material
G1 X96.153 Y92.538 E2.25830 ; support material
G1 X96.523 Y91.941 E2.27579 ; support material
G1 X96.652 Y91.251 E2.29327 ; support material
G1 X96.523 Y90.561 E2.31076 ; support material
G1 X96.153 Y89.964 E2.32825 ; support material
G1 X95.593 Y89.541 E2.34573 ; support material
G1 E0.34573 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X96.371 Y95.007 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2968.385
G1 X95.786 Y94.725 E2.01618 ; support material
G1 X95.094 Y94.725 E2.03339 ; support material
G1 X94.472 Y95.025 E2.05061 ; support material
G1 X94.041 Y95.565 E2.06782 ; support material
G1 X93.941 Y96.003 E2.07900 ; support material
G1 X93.233 Y95.862 E2.09697 ; support material
G1 X92.580 Y95.992 E2.11356 ; support material
G1 X92.026 Y96.362 E2.13015 ; support material
G1 X91.656 Y96.916 E2.14674 ; support material
G1 X91.526 Y97.569 E2.16334 ; support material
G1 X91.656 Y98.222 E2.17993 ; support material
G1 X92.026 Y98.776 E2.19652 ; support material
G1 X92.580 Y99.146 E2.21311 ; support material
G1 X93.233 Y99.276 E2.22970 ; support material
G1 X93.384 Y99.246 E2.23352 ; support material
G1 X93.558 Y99.518 E2.24157 ; support material
G1 X94.111 Y99.770 E2.25670 ; support material
G1 X94.712 Y99.684 E2.27184 ; support material
G1 X95.172 Y99.286 E2.28697 ; support material
G1 X95.343 Y98.703 E2.30211 ; support material
G1 X95.064 Y97.753 E2.32677 ; support material
G1 X95.786 Y97.753 E2.34475 ; support material
G1 X96.408 Y97.453 E2.36196 ; support material
G1 X96.771 Y96.999 E2.37644 ; support material
G1 X97.245 Y96.930 E2.38839 ; support material
G1 X97.705 Y96.533 E2.40352 ; support material
G1 X97.876 Y95.950 E2.41866 ; support material
G1 X97.705 Y95.366 E2.43379 ; support material
G1 X97.245 Y94.969 E2.44893 ; support material
G1 X96.644 Y94.882 E2.46407 ; support material
G1 X96.371 Y95.007 E2.47155 ; support material
G1 E0.47155 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.903 Y101.199 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2968.385
G1 X91.250 Y101.069 E2.01659 ; support material
G1 X90.597 Y101.199 E2.03318 ; support material
G1 X90.043 Y101.569 E2.04977 ; support material
G1 X89.673 Y102.123 E2.06637 ; support material
G1 X89.543 Y102.776 E2.08296 ; support material
G1 X89.673 Y103.429 E2.09955 ; support material
G1 X90.043 Y103.983 E2.11614 ; support material
G1 X90.597 Y104.353 E2.13273 ; support material
G1 X91.250 Y104.483 E2.14932 ; support material
G1 X91.903 Y104.353 E2.16591 ; support material
G1 X92.457 Y103.983 E2.18251 ; support material
G1 X92.827 Y103.429 E2.19910 ; support material
G1 X92.957 Y102.776 E2.21569 ; support material
G1 X92.827 Y102.123 E2.23228 ; support material
G1 X92.457 Y101.569 E2.24887 ; support material
G1 X91.903 Y101.199 E2.26546 ; support material
G1 E0.26546 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.715 Y105.241 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2968.385
G1 X91.091 Y105.151 E2.01570 ; support material
G1 X90.517 Y105.413 E2.03140 ; support material
G1 X90.177 Y105.943 E2.04711 ; support material
G1 X90.177 Y106.574 E2.06281 ; support material
G1 X90.331 Y106.815 E2.06994 ; support material
G1 X90.177 Y107.055 E2.07707 ; support material
G1 X90.177 Y107.686 E2.09277 ; support material
G1 X90.517 Y108.216 E2.10847 ; support material
G1 X91.091 Y108.478 E2.12418 ; support material
G1 X91.715 Y108.388 E2.13988 ; support material
G1 X92.191 Y107.975 E2.15558 ; support material
G1 X92.369 Y107.371 E2.17128 ; support material
G1 X92.206 Y106.815 E2.18572 ; support material
G1 X92.369 Y106.259 E2.20015 ; support material
G1 X92.191 Y105.654 E2.21586 ; support material
G1 X91.715 Y105.241 E2.23156 ; support material
G1 E0.23156 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X96.675 Y105.476 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F2968.385
G1 X96.029 Y105.241 E2.01711 ; support material
G1 X95.342 Y105.241 E2.03423 ; support material
G1 X94.696 Y105.476 E2.05134 ; support material
G1 X94.170 Y105.918 E2.06845 ; support material
G1 X93.827 Y106.513 E2.08557 ; support material
G1 X93.707 Y107.190 E2.10268 ; support material
G1 X93.827 Y107.866 E2.11979 ; support material
G1 X94.170 Y108.461 E2.13691 ; support material
G1 X94.411 Y108.663 E2.14473 ; support material
G1 X94.411 Y109.098 E2.15558 ; support material
G1 X94.703 Y109.655 E2.17123 ; support material
G1 X95.220 Y110.012 E2.18689 ; support material
G1 X95.844 Y110.088 E2.20254 ; support material
G1 X96.431 Y109.865 E2.21820 ; support material
G1 X96.848 Y109.394 E2.23385 ; support material
G1 X96.999 Y108.784 E2.24951 ; support material
G1 X96.967 Y108.657 E2.25277 ; support material
G1 X97.201 Y108.461 E2.26036 ; support material
G1 X97.545 Y107.866 E2.27748 ; support material
G1 X97.664 Y107.190 E2.29459 ; support material
G1 X97.545 Y106.513 E2.31171 ; support material
G1 X97.201 Y105.918 E2.32882 ; support material
G1 X96.675 Y105.476 E2.34593 ; support material
G1 Z2.450 F7800.000 ; move to next layer (14)
G1 E0.34593 F2400.00000 ; retract extruder 0
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
G1 F772.989
G1 X99.471 Y100.529 E2.67276 ; small perimeter
G1 X99.471 Y99.471 E2.70129 ; small perimeter
G1 X100.529 Y99.471 E2.72982 ; small perimeter
G1 X100.529 Y100.454 E2.75632 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F772.989
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
G1 X103.583 Y105.012 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3091.954
G1 X102.931 Y104.775 E2.01727 ; support material
G1 X102.238 Y104.775 E2.03455 ; support material
G1 X101.586 Y105.012 E2.05182 ; support material
G1 X101.055 Y105.458 E2.06910 ; support material
G1 X100.708 Y106.058 E2.08637 ; support material
G1 X100.588 Y106.741 E2.10364 ; support material
G1 X100.708 Y107.424 E2.12092 ; support material
G1 X101.055 Y108.025 E2.13819 ; support material
G1 X101.586 Y108.470 E2.15547 ; support material
G1 X102.238 Y108.708 E2.17274 ; support material
G1 X102.931 Y108.708 E2.19002 ; support material
G1 X103.583 Y108.470 E2.20729 ; support material
G1 X104.135 Y108.007 E2.22526 ; support material
G1 X104.511 Y108.851 E2.24828 ; support material
G1 X105.006 Y109.297 E2.26486 ; support material
G1 X105.369 Y109.414 E2.27436 ; support material
G1 X105.134 Y109.709 E2.28374 ; support material
G1 X105.015 Y110.231 E2.29709 ; support material
G1 X104.623 Y109.789 E2.31180 ; support material
G1 X104.036 Y109.566 E2.32746 ; support material
G1 X103.412 Y109.642 E2.34311 ; support material
G1 X102.894 Y109.999 E2.35877 ; support material
G1 X102.602 Y110.556 E2.37442 ; support material
G1 X102.602 Y111.184 E2.39008 ; support material
G1 X102.894 Y111.741 E2.40573 ; support material
G1 X103.412 Y112.098 E2.42139 ; support material
G1 X104.036 Y112.173 E2.43704 ; support material
G1 X104.623 Y111.950 E2.45270 ; support material
G1 X105.285 Y111.204 E2.47755 ; support material
G1 X105.552 Y111.539 E2.48821 ; support material
G1 X106.155 Y111.829 E2.50490 ; support material
G1 X106.825 Y111.829 E2.52158 ; support material
G1 X107.429 Y111.539 E2.53827 ; support material
G1 X107.846 Y111.015 E2.55495 ; support material
G1 X107.995 Y110.362 E2.57164 ; support material
G1 X107.846 Y109.709 E2.58833 ; support material
G1 X107.429 Y109.185 E2.60501 ; support material
G1 X106.975 Y108.967 E2.61755 ; support material
G1 X107.270 Y108.561 E2.63004 ; support material
G1 X107.408 Y107.910 E2.64662 ; support material
G1 X107.270 Y107.258 E2.66321 ; support material
G1 X106.879 Y106.719 E2.67980 ; support material
G1 X106.302 Y106.386 E2.69639 ; support material
G1 X105.640 Y106.317 E2.71298 ; support material
G1 X105.006 Y106.523 E2.72957 ; support material
G1 X104.606 Y106.883 E2.74297 ; support material
G1 X104.461 Y106.058 E2.76383 ; support material
G1 X104.114 Y105.458 E2.78110 ; support material
G1 X103.583 Y105.012 E2.79838 ; support material
G1 E0.79838 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X107.931 Y101.659 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3091.954
G1 X107.217 Y101.600 E2.01785 ; support material
G1 X106.523 Y101.776 E2.03570 ; support material
G1 X105.923 Y102.168 E2.05354 ; support material
G1 X105.483 Y102.733 E2.07139 ; support material
G1 X105.250 Y103.411 E2.08924 ; support material
G1 X105.250 Y104.127 E2.10709 ; support material
G1 X105.483 Y104.805 E2.12494 ; support material
G1 X105.923 Y105.371 E2.14279 ; support material
G1 X106.523 Y105.762 E2.16063 ; support material
G1 X107.217 Y105.938 E2.17848 ; support material
G1 X107.931 Y105.879 E2.19633 ; support material
G1 X108.588 Y105.591 E2.21418 ; support material
G1 X109.115 Y105.106 E2.23203 ; support material
G1 X109.456 Y104.476 E2.24987 ; support material
G1 X109.574 Y103.769 E2.26772 ; support material
G1 X109.456 Y103.062 E2.28557 ; support material
G1 X109.115 Y102.432 E2.30342 ; support material
G1 X108.588 Y101.947 E2.32127 ; support material
G1 X107.931 Y101.659 E2.33911 ; support material
G1 E0.33911 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X107.795 Y94.706 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3091.954
G1 X107.108 Y94.597 E2.01731 ; support material
G1 X106.422 Y94.706 E2.03463 ; support material
G1 X105.802 Y95.022 E2.05194 ; support material
G1 X105.311 Y95.513 E2.06925 ; support material
G1 X104.995 Y96.132 E2.08657 ; support material
G1 X104.887 Y96.819 E2.10388 ; support material
G1 X104.995 Y97.505 E2.12119 ; support material
G1 X105.311 Y98.125 E2.13851 ; support material
G1 X105.802 Y98.616 E2.15582 ; support material
G1 X106.422 Y98.932 E2.17313 ; support material
G1 X107.108 Y99.040 E2.19045 ; support material
G1 X107.795 Y98.932 E2.20776 ; support material
G1 X108.414 Y98.616 E2.22507 ; support material
G1 X108.906 Y98.125 E2.24239 ; support material
G1 X109.221 Y97.505 E2.25970 ; support material
G1 X109.330 Y96.819 E2.27701 ; support material
G1 X109.221 Y96.132 E2.29433 ; support material
G1 X108.906 Y95.513 E2.31164 ; support material
G1 X108.414 Y95.022 E2.32895 ; support material
G1 X107.795 Y94.706 E2.34627 ; support material
G1 E0.34627 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X108.447 Y90.124 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3091.954
G1 X107.863 Y89.843 E2.01616 ; support material
G1 X107.214 Y89.843 E2.03231 ; support material
G1 X106.977 Y89.957 E2.03887 ; support material
G1 X106.751 Y89.848 E2.04512 ; support material
G1 X106.103 Y89.848 E2.06127 ; support material
G1 X105.518 Y90.130 E2.07743 ; support material
G1 X105.114 Y90.637 E2.09359 ; support material
G1 X104.969 Y91.269 E2.10974 ; support material
G1 X105.114 Y91.902 E2.12590 ; support material
G1 X105.518 Y92.409 E2.14206 ; support material
G1 X106.103 Y92.690 E2.15821 ; support material
G1 X106.751 Y92.690 E2.17437 ; support material
G1 X106.989 Y92.576 E2.18093 ; support material
G1 X107.214 Y92.685 E2.18717 ; support material
G1 X107.863 Y92.685 E2.20333 ; support material
G1 X108.447 Y92.403 E2.21949 ; support material
G1 X108.852 Y91.896 E2.23564 ; support material
G1 X108.996 Y91.264 E2.25180 ; support material
G1 X108.852 Y90.631 E2.26796 ; support material
G1 X108.447 Y90.124 E2.28411 ; support material
G1 E0.28411 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X102.429 Y89.989 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3091.954
G1 X101.742 Y89.880 E2.01731 ; support material
G1 X101.056 Y89.989 E2.03463 ; support material
G1 X100.436 Y90.305 E2.05194 ; support material
G1 X99.945 Y90.796 E2.06925 ; support material
G1 X99.629 Y91.416 E2.08657 ; support material
G1 X99.520 Y92.102 E2.10388 ; support material
G1 X99.629 Y92.789 E2.12119 ; support material
G1 X99.945 Y93.408 E2.13851 ; support material
G1 X100.436 Y93.899 E2.15582 ; support material
G1 X101.056 Y94.215 E2.17313 ; support material
G1 X101.742 Y94.324 E2.19045 ; support material
G1 X102.429 Y94.215 E2.20776 ; support material
G1 X103.048 Y93.899 E2.22507 ; support material
G1 X103.539 Y93.408 E2.24239 ; support material
G1 X103.855 Y92.789 E2.25970 ; support material
G1 X103.964 Y92.102 E2.27701 ; support material
G1 X103.855 Y91.416 E2.29433 ; support material
G1 X103.539 Y90.796 E2.31164 ; support material
G1 X103.048 Y90.305 E2.32895 ; support material
G1 X102.429 Y89.989 E2.34627 ; support material
G1 E0.34627 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.908 Y89.545 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3091.954
G1 X95.233 Y89.353 E2.01749 ; support material
G1 X94.534 Y89.418 E2.03497 ; support material
G1 X93.970 Y89.699 E2.05066 ; support material
G1 X93.877 Y89.637 E2.05345 ; support material
G1 X93.216 Y89.505 E2.07022 ; support material
G1 X92.556 Y89.637 E2.08699 ; support material
G1 X91.996 Y90.011 E2.10377 ; support material
G1 X91.622 Y90.571 E2.12054 ; support material
G1 X91.490 Y91.231 E2.13732 ; support material
G1 X91.622 Y91.892 E2.15409 ; support material
G1 X91.996 Y92.452 E2.17087 ; support material
G1 X92.556 Y92.826 E2.18764 ; support material
G1 X93.216 Y92.957 E2.20441 ; support material
G1 X93.963 Y92.809 E2.22338 ; support material
G1 X94.534 Y93.093 E2.23925 ; support material
G1 X95.233 Y93.157 E2.25674 ; support material
G1 X95.908 Y92.965 E2.27423 ; support material
G1 X96.468 Y92.542 E2.29171 ; support material
G1 X96.838 Y91.945 E2.30920 ; support material
G1 X96.967 Y91.255 E2.32669 ; support material
G1 X96.838 Y90.565 E2.34417 ; support material
G1 X96.468 Y89.968 E2.36166 ; support material
G1 X95.908 Y89.545 E2.37914 ; support material
G1 E0.37914 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X96.394 Y95.018 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3091.954
G1 X95.786 Y94.725 E2.01681 ; support material
G1 X95.094 Y94.725 E2.03402 ; support material
G1 X94.472 Y95.025 E2.05124 ; support material
G1 X94.041 Y95.565 E2.06845 ; support material
G1 X93.983 Y95.820 E2.07497 ; support material
G1 X93.022 Y95.629 E2.09937 ; support material
G1 X92.368 Y95.759 E2.11597 ; support material
G1 X91.815 Y96.129 E2.13256 ; support material
G1 X91.444 Y96.683 E2.14915 ; support material
G1 X91.315 Y97.336 E2.16574 ; support material
G1 X91.444 Y97.989 E2.18233 ; support material
G1 X91.815 Y98.543 E2.19892 ; support material
G1 X92.368 Y98.913 E2.21551 ; support material
G1 X93.022 Y99.043 E2.23211 ; support material
G1 X93.442 Y98.960 E2.24278 ; support material
G1 X93.633 Y99.548 E2.25819 ; support material
G1 X94.154 Y99.927 E2.27424 ; support material
G1 X94.798 Y99.927 E2.29028 ; support material
G1 X95.319 Y99.548 E2.30632 ; support material
G1 X95.518 Y98.936 E2.32236 ; support material
G1 X95.319 Y98.323 E2.33841 ; support material
G1 X95.058 Y98.133 E2.34647 ; support material
G1 X95.181 Y97.753 E2.35642 ; support material
G1 X95.786 Y97.753 E2.37148 ; support material
G1 X96.408 Y97.453 E2.38869 ; support material
G1 X96.817 Y96.941 E2.40502 ; support material
G1 X97.119 Y96.941 E2.41256 ; support material
G1 X97.641 Y96.562 E2.42860 ; support material
G1 X97.840 Y95.950 E2.44465 ; support material
G1 X97.641 Y95.337 E2.46069 ; support material
G1 X97.119 Y94.958 E2.47673 ; support material
G1 X96.475 Y94.958 E2.49277 ; support material
G1 X96.394 Y95.018 E2.49529 ; support material
G1 E0.49529 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.903 Y100.884 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3091.954
G1 X91.250 Y100.754 E2.01659 ; support material
G1 X90.597 Y100.884 E2.03318 ; support material
G1 X90.043 Y101.254 E2.04977 ; support material
G1 X89.673 Y101.808 E2.06637 ; support material
G1 X89.543 Y102.461 E2.08296 ; support material
G1 X89.673 Y103.114 E2.09955 ; support material
G1 X90.043 Y103.668 E2.11614 ; support material
G1 X90.597 Y104.038 E2.13273 ; support material
G1 X91.250 Y104.168 E2.14932 ; support material
G1 X91.903 Y104.038 E2.16591 ; support material
G1 X92.457 Y103.668 E2.18251 ; support material
G1 X92.827 Y103.114 E2.19910 ; support material
G1 X92.957 Y102.461 E2.21569 ; support material
G1 X92.827 Y101.808 E2.23228 ; support material
G1 X92.457 Y101.254 E2.24887 ; support material
G1 X91.903 Y100.884 E2.26546 ; support material
G1 E0.26546 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.715 Y104.926 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3091.954
G1 X91.091 Y104.836 E2.01570 ; support material
G1 X90.517 Y105.098 E2.03140 ; support material
G1 X90.177 Y105.629 E2.04711 ; support material
G1 X90.177 Y106.259 E2.06281 ; support material
G1 X90.534 Y106.815 E2.07926 ; support material
G1 X90.177 Y107.370 E2.09570 ; support material
G1 X90.177 Y108.000 E2.11141 ; support material
G1 X90.517 Y108.531 E2.12711 ; support material
G1 X91.091 Y108.793 E2.14281 ; support material
G1 X91.715 Y108.703 E2.15851 ; support material
G1 X92.191 Y108.290 E2.17422 ; support material
G1 X92.369 Y107.685 E2.18992 ; support material
G1 X92.191 Y107.080 E2.20562 ; support material
G1 X91.884 Y106.815 E2.21573 ; support material
G1 X92.191 Y106.549 E2.22584 ; support material
G1 X92.369 Y105.944 E2.24154 ; support material
G1 X92.191 Y105.339 E2.25725 ; support material
G1 X91.715 Y104.926 E2.27295 ; support material
G1 E0.27295 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X96.675 Y105.162 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3091.954
G1 X96.029 Y104.927 E2.01711 ; support material
G1 X95.342 Y104.927 E2.03423 ; support material
G1 X94.696 Y105.162 E2.05134 ; support material
G1 X94.170 Y105.603 E2.06845 ; support material
G1 X93.827 Y106.198 E2.08557 ; support material
G1 X93.707 Y106.875 E2.10268 ; support material
G1 X93.827 Y107.551 E2.11979 ; support material
G1 X94.170 Y108.146 E2.13691 ; support material
G1 X94.570 Y108.482 E2.14990 ; support material
G1 X94.411 Y108.785 E2.15842 ; support material
G1 X94.411 Y109.413 E2.17408 ; support material
G1 X94.703 Y109.970 E2.18973 ; support material
G1 X95.220 Y110.327 E2.20539 ; support material
G1 X95.844 Y110.402 E2.22104 ; support material
G1 X96.431 Y110.180 E2.23670 ; support material
G1 X96.848 Y109.709 E2.25235 ; support material
G1 X96.999 Y109.099 E2.26801 ; support material
G1 X96.839 Y108.450 E2.28464 ; support material
G1 X97.201 Y108.146 E2.29642 ; support material
G1 X97.545 Y107.551 E2.31353 ; support material
G1 X97.664 Y106.875 E2.33065 ; support material
G1 X97.545 Y106.198 E2.34776 ; support material
G1 X97.201 Y105.603 E2.36488 ; support material
G1 X96.675 Y105.162 E2.38199 ; support material
G1 Z3.050 F7800.000 ; move to next layer (17)
G1 E0.38199 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F833.558
G1 X99.471 Y100.529 E2.02853 ; small perimeter
G1 X99.471 Y99.471 E2.05706 ; small perimeter
G1 X100.529 Y99.471 E2.08558 ; small perimeter
G1 X100.529 Y100.454 E2.11209 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F833.558
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
G1 X103.290 Y104.896 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3334.233
G1 X102.639 Y104.658 E2.01727 ; support material
G1 X101.945 Y104.658 E2.03455 ; support material
G1 X101.294 Y104.896 E2.05182 ; support material
G1 X100.762 Y105.341 E2.06910 ; support material
G1 X100.416 Y105.942 E2.08637 ; support material
G1 X100.295 Y106.625 E2.10364 ; support material
G1 X100.416 Y107.308 E2.12092 ; support material
G1 X100.762 Y107.908 E2.13819 ; support material
G1 X101.294 Y108.354 E2.15547 ; support material
G1 X101.945 Y108.591 E2.17274 ; support material
G1 X102.639 Y108.591 E2.19002 ; support material
G1 X103.290 Y108.354 E2.20729 ; support material
G1 X103.822 Y107.908 E2.22456 ; support material
G1 X104.143 Y107.352 E2.24056 ; support material
G1 X104.159 Y107.360 E2.24101 ; support material
G1 X104.289 Y106.625 E2.25959 ; support material
G1 X104.168 Y105.942 E2.27687 ; support material
G1 X103.822 Y105.341 E2.29414 ; support material
G1 X103.290 Y104.896 E2.31142 ; support material
G1 E0.31142 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.078 Y107.135 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3334.233
G1 X105.804 Y106.937 E2.00843 ; support material
G1 X105.181 Y106.937 E2.02395 ; support material
G1 X104.432 Y107.481 E2.04702 ; support material
G1 X104.595 Y107.554 E2.05148 ; support material
G1 X104.484 Y107.896 E2.06043 ; support material
G1 X104.677 Y108.488 E2.07595 ; support material
G1 X105.181 Y108.855 E2.09148 ; support material
G1 X105.891 Y108.855 E2.10916 ; support material
G1 X105.989 Y109.282 E2.12009 ; support material
G1 X105.538 Y109.499 E2.13254 ; support material
G1 X105.120 Y110.023 E2.14923 ; support material
G1 X104.992 Y110.584 E2.16355 ; support material
G1 X104.309 Y109.813 E2.18921 ; support material
G1 X103.722 Y109.590 E2.20486 ; support material
G1 X103.098 Y109.666 E2.22052 ; support material
G1 X102.581 Y110.023 E2.23617 ; support material
G1 X102.289 Y110.579 E2.25183 ; support material
G1 X102.289 Y111.207 E2.26748 ; support material
G1 X102.581 Y111.764 E2.28314 ; support material
G1 X103.098 Y112.121 E2.29879 ; support material
G1 X103.722 Y112.197 E2.31445 ; support material
G1 X104.309 Y111.974 E2.33010 ; support material
G1 X104.726 Y111.503 E2.34575 ; support material
G1 X104.852 Y110.993 E2.35886 ; support material
G1 X105.538 Y111.853 E2.38626 ; support material
G1 X106.142 Y112.144 E2.40295 ; support material
G1 X106.811 Y112.144 E2.41963 ; support material
G1 X107.415 Y111.853 E2.43632 ; support material
G1 X107.833 Y111.329 E2.45300 ; support material
G1 X107.982 Y110.676 E2.46969 ; support material
G1 X107.833 Y110.023 E2.48638 ; support material
G1 X107.415 Y109.499 E2.50306 ; support material
G1 X106.617 Y109.115 E2.52514 ; support material
G1 X107.412 Y108.537 E2.54961 ; support material
G1 X107.604 Y107.945 E2.56514 ; support material
G1 X107.412 Y107.352 E2.58066 ; support material
G1 X106.907 Y106.986 E2.59618 ; support material
G1 X106.284 Y106.986 E2.61171 ; support material
G1 X106.078 Y107.135 E2.61806 ; support material
G1 E0.61806 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X107.991 Y101.350 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3334.233
G1 X107.277 Y101.291 E2.01785 ; support material
G1 X106.582 Y101.467 E2.03570 ; support material
G1 X105.982 Y101.859 E2.05354 ; support material
G1 X105.542 Y102.424 E2.07139 ; support material
G1 X105.309 Y103.102 E2.08924 ; support material
G1 X105.309 Y103.818 E2.10709 ; support material
G1 X105.542 Y104.496 E2.12494 ; support material
G1 X105.982 Y105.062 E2.14279 ; support material
G1 X106.582 Y105.453 E2.16063 ; support material
G1 X107.277 Y105.629 E2.17848 ; support material
G1 X107.991 Y105.570 E2.19633 ; support material
G1 X108.647 Y105.282 E2.21418 ; support material
G1 X109.174 Y104.797 E2.23203 ; support material
G1 X109.515 Y104.167 E2.24987 ; support material
G1 X109.633 Y103.460 E2.26772 ; support material
G1 X109.515 Y102.753 E2.28557 ; support material
G1 X109.174 Y102.123 E2.30342 ; support material
G1 X108.647 Y101.638 E2.32127 ; support material
G1 X107.991 Y101.350 E2.33911 ; support material
G1 E0.33911 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X107.753 Y95.018 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3334.233
G1 X107.066 Y94.909 E2.01731 ; support material
G1 X106.380 Y95.018 E2.03463 ; support material
G1 X105.761 Y95.333 E2.05194 ; support material
G1 X105.269 Y95.825 E2.06925 ; support material
G1 X104.954 Y96.444 E2.08657 ; support material
G1 X104.845 Y97.131 E2.10388 ; support material
G1 X104.954 Y97.817 E2.12119 ; support material
G1 X105.269 Y98.437 E2.13851 ; support material
G1 X105.761 Y98.928 E2.15582 ; support material
G1 X106.380 Y99.244 E2.17313 ; support material
G1 X107.066 Y99.352 E2.19045 ; support material
G1 X107.753 Y99.244 E2.20776 ; support material
G1 X108.372 Y98.928 E2.22507 ; support material
G1 X108.864 Y98.437 E2.24239 ; support material
G1 X109.179 Y97.817 E2.25970 ; support material
G1 X109.288 Y97.131 E2.27701 ; support material
G1 X109.179 Y96.444 E2.29433 ; support material
G1 X108.864 Y95.825 E2.31164 ; support material
G1 X108.372 Y95.333 E2.32895 ; support material
G1 X107.753 Y95.018 E2.34627 ; support material
G1 E0.34627 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X108.762 Y90.123 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3334.233
G1 X108.178 Y89.841 E2.01616 ; support material
G1 X107.529 Y89.841 E2.03231 ; support material
G1 X106.974 Y90.109 E2.04766 ; support material
G1 X106.437 Y89.850 E2.06252 ; support material
G1 X105.788 Y89.850 E2.07867 ; support material
G1 X105.204 Y90.131 E2.09483 ; support material
G1 X104.799 Y90.638 E2.11099 ; support material
G1 X104.655 Y91.271 E2.12714 ; support material
G1 X104.799 Y91.903 E2.14330 ; support material
G1 X105.204 Y92.410 E2.15945 ; support material
G1 X105.788 Y92.692 E2.17561 ; support material
G1 X106.437 Y92.692 E2.19177 ; support material
G1 X106.992 Y92.424 E2.20712 ; support material
G1 X107.529 Y92.683 E2.22197 ; support material
G1 X108.178 Y92.683 E2.23813 ; support material
G1 X108.762 Y92.402 E2.25428 ; support material
G1 X109.166 Y91.895 E2.27044 ; support material
G1 X109.311 Y91.262 E2.28660 ; support material
G1 X109.166 Y90.630 E2.30275 ; support material
G1 X108.762 Y90.123 E2.31891 ; support material
G1 E0.31891 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X102.119 Y90.048 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3334.233
G1 X101.433 Y89.939 E2.01731 ; support material
G1 X100.746 Y90.048 E2.03463 ; support material
G1 X100.127 Y90.364 E2.05194 ; support material
G1 X99.636 Y90.855 E2.06925 ; support material
G1 X99.320 Y91.474 E2.08657 ; support material
G1 X99.211 Y92.161 E2.10388 ; support material
G1 X99.320 Y92.847 E2.12119 ; support material
G1 X99.636 Y93.467 E2.13851 ; support material
G1 X100.127 Y93.958 E2.15582 ; support material
G1 X100.746 Y94.274 E2.17313 ; support material
G1 X101.433 Y94.382 E2.19045 ; support material
G1 X102.119 Y94.274 E2.20776 ; support material
G1 X102.739 Y93.958 E2.22507 ; support material
G1 X103.230 Y93.467 E2.24239 ; support material
G1 X103.546 Y92.847 E2.25970 ; support material
G1 X103.654 Y92.161 E2.27701 ; support material
G1 X103.546 Y91.474 E2.29433 ; support material
G1 X103.230 Y90.855 E2.31164 ; support material
G1 X102.739 Y90.364 E2.32895 ; support material
G1 X102.119 Y90.048 E2.34627 ; support material
G1 E0.34627 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X96.222 Y89.550 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3334.233
G1 X95.547 Y89.357 E2.01749 ; support material
G1 X94.848 Y89.422 E2.03497 ; support material
G1 X94.220 Y89.735 E2.05246 ; support material
G1 X94.029 Y89.945 E2.05952 ; support material
G1 X93.562 Y89.633 E2.07350 ; support material
G1 X92.902 Y89.501 E2.09027 ; support material
G1 X92.241 Y89.633 E2.10705 ; support material
G1 X91.681 Y90.007 E2.12382 ; support material
G1 X91.307 Y90.567 E2.14060 ; support material
G1 X91.176 Y91.227 E2.15737 ; support material
G1 X91.307 Y91.888 E2.17414 ; support material
G1 X91.681 Y92.448 E2.19092 ; support material
G1 X92.241 Y92.822 E2.20769 ; support material
G1 X92.902 Y92.953 E2.22447 ; support material
G1 X93.562 Y92.822 E2.24124 ; support material
G1 X93.992 Y92.534 E2.25413 ; support material
G1 X94.220 Y92.784 E2.26254 ; support material
G1 X94.848 Y93.097 E2.28003 ; support material
G1 X95.547 Y93.162 E2.29751 ; support material
G1 X96.222 Y92.969 E2.31500 ; support material
G1 X96.783 Y92.546 E2.33248 ; support material
G1 X97.152 Y91.950 E2.34997 ; support material
G1 X97.281 Y91.259 E2.36746 ; support material
G1 X97.152 Y90.569 E2.38494 ; support material
G1 X96.783 Y89.973 E2.40243 ; support material
G1 X96.222 Y89.550 E2.41992 ; support material
G1 E0.41992 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X96.425 Y94.991 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3334.233
G1 X95.874 Y94.725 E2.01524 ; support material
G1 X95.183 Y94.725 E2.03245 ; support material
G1 X94.560 Y95.025 E2.04967 ; support material
G1 X94.129 Y95.565 E2.06688 ; support material
G1 X94.049 Y95.918 E2.07588 ; support material
G1 X93.463 Y95.526 E2.09343 ; support material
G1 X92.810 Y95.396 E2.11002 ; support material
G1 X92.157 Y95.526 E2.12661 ; support material
G1 X91.603 Y95.896 E2.14320 ; support material
G1 X91.233 Y96.450 E2.15980 ; support material
G1 X91.103 Y97.103 E2.17639 ; support material
G1 X91.233 Y97.757 E2.19298 ; support material
G1 X91.603 Y98.310 E2.20957 ; support material
G1 X92.157 Y98.681 E2.22616 ; support material
G1 X92.810 Y98.810 E2.24275 ; support material
G1 X93.864 Y98.601 E2.26952 ; support material
G1 X93.679 Y99.169 E2.28439 ; support material
G1 X93.872 Y99.761 E2.29992 ; support material
G1 X94.376 Y100.128 E2.31544 ; support material
G1 X94.999 Y100.128 E2.33096 ; support material
G1 X95.504 Y99.761 E2.34649 ; support material
G1 X95.696 Y99.169 E2.36201 ; support material
G1 X95.504 Y98.576 E2.37753 ; support material
G1 X94.999 Y98.210 E2.39306 ; support material
G1 X94.084 Y98.210 E2.41585 ; support material
G1 X94.387 Y97.757 E2.42942 ; support material
G1 X94.457 Y97.404 E2.43839 ; support material
G1 X95.183 Y97.753 E2.45845 ; support material
G1 X95.874 Y97.753 E2.47566 ; support material
G1 X96.497 Y97.453 E2.49288 ; support material
G1 X96.931 Y96.909 E2.51023 ; support material
G1 X97.109 Y96.909 E2.51466 ; support material
G1 X97.613 Y96.542 E2.53019 ; support material
G1 X97.806 Y95.950 E2.54571 ; support material
G1 X97.613 Y95.357 E2.56123 ; support material
G1 X97.109 Y94.991 E2.57675 ; support material
G1 X96.425 Y94.991 E2.59379 ; support material
G1 E0.59379 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.903 Y100.569 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3334.233
G1 X91.250 Y100.439 E2.01659 ; support material
G1 X90.597 Y100.569 E2.03318 ; support material
G1 X90.043 Y100.939 E2.04977 ; support material
G1 X89.673 Y101.493 E2.06637 ; support material
G1 X89.543 Y102.146 E2.08296 ; support material
G1 X89.673 Y102.800 E2.09955 ; support material
G1 X90.043 Y103.354 E2.11614 ; support material
G1 X90.597 Y103.724 E2.13273 ; support material
G1 X91.250 Y103.854 E2.14932 ; support material
G1 X91.903 Y103.724 E2.16591 ; support material
G1 X92.457 Y103.354 E2.18251 ; support material
G1 X92.827 Y102.800 E2.19910 ; support material
G1 X92.957 Y102.146 E2.21569 ; support material
G1 X92.827 Y101.493 E2.23228 ; support material
G1 X92.457 Y100.939 E2.24887 ; support material
G1 X91.903 Y100.569 E2.26546 ; support material
G1 E0.26546 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.715 Y104.612 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3334.233
G1 X91.091 Y104.522 E2.01570 ; support material
G1 X90.517 Y104.784 E2.03140 ; support material
G1 X90.177 Y105.314 E2.04711 ; support material
G1 X90.177 Y105.944 E2.06281 ; support material
G1 X90.517 Y106.475 E2.07851 ; support material
G1 X91.262 Y106.815 E2.09889 ; support material
G1 X90.517 Y107.154 E2.11927 ; support material
G1 X90.177 Y107.685 E2.13497 ; support material
G1 X90.177 Y108.315 E2.15067 ; support material
G1 X90.517 Y108.845 E2.16637 ; support material
G1 X91.091 Y109.107 E2.18207 ; support material
G1 X91.715 Y109.018 E2.19778 ; support material
G1 X92.191 Y108.605 E2.21348 ; support material
G1 X92.369 Y108.000 E2.22918 ; support material
G1 X92.191 Y107.395 E2.24488 ; support material
G1 X91.521 Y106.815 E2.26696 ; support material
G1 X92.191 Y106.234 E2.28904 ; support material
G1 X92.369 Y105.629 E2.30475 ; support material
G1 X92.191 Y105.024 E2.32045 ; support material
G1 X91.715 Y104.612 E2.33615 ; support material
G1 E0.33615 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X96.675 Y104.847 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3334.233
G1 X96.029 Y104.612 E2.01711 ; support material
G1 X95.342 Y104.612 E2.03423 ; support material
G1 X94.696 Y104.847 E2.05134 ; support material
G1 X94.170 Y105.289 E2.06845 ; support material
G1 X93.827 Y105.884 E2.08557 ; support material
G1 X93.707 Y106.560 E2.10268 ; support material
G1 X93.827 Y107.237 E2.11979 ; support material
G1 X94.170 Y107.832 E2.13691 ; support material
G1 X94.799 Y108.359 E2.15736 ; support material
G1 X94.411 Y109.099 E2.17817 ; support material
G1 X94.411 Y109.728 E2.19382 ; support material
G1 X94.703 Y110.284 E2.20948 ; support material
G1 X95.220 Y110.641 E2.22513 ; support material
G1 X95.844 Y110.717 E2.24079 ; support material
G1 X96.431 Y110.494 E2.25644 ; support material
G1 X96.848 Y110.024 E2.27210 ; support material
G1 X96.999 Y109.414 E2.28775 ; support material
G1 X96.848 Y108.803 E2.30341 ; support material
G1 X96.505 Y108.416 E2.31630 ; support material
G1 X97.201 Y107.832 E2.33894 ; support material
G1 X97.545 Y107.237 E2.35605 ; support material
G1 X97.664 Y106.560 E2.37316 ; support material
G1 X97.545 Y105.884 E2.39028 ; support material
G1 X97.201 Y105.289 E2.40739 ; support material
G1 X96.675 Y104.847 E2.42450 ; support material
G1 Z3.350 F7800.000 ; move to next layer (19)
G1 E0.42450 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F869.924
G1 X99.471 Y100.529 E2.02853 ; small perimeter
G1 X99.471 Y99.471 E2.05706 ; small perimeter
G1 X100.529 Y99.471 E2.08558 ; small perimeter
G1 X100.529 Y100.454 E2.11209 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F869.924
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
G1 X103.002 Y104.770 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3479.695
G1 X102.350 Y104.533 E2.01727 ; support material
G1 X101.657 Y104.533 E2.03455 ; support material
G1 X101.005 Y104.770 E2.05182 ; support material
G1 X100.474 Y105.216 E2.06910 ; support material
G1 X100.127 Y105.816 E2.08637 ; support material
G1 X100.007 Y106.499 E2.10364 ; support material
G1 X100.127 Y107.182 E2.12092 ; support material
G1 X100.474 Y107.783 E2.13819 ; support material
G1 X101.005 Y108.229 E2.15547 ; support material
G1 X101.657 Y108.466 E2.17274 ; support material
G1 X102.350 Y108.466 E2.19002 ; support material
G1 X103.002 Y108.229 E2.20729 ; support material
G1 X103.533 Y107.783 E2.22456 ; support material
G1 X103.880 Y107.182 E2.24184 ; support material
G1 X104.000 Y106.499 E2.25911 ; support material
G1 X103.880 Y105.816 E2.27639 ; support material
G1 X103.533 Y105.216 E2.29366 ; support material
G1 X103.002 Y104.770 E2.31093 ; support material
G1 E0.31093 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.097 Y107.404 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3479.695
G1 X105.479 Y106.955 E2.01902 ; support material
G1 X104.877 Y106.955 E2.03402 ; support material
G1 X104.390 Y107.309 E2.04902 ; support material
G1 X104.204 Y107.882 E2.06403 ; support material
G1 X104.390 Y108.455 E2.07903 ; support material
G1 X104.877 Y108.809 E2.09403 ; support material
G1 X105.479 Y108.809 E2.10904 ; support material
G1 X105.991 Y108.437 E2.12480 ; support material
G1 X106.609 Y108.885 E2.14381 ; support material
G1 X107.211 Y108.885 E2.15882 ; support material
G1 X107.699 Y108.531 E2.17382 ; support material
G1 X107.885 Y107.958 E2.18883 ; support material
G1 X107.699 Y107.386 E2.20383 ; support material
G1 X107.211 Y107.032 E2.21883 ; support material
G1 X106.609 Y107.032 E2.23384 ; support material
G1 X106.097 Y107.404 E2.24960 ; support material
G1 E0.24960 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X107.365 Y109.810 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3479.695
G1 X106.762 Y109.519 E2.01669 ; support material
G1 X106.092 Y109.519 E2.03337 ; support material
G1 X105.488 Y109.810 E2.05006 ; support material
G1 X105.071 Y110.334 E2.06674 ; support material
G1 X104.971 Y110.773 E2.07795 ; support material
G1 X104.536 Y110.776 E2.08878 ; support material
G1 X104.412 Y110.273 E2.10170 ; support material
G1 X103.995 Y109.802 E2.11736 ; support material
G1 X103.407 Y109.579 E2.13301 ; support material
G1 X102.783 Y109.655 E2.14867 ; support material
G1 X102.266 Y110.012 E2.16432 ; support material
G1 X101.974 Y110.569 E2.17998 ; support material
G1 X101.974 Y111.197 E2.19563 ; support material
G1 X102.266 Y111.754 E2.21129 ; support material
G1 X102.783 Y112.111 E2.22694 ; support material
G1 X103.407 Y112.186 E2.24260 ; support material
G1 X103.995 Y111.964 E2.25825 ; support material
G1 X104.412 Y111.493 E2.27391 ; support material
G1 X104.511 Y111.090 E2.28426 ; support material
G1 X104.946 Y111.093 E2.29509 ; support material
G1 X105.071 Y111.640 E2.30906 ; support material
G1 X105.488 Y112.164 E2.32575 ; support material
G1 X106.092 Y112.454 E2.34243 ; support material
G1 X106.762 Y112.454 E2.35912 ; support material
G1 X107.365 Y112.164 E2.37580 ; support material
G1 X107.783 Y111.640 E2.39249 ; support material
G1 X107.932 Y110.987 E2.40917 ; support material
G1 X107.783 Y110.334 E2.42586 ; support material
G1 X107.365 Y109.810 E2.44254 ; support material
G1 E0.44254 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X108.033 Y102.206 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3479.695
G1 X107.485 Y101.943 E2.01515 ; support material
G1 X106.799 Y101.943 E2.03224 ; support material
G1 X106.181 Y102.240 E2.04933 ; support material
G1 X105.753 Y102.777 E2.06642 ; support material
G1 X105.600 Y103.446 E2.08351 ; support material
G1 X105.753 Y104.115 E2.10061 ; support material
G1 X106.181 Y104.651 E2.11770 ; support material
G1 X106.799 Y104.949 E2.13479 ; support material
G1 X107.485 Y104.949 E2.15188 ; support material
G1 X107.852 Y104.772 E2.16202 ; support material
G1 X108.503 Y104.851 E2.17834 ; support material
G1 X109.111 Y104.620 E2.19457 ; support material
G1 X109.543 Y104.133 E2.21079 ; support material
G1 X109.699 Y103.500 E2.22702 ; support material
G1 X109.543 Y102.868 E2.24324 ; support material
G1 X109.111 Y102.380 E2.25946 ; support material
G1 X108.503 Y102.149 E2.27569 ; support material
G1 X108.033 Y102.206 E2.28747 ; support material
G1 E0.28747 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X107.442 Y95.424 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3479.695
G1 X106.756 Y95.287 E2.01743 ; support material
G1 X106.070 Y95.424 E2.03486 ; support material
G1 X105.488 Y95.813 E2.05229 ; support material
G1 X105.099 Y96.394 E2.06972 ; support material
G1 X104.962 Y97.081 E2.08715 ; support material
G1 X105.099 Y97.767 E2.10458 ; support material
G1 X105.488 Y98.349 E2.12201 ; support material
G1 X106.070 Y98.737 E2.13944 ; support material
G1 X106.756 Y98.874 E2.15687 ; support material
G1 X107.442 Y98.737 E2.17430 ; support material
G1 X107.848 Y98.467 E2.18644 ; support material
G1 X108.353 Y98.602 E2.19947 ; support material
G1 X108.985 Y98.433 E2.21576 ; support material
G1 X109.447 Y97.970 E2.23206 ; support material
G1 X109.617 Y97.338 E2.24836 ; support material
G1 X109.447 Y96.706 E2.26465 ; support material
G1 X108.985 Y96.243 E2.28095 ; support material
G1 X108.353 Y96.074 E2.29724 ; support material
G1 X108.222 Y96.109 E2.30061 ; support material
G1 X108.024 Y95.813 E2.30950 ; support material
G1 X107.442 Y95.424 E2.32693 ; support material
G1 E0.32693 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X109.077 Y90.121 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3479.695
G1 X108.492 Y89.840 E2.01616 ; support material
G1 X107.844 Y89.840 E2.03231 ; support material
G1 X107.259 Y90.121 E2.04847 ; support material
G1 X106.978 Y90.474 E2.05970 ; support material
G1 X106.706 Y90.133 E2.07057 ; support material
G1 X106.122 Y89.852 E2.08672 ; support material
G1 X105.473 Y89.852 E2.10288 ; support material
G1 X104.889 Y90.133 E2.11903 ; support material
G1 X104.485 Y90.640 E2.13519 ; support material
G1 X104.340 Y91.272 E2.15135 ; support material
G1 X104.485 Y91.905 E2.16750 ; support material
G1 X104.889 Y92.412 E2.18366 ; support material
G1 X105.473 Y92.693 E2.19981 ; support material
G1 X106.122 Y92.693 E2.21597 ; support material
G1 X106.706 Y92.412 E2.23213 ; support material
G1 X106.988 Y92.059 E2.24336 ; support material
G1 X107.259 Y92.400 E2.25422 ; support material
G1 X107.844 Y92.681 E2.27038 ; support material
G1 X108.492 Y92.681 E2.28654 ; support material
G1 X109.077 Y92.400 E2.30269 ; support material
G1 X109.481 Y91.893 E2.31885 ; support material
G1 X109.625 Y91.261 E2.33500 ; support material
G1 X109.481 Y90.628 E2.35116 ; support material
G1 X109.077 Y90.121 E2.36732 ; support material
G1 E0.36732 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X102.434 Y90.117 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3479.695
G1 X101.782 Y89.880 E2.01727 ; support material
G1 X101.089 Y89.880 E2.03455 ; support material
G1 X100.437 Y90.117 E2.05182 ; support material
G1 X99.906 Y90.563 E2.06910 ; support material
G1 X99.559 Y91.163 E2.08637 ; support material
G1 X99.439 Y91.846 E2.10364 ; support material
G1 X99.559 Y92.529 E2.12092 ; support material
G1 X99.906 Y93.130 E2.13819 ; support material
G1 X100.437 Y93.575 E2.15547 ; support material
G1 X100.521 Y93.606 E2.15768 ; support material
G1 X100.634 Y93.953 E2.16678 ; support material
G1 X101.121 Y94.307 E2.18178 ; support material
G1 X101.723 Y94.307 E2.19679 ; support material
G1 X102.211 Y93.953 E2.21179 ; support material
G1 X102.320 Y93.617 E2.22060 ; support material
G1 X102.434 Y93.575 E2.22363 ; support material
G1 X102.965 Y93.130 E2.24090 ; support material
G1 X103.312 Y92.529 E2.25818 ; support material
G1 X103.433 Y91.846 E2.27545 ; support material
G1 X103.312 Y91.163 E2.29272 ; support material
G1 X102.965 Y90.563 E2.31000 ; support material
G1 X102.434 Y90.117 E2.32727 ; support material
G1 E0.32727 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X96.537 Y89.554 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3479.695
G1 X95.862 Y89.362 E2.01749 ; support material
G1 X95.163 Y89.426 E2.03497 ; support material
G1 X94.534 Y89.739 E2.05246 ; support material
G1 X94.013 Y90.311 E2.07173 ; support material
G1 X93.807 Y90.003 E2.08096 ; support material
G1 X93.247 Y89.629 E2.09773 ; support material
G1 X92.587 Y89.497 E2.11451 ; support material
G1 X91.927 Y89.629 E2.13128 ; support material
G1 X91.367 Y90.003 E2.14805 ; support material
G1 X90.992 Y90.563 E2.16483 ; support material
G1 X90.861 Y91.223 E2.18160 ; support material
G1 X90.992 Y91.884 E2.19838 ; support material
G1 X91.367 Y92.444 E2.21515 ; support material
G1 X91.927 Y92.818 E2.23192 ; support material
G1 X92.587 Y92.949 E2.24870 ; support material
G1 X93.247 Y92.818 E2.26547 ; support material
G1 X93.807 Y92.444 E2.28225 ; support material
G1 X93.982 Y92.182 E2.29008 ; support material
G1 X94.534 Y92.788 E2.31050 ; support material
G1 X95.163 Y93.101 E2.32799 ; support material
G1 X95.862 Y93.166 E2.34547 ; support material
G1 X96.537 Y92.974 E2.36296 ; support material
G1 X97.097 Y92.551 E2.38044 ; support material
G1 X97.467 Y91.954 E2.39793 ; support material
G1 X97.596 Y91.264 E2.41542 ; support material
G1 X97.467 Y90.574 E2.43290 ; support material
G1 X97.097 Y89.977 E2.45039 ; support material
G1 X96.537 Y89.554 E2.46788 ; support material
G1 E0.46788 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X97.586 Y95.377 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3479.695
G1 X97.099 Y95.023 E2.01500 ; support material
G1 X96.496 Y95.023 E2.03001 ; support material
G1 X96.230 Y95.216 E2.03821 ; support material
G1 X95.987 Y95.039 E2.04570 ; support material
G1 X95.384 Y95.039 E2.06070 ; support material
G1 X94.897 Y95.393 E2.07570 ; support material
G1 X94.725 Y95.924 E2.08960 ; support material
G1 X94.496 Y96.090 E2.09664 ; support material
G1 X94.268 Y96.791 E2.11500 ; support material
G1 X93.707 Y95.951 E2.14015 ; support material
G1 X93.153 Y95.581 E2.15674 ; support material
G1 X92.500 Y95.451 E2.17333 ; support material
G1 X91.847 Y95.581 E2.18993 ; support material
G1 X91.293 Y95.951 E2.20652 ; support material
G1 X90.923 Y96.505 E2.22311 ; support material
G1 X90.793 Y97.158 E2.23970 ; support material
G1 X90.923 Y97.812 E2.25629 ; support material
G1 X91.293 Y98.366 E2.27288 ; support material
G1 X91.847 Y98.736 E2.28947 ; support material
G1 X92.500 Y98.866 E2.30607 ; support material
G1 X93.153 Y98.736 E2.32266 ; support material
G1 X93.585 Y98.447 E2.33559 ; support material
G1 X93.630 Y98.481 E2.33699 ; support material
G1 X94.077 Y97.812 E2.35705 ; support material
G1 X94.230 Y97.043 E2.37658 ; support material
G1 X94.983 Y97.590 E2.39976 ; support material
G1 X95.586 Y97.590 E2.41477 ; support material
G1 X96.073 Y97.236 E2.42977 ; support material
G1 X96.248 Y96.696 E2.44390 ; support material
G1 X96.496 Y96.876 E2.45154 ; support material
G1 X97.099 Y96.876 E2.46654 ; support material
G1 X97.586 Y96.522 E2.48154 ; support material
G1 X97.772 Y95.950 E2.49655 ; support material
G1 X97.586 Y95.377 E2.51155 ; support material
G1 E0.51155 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.403 Y98.902 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3479.695
G1 X94.916 Y98.548 E2.01500 ; support material
G1 X94.314 Y98.548 E2.03001 ; support material
G1 X93.958 Y98.806 E2.04095 ; support material
G1 X93.882 Y98.732 E2.04360 ; support material
G1 X93.640 Y99.475 E2.06305 ; support material
G1 X93.826 Y100.048 E2.07805 ; support material
G1 X94.314 Y100.402 E2.09306 ; support material
G1 X94.916 Y100.402 E2.10806 ; support material
G1 X95.403 Y100.048 E2.12306 ; support material
G1 X95.590 Y99.475 E2.13807 ; support material
G1 X95.403 Y98.902 E2.15307 ; support material
G1 E0.15307 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.903 Y100.255 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3479.695
G1 X91.250 Y100.125 E2.01659 ; support material
G1 X90.597 Y100.255 E2.03318 ; support material
G1 X90.043 Y100.625 E2.04977 ; support material
G1 X89.673 Y101.179 E2.06637 ; support material
G1 X89.543 Y101.832 E2.08296 ; support material
G1 X89.673 Y102.485 E2.09955 ; support material
G1 X90.043 Y103.039 E2.11614 ; support material
G1 X90.597 Y103.409 E2.13273 ; support material
G1 X91.250 Y103.539 E2.14932 ; support material
G1 X91.903 Y103.409 E2.16591 ; support material
G1 X92.457 Y103.039 E2.18251 ; support material
G1 X92.827 Y102.485 E2.19910 ; support material
G1 X92.957 Y101.832 E2.21569 ; support material
G1 X92.827 Y101.179 E2.23228 ; support material
G1 X92.457 Y100.625 E2.24887 ; support material
G1 X91.903 Y100.255 E2.26546 ; support material
G1 E0.26546 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.715 Y104.297 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3479.695
G1 X91.091 Y104.207 E2.01570 ; support material
G1 X90.517 Y104.469 E2.03140 ; support material
G1 X90.177 Y104.999 E2.04711 ; support material
G1 X90.177 Y105.630 E2.06281 ; support material
G1 X90.517 Y106.160 E2.07851 ; support material
G1 X91.091 Y106.422 E2.09421 ; support material
G1 X91.715 Y106.332 E2.10992 ; support material
G1 X92.191 Y105.919 E2.12562 ; support material
G1 X92.369 Y105.315 E2.14132 ; support material
G1 X92.191 Y104.710 E2.15702 ; support material
G1 X91.715 Y104.297 E2.17272 ; support material
G1 E0.17272 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.715 Y107.297 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3479.695
G1 X91.091 Y107.207 E2.01570 ; support material
G1 X90.517 Y107.469 E2.03140 ; support material
G1 X90.177 Y107.999 E2.04711 ; support material
G1 X90.177 Y108.630 E2.06281 ; support material
G1 X90.517 Y109.160 E2.07851 ; support material
G1 X91.091 Y109.422 E2.09421 ; support material
G1 X91.715 Y109.332 E2.10992 ; support material
G1 X92.191 Y108.919 E2.12562 ; support material
G1 X92.369 Y108.315 E2.14132 ; support material
G1 X92.191 Y107.710 E2.15702 ; support material
G1 X91.715 Y107.297 E2.17272 ; support material
G1 E0.17272 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X96.675 Y104.532 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3479.695
G1 X96.029 Y104.297 E2.01711 ; support material
G1 X95.342 Y104.297 E2.03423 ; support material
G1 X94.696 Y104.532 E2.05134 ; support material
G1 X94.170 Y104.974 E2.06845 ; support material
G1 X93.827 Y105.569 E2.08557 ; support material
G1 X93.707 Y106.246 E2.10268 ; support material
G1 X93.827 Y106.922 E2.11979 ; support material
G1 X94.170 Y107.517 E2.13691 ; support material
G1 X94.696 Y107.959 E2.15402 ; support material
G1 X95.553 Y108.271 E2.17673 ; support material
G1 X94.703 Y108.858 E2.20247 ; support material
G1 X94.411 Y109.414 E2.21812 ; support material
G1 X94.411 Y110.042 E2.23378 ; support material
G1 X94.703 Y110.599 E2.24943 ; support material
G1 X95.220 Y110.956 E2.26509 ; support material
G1 X95.844 Y111.032 E2.28074 ; support material
G1 X96.431 Y110.809 E2.29640 ; support material
G1 X96.848 Y110.338 E2.31205 ; support material
G1 X96.999 Y109.728 E2.32770 ; support material
G1 X96.848 Y109.118 E2.34336 ; support material
G1 X96.431 Y108.648 E2.35901 ; support material
G1 X95.624 Y108.341 E2.38053 ; support material
G1 X96.675 Y107.959 E2.40839 ; support material
G1 X97.201 Y107.517 E2.42550 ; support material
G1 X97.545 Y106.922 E2.44262 ; support material
G1 X97.664 Y106.246 E2.45973 ; support material
G1 X97.545 Y105.569 E2.47685 ; support material
G1 X97.201 Y104.974 E2.49396 ; support material
G1 X96.675 Y104.532 E2.51107 ; support material
G1 Z3.650 F7800.000 ; move to next layer (21)
G1 E0.51107 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F895.573
G1 X99.471 Y100.529 E2.02853 ; small perimeter
G1 X99.471 Y99.471 E2.05706 ; small perimeter
G1 X100.529 Y99.471 E2.08558 ; small perimeter
G1 X100.529 Y100.454 E2.11209 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F895.573
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
G1 X102.718 Y104.634 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3582.293
G1 X102.066 Y104.397 E2.01727 ; support material
G1 X101.373 Y104.397 E2.03455 ; support material
G1 X100.721 Y104.634 E2.05182 ; support material
G1 X100.190 Y105.080 E2.06910 ; support material
G1 X99.843 Y105.681 E2.08637 ; support material
G1 X99.723 Y106.363 E2.10364 ; support material
G1 X99.843 Y107.046 E2.12092 ; support material
G1 X100.190 Y107.647 E2.13819 ; support material
G1 X100.721 Y108.093 E2.15547 ; support material
G1 X101.373 Y108.330 E2.17274 ; support material
G1 X102.066 Y108.330 E2.19002 ; support material
G1 X102.718 Y108.093 E2.20729 ; support material
G1 X103.249 Y107.647 E2.22456 ; support material
G1 X103.596 Y107.046 E2.24184 ; support material
G1 X103.716 Y106.363 E2.25911 ; support material
G1 X103.596 Y105.681 E2.27639 ; support material
G1 X103.249 Y105.080 E2.29366 ; support material
G1 X102.718 Y104.634 E2.31093 ; support material
G1 E0.31093 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X105.625 Y107.315 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3582.293
G1 X105.155 Y106.973 E2.01448 ; support material
G1 X104.573 Y106.973 E2.02897 ; support material
G1 X104.103 Y107.315 E2.04345 ; support material
G1 X103.923 Y107.868 E2.05794 ; support material
G1 X104.103 Y108.421 E2.07242 ; support material
G1 X104.573 Y108.763 E2.08690 ; support material
G1 X105.155 Y108.763 E2.10139 ; support material
G1 X105.625 Y108.421 E2.11587 ; support material
G1 X105.805 Y107.868 E2.13036 ; support material
G1 X105.625 Y107.315 E2.14484 ; support material
G1 E0.14484 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X107.986 Y107.419 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3582.293
G1 X107.515 Y107.078 E2.01448 ; support material
G1 X106.934 Y107.078 E2.02897 ; support material
G1 X106.463 Y107.419 E2.04345 ; support material
G1 X106.284 Y107.972 E2.05794 ; support material
G1 X106.463 Y108.525 E2.07242 ; support material
G1 X106.934 Y108.867 E2.08690 ; support material
G1 X107.515 Y108.867 E2.10139 ; support material
G1 X107.986 Y108.525 E2.11587 ; support material
G1 X108.165 Y107.972 E2.13036 ; support material
G1 X107.986 Y107.419 E2.14484 ; support material
G1 E0.14484 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.673 Y110.286 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3582.293
G1 X106.403 Y110.090 E2.00832 ; support material
G1 X105.822 Y110.090 E2.02280 ; support material
G1 X105.351 Y110.432 E2.03729 ; support material
G1 X105.171 Y110.985 E2.05177 ; support material
G1 X105.351 Y111.538 E2.06626 ; support material
G1 X105.822 Y111.880 E2.08074 ; support material
G1 X106.403 Y111.880 E2.09522 ; support material
G1 X106.663 Y111.691 E2.10323 ; support material
G1 X106.933 Y111.887 E2.11155 ; support material
G1 X107.515 Y111.887 E2.12604 ; support material
G1 X107.985 Y111.545 E2.14052 ; support material
G1 X108.165 Y110.992 E2.15500 ; support material
G1 X107.985 Y110.439 E2.16949 ; support material
G1 X107.515 Y110.097 E2.18397 ; support material
G1 X106.933 Y110.097 E2.19846 ; support material
G1 X106.673 Y110.286 E2.20646 ; support material
G1 E0.20646 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.680 Y109.791 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3582.293
G1 X103.093 Y109.568 E2.01565 ; support material
G1 X102.469 Y109.644 E2.03131 ; support material
G1 X101.952 Y110.001 E2.04696 ; support material
G1 X101.660 Y110.558 E2.06262 ; support material
G1 X101.660 Y111.186 E2.07827 ; support material
G1 X101.952 Y111.743 E2.09393 ; support material
G1 X102.469 Y112.100 E2.10958 ; support material
G1 X103.093 Y112.175 E2.12524 ; support material
G1 X103.680 Y111.952 E2.14089 ; support material
G1 X104.097 Y111.482 E2.15655 ; support material
G1 X104.248 Y110.872 E2.17220 ; support material
G1 X104.097 Y110.262 E2.18786 ; support material
G1 X103.680 Y109.791 E2.20351 ; support material
G1 E0.20351 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X96.431 Y108.962 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3582.293
G1 X95.455 Y108.592 E2.02601 ; support material
G1 X95.455 Y108.787 E2.03086 ; support material
G1 X95.220 Y108.815 E2.03676 ; support material
G1 X94.703 Y109.172 E2.05241 ; support material
G1 X94.411 Y109.729 E2.06807 ; support material
G1 X94.411 Y110.357 E2.08372 ; support material
G1 X94.703 Y110.914 E2.09938 ; support material
G1 X95.220 Y111.271 E2.11503 ; support material
G1 X95.844 Y111.346 E2.13069 ; support material
G1 X96.431 Y111.124 E2.14634 ; support material
G1 X96.848 Y110.653 E2.16200 ; support material
G1 X96.999 Y110.043 E2.17765 ; support material
G1 X96.848 Y109.433 E2.19331 ; support material
G1 X96.431 Y108.962 E2.20896 ; support material
G1 E0.20896 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X96.431 Y104.850 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3582.293
G1 X95.844 Y104.627 E2.01565 ; support material
G1 X95.220 Y104.703 E2.03131 ; support material
G1 X94.703 Y105.060 E2.04696 ; support material
G1 X94.411 Y105.617 E2.06262 ; support material
G1 X94.411 Y106.245 E2.07827 ; support material
G1 X94.538 Y106.487 E2.08507 ; support material
G1 X94.411 Y106.729 E2.09188 ; support material
G1 X94.411 Y107.357 E2.10753 ; support material
G1 X94.703 Y107.914 E2.12319 ; support material
G1 X95.220 Y108.271 E2.13884 ; support material
G1 X95.455 Y108.299 E2.14474 ; support material
G1 X95.455 Y108.494 E2.14959 ; support material
G1 X96.431 Y108.124 E2.17560 ; support material
G1 X96.848 Y107.653 E2.19125 ; support material
G1 X96.999 Y107.043 E2.20691 ; support material
G1 X96.862 Y106.487 E2.22117 ; support material
G1 X96.999 Y105.931 E2.23544 ; support material
G1 X96.848 Y105.321 E2.25109 ; support material
G1 X96.431 Y104.850 E2.26675 ; support material
G1 E0.26675 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.715 Y104.612 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3582.293
G1 X91.091 Y104.522 E2.01570 ; support material
G1 X90.517 Y104.784 E2.03140 ; support material
G1 X90.177 Y105.314 E2.04711 ; support material
G1 X90.177 Y105.944 E2.06281 ; support material
G1 X90.517 Y106.475 E2.07851 ; support material
G1 X91.091 Y106.737 E2.09421 ; support material
G1 X91.715 Y106.647 E2.10992 ; support material
G1 X92.191 Y106.234 E2.12562 ; support material
G1 X92.369 Y105.629 E2.14132 ; support material
G1 X92.191 Y105.024 E2.15702 ; support material
G1 X91.715 Y104.612 E2.17272 ; support material
G1 E0.17272 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.715 Y107.612 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3582.293
G1 X91.091 Y107.522 E2.01570 ; support material
G1 X90.517 Y107.784 E2.03140 ; support material
G1 X90.177 Y108.314 E2.04711 ; support material
G1 X90.177 Y108.944 E2.06281 ; support material
G1 X90.517 Y109.475 E2.07851 ; support material
G1 X91.091 Y109.737 E2.09421 ; support material
G1 X91.715 Y109.647 E2.10992 ; support material
G1 X92.191 Y109.234 E2.12562 ; support material
G1 X92.369 Y108.629 E2.14132 ; support material
G1 X92.191 Y108.024 E2.15702 ; support material
G1 X91.715 Y107.612 E2.17272 ; support material
G1 E0.17272 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.715 Y100.499 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3582.293
G1 X91.091 Y100.410 E2.01570 ; support material
G1 X90.517 Y100.672 E2.03140 ; support material
G1 X90.177 Y101.202 E2.04711 ; support material
G1 X90.177 Y101.832 E2.06281 ; support material
G1 X90.331 Y102.073 E2.06994 ; support material
G1 X90.177 Y102.314 E2.07707 ; support material
G1 X90.177 Y102.944 E2.09277 ; support material
G1 X90.517 Y103.475 E2.10847 ; support material
G1 X91.091 Y103.737 E2.12418 ; support material
G1 X91.715 Y103.647 E2.13988 ; support material
G1 X92.191 Y103.234 E2.15558 ; support material
G1 X92.369 Y102.629 E2.17128 ; support material
G1 X92.206 Y102.073 E2.18572 ; support material
G1 X92.369 Y101.517 E2.20015 ; support material
G1 X92.191 Y100.912 E2.21586 ; support material
G1 X91.715 Y100.499 E2.23156 ; support material
G1 E0.23156 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.314 Y99.230 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3582.293
G1 X94.843 Y98.888 E2.01448 ; support material
G1 X94.262 Y98.888 E2.02897 ; support material
G1 X93.791 Y99.230 E2.04345 ; support material
G1 X93.612 Y99.783 E2.05794 ; support material
G1 X93.791 Y100.336 E2.07242 ; support material
G1 X94.262 Y100.678 E2.08690 ; support material
G1 X94.843 Y100.678 E2.10139 ; support material
G1 X95.314 Y100.336 E2.11587 ; support material
G1 X95.493 Y99.783 E2.13036 ; support material
G1 X95.314 Y99.230 E2.14484 ; support material
G1 E0.14484 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X97.559 Y95.396 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3582.293
G1 X97.088 Y95.055 E2.01448 ; support material
G1 X96.507 Y95.055 E2.02897 ; support material
G1 X96.230 Y95.256 E2.03749 ; support material
G1 X95.976 Y95.072 E2.04530 ; support material
G1 X95.395 Y95.072 E2.05978 ; support material
G1 X94.924 Y95.413 E2.07427 ; support material
G1 X94.745 Y95.966 E2.08875 ; support material
G1 X94.782 Y96.081 E2.09175 ; support material
G1 X94.366 Y96.383 E2.10454 ; support material
G1 X94.234 Y96.789 E2.11519 ; support material
G1 X93.810 Y96.764 E2.12578 ; support material
G1 X93.764 Y96.532 E2.13168 ; support material
G1 X93.394 Y95.978 E2.14827 ; support material
G1 X92.840 Y95.608 E2.16487 ; support material
G1 X92.187 Y95.478 E2.18146 ; support material
G1 X91.533 Y95.608 E2.19805 ; support material
G1 X90.980 Y95.978 E2.21464 ; support material
G1 X90.609 Y96.532 E2.23123 ; support material
G1 X90.480 Y97.185 E2.24782 ; support material
G1 X90.609 Y97.838 E2.26441 ; support material
G1 X90.980 Y98.392 E2.28101 ; support material
G1 X91.533 Y98.762 E2.29760 ; support material
G1 X92.187 Y98.892 E2.31419 ; support material
G1 X92.840 Y98.762 E2.33078 ; support material
G1 X93.394 Y98.392 E2.34737 ; support material
G1 X93.764 Y97.838 E2.36396 ; support material
G1 X93.872 Y97.297 E2.37772 ; support material
G1 X94.296 Y97.272 E2.38831 ; support material
G1 X94.366 Y97.489 E2.39400 ; support material
G1 X94.837 Y97.831 E2.40848 ; support material
G1 X95.418 Y97.831 E2.42297 ; support material
G1 X95.889 Y97.489 E2.43745 ; support material
G1 X96.176 Y96.604 E2.46062 ; support material
G1 X96.507 Y96.844 E2.47079 ; support material
G1 X97.088 Y96.844 E2.48528 ; support material
G1 X97.559 Y96.503 E2.49976 ; support material
G1 X97.738 Y95.950 E2.51425 ; support material
G1 X97.559 Y95.396 E2.52873 ; support material
G1 E0.52873 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X96.852 Y89.558 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3582.293
G1 X96.176 Y89.366 E2.01749 ; support material
G1 X95.477 Y89.430 E2.03497 ; support material
G1 X94.849 Y89.743 E2.05246 ; support material
G1 X94.376 Y90.262 E2.06995 ; support material
G1 X94.117 Y90.932 E2.08784 ; support material
G1 X93.493 Y89.999 E2.11581 ; support material
G1 X92.933 Y89.624 E2.13258 ; support material
G1 X92.272 Y89.493 E2.14936 ; support material
G1 X91.612 Y89.624 E2.16613 ; support material
G1 X91.052 Y89.999 E2.18291 ; support material
G1 X90.678 Y90.559 E2.19968 ; support material
G1 X90.546 Y91.219 E2.21645 ; support material
G1 X90.678 Y91.879 E2.23323 ; support material
G1 X91.052 Y92.439 E2.25000 ; support material
G1 X91.612 Y92.814 E2.26678 ; support material
G1 X92.272 Y92.945 E2.28355 ; support material
G1 X92.933 Y92.814 E2.30032 ; support material
G1 X93.493 Y92.439 E2.31710 ; support material
G1 X94.093 Y91.542 E2.34399 ; support material
G1 X94.376 Y92.273 E2.36354 ; support material
G1 X94.849 Y92.792 E2.38103 ; support material
G1 X95.477 Y93.105 E2.39851 ; support material
G1 X96.176 Y93.170 E2.41600 ; support material
G1 X96.852 Y92.978 E2.43348 ; support material
G1 X97.412 Y92.555 E2.45097 ; support material
G1 X97.781 Y91.958 E2.46846 ; support material
G1 X97.910 Y91.268 E2.48594 ; support material
G1 X97.781 Y90.578 E2.50343 ; support material
G1 X97.412 Y89.981 E2.52092 ; support material
G1 X96.852 Y89.558 E2.53840 ; support material
G1 E0.53840 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X102.437 Y89.802 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3582.293
G1 X101.785 Y89.565 E2.01727 ; support material
G1 X101.092 Y89.565 E2.03455 ; support material
G1 X100.440 Y89.802 E2.05182 ; support material
G1 X99.909 Y90.248 E2.06910 ; support material
G1 X99.562 Y90.849 E2.08637 ; support material
G1 X99.442 Y91.532 E2.10364 ; support material
G1 X99.562 Y92.214 E2.12092 ; support material
G1 X99.909 Y92.815 E2.13819 ; support material
G1 X100.581 Y93.379 E2.16006 ; support material
G1 X100.479 Y93.695 E2.16833 ; support material
G1 X100.658 Y94.248 E2.18281 ; support material
G1 X101.129 Y94.590 E2.19730 ; support material
G1 X101.710 Y94.590 E2.21178 ; support material
G1 X102.181 Y94.248 E2.22626 ; support material
G1 X102.360 Y93.695 E2.24075 ; support material
G1 X102.266 Y93.404 E2.24836 ; support material
G1 X102.968 Y92.815 E2.27120 ; support material
G1 X103.315 Y92.214 E2.28848 ; support material
G1 X103.435 Y91.532 E2.30575 ; support material
G1 X103.315 Y90.849 E2.32302 ; support material
G1 X102.968 Y90.248 E2.34030 ; support material
G1 X102.437 Y89.802 E2.35757 ; support material
G1 E0.35757 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X109.391 Y90.120 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3582.293
G1 X108.807 Y89.838 E2.01616 ; support material
G1 X108.158 Y89.838 E2.03231 ; support material
G1 X107.574 Y90.120 E2.04847 ; support material
G1 X106.977 Y90.868 E2.07233 ; support material
G1 X106.392 Y90.135 E2.09571 ; support material
G1 X105.807 Y89.853 E2.11186 ; support material
G1 X105.159 Y89.853 E2.12802 ; support material
G1 X104.574 Y90.135 E2.14418 ; support material
G1 X104.170 Y90.642 E2.16033 ; support material
G1 X104.026 Y91.274 E2.17649 ; support material
G1 X104.170 Y91.906 E2.19264 ; support material
G1 X104.574 Y92.413 E2.20880 ; support material
G1 X105.159 Y92.695 E2.22496 ; support material
G1 X105.807 Y92.695 E2.24111 ; support material
G1 X106.392 Y92.413 E2.25727 ; support material
G1 X106.989 Y91.665 E2.28113 ; support material
G1 X107.574 Y92.398 E2.30451 ; support material
G1 X108.158 Y92.680 E2.32066 ; support material
G1 X108.807 Y92.680 E2.33682 ; support material
G1 X109.391 Y92.398 E2.35298 ; support material
G1 X109.796 Y91.891 E2.36913 ; support material
G1 X109.940 Y91.259 E2.38529 ; support material
G1 X109.796 Y90.627 E2.40144 ; support material
G1 X109.391 Y90.120 E2.41760 ; support material
G1 E0.41760 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X107.131 Y95.374 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3582.293
G1 X106.445 Y95.237 E2.01743 ; support material
G1 X105.759 Y95.374 E2.03486 ; support material
G1 X105.177 Y95.763 E2.05229 ; support material
G1 X104.788 Y96.344 E2.06972 ; support material
G1 X104.652 Y97.031 E2.08715 ; support material
G1 X104.788 Y97.717 E2.10458 ; support material
G1 X105.177 Y98.299 E2.12201 ; support material
G1 X105.759 Y98.687 E2.13944 ; support material
G1 X106.445 Y98.824 E2.15687 ; support material
G1 X107.131 Y98.687 E2.17430 ; support material
G1 X107.794 Y98.245 E2.19413 ; support material
G1 X108.031 Y98.483 E2.20251 ; support material
G1 X108.663 Y98.652 E2.21880 ; support material
G1 X109.295 Y98.483 E2.23510 ; support material
G1 X109.758 Y98.020 E2.25140 ; support material
G1 X109.927 Y97.388 E2.26769 ; support material
G1 X109.758 Y96.756 E2.28399 ; support material
G1 X109.295 Y96.294 E2.30028 ; support material
G1 X108.663 Y96.124 E2.31658 ; support material
G1 X108.062 Y96.285 E2.33207 ; support material
G1 X107.713 Y95.763 E2.34773 ; support material
G1 X107.131 Y95.374 E2.36516 ; support material
G1 E0.36516 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X107.789 Y102.226 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3582.293
G1 X107.171 Y101.928 E2.01709 ; support material
G1 X106.485 Y101.928 E2.03418 ; support material
G1 X105.866 Y102.226 E2.05127 ; support material
G1 X105.439 Y102.762 E2.06837 ; support material
G1 X105.286 Y103.431 E2.08546 ; support material
G1 X105.439 Y104.100 E2.10255 ; support material
G1 X105.866 Y104.637 E2.11964 ; support material
G1 X106.485 Y104.935 E2.13673 ; support material
G1 X107.171 Y104.935 E2.15382 ; support material
G1 X107.885 Y104.590 E2.17358 ; support material
G1 X108.170 Y104.787 E2.18220 ; support material
G1 X108.817 Y104.866 E2.19843 ; support material
G1 X109.426 Y104.635 E2.21465 ; support material
G1 X109.858 Y104.147 E2.23087 ; support material
G1 X110.014 Y103.515 E2.24710 ; support material
G1 X109.858 Y102.882 E2.26332 ; support material
G1 X109.426 Y102.395 E2.27954 ; support material
G1 X108.817 Y102.164 E2.29577 ; support material
G1 X108.170 Y102.242 E2.31199 ; support material
G1 X107.933 Y102.406 E2.31918 ; support material
G1 X107.789 Y102.226 E2.32492 ; support material
G1 Z3.950 F7800.000 ; move to next layer (23)
G1 E0.32492 F2400.00000 ; retract extruder 0
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
G1 Z4.250 F7800.000 ; move to next layer (24)
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
G1 Z4.300 F7800.000 ; move to next layer (25)
G1 E1.28846 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X102.440 Y104.488 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X101.788 Y104.250 E2.01727 ; support material
G1 X101.095 Y104.250 E2.03455 ; support material
G1 X100.443 Y104.488 E2.05182 ; support material
G1 X99.912 Y104.933 E2.06910 ; support material
G1 X99.565 Y105.534 E2.08637 ; support material
G1 X99.444 Y106.217 E2.10364 ; support material
G1 X99.565 Y106.900 E2.12092 ; support material
G1 X99.912 Y107.500 E2.13819 ; support material
G1 X100.443 Y107.946 E2.15547 ; support material
G1 X101.095 Y108.183 E2.17274 ; support material
G1 X101.788 Y108.183 E2.19002 ; support material
G1 X102.440 Y107.946 E2.20729 ; support material
G1 X102.971 Y107.500 E2.22456 ; support material
G1 X103.318 Y106.900 E2.24184 ; support material
G1 X103.438 Y106.217 E2.25911 ; support material
G1 X103.318 Y105.534 E2.27639 ; support material
G1 X102.971 Y104.933 E2.29366 ; support material
G1 X102.440 Y104.488 E2.31093 ; support material
G1 E0.31093 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X105.242 Y107.273 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X104.706 Y106.964 E2.01540 ; support material
G1 X104.098 Y107.071 E2.03079 ; support material
G1 X103.700 Y107.545 E2.04619 ; support material
G1 X103.700 Y108.163 E2.06159 ; support material
G1 X104.098 Y108.636 E2.07698 ; support material
G1 X104.706 Y108.744 E2.09238 ; support material
G1 X105.242 Y108.435 E2.10777 ; support material
G1 X105.453 Y107.854 E2.12317 ; support material
G1 X105.242 Y107.273 E2.13857 ; support material
G1 E0.13857 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X108.231 Y107.406 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X107.696 Y107.096 E2.01540 ; support material
G1 X107.087 Y107.204 E2.03079 ; support material
G1 X106.690 Y107.677 E2.04619 ; support material
G1 X106.690 Y108.295 E2.06159 ; support material
G1 X107.087 Y108.769 E2.07698 ; support material
G1 X107.696 Y108.876 E2.09238 ; support material
G1 X108.231 Y108.567 E2.10777 ; support material
G1 X108.442 Y107.986 E2.12317 ; support material
G1 X108.231 Y107.406 E2.13857 ; support material
G1 E0.13857 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.490 Y110.402 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X105.955 Y110.093 E2.01540 ; support material
G1 X105.346 Y110.200 E2.03079 ; support material
G1 X104.949 Y110.674 E2.04619 ; support material
G1 X104.949 Y111.292 E2.06158 ; support material
G1 X105.346 Y111.765 E2.07698 ; support material
G1 X105.955 Y111.873 E2.09238 ; support material
G1 X106.771 Y111.401 E2.11588 ; support material
G1 X107.087 Y111.777 E2.12810 ; support material
G1 X107.696 Y111.884 E2.14350 ; support material
G1 X108.231 Y111.575 E2.15889 ; support material
G1 X108.442 Y110.994 E2.17429 ; support material
G1 X108.231 Y110.413 E2.18968 ; support material
G1 X107.696 Y110.104 E2.20508 ; support material
G1 X107.087 Y110.212 E2.22048 ; support material
G1 X106.622 Y110.766 E2.23849 ; support material
G1 X106.490 Y110.402 E2.24813 ; support material
G1 E0.24813 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.366 Y109.779 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X102.778 Y109.556 E2.01565 ; support material
G1 X102.155 Y109.632 E2.03131 ; support material
G1 X101.637 Y109.989 E2.04696 ; support material
G1 X101.345 Y110.545 E2.06262 ; support material
G1 X101.345 Y111.174 E2.07827 ; support material
G1 X101.637 Y111.730 E2.09393 ; support material
G1 X102.155 Y112.087 E2.10958 ; support material
G1 X102.778 Y112.163 E2.12524 ; support material
G1 X103.366 Y111.940 E2.14089 ; support material
G1 X103.783 Y111.470 E2.15655 ; support material
G1 X103.933 Y110.860 E2.17220 ; support material
G1 X103.783 Y110.249 E2.18786 ; support material
G1 X103.366 Y109.779 E2.20351 ; support material
G1 E0.20351 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X96.431 Y109.277 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X95.455 Y108.907 E2.02601 ; support material
G1 X95.455 Y109.101 E2.03086 ; support material
G1 X95.220 Y109.130 E2.03676 ; support material
G1 X94.703 Y109.487 E2.05241 ; support material
G1 X94.411 Y110.043 E2.06807 ; support material
G1 X94.411 Y110.672 E2.08372 ; support material
G1 X94.703 Y111.228 E2.09938 ; support material
G1 X95.220 Y111.585 E2.11503 ; support material
G1 X95.844 Y111.661 E2.13069 ; support material
G1 X96.431 Y111.438 E2.14634 ; support material
G1 X96.848 Y110.968 E2.16200 ; support material
G1 X96.999 Y110.358 E2.17765 ; support material
G1 X96.848 Y109.747 E2.19331 ; support material
G1 X96.431 Y109.277 E2.20896 ; support material
G1 E0.20896 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X96.431 Y104.536 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X95.844 Y104.313 E2.01565 ; support material
G1 X95.220 Y104.388 E2.03131 ; support material
G1 X94.703 Y104.745 E2.04696 ; support material
G1 X94.411 Y105.302 E2.06262 ; support material
G1 X94.411 Y105.930 E2.07827 ; support material
G1 X94.703 Y106.487 E2.09393 ; support material
G1 X94.411 Y107.043 E2.10958 ; support material
G1 X94.411 Y107.672 E2.12523 ; support material
G1 X94.703 Y108.228 E2.14089 ; support material
G1 X95.220 Y108.585 E2.15654 ; support material
G1 X95.455 Y108.614 E2.16244 ; support material
G1 X95.455 Y108.808 E2.16729 ; support material
G1 X96.431 Y108.438 E2.19330 ; support material
G1 X96.848 Y107.968 E2.20896 ; support material
G1 X96.999 Y107.358 E2.22461 ; support material
G1 X96.848 Y106.747 E2.24027 ; support material
G1 X96.617 Y106.487 E2.24894 ; support material
G1 X96.848 Y106.226 E2.25760 ; support material
G1 X96.999 Y105.616 E2.27326 ; support material
G1 X96.848 Y105.006 E2.28891 ; support material
G1 X96.431 Y104.536 E2.30457 ; support material
G1 E0.30457 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.715 Y104.926 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.091 Y104.836 E2.01570 ; support material
G1 X90.517 Y105.098 E2.03140 ; support material
G1 X90.177 Y105.629 E2.04711 ; support material
G1 X90.177 Y106.259 E2.06281 ; support material
G1 X90.517 Y106.789 E2.07851 ; support material
G1 X91.091 Y107.051 E2.09421 ; support material
G1 X91.715 Y106.962 E2.10992 ; support material
G1 X92.191 Y106.549 E2.12562 ; support material
G1 X92.369 Y105.944 E2.14132 ; support material
G1 X92.191 Y105.339 E2.15702 ; support material
G1 X91.715 Y104.926 E2.17272 ; support material
G1 E0.17272 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.715 Y107.926 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.091 Y107.836 E2.01570 ; support material
G1 X90.517 Y108.098 E2.03140 ; support material
G1 X90.177 Y108.629 E2.04711 ; support material
G1 X90.177 Y109.259 E2.06281 ; support material
G1 X90.517 Y109.789 E2.07851 ; support material
G1 X91.091 Y110.051 E2.09421 ; support material
G1 X91.715 Y109.962 E2.10992 ; support material
G1 X92.191 Y109.549 E2.12562 ; support material
G1 X92.369 Y108.944 E2.14132 ; support material
G1 X92.191 Y108.339 E2.15702 ; support material
G1 X91.715 Y107.926 E2.17272 ; support material
G1 E0.17272 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.715 Y100.185 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.091 Y100.095 E2.01570 ; support material
G1 X90.517 Y100.357 E2.03140 ; support material
G1 X90.177 Y100.887 E2.04711 ; support material
G1 X90.177 Y101.518 E2.06281 ; support material
G1 X90.534 Y102.073 E2.07926 ; support material
G1 X90.177 Y102.629 E2.09570 ; support material
G1 X90.177 Y103.259 E2.11141 ; support material
G1 X90.517 Y103.789 E2.12711 ; support material
G1 X91.091 Y104.051 E2.14281 ; support material
G1 X91.715 Y103.962 E2.15851 ; support material
G1 X92.191 Y103.549 E2.17422 ; support material
G1 X92.369 Y102.944 E2.18992 ; support material
G1 X92.191 Y102.339 E2.20562 ; support material
G1 X91.884 Y102.073 E2.21573 ; support material
G1 X92.191 Y101.807 E2.22584 ; support material
G1 X92.369 Y101.202 E2.24154 ; support material
G1 X92.191 Y100.598 E2.25725 ; support material
G1 X91.715 Y100.185 E2.27295 ; support material
G1 E0.27295 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.194 Y99.513 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.659 Y99.204 E2.01540 ; support material
G1 X94.050 Y99.311 E2.03079 ; support material
G1 X93.653 Y99.785 E2.04619 ; support material
G1 X93.653 Y100.403 E2.06159 ; support material
G1 X94.050 Y100.876 E2.07698 ; support material
G1 X94.659 Y100.984 E2.09238 ; support material
G1 X95.194 Y100.675 E2.10777 ; support material
G1 X95.406 Y100.094 E2.12317 ; support material
G1 X95.194 Y99.513 E2.13857 ; support material
G1 E0.13857 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X94.519 Y96.426 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.122 Y96.899 E2.01540 ; support material
G1 X94.122 Y97.518 E2.03079 ; support material
G1 X94.519 Y97.991 E2.04619 ; support material
G1 X95.128 Y98.098 E2.06159 ; support material
G1 X95.663 Y97.789 E2.07698 ; support material
G1 X95.874 Y97.208 E2.09238 ; support material
G1 X95.763 Y96.902 E2.10050 ; support material
G1 X96.252 Y96.620 E2.11456 ; support material
G1 X96.346 Y96.732 E2.11820 ; support material
G1 X96.954 Y96.839 E2.13360 ; support material
G1 X97.490 Y96.530 E2.14899 ; support material
G1 X97.701 Y95.950 E2.16439 ; support material
G1 X97.490 Y95.369 E2.17979 ; support material
G1 X96.954 Y95.060 E2.19518 ; support material
G1 X96.346 Y95.167 E2.21058 ; support material
G1 X96.233 Y95.302 E2.21496 ; support material
G1 X95.842 Y95.076 E2.22618 ; support material
G1 X95.234 Y95.184 E2.24158 ; support material
G1 X94.836 Y95.657 E2.25697 ; support material
G1 X94.836 Y96.370 E2.27473 ; support material
G1 X94.519 Y96.426 E2.28276 ; support material
G1 E0.28276 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X92.525 Y95.605 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.872 Y95.475 E2.01659 ; support material
G1 X91.219 Y95.605 E2.03318 ; support material
G1 X90.665 Y95.975 E2.04977 ; support material
G1 X90.295 Y96.529 E2.06637 ; support material
G1 X90.165 Y97.182 E2.08296 ; support material
G1 X90.295 Y97.836 E2.09955 ; support material
G1 X90.665 Y98.390 E2.11614 ; support material
G1 X91.219 Y98.760 E2.13273 ; support material
G1 X91.872 Y98.890 E2.14932 ; support material
G1 X92.525 Y98.760 E2.16591 ; support material
G1 X93.079 Y98.390 E2.18251 ; support material
G1 X93.449 Y97.836 E2.19910 ; support material
G1 X93.579 Y97.182 E2.21569 ; support material
G1 X93.449 Y96.529 E2.23228 ; support material
G1 X93.079 Y95.975 E2.24887 ; support material
G1 X92.525 Y95.605 E2.26546 ; support material
G1 E0.26546 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X92.618 Y89.620 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.958 Y89.488 E2.01677 ; support material
G1 X91.297 Y89.620 E2.03355 ; support material
G1 X90.737 Y89.994 E2.05032 ; support material
G1 X90.363 Y90.554 E2.06710 ; support material
G1 X90.232 Y91.214 E2.08387 ; support material
G1 X90.363 Y91.875 E2.10064 ; support material
G1 X90.737 Y92.435 E2.11742 ; support material
G1 X91.297 Y92.809 E2.13419 ; support material
G1 X91.958 Y92.940 E2.15097 ; support material
G1 X92.618 Y92.809 E2.16774 ; support material
G1 X93.178 Y92.435 E2.18452 ; support material
G1 X93.552 Y91.875 E2.20129 ; support material
G1 X93.684 Y91.214 E2.21806 ; support material
G1 X93.552 Y90.554 E2.23484 ; support material
G1 X93.178 Y89.994 E2.25161 ; support material
G1 X92.618 Y89.620 E2.26839 ; support material
G1 E0.26839 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X97.429 Y90.169 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X96.797 Y90.000 E2.01630 ; support material
G1 X96.231 Y90.152 E2.03090 ; support material
G1 X95.686 Y90.005 E2.04497 ; support material
G1 X95.054 Y90.175 E2.06126 ; support material
G1 X94.591 Y90.637 E2.07756 ; support material
G1 X94.422 Y91.269 E2.09386 ; support material
G1 X94.591 Y91.901 E2.11015 ; support material
G1 X95.054 Y92.364 E2.12645 ; support material
G1 X95.686 Y92.533 E2.14274 ; support material
G1 X96.252 Y92.381 E2.15735 ; support material
G1 X96.797 Y92.528 E2.17141 ; support material
G1 X97.429 Y92.358 E2.18771 ; support material
G1 X97.892 Y91.896 E2.20401 ; support material
G1 X98.061 Y91.264 E2.22030 ; support material
G1 X97.892 Y90.632 E2.23660 ; support material
G1 X97.429 Y90.169 E2.25290 ; support material
G1 E0.25290 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X102.440 Y89.488 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X101.788 Y89.250 E2.01727 ; support material
G1 X101.095 Y89.250 E2.03455 ; support material
G1 X100.443 Y89.488 E2.05182 ; support material
G1 X99.912 Y89.933 E2.06910 ; support material
G1 X99.565 Y90.534 E2.08637 ; support material
G1 X99.444 Y91.217 E2.10364 ; support material
G1 X99.565 Y91.900 E2.12092 ; support material
G1 X99.912 Y92.500 E2.13819 ; support material
G1 X100.443 Y92.946 E2.15547 ; support material
G1 X101.023 Y93.157 E2.17085 ; support material
G1 X100.567 Y93.701 E2.18852 ; support material
G1 X100.567 Y94.319 E2.20392 ; support material
G1 X100.965 Y94.792 E2.21931 ; support material
G1 X101.573 Y94.900 E2.23471 ; support material
G1 X102.109 Y94.591 E2.25010 ; support material
G1 X102.320 Y94.010 E2.26550 ; support material
G1 X101.992 Y93.109 E2.28938 ; support material
G1 X102.440 Y92.946 E2.30124 ; support material
G1 X102.971 Y92.500 E2.31851 ; support material
G1 X103.318 Y91.900 E2.33578 ; support material
G1 X103.438 Y91.217 E2.35306 ; support material
G1 X103.318 Y90.534 E2.37033 ; support material
G1 X102.971 Y89.933 E2.38761 ; support material
G1 X102.440 Y89.488 E2.40488 ; support material
G1 E0.40488 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.175 Y90.378 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X105.640 Y90.069 E2.01540 ; support material
G1 X105.031 Y90.177 E2.03079 ; support material
G1 X104.634 Y90.650 E2.04619 ; support material
G1 X104.634 Y91.268 E2.06159 ; support material
G1 X104.828 Y91.500 E2.06912 ; support material
G1 X104.634 Y91.732 E2.07665 ; support material
G1 X104.634 Y92.350 E2.09205 ; support material
G1 X105.031 Y92.823 E2.10744 ; support material
G1 X105.640 Y92.931 E2.12284 ; support material
G1 X106.175 Y92.622 E2.13823 ; support material
G1 X106.387 Y92.041 E2.15363 ; support material
G1 X106.190 Y91.500 E2.16796 ; support material
G1 X106.387 Y90.959 E2.18230 ; support material
G1 X106.175 Y90.378 E2.19769 ; support material
G1 E0.19769 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X109.175 Y90.364 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X108.640 Y90.055 E2.01540 ; support material
G1 X108.031 Y90.162 E2.03079 ; support material
G1 X107.634 Y90.635 E2.04619 ; support material
G1 X107.634 Y91.253 E2.06159 ; support material
G1 X107.840 Y91.500 E2.06960 ; support material
G1 X107.634 Y91.747 E2.07762 ; support material
G1 X107.634 Y92.365 E2.09302 ; support material
G1 X108.031 Y92.838 E2.10841 ; support material
G1 X108.640 Y92.945 E2.12381 ; support material
G1 X109.175 Y92.636 E2.13920 ; support material
G1 X109.386 Y92.056 E2.15460 ; support material
G1 X109.184 Y91.500 E2.16933 ; support material
G1 X109.386 Y90.944 E2.18406 ; support material
G1 X109.175 Y90.364 E2.19945 ; support material
G1 E0.19945 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.821 Y95.324 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X106.134 Y95.187 E2.01743 ; support material
G1 X105.448 Y95.324 E2.03486 ; support material
G1 X104.866 Y95.712 E2.05229 ; support material
G1 X104.478 Y96.294 E2.06972 ; support material
G1 X104.341 Y96.981 E2.08715 ; support material
G1 X104.478 Y97.667 E2.10458 ; support material
G1 X104.866 Y98.249 E2.12201 ; support material
G1 X105.448 Y98.637 E2.13944 ; support material
G1 X106.134 Y98.774 E2.15687 ; support material
G1 X106.821 Y98.637 E2.17430 ; support material
G1 X107.403 Y98.249 E2.19172 ; support material
G1 X107.665 Y97.856 E2.20349 ; support material
G1 X108.342 Y98.533 E2.22734 ; support material
G1 X108.974 Y98.702 E2.24364 ; support material
G1 X109.606 Y98.533 E2.25993 ; support material
G1 X110.068 Y98.070 E2.27623 ; support material
G1 X110.238 Y97.438 E2.29253 ; support material
G1 X110.068 Y96.806 E2.30882 ; support material
G1 X109.606 Y96.344 E2.32512 ; support material
G1 X108.974 Y96.174 E2.34141 ; support material
G1 X108.342 Y96.344 E2.35771 ; support material
G1 X107.891 Y96.795 E2.37360 ; support material
G1 X107.791 Y96.294 E2.38631 ; support material
G1 X107.403 Y95.712 E2.40374 ; support material
G1 X106.821 Y95.324 E2.42117 ; support material
G1 E0.42117 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X107.475 Y102.212 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X106.857 Y101.914 E2.01709 ; support material
G1 X106.170 Y101.914 E2.03418 ; support material
G1 X105.552 Y102.212 E2.05127 ; support material
G1 X105.124 Y102.748 E2.06837 ; support material
G1 X104.972 Y103.417 E2.08546 ; support material
G1 X105.124 Y104.086 E2.10255 ; support material
G1 X105.552 Y104.623 E2.11964 ; support material
G1 X106.170 Y104.920 E2.13673 ; support material
G1 X106.857 Y104.920 E2.15382 ; support material
G1 X107.475 Y104.623 E2.17092 ; support material
G1 X107.741 Y104.288 E2.18157 ; support material
G1 X108.485 Y104.801 E2.20406 ; support material
G1 X109.131 Y104.880 E2.22029 ; support material
G1 X109.740 Y104.649 E2.23651 ; support material
G1 X110.172 Y104.161 E2.25273 ; support material
G1 X110.328 Y103.529 E2.26896 ; support material
G1 X110.172 Y102.897 E2.28518 ; support material
G1 X109.740 Y102.409 E2.30141 ; support material
G1 X109.131 Y102.178 E2.31763 ; support material
G1 X108.485 Y102.257 E2.33385 ; support material
G1 X107.856 Y102.690 E2.35287 ; support material
G1 X107.475 Y102.212 E2.36812 ; support material
G1 Z4.550 F7800.000 ; move to next layer (26)
G1 E0.36812 F2400.00000 ; retract extruder 0
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
G1 Z4.675 F7800.000 ; move to next layer (27)
G1 E0.64423 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X101.797 Y104.369 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X101.113 Y104.297 E2.01714 ; support material
G1 X100.458 Y104.510 E2.03429 ; support material
G1 X99.947 Y104.970 E2.05143 ; support material
G1 X99.667 Y105.599 E2.06858 ; support material
G1 X99.667 Y106.287 E2.08572 ; support material
G1 X99.947 Y106.916 E2.10287 ; support material
G1 X100.458 Y107.377 E2.12001 ; support material
G1 X101.113 Y107.589 E2.13715 ; support material
G1 X101.215 Y107.579 E2.13972 ; support material
G1 X101.637 Y108.081 E2.15605 ; support material
G1 X102.223 Y108.184 E2.17087 ; support material
G1 X102.738 Y107.887 E2.18570 ; support material
G1 X102.942 Y107.328 E2.20052 ; support material
G1 X102.721 Y106.722 E2.21656 ; support material
G1 X102.798 Y106.616 E2.21982 ; support material
G1 X102.941 Y105.943 E2.23696 ; support material
G1 X102.798 Y105.270 E2.25411 ; support material
G1 X102.393 Y104.713 E2.27125 ; support material
G1 X101.797 Y104.369 E2.28840 ; support material
G1 E0.28840 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X105.524 Y107.360 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X105.008 Y107.063 E2.01482 ; support material
G1 X104.422 Y107.166 E2.02964 ; support material
G1 X104.040 Y107.622 E2.04446 ; support material
G1 X104.040 Y108.217 E2.05928 ; support material
G1 X104.422 Y108.673 E2.07411 ; support material
G1 X105.008 Y108.776 E2.08893 ; support material
G1 X105.524 Y108.478 E2.10375 ; support material
G1 X105.727 Y107.919 E2.11857 ; support material
G1 X105.524 Y107.360 E2.13339 ; support material
G1 E0.13339 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X108.520 Y107.435 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X108.004 Y107.138 E2.01482 ; support material
G1 X107.418 Y107.241 E2.02964 ; support material
G1 X107.036 Y107.697 E2.04446 ; support material
G1 X107.036 Y108.292 E2.05928 ; support material
G1 X107.418 Y108.748 E2.07411 ; support material
G1 X108.004 Y108.851 E2.08893 ; support material
G1 X108.520 Y108.553 E2.10375 ; support material
G1 X108.723 Y107.994 E2.11857 ; support material
G1 X108.520 Y107.435 E2.13339 ; support material
G1 E0.13339 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X108.520 Y110.437 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X108.004 Y110.140 E2.01482 ; support material
G1 X107.418 Y110.243 E2.02964 ; support material
G1 X107.036 Y110.699 E2.04446 ; support material
G1 X107.036 Y111.294 E2.05928 ; support material
G1 X107.418 Y111.750 E2.07411 ; support material
G1 X108.004 Y111.853 E2.08893 ; support material
G1 X108.520 Y111.556 E2.10375 ; support material
G1 X108.723 Y110.996 E2.11857 ; support material
G1 X108.520 Y110.437 E2.13339 ; support material
G1 E0.13339 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.149 Y110.421 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X105.634 Y110.124 E2.01482 ; support material
G1 X105.048 Y110.227 E2.02964 ; support material
G1 X104.666 Y110.683 E2.04446 ; support material
G1 X104.666 Y111.278 E2.05928 ; support material
G1 X105.048 Y111.734 E2.07411 ; support material
G1 X105.634 Y111.837 E2.08893 ; support material
G1 X106.149 Y111.540 E2.10375 ; support material
G1 X106.353 Y110.981 E2.11857 ; support material
G1 X106.149 Y110.421 E2.13339 ; support material
G1 E0.13339 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.052 Y109.766 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X102.464 Y109.543 E2.01565 ; support material
G1 X101.840 Y109.619 E2.03131 ; support material
G1 X101.323 Y109.976 E2.04696 ; support material
G1 X101.031 Y110.532 E2.06262 ; support material
G1 X101.031 Y111.161 E2.07827 ; support material
G1 X101.323 Y111.717 E2.09393 ; support material
G1 X101.840 Y112.074 E2.10958 ; support material
G1 X102.464 Y112.150 E2.12524 ; support material
G1 X103.052 Y111.927 E2.14089 ; support material
G1 X103.468 Y111.457 E2.15655 ; support material
G1 X103.619 Y110.846 E2.17220 ; support material
G1 X103.468 Y110.236 E2.18786 ; support material
G1 X103.052 Y109.766 E2.20351 ; support material
G1 E0.20351 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X96.431 Y109.592 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X95.455 Y109.221 E2.02601 ; support material
G1 X95.455 Y109.416 E2.03086 ; support material
G1 X95.220 Y109.444 E2.03676 ; support material
G1 X94.703 Y109.801 E2.05241 ; support material
G1 X94.411 Y110.358 E2.06807 ; support material
G1 X94.411 Y110.986 E2.08372 ; support material
G1 X94.703 Y111.543 E2.09938 ; support material
G1 X95.220 Y111.900 E2.11503 ; support material
G1 X95.844 Y111.976 E2.13069 ; support material
G1 X96.431 Y111.753 E2.14634 ; support material
G1 X96.848 Y111.282 E2.16200 ; support material
G1 X96.999 Y110.672 E2.17765 ; support material
G1 X96.848 Y110.062 E2.19331 ; support material
G1 X96.431 Y109.592 E2.20896 ; support material
G1 E0.20896 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.715 Y108.241 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.091 Y108.151 E2.01570 ; support material
G1 X90.517 Y108.413 E2.03140 ; support material
G1 X90.177 Y108.943 E2.04711 ; support material
G1 X90.177 Y109.574 E2.06281 ; support material
G1 X90.517 Y110.104 E2.07851 ; support material
G1 X91.091 Y110.366 E2.09421 ; support material
G1 X91.715 Y110.276 E2.10992 ; support material
G1 X92.191 Y109.863 E2.12562 ; support material
G1 X92.369 Y109.259 E2.14132 ; support material
G1 X92.191 Y108.654 E2.15702 ; support material
G1 X91.715 Y108.241 E2.17272 ; support material
G1 E0.17272 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.715 Y105.241 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.091 Y105.151 E2.01570 ; support material
G1 X90.517 Y105.413 E2.03140 ; support material
G1 X90.177 Y105.943 E2.04711 ; support material
G1 X90.177 Y106.574 E2.06281 ; support material
G1 X90.517 Y107.104 E2.07851 ; support material
G1 X91.091 Y107.366 E2.09421 ; support material
G1 X91.715 Y107.276 E2.10992 ; support material
G1 X92.191 Y106.863 E2.12562 ; support material
G1 X92.369 Y106.259 E2.14132 ; support material
G1 X92.191 Y105.654 E2.15702 ; support material
G1 X91.715 Y105.241 E2.17272 ; support material
G1 E0.17272 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X96.431 Y104.221 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X95.844 Y103.998 E2.01565 ; support material
G1 X95.220 Y104.074 E2.03131 ; support material
G1 X94.703 Y104.431 E2.04696 ; support material
G1 X94.411 Y104.987 E2.06262 ; support material
G1 X94.411 Y105.616 E2.07827 ; support material
G1 X94.703 Y106.172 E2.09393 ; support material
G1 X95.159 Y106.487 E2.10772 ; support material
G1 X94.703 Y106.801 E2.12152 ; support material
G1 X94.411 Y107.358 E2.13717 ; support material
G1 X94.411 Y107.986 E2.15283 ; support material
G1 X94.703 Y108.543 E2.16848 ; support material
G1 X95.220 Y108.900 E2.18414 ; support material
G1 X95.455 Y108.928 E2.19004 ; support material
G1 X95.455 Y109.123 E2.19489 ; support material
G1 X96.431 Y108.753 E2.22090 ; support material
G1 X96.848 Y108.282 E2.23655 ; support material
G1 X96.999 Y107.672 E2.25221 ; support material
G1 X96.848 Y107.062 E2.26786 ; support material
G1 X96.339 Y106.487 E2.28700 ; support material
G1 X96.848 Y105.912 E2.30614 ; support material
G1 X96.999 Y105.302 E2.32179 ; support material
G1 X96.848 Y104.691 E2.33745 ; support material
G1 X96.431 Y104.221 E2.35310 ; support material
G1 E0.35310 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.131 Y99.847 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.616 Y99.550 E2.01482 ; support material
G1 X94.030 Y99.653 E2.02964 ; support material
G1 X93.648 Y100.109 E2.04446 ; support material
G1 X93.648 Y100.704 E2.05928 ; support material
G1 X94.030 Y101.160 E2.07411 ; support material
G1 X94.616 Y101.263 E2.08893 ; support material
G1 X95.131 Y100.965 E2.10375 ; support material
G1 X95.335 Y100.406 E2.11857 ; support material
G1 X95.131 Y99.847 E2.13339 ; support material
G1 E0.13339 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.715 Y99.870 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.091 Y99.780 E2.01570 ; support material
G1 X90.517 Y100.042 E2.03140 ; support material
G1 X90.177 Y100.573 E2.04711 ; support material
G1 X90.177 Y101.203 E2.06281 ; support material
G1 X90.517 Y101.733 E2.07851 ; support material
G1 X91.262 Y102.073 E2.09889 ; support material
G1 X90.517 Y102.413 E2.11927 ; support material
G1 X90.177 Y102.943 E2.13497 ; support material
G1 X90.177 Y103.574 E2.15067 ; support material
G1 X90.517 Y104.104 E2.16637 ; support material
G1 X91.091 Y104.366 E2.18207 ; support material
G1 X91.715 Y104.276 E2.19778 ; support material
G1 X92.191 Y103.863 E2.21348 ; support material
G1 X92.369 Y103.259 E2.22918 ; support material
G1 X92.191 Y102.654 E2.24488 ; support material
G1 X91.521 Y102.073 E2.26696 ; support material
G1 X92.191 Y101.493 E2.28904 ; support material
G1 X92.369 Y100.888 E2.30475 ; support material
G1 X92.191 Y100.283 E2.32045 ; support material
G1 X91.715 Y99.870 E2.33615 ; support material
G1 E0.33615 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X92.212 Y95.573 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.559 Y95.444 E2.01659 ; support material
G1 X90.906 Y95.573 E2.03318 ; support material
G1 X90.352 Y95.944 E2.04977 ; support material
G1 X89.982 Y96.497 E2.06637 ; support material
G1 X89.852 Y97.151 E2.08296 ; support material
G1 X89.982 Y97.804 E2.09955 ; support material
G1 X90.352 Y98.358 E2.11614 ; support material
G1 X90.906 Y98.728 E2.13273 ; support material
G1 X91.559 Y98.858 E2.14932 ; support material
G1 X92.212 Y98.728 E2.16591 ; support material
G1 X92.766 Y98.358 E2.18251 ; support material
G1 X93.136 Y97.804 E2.19910 ; support material
G1 X93.266 Y97.151 E2.21569 ; support material
G1 X93.136 Y96.497 E2.23228 ; support material
G1 X92.766 Y95.944 E2.24887 ; support material
G1 X92.212 Y95.573 E2.26546 ; support material
G1 E0.26546 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X97.464 Y95.390 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X96.948 Y95.093 E2.01482 ; support material
G1 X96.363 Y95.196 E2.02964 ; support material
G1 X96.240 Y95.342 E2.03440 ; support material
G1 X95.837 Y95.110 E2.04600 ; support material
G1 X95.251 Y95.213 E2.06082 ; support material
G1 X94.868 Y95.669 E2.07564 ; support material
G1 X94.868 Y96.264 E2.09046 ; support material
G1 X95.144 Y96.593 E2.10116 ; support material
G1 X94.379 Y96.728 E2.12052 ; support material
G1 X93.996 Y97.184 E2.13534 ; support material
G1 X93.996 Y97.779 E2.15016 ; support material
G1 X94.379 Y98.234 E2.16498 ; support material
G1 X94.965 Y98.338 E2.17981 ; support material
G1 X95.480 Y98.040 E2.19463 ; support material
G1 X95.684 Y97.481 E2.20945 ; support material
G1 X95.417 Y96.749 E2.22886 ; support material
G1 X95.837 Y96.823 E2.23947 ; support material
G1 X96.259 Y96.579 E2.25161 ; support material
G1 X96.363 Y96.703 E2.25563 ; support material
G1 X96.948 Y96.806 E2.27045 ; support material
G1 X97.464 Y96.509 E2.28527 ; support material
G1 X97.667 Y95.950 E2.30009 ; support material
G1 X97.464 Y95.390 E2.31492 ; support material
G1 E0.31492 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X101.613 Y93.538 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X101.659 Y93.410 E2.00340 ; support material
G1 X100.867 Y93.550 E2.02343 ; support material
G1 X100.485 Y94.005 E2.03825 ; support material
G1 X100.485 Y94.600 E2.05307 ; support material
G1 X100.867 Y95.056 E2.06789 ; support material
G1 X101.453 Y95.160 E2.08271 ; support material
G1 X101.969 Y94.862 E2.09754 ; support material
G1 X102.172 Y94.303 E2.11236 ; support material
G1 X101.969 Y93.744 E2.12718 ; support material
G1 X101.613 Y93.538 E2.13742 ; support material
G1 X101.797 Y89.369 F7800.000 ; move to first support material point
G1 F3600.000
G1 X101.113 Y89.297 E2.15456 ; support material
G1 X100.458 Y89.510 E2.17171 ; support material
G1 X99.947 Y89.970 E2.18885 ; support material
G1 X99.667 Y90.599 E2.20600 ; support material
G1 X99.667 Y91.287 E2.22314 ; support material
G1 X99.947 Y91.916 E2.24028 ; support material
G1 X100.458 Y92.377 E2.25743 ; support material
G1 X101.113 Y92.589 E2.27457 ; support material
G1 X101.215 Y92.579 E2.27714 ; support material
G1 X101.736 Y93.199 E2.29732 ; support material
G1 X101.771 Y93.104 E2.29983 ; support material
G1 X102.223 Y93.184 E2.31127 ; support material
G1 X102.738 Y92.887 E2.32609 ; support material
G1 X102.942 Y92.328 E2.34091 ; support material
G1 X102.721 Y91.722 E2.35696 ; support material
G1 X102.798 Y91.616 E2.36021 ; support material
G1 X102.941 Y90.943 E2.37736 ; support material
G1 X102.798 Y90.270 E2.39450 ; support material
G1 X102.393 Y89.713 E2.41165 ; support material
G1 X101.797 Y89.369 E2.42879 ; support material
G1 E0.42879 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X97.744 Y90.168 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X97.112 Y89.998 E2.01630 ; support material
G1 X96.480 Y90.168 E2.03259 ; support material
G1 X96.237 Y90.411 E2.04115 ; support material
G1 X96.003 Y90.176 E2.04940 ; support material
G1 X95.371 Y90.007 E2.06570 ; support material
G1 X94.739 Y90.176 E2.08200 ; support material
G1 X94.276 Y90.639 E2.09829 ; support material
G1 X94.107 Y91.271 E2.11459 ; support material
G1 X94.276 Y91.903 E2.13089 ; support material
G1 X94.739 Y92.365 E2.14718 ; support material
G1 X95.371 Y92.535 E2.16348 ; support material
G1 X96.003 Y92.365 E2.17977 ; support material
G1 X96.246 Y92.122 E2.18833 ; support material
G1 X96.480 Y92.357 E2.19659 ; support material
G1 X97.112 Y92.526 E2.21288 ; support material
G1 X97.744 Y92.357 E2.22918 ; support material
G1 X98.207 Y91.894 E2.24547 ; support material
G1 X98.376 Y91.262 E2.26177 ; support material
G1 X98.207 Y90.630 E2.27807 ; support material
G1 X97.744 Y90.168 E2.29436 ; support material
G1 E0.29436 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X92.304 Y89.615 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.643 Y89.483 E2.01677 ; support material
G1 X90.983 Y89.615 E2.03355 ; support material
G1 X90.423 Y89.989 E2.05032 ; support material
G1 X90.049 Y90.549 E2.06710 ; support material
G1 X89.917 Y91.209 E2.08387 ; support material
G1 X90.049 Y91.870 E2.10064 ; support material
G1 X90.423 Y92.430 E2.11742 ; support material
G1 X90.983 Y92.804 E2.13419 ; support material
G1 X91.643 Y92.935 E2.15097 ; support material
G1 X92.304 Y92.804 E2.16774 ; support material
G1 X92.864 Y92.430 E2.18452 ; support material
G1 X93.238 Y91.870 E2.20129 ; support material
G1 X93.369 Y91.209 E2.21806 ; support material
G1 X93.238 Y90.549 E2.23484 ; support material
G1 X92.864 Y89.989 E2.25161 ; support material
G1 X92.304 Y89.615 E2.26839 ; support material
G1 E0.26839 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.149 Y90.086 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X105.634 Y89.788 E2.01482 ; support material
G1 X105.048 Y89.891 E2.02964 ; support material
G1 X104.666 Y90.347 E2.04446 ; support material
G1 X104.666 Y90.942 E2.05928 ; support material
G1 X105.134 Y91.500 E2.07742 ; support material
G1 X104.666 Y92.058 E2.09556 ; support material
G1 X104.666 Y92.653 E2.11038 ; support material
G1 X105.048 Y93.109 E2.12521 ; support material
G1 X105.634 Y93.212 E2.14003 ; support material
G1 X106.149 Y92.914 E2.15485 ; support material
G1 X106.353 Y92.355 E2.16967 ; support material
G1 X106.149 Y91.796 E2.18449 ; support material
G1 X105.636 Y91.500 E2.19925 ; support material
G1 X106.149 Y91.204 E2.21401 ; support material
G1 X106.353 Y90.645 E2.22883 ; support material
G1 X106.149 Y90.086 E2.24365 ; support material
G1 E0.24365 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X109.149 Y90.071 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X108.634 Y89.773 E2.01482 ; support material
G1 X108.048 Y89.876 E2.02964 ; support material
G1 X107.665 Y90.332 E2.04446 ; support material
G1 X107.665 Y90.927 E2.05928 ; support material
G1 X108.146 Y91.500 E2.07791 ; support material
G1 X107.665 Y92.073 E2.09653 ; support material
G1 X107.665 Y92.668 E2.11135 ; support material
G1 X108.048 Y93.124 E2.12618 ; support material
G1 X108.634 Y93.227 E2.14100 ; support material
G1 X109.149 Y92.929 E2.15582 ; support material
G1 X109.353 Y92.370 E2.17064 ; support material
G1 X109.149 Y91.811 E2.18546 ; support material
G1 X108.610 Y91.500 E2.20096 ; support material
G1 X109.149 Y91.189 E2.21646 ; support material
G1 X109.353 Y90.630 E2.23128 ; support material
G1 X109.149 Y90.071 E2.24610 ; support material
G1 E0.24610 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.510 Y95.274 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X105.824 Y95.137 E2.01743 ; support material
G1 X105.138 Y95.274 E2.03486 ; support material
G1 X104.556 Y95.662 E2.05229 ; support material
G1 X104.167 Y96.244 E2.06972 ; support material
G1 X104.030 Y96.930 E2.08715 ; support material
G1 X104.167 Y97.617 E2.10458 ; support material
G1 X104.556 Y98.199 E2.12201 ; support material
G1 X105.138 Y98.587 E2.13944 ; support material
G1 X105.824 Y98.724 E2.15687 ; support material
G1 X106.510 Y98.587 E2.17430 ; support material
G1 X107.092 Y98.199 E2.19172 ; support material
G1 X107.481 Y97.617 E2.20915 ; support material
G1 X107.538 Y97.329 E2.21646 ; support material
G1 X107.974 Y97.315 E2.22733 ; support material
G1 X108.190 Y98.120 E2.24810 ; support material
G1 X108.653 Y98.583 E2.26440 ; support material
G1 X109.285 Y98.752 E2.28069 ; support material
G1 X109.917 Y98.583 E2.29699 ; support material
G1 X110.379 Y98.120 E2.31328 ; support material
G1 X110.548 Y97.488 E2.32958 ; support material
G1 X110.379 Y96.856 E2.34588 ; support material
G1 X109.917 Y96.394 E2.36217 ; support material
G1 X109.285 Y96.224 E2.37847 ; support material
G1 X108.653 Y96.394 E2.39476 ; support material
G1 X108.190 Y96.856 E2.41106 ; support material
G1 X108.102 Y97.186 E2.41957 ; support material
G1 X107.665 Y97.172 E2.43045 ; support material
G1 X107.481 Y96.244 E2.45401 ; support material
G1 X107.092 Y95.662 E2.47144 ; support material
G1 X106.510 Y95.274 E2.48887 ; support material
G1 E0.48887 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X107.160 Y102.197 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X106.542 Y101.900 E2.01709 ; support material
G1 X105.856 Y101.900 E2.03418 ; support material
G1 X105.238 Y102.197 E2.05127 ; support material
G1 X104.810 Y102.734 E2.06837 ; support material
G1 X104.657 Y103.403 E2.08546 ; support material
G1 X104.810 Y104.072 E2.10255 ; support material
G1 X105.238 Y104.608 E2.11964 ; support material
G1 X105.856 Y104.906 E2.13673 ; support material
G1 X106.542 Y104.906 E2.15382 ; support material
G1 X107.160 Y104.608 E2.17092 ; support material
G1 X107.877 Y103.710 E2.19954 ; support material
G1 X108.263 Y104.446 E2.22023 ; support material
G1 X108.799 Y104.816 E2.23646 ; support material
G1 X109.446 Y104.894 E2.25268 ; support material
G1 X110.055 Y104.663 E2.26891 ; support material
G1 X110.486 Y104.176 E2.28513 ; support material
G1 X110.642 Y103.543 E2.30135 ; support material
G1 X110.486 Y102.911 E2.31758 ; support material
G1 X110.055 Y102.423 E2.33380 ; support material
G1 X109.446 Y102.192 E2.35002 ; support material
G1 X108.799 Y102.271 E2.36625 ; support material
G1 X108.263 Y102.641 E2.38247 ; support material
G1 X107.778 Y103.565 E2.40847 ; support material
G1 X107.588 Y102.734 E2.42971 ; support material
G1 X107.160 Y102.197 E2.44680 ; support material
G1 Z4.850 F7800.000 ; move to next layer (28)
G1 E0.44680 F2400.00000 ; retract extruder 0
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
G1 Z5.050 F7800.000 ; move to next layer (29)
G1 E0.64423 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X102.885 Y104.851 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X102.390 Y104.565 E2.01425 ; support material
G1 X101.827 Y104.664 E2.02849 ; support material
G1 X101.559 Y104.983 E2.03887 ; support material
G1 X101.014 Y104.837 E2.05293 ; support material
G1 X100.382 Y105.006 E2.06923 ; support material
G1 X99.919 Y105.469 E2.08552 ; support material
G1 X99.750 Y106.101 E2.10182 ; support material
G1 X99.919 Y106.733 E2.11811 ; support material
G1 X100.382 Y107.195 E2.13441 ; support material
G1 X101.014 Y107.365 E2.15071 ; support material
G1 X101.492 Y107.237 E2.16303 ; support material
G1 X101.492 Y107.852 E2.17835 ; support material
G1 X101.859 Y108.290 E2.19260 ; support material
G1 X102.422 Y108.389 E2.20684 ; support material
G1 X102.918 Y108.103 E2.22109 ; support material
G1 X103.113 Y107.566 E2.23534 ; support material
G1 X102.918 Y107.028 E2.24958 ; support material
G1 X101.946 Y106.467 E2.27753 ; support material
G1 X102.885 Y105.925 E2.30453 ; support material
G1 X103.081 Y105.388 E2.31878 ; support material
G1 X102.885 Y104.851 E2.33303 ; support material
G1 E0.33303 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X105.810 Y107.425 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X105.314 Y107.139 E2.01425 ; support material
G1 X104.751 Y107.238 E2.02849 ; support material
G1 X104.383 Y107.676 E2.04274 ; support material
G1 X104.383 Y108.248 E2.05698 ; support material
G1 X104.751 Y108.686 E2.07123 ; support material
G1 X105.314 Y108.785 E2.08548 ; support material
G1 X105.810 Y108.499 E2.09972 ; support material
G1 X106.005 Y107.962 E2.11397 ; support material
G1 X105.810 Y107.425 E2.12822 ; support material
G1 E0.12822 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X108.809 Y107.461 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X108.313 Y107.175 E2.01425 ; support material
G1 X107.750 Y107.274 E2.02849 ; support material
G1 X107.382 Y107.712 E2.04274 ; support material
G1 X107.382 Y108.284 E2.05698 ; support material
G1 X107.750 Y108.722 E2.07123 ; support material
G1 X108.313 Y108.821 E2.08548 ; support material
G1 X108.809 Y108.535 E2.09972 ; support material
G1 X109.004 Y107.998 E2.11397 ; support material
G1 X108.809 Y107.461 E2.12822 ; support material
G1 E0.12822 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X108.809 Y110.461 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X108.313 Y110.175 E2.01425 ; support material
G1 X107.750 Y110.274 E2.02849 ; support material
G1 X107.382 Y110.713 E2.04274 ; support material
G1 X107.382 Y111.284 E2.05698 ; support material
G1 X107.750 Y111.723 E2.07123 ; support material
G1 X108.313 Y111.822 E2.08548 ; support material
G1 X108.809 Y111.536 E2.09972 ; support material
G1 X109.004 Y110.998 E2.11397 ; support material
G1 X108.809 Y110.461 E2.12822 ; support material
G1 E0.12822 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X105.809 Y110.441 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X105.314 Y110.155 E2.01425 ; support material
G1 X104.750 Y110.254 E2.02849 ; support material
G1 X104.383 Y110.693 E2.04274 ; support material
G1 X104.383 Y111.264 E2.05698 ; support material
G1 X104.750 Y111.703 E2.07123 ; support material
G1 X105.314 Y111.802 E2.08548 ; support material
G1 X105.809 Y111.516 E2.09972 ; support material
G1 X106.004 Y110.978 E2.11397 ; support material
G1 X105.809 Y110.441 E2.12822 ; support material
G1 E0.12822 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X102.737 Y109.751 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X102.150 Y109.528 E2.01565 ; support material
G1 X101.526 Y109.604 E2.03131 ; support material
G1 X101.009 Y109.961 E2.04696 ; support material
G1 X100.717 Y110.518 E2.06262 ; support material
G1 X100.717 Y111.146 E2.07827 ; support material
G1 X101.009 Y111.703 E2.09393 ; support material
G1 X101.526 Y112.060 E2.10958 ; support material
G1 X102.150 Y112.135 E2.12524 ; support material
G1 X102.737 Y111.912 E2.14089 ; support material
G1 X103.154 Y111.442 E2.15655 ; support material
G1 X103.305 Y110.832 E2.17220 ; support material
G1 X103.154 Y110.222 E2.18786 ; support material
G1 X102.737 Y109.751 E2.20351 ; support material
G1 E0.20351 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X96.431 Y109.906 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X95.455 Y109.536 E2.02601 ; support material
G1 X95.455 Y109.731 E2.03086 ; support material
G1 X95.220 Y109.759 E2.03676 ; support material
G1 X94.703 Y110.116 E2.05241 ; support material
G1 X94.411 Y110.673 E2.06807 ; support material
G1 X94.411 Y111.301 E2.08372 ; support material
G1 X94.703 Y111.858 E2.09938 ; support material
G1 X95.220 Y112.215 E2.11503 ; support material
G1 X95.844 Y112.290 E2.13069 ; support material
G1 X96.431 Y112.068 E2.14634 ; support material
G1 X96.848 Y111.597 E2.16200 ; support material
G1 X96.999 Y110.987 E2.17765 ; support material
G1 X96.848 Y110.377 E2.19331 ; support material
G1 X96.431 Y109.906 E2.20896 ; support material
G1 E0.20896 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X96.431 Y106.906 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X95.455 Y106.536 E2.02601 ; support material
G1 X95.455 Y106.731 E2.03086 ; support material
G1 X95.220 Y106.759 E2.03676 ; support material
G1 X94.703 Y107.116 E2.05241 ; support material
G1 X94.411 Y107.673 E2.06807 ; support material
G1 X94.411 Y108.301 E2.08372 ; support material
G1 X94.703 Y108.858 E2.09938 ; support material
G1 X95.220 Y109.215 E2.11503 ; support material
G1 X95.455 Y109.243 E2.12093 ; support material
G1 X95.455 Y109.438 E2.12578 ; support material
G1 X96.431 Y109.068 E2.15179 ; support material
G1 X96.848 Y108.597 E2.16745 ; support material
G1 X96.999 Y107.987 E2.18310 ; support material
G1 X96.848 Y107.377 E2.19876 ; support material
G1 X96.431 Y106.906 E2.21441 ; support material
G1 E0.21441 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X96.431 Y103.906 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X95.844 Y103.683 E2.01565 ; support material
G1 X95.220 Y103.759 E2.03131 ; support material
G1 X94.703 Y104.116 E2.04696 ; support material
G1 X94.411 Y104.673 E2.06262 ; support material
G1 X94.411 Y105.301 E2.07827 ; support material
G1 X94.703 Y105.858 E2.09393 ; support material
G1 X95.220 Y106.215 E2.10958 ; support material
G1 X95.455 Y106.243 E2.11548 ; support material
G1 X95.455 Y106.438 E2.12033 ; support material
G1 X96.431 Y106.068 E2.14634 ; support material
G1 X96.848 Y105.597 E2.16200 ; support material
G1 X96.999 Y104.987 E2.17765 ; support material
G1 X96.848 Y104.377 E2.19331 ; support material
G1 X96.431 Y103.906 E2.20896 ; support material
G1 E0.20896 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.083 Y100.183 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.587 Y99.897 E2.01425 ; support material
G1 X94.024 Y99.996 E2.02849 ; support material
G1 X93.657 Y100.434 E2.04274 ; support material
G1 X93.657 Y101.006 E2.05698 ; support material
G1 X94.024 Y101.444 E2.07123 ; support material
G1 X94.587 Y101.543 E2.08548 ; support material
G1 X95.083 Y101.258 E2.09972 ; support material
G1 X95.278 Y100.720 E2.11397 ; support material
G1 X95.083 Y100.183 E2.12822 ; support material
G1 E0.12822 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.715 Y99.556 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.091 Y99.466 E2.01570 ; support material
G1 X90.517 Y99.728 E2.03140 ; support material
G1 X90.177 Y100.258 E2.04711 ; support material
G1 X90.177 Y100.888 E2.06281 ; support material
G1 X90.517 Y101.419 E2.07851 ; support material
G1 X91.091 Y101.681 E2.09421 ; support material
G1 X91.715 Y101.591 E2.10992 ; support material
G1 X92.191 Y101.178 E2.12562 ; support material
G1 X92.369 Y100.573 E2.14132 ; support material
G1 X92.191 Y99.968 E2.15702 ; support material
G1 X91.715 Y99.556 E2.17272 ; support material
G1 E0.17272 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.715 Y102.556 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.091 Y102.466 E2.01570 ; support material
G1 X90.517 Y102.728 E2.03140 ; support material
G1 X90.177 Y103.258 E2.04711 ; support material
G1 X90.177 Y103.888 E2.06281 ; support material
G1 X90.517 Y104.419 E2.07851 ; support material
G1 X91.091 Y104.681 E2.09421 ; support material
G1 X91.715 Y104.591 E2.10992 ; support material
G1 X92.191 Y104.178 E2.12562 ; support material
G1 X92.369 Y103.573 E2.14132 ; support material
G1 X92.191 Y102.968 E2.15702 ; support material
G1 X91.715 Y102.556 E2.17272 ; support material
G1 E0.17272 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.715 Y105.556 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.091 Y105.466 E2.01570 ; support material
G1 X90.517 Y105.728 E2.03140 ; support material
G1 X90.177 Y106.258 E2.04711 ; support material
G1 X90.177 Y106.888 E2.06281 ; support material
G1 X90.517 Y107.419 E2.07851 ; support material
G1 X91.091 Y107.681 E2.09421 ; support material
G1 X91.715 Y107.591 E2.10992 ; support material
G1 X92.191 Y107.178 E2.12562 ; support material
G1 X92.369 Y106.573 E2.14132 ; support material
G1 X92.191 Y105.968 E2.15702 ; support material
G1 X91.715 Y105.556 E2.17272 ; support material
G1 E0.17272 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.715 Y108.556 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.091 Y108.466 E2.01570 ; support material
G1 X90.517 Y108.728 E2.03140 ; support material
G1 X90.177 Y109.258 E2.04711 ; support material
G1 X90.177 Y109.888 E2.06281 ; support material
G1 X90.517 Y110.419 E2.07851 ; support material
G1 X91.091 Y110.681 E2.09421 ; support material
G1 X91.715 Y110.591 E2.10992 ; support material
G1 X92.191 Y110.178 E2.12562 ; support material
G1 X92.369 Y109.573 E2.14132 ; support material
G1 X92.191 Y108.968 E2.15702 ; support material
G1 X91.715 Y108.556 E2.17272 ; support material
G1 E0.17272 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.903 Y95.513 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.250 Y95.383 E2.01659 ; support material
G1 X90.597 Y95.513 E2.03318 ; support material
G1 X90.043 Y95.883 E2.04977 ; support material
G1 X89.673 Y96.437 E2.06637 ; support material
G1 X89.543 Y97.090 E2.08296 ; support material
G1 X89.673 Y97.744 E2.09955 ; support material
G1 X90.043 Y98.298 E2.11614 ; support material
G1 X90.597 Y98.668 E2.13273 ; support material
G1 X91.250 Y98.798 E2.14932 ; support material
G1 X91.903 Y98.668 E2.16591 ; support material
G1 X92.457 Y98.298 E2.18251 ; support material
G1 X92.827 Y97.744 E2.19910 ; support material
G1 X92.957 Y97.090 E2.21569 ; support material
G1 X92.827 Y96.437 E2.23228 ; support material
G1 X92.457 Y95.883 E2.24887 ; support material
G1 X91.903 Y95.513 E2.26546 ; support material
G1 E0.26546 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X97.438 Y95.412 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X96.943 Y95.126 E2.01425 ; support material
G1 X96.379 Y95.225 E2.02849 ; support material
G1 X96.247 Y95.383 E2.03362 ; support material
G1 X95.831 Y95.143 E2.04560 ; support material
G1 X95.267 Y95.242 E2.05984 ; support material
G1 X94.900 Y95.680 E2.07409 ; support material
G1 X94.900 Y96.252 E2.08834 ; support material
G1 X95.241 Y96.659 E2.10156 ; support material
G1 X94.944 Y97.013 E2.11306 ; support material
G1 X94.802 Y96.931 E2.11716 ; support material
G1 X94.239 Y97.030 E2.13141 ; support material
G1 X93.871 Y97.468 E2.14565 ; support material
G1 X93.871 Y98.040 E2.15990 ; support material
G1 X94.239 Y98.478 E2.17414 ; support material
G1 X94.802 Y98.577 E2.18839 ; support material
G1 X95.297 Y98.291 E2.20264 ; support material
G1 X95.493 Y97.754 E2.21688 ; support material
G1 X95.297 Y97.216 E2.23113 ; support material
G1 X95.150 Y97.131 E2.23537 ; support material
G1 X95.308 Y96.698 E2.24687 ; support material
G1 X95.831 Y96.790 E2.26010 ; support material
G1 X96.266 Y96.538 E2.27262 ; support material
G1 X96.379 Y96.674 E2.27701 ; support material
G1 X96.943 Y96.773 E2.29126 ; support material
G1 X97.438 Y96.487 E2.30551 ; support material
G1 X97.634 Y95.950 E2.31975 ; support material
G1 X97.438 Y95.412 E2.33400 ; support material
G1 E0.33400 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X101.789 Y94.040 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X101.294 Y93.754 E2.01425 ; support material
G1 X100.730 Y93.853 E2.02849 ; support material
G1 X100.363 Y94.291 E2.04274 ; support material
G1 X100.363 Y94.863 E2.05698 ; support material
G1 X100.730 Y95.301 E2.07123 ; support material
G1 X101.294 Y95.401 E2.08548 ; support material
G1 X101.789 Y95.115 E2.09972 ; support material
G1 X101.984 Y94.577 E2.11397 ; support material
G1 X101.789 Y94.040 E2.12822 ; support material
G1 E0.12822 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X102.885 Y89.851 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X102.390 Y89.565 E2.01425 ; support material
G1 X101.827 Y89.664 E2.02849 ; support material
G1 X101.559 Y89.983 E2.03887 ; support material
G1 X101.014 Y89.837 E2.05293 ; support material
G1 X100.382 Y90.006 E2.06923 ; support material
G1 X99.919 Y90.469 E2.08552 ; support material
G1 X99.750 Y91.101 E2.10182 ; support material
G1 X99.919 Y91.733 E2.11811 ; support material
G1 X100.382 Y92.195 E2.13441 ; support material
G1 X101.014 Y92.365 E2.15071 ; support material
G1 X101.492 Y92.237 E2.16303 ; support material
G1 X101.492 Y92.852 E2.17835 ; support material
G1 X101.859 Y93.290 E2.19260 ; support material
G1 X102.422 Y93.389 E2.20684 ; support material
G1 X102.918 Y93.103 E2.22109 ; support material
G1 X103.113 Y92.566 E2.23534 ; support material
G1 X102.918 Y92.028 E2.24958 ; support material
G1 X101.946 Y91.467 E2.27753 ; support material
G1 X102.885 Y90.925 E2.30453 ; support material
G1 X103.081 Y90.388 E2.31878 ; support material
G1 X102.885 Y89.851 E2.33302 ; support material
G1 E0.33302 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.123 Y89.793 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X105.628 Y89.507 E2.01425 ; support material
G1 X105.065 Y89.606 E2.02849 ; support material
G1 X104.697 Y90.044 E2.04274 ; support material
G1 X104.697 Y90.616 E2.05698 ; support material
G1 X105.065 Y91.054 E2.07123 ; support material
G1 X105.628 Y91.153 E2.08548 ; support material
G1 X106.123 Y90.867 E2.09972 ; support material
G1 X106.319 Y90.330 E2.11397 ; support material
G1 X106.123 Y89.793 E2.12822 ; support material
G1 E0.12822 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.123 Y92.133 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X105.628 Y91.847 E2.01425 ; support material
G1 X105.065 Y91.946 E2.02849 ; support material
G1 X104.697 Y92.384 E2.04274 ; support material
G1 X104.697 Y92.956 E2.05698 ; support material
G1 X105.065 Y93.394 E2.07123 ; support material
G1 X105.628 Y93.493 E2.08548 ; support material
G1 X106.123 Y93.207 E2.09972 ; support material
G1 X106.319 Y92.670 E2.11397 ; support material
G1 X106.123 Y92.133 E2.12822 ; support material
G1 E0.12822 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X109.123 Y92.147 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X108.628 Y91.862 E2.01425 ; support material
G1 X108.065 Y91.961 E2.02849 ; support material
G1 X107.697 Y92.399 E2.04274 ; support material
G1 X107.697 Y92.971 E2.05698 ; support material
G1 X108.065 Y93.409 E2.07123 ; support material
G1 X108.628 Y93.508 E2.08548 ; support material
G1 X109.123 Y93.222 E2.09972 ; support material
G1 X109.319 Y92.685 E2.11397 ; support material
G1 X109.123 Y92.147 E2.12822 ; support material
G1 E0.12822 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X109.123 Y89.778 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X108.628 Y89.492 E2.01425 ; support material
G1 X108.065 Y89.591 E2.02849 ; support material
G1 X107.697 Y90.029 E2.04274 ; support material
G1 X107.697 Y90.601 E2.05698 ; support material
G1 X108.065 Y91.039 E2.07123 ; support material
G1 X108.628 Y91.138 E2.08548 ; support material
G1 X109.123 Y90.852 E2.09972 ; support material
G1 X109.319 Y90.315 E2.11397 ; support material
G1 X109.123 Y89.778 E2.12822 ; support material
G1 E0.12822 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.199 Y95.224 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X105.513 Y95.087 E2.01743 ; support material
G1 X104.827 Y95.224 E2.03486 ; support material
G1 X104.245 Y95.612 E2.05229 ; support material
G1 X103.856 Y96.194 E2.06972 ; support material
G1 X103.720 Y96.880 E2.08715 ; support material
G1 X103.856 Y97.567 E2.10458 ; support material
G1 X104.245 Y98.148 E2.12201 ; support material
G1 X104.827 Y98.537 E2.13944 ; support material
G1 X105.513 Y98.674 E2.15687 ; support material
G1 X106.199 Y98.537 E2.17430 ; support material
G1 X106.781 Y98.148 E2.19172 ; support material
G1 X107.170 Y97.567 E2.20915 ; support material
G1 X107.307 Y96.880 E2.22658 ; support material
G1 X107.170 Y96.194 E2.24401 ; support material
G1 X106.781 Y95.612 E2.26144 ; support material
G1 X106.199 Y95.224 E2.27887 ; support material
G1 E0.27887 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.227 Y96.444 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X109.595 Y96.274 E2.01630 ; support material
G1 X108.963 Y96.444 E2.03259 ; support material
G1 X108.501 Y96.906 E2.04889 ; support material
G1 X108.331 Y97.538 E2.06518 ; support material
G1 X108.501 Y98.170 E2.08148 ; support material
G1 X108.963 Y98.633 E2.09778 ; support material
G1 X109.595 Y98.802 E2.11407 ; support material
G1 X110.227 Y98.633 E2.13037 ; support material
G1 X110.690 Y98.170 E2.14666 ; support material
G1 X110.859 Y97.538 E2.16296 ; support material
G1 X110.690 Y96.906 E2.17926 ; support material
G1 X110.227 Y96.444 E2.19555 ; support material
G1 E0.19555 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X109.958 Y102.693 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X109.463 Y102.407 E2.01425 ; support material
G1 X108.900 Y102.507 E2.02849 ; support material
G1 X108.532 Y102.945 E2.04274 ; support material
G1 X108.532 Y103.661 E2.06058 ; support material
G1 X108.435 Y103.776 E2.06433 ; support material
G1 X108.435 Y104.348 E2.07857 ; support material
G1 X108.803 Y104.786 E2.09282 ; support material
G1 X109.366 Y104.886 E2.10707 ; support material
G1 X109.862 Y104.600 E2.12131 ; support material
G1 X110.057 Y104.062 E2.13556 ; support material
G1 X109.954 Y103.779 E2.14306 ; support material
G1 X110.154 Y103.231 E2.15760 ; support material
G1 X109.958 Y102.693 E2.17185 ; support material
G1 E0.17185 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.681 Y102.071 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X106.057 Y101.981 E2.01570 ; support material
G1 X105.484 Y102.243 E2.03140 ; support material
G1 X105.143 Y102.773 E2.04711 ; support material
G1 X105.143 Y103.404 E2.06281 ; support material
G1 X105.378 Y103.769 E2.07363 ; support material
G1 X105.378 Y104.343 E2.08793 ; support material
G1 X105.745 Y104.781 E2.10218 ; support material
G1 X106.309 Y104.881 E2.11642 ; support material
G1 X106.804 Y104.595 E2.13067 ; support material
G1 X107.000 Y104.057 E2.14492 ; support material
G1 X106.937 Y103.885 E2.14950 ; support material
G1 X107.157 Y103.693 E2.15677 ; support material
G1 X107.335 Y103.089 E2.17247 ; support material
G1 X107.157 Y102.484 E2.18817 ; support material
G1 X106.681 Y102.071 E2.20388 ; support material
G1 E0.20388 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X98.059 Y90.166 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X97.427 Y89.997 E2.01630 ; support material
G1 X96.795 Y90.166 E2.03259 ; support material
G1 X96.236 Y90.725 E2.05229 ; support material
G1 X95.688 Y90.178 E2.07157 ; support material
G1 X95.056 Y90.009 E2.08787 ; support material
G1 X94.424 Y90.178 E2.10417 ; support material
G1 X93.962 Y90.640 E2.12046 ; support material
G1 X93.792 Y91.272 E2.13676 ; support material
G1 X93.962 Y91.904 E2.15305 ; support material
G1 X94.424 Y92.367 E2.16935 ; support material
G1 X95.056 Y92.536 E2.18565 ; support material
G1 X95.688 Y92.367 E2.20194 ; support material
G1 X96.247 Y91.808 E2.22164 ; support material
G1 X96.795 Y92.355 E2.24092 ; support material
G1 X97.427 Y92.524 E2.25722 ; support material
G1 X98.059 Y92.355 E2.27352 ; support material
G1 X98.521 Y91.893 E2.28981 ; support material
G1 X98.691 Y91.261 E2.30611 ; support material
G1 X98.521 Y90.629 E2.32240 ; support material
G1 X98.059 Y90.166 E2.33870 ; support material
G1 E0.33870 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.989 Y89.609 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.329 Y89.477 E2.01677 ; support material
G1 X90.668 Y89.609 E2.03355 ; support material
G1 X90.108 Y89.983 E2.05032 ; support material
G1 X89.734 Y90.543 E2.06710 ; support material
G1 X89.603 Y91.203 E2.08387 ; support material
G1 X89.734 Y91.864 E2.10064 ; support material
G1 X90.108 Y92.424 E2.11742 ; support material
G1 X90.668 Y92.798 E2.13419 ; support material
G1 X91.329 Y92.929 E2.15097 ; support material
G1 X91.989 Y92.798 E2.16774 ; support material
G1 X92.549 Y92.424 E2.18452 ; support material
G1 X92.923 Y91.864 E2.20129 ; support material
G1 X93.054 Y91.203 E2.21806 ; support material
G1 X92.923 Y90.543 E2.23484 ; support material
G1 X92.549 Y89.983 E2.25161 ; support material
G1 X91.989 Y89.609 E2.26839 ; support material
G1 Z5.150 F7800.000 ; move to next layer (30)
G1 E0.26839 F2400.00000 ; retract extruder 0
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
G1 Z5.425 F7800.000 ; move to next layer (31)
G1 E0.64423 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.132 Y104.714 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X102.656 Y104.440 E2.01367 ; support material
G1 X102.116 Y104.535 E2.02734 ; support material
G1 X101.763 Y104.956 E2.04101 ; support material
G1 X101.763 Y105.269 E2.04880 ; support material
G1 X100.741 Y104.995 E2.07515 ; support material
G1 X100.109 Y105.164 E2.09144 ; support material
G1 X99.647 Y105.627 E2.10774 ; support material
G1 X99.477 Y106.259 E2.12404 ; support material
G1 X99.647 Y106.891 E2.14033 ; support material
G1 X100.109 Y107.353 E2.15663 ; support material
G1 X100.741 Y107.523 E2.17292 ; support material
G1 X101.763 Y107.249 E2.19927 ; support material
G1 X101.763 Y108.044 E2.21908 ; support material
G1 X102.116 Y108.465 E2.23275 ; support material
G1 X102.656 Y108.560 E2.24642 ; support material
G1 X103.132 Y108.286 E2.26010 ; support material
G1 X103.319 Y107.770 E2.27377 ; support material
G1 X103.132 Y107.254 E2.28744 ; support material
G1 X102.656 Y106.980 E2.30111 ; support material
G1 X101.770 Y107.136 E2.32352 ; support material
G1 X102.005 Y106.259 E2.34614 ; support material
G1 X101.906 Y105.888 E2.35570 ; support material
G1 X102.656 Y106.020 E2.37468 ; support material
G1 X103.132 Y105.746 E2.38835 ; support material
G1 X103.319 Y105.230 E2.40202 ; support material
G1 X103.132 Y104.714 E2.41569 ; support material
G1 E0.41569 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.098 Y107.469 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X105.622 Y107.195 E2.01367 ; support material
G1 X105.082 Y107.290 E2.02734 ; support material
G1 X104.729 Y107.710 E2.04101 ; support material
G1 X104.729 Y108.259 E2.05468 ; support material
G1 X105.082 Y108.680 E2.06836 ; support material
G1 X105.622 Y108.775 E2.08203 ; support material
G1 X106.098 Y108.500 E2.09570 ; support material
G1 X106.285 Y107.985 E2.10937 ; support material
G1 X106.098 Y107.469 E2.12304 ; support material
G1 E0.12304 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X109.097 Y107.484 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X108.622 Y107.209 E2.01367 ; support material
G1 X108.082 Y107.305 E2.02734 ; support material
G1 X107.729 Y107.725 E2.04101 ; support material
G1 X107.729 Y108.274 E2.05468 ; support material
G1 X108.082 Y108.694 E2.06836 ; support material
G1 X108.622 Y108.790 E2.08203 ; support material
G1 X109.097 Y108.515 E2.09570 ; support material
G1 X109.285 Y108.000 E2.10937 ; support material
G1 X109.097 Y107.484 E2.12304 ; support material
G1 E0.12304 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X109.097 Y110.484 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X108.622 Y110.209 E2.01367 ; support material
G1 X108.082 Y110.305 E2.02734 ; support material
G1 X107.729 Y110.725 E2.04101 ; support material
G1 X107.729 Y111.274 E2.05468 ; support material
G1 X108.082 Y111.694 E2.06836 ; support material
G1 X108.622 Y111.790 E2.08203 ; support material
G1 X109.097 Y111.515 E2.09570 ; support material
G1 X109.285 Y111.000 E2.10937 ; support material
G1 X109.097 Y110.484 E2.12304 ; support material
G1 E0.12304 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.097 Y110.473 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X105.622 Y110.199 E2.01367 ; support material
G1 X105.082 Y110.294 E2.02734 ; support material
G1 X104.729 Y110.714 E2.04101 ; support material
G1 X104.729 Y111.263 E2.05468 ; support material
G1 X105.082 Y111.684 E2.06836 ; support material
G1 X105.622 Y111.779 E2.08203 ; support material
G1 X106.097 Y111.505 E2.09570 ; support material
G1 X106.285 Y110.989 E2.10937 ; support material
G1 X106.097 Y110.473 E2.12304 ; support material
G1 E0.12304 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X102.134 Y110.187 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X101.818 Y110.005 E2.00908 ; support material
G1 X101.278 Y110.100 E2.02275 ; support material
G1 X100.925 Y110.521 E2.03642 ; support material
G1 X100.925 Y111.070 E2.05009 ; support material
G1 X101.278 Y111.490 E2.06376 ; support material
G1 X101.818 Y111.585 E2.07743 ; support material
G1 X102.000 Y111.480 E2.08266 ; support material
G1 X102.088 Y111.585 E2.08607 ; support material
G1 X102.628 Y111.680 E2.09974 ; support material
G1 X103.104 Y111.406 E2.11341 ; support material
G1 X103.291 Y110.890 E2.12708 ; support material
G1 X103.104 Y110.374 E2.14075 ; support material
G1 X102.628 Y110.100 E2.15442 ; support material
G1 X102.134 Y110.187 E2.16693 ; support material
G1 E0.16693 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.953 Y110.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X95.510 Y110.195 E2.01274 ; support material
G1 X94.970 Y110.290 E2.02641 ; support material
G1 X94.617 Y110.710 E2.04008 ; support material
G1 X94.617 Y111.259 E2.05375 ; support material
G1 X94.970 Y111.680 E2.06742 ; support material
G1 X95.510 Y111.775 E2.08109 ; support material
G1 X95.945 Y111.524 E2.09359 ; support material
G1 X96.082 Y111.687 E2.09889 ; support material
G1 X96.622 Y111.782 E2.11256 ; support material
G1 X97.097 Y111.508 E2.12623 ; support material
G1 X97.285 Y110.992 E2.13991 ; support material
G1 X97.097 Y110.476 E2.15358 ; support material
G1 X96.622 Y110.202 E2.16725 ; support material
G1 X96.082 Y110.297 E2.18092 ; support material
G1 X95.953 Y110.450 E2.18589 ; support material
G1 E0.18589 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.953 Y107.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X95.510 Y107.195 E2.01274 ; support material
G1 X94.970 Y107.290 E2.02641 ; support material
G1 X94.617 Y107.710 E2.04008 ; support material
G1 X94.617 Y108.259 E2.05375 ; support material
G1 X94.970 Y108.680 E2.06742 ; support material
G1 X95.510 Y108.775 E2.08109 ; support material
G1 X95.945 Y108.524 E2.09359 ; support material
G1 X96.082 Y108.687 E2.09889 ; support material
G1 X96.622 Y108.782 E2.11256 ; support material
G1 X97.097 Y108.508 E2.12623 ; support material
G1 X97.285 Y107.992 E2.13991 ; support material
G1 X97.097 Y107.476 E2.15358 ; support material
G1 X96.622 Y107.202 E2.16725 ; support material
G1 X96.082 Y107.297 E2.18092 ; support material
G1 X95.953 Y107.450 E2.18589 ; support material
G1 E0.18589 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.953 Y104.450 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X95.510 Y104.195 E2.01274 ; support material
G1 X94.970 Y104.290 E2.02641 ; support material
G1 X94.617 Y104.710 E2.04008 ; support material
G1 X94.617 Y105.259 E2.05375 ; support material
G1 X94.970 Y105.680 E2.06742 ; support material
G1 X95.510 Y105.775 E2.08109 ; support material
G1 X95.945 Y105.524 E2.09359 ; support material
G1 X96.082 Y105.687 E2.09889 ; support material
G1 X96.622 Y105.782 E2.11256 ; support material
G1 X97.097 Y105.508 E2.12623 ; support material
G1 X97.285 Y104.992 E2.13991 ; support material
G1 X97.097 Y104.476 E2.15358 ; support material
G1 X96.622 Y104.202 E2.16725 ; support material
G1 X96.082 Y104.297 E2.18092 ; support material
G1 X95.953 Y104.450 E2.18589 ; support material
G1 E0.18589 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.045 Y100.519 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.570 Y100.244 E2.01367 ; support material
G1 X94.030 Y100.340 E2.02734 ; support material
G1 X93.677 Y100.760 E2.04101 ; support material
G1 X93.677 Y101.309 E2.05468 ; support material
G1 X94.030 Y101.729 E2.06836 ; support material
G1 X94.570 Y101.825 E2.08203 ; support material
G1 X95.045 Y101.550 E2.09570 ; support material
G1 X95.233 Y101.035 E2.10937 ; support material
G1 X95.045 Y100.519 E2.12304 ; support material
G1 E0.12304 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.154 Y97.530 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.679 Y97.256 E2.01367 ; support material
G1 X94.139 Y97.351 E2.02734 ; support material
G1 X93.786 Y97.772 E2.04101 ; support material
G1 X93.786 Y98.320 E2.05468 ; support material
G1 X94.139 Y98.741 E2.06836 ; support material
G1 X94.679 Y98.836 E2.08203 ; support material
G1 X95.154 Y98.562 E2.09570 ; support material
G1 X95.342 Y98.046 E2.10937 ; support material
G1 X95.154 Y97.530 E2.12304 ; support material
G1 E0.12304 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X97.412 Y95.434 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X96.937 Y95.159 E2.01367 ; support material
G1 X96.396 Y95.255 E2.02734 ; support material
G1 X96.149 Y95.550 E2.03693 ; support material
G1 X95.510 Y95.181 E2.05530 ; support material
G1 X94.970 Y95.276 E2.06897 ; support material
G1 X94.617 Y95.697 E2.08264 ; support material
G1 X94.617 Y96.245 E2.09631 ; support material
G1 X94.970 Y96.666 E2.10998 ; support material
G1 X95.510 Y96.761 E2.12366 ; support material
G1 X96.173 Y96.378 E2.14272 ; support material
G1 X96.396 Y96.644 E2.15137 ; support material
G1 X96.937 Y96.740 E2.16504 ; support material
G1 X97.412 Y96.465 E2.17871 ; support material
G1 X97.600 Y95.950 E2.19238 ; support material
G1 X97.412 Y95.434 E2.20605 ; support material
G1 E0.20605 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X101.573 Y94.313 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X101.098 Y94.038 E2.01367 ; support material
G1 X100.557 Y94.133 E2.02734 ; support material
G1 X100.205 Y94.554 E2.04101 ; support material
G1 X100.205 Y95.103 E2.05468 ; support material
G1 X100.557 Y95.523 E2.06836 ; support material
G1 X101.098 Y95.618 E2.08203 ; support material
G1 X101.573 Y95.344 E2.09570 ; support material
G1 X101.761 Y94.828 E2.10937 ; support material
G1 X101.573 Y94.313 E2.12304 ; support material
G1 E0.12304 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.202 Y95.538 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X105.516 Y95.402 E2.01743 ; support material
G1 X104.829 Y95.538 E2.03486 ; support material
G1 X104.248 Y95.927 E2.05229 ; support material
G1 X103.859 Y96.509 E2.06972 ; support material
G1 X103.722 Y97.195 E2.08715 ; support material
G1 X103.859 Y97.881 E2.10458 ; support material
G1 X104.248 Y98.463 E2.12201 ; support material
G1 X104.829 Y98.852 E2.13944 ; support material
G1 X105.516 Y98.988 E2.15687 ; support material
G1 X106.202 Y98.852 E2.17430 ; support material
G1 X106.784 Y98.463 E2.19172 ; support material
G1 X107.172 Y97.881 E2.20915 ; support material
G1 X107.309 Y97.195 E2.22658 ; support material
G1 X107.172 Y96.509 E2.24401 ; support material
G1 X106.784 Y95.927 E2.26144 ; support material
G1 X106.202 Y95.538 E2.27887 ; support material
G1 E0.27887 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.098 Y92.469 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X105.622 Y92.195 E2.01367 ; support material
G1 X105.082 Y92.290 E2.02734 ; support material
G1 X104.729 Y92.710 E2.04101 ; support material
G1 X104.729 Y93.259 E2.05468 ; support material
G1 X105.082 Y93.680 E2.06836 ; support material
G1 X105.622 Y93.775 E2.08203 ; support material
G1 X106.098 Y93.500 E2.09570 ; support material
G1 X106.285 Y92.985 E2.10937 ; support material
G1 X106.098 Y92.469 E2.12304 ; support material
G1 E0.12304 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.098 Y89.500 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X105.622 Y89.225 E2.01367 ; support material
G1 X105.082 Y89.320 E2.02734 ; support material
G1 X104.729 Y89.741 E2.04101 ; support material
G1 X104.729 Y90.290 E2.05468 ; support material
G1 X105.082 Y90.710 E2.06836 ; support material
G1 X105.622 Y90.805 E2.08203 ; support material
G1 X106.098 Y90.531 E2.09570 ; support material
G1 X106.285 Y90.015 E2.10937 ; support material
G1 X106.098 Y89.500 E2.12304 ; support material
G1 E0.12304 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.132 Y89.714 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X102.656 Y89.440 E2.01367 ; support material
G1 X102.116 Y89.535 E2.02734 ; support material
G1 X101.763 Y89.956 E2.04101 ; support material
G1 X101.763 Y90.269 E2.04880 ; support material
G1 X100.741 Y89.995 E2.07515 ; support material
G1 X100.109 Y90.164 E2.09144 ; support material
G1 X99.647 Y90.627 E2.10774 ; support material
G1 X99.477 Y91.259 E2.12404 ; support material
G1 X99.647 Y91.891 E2.14033 ; support material
G1 X100.109 Y92.353 E2.15663 ; support material
G1 X100.741 Y92.523 E2.17292 ; support material
G1 X101.763 Y92.249 E2.19927 ; support material
G1 X101.763 Y93.044 E2.21908 ; support material
G1 X102.116 Y93.465 E2.23275 ; support material
G1 X102.656 Y93.560 E2.24642 ; support material
G1 X103.132 Y93.286 E2.26010 ; support material
G1 X103.319 Y92.770 E2.27377 ; support material
G1 X103.132 Y92.254 E2.28744 ; support material
G1 X102.656 Y91.980 E2.30111 ; support material
G1 X101.770 Y92.136 E2.32352 ; support material
G1 X102.005 Y91.259 E2.34614 ; support material
G1 X101.906 Y90.888 E2.35570 ; support material
G1 X102.656 Y91.020 E2.37468 ; support material
G1 X103.132 Y90.746 E2.38835 ; support material
G1 X103.319 Y90.230 E2.40202 ; support material
G1 X103.132 Y89.714 E2.41569 ; support material
G1 E0.41569 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X98.373 Y90.165 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X97.741 Y89.995 E2.01630 ; support material
G1 X97.109 Y90.165 E2.03259 ; support material
G1 X96.647 Y90.627 E2.04889 ; support material
G1 X96.477 Y91.259 E2.06518 ; support material
G1 X96.647 Y91.891 E2.08148 ; support material
G1 X97.109 Y92.354 E2.09778 ; support material
G1 X97.741 Y92.523 E2.11407 ; support material
G1 X98.373 Y92.354 E2.13037 ; support material
G1 X98.836 Y91.891 E2.14666 ; support material
G1 X99.005 Y91.259 E2.16296 ; support material
G1 X98.836 Y90.627 E2.17926 ; support material
G1 X98.373 Y90.165 E2.19555 ; support material
G1 E0.19555 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.374 Y90.179 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.742 Y90.010 E2.01630 ; support material
G1 X94.110 Y90.179 E2.03259 ; support material
G1 X93.647 Y90.642 E2.04889 ; support material
G1 X93.478 Y91.274 E2.06518 ; support material
G1 X93.647 Y91.906 E2.08148 ; support material
G1 X94.110 Y92.368 E2.09778 ; support material
G1 X94.742 Y92.538 E2.11407 ; support material
G1 X95.374 Y92.368 E2.13037 ; support material
G1 X95.836 Y91.906 E2.14666 ; support material
G1 X96.005 Y91.274 E2.16296 ; support material
G1 X95.836 Y90.642 E2.17926 ; support material
G1 X95.374 Y90.179 E2.19555 ; support material
G1 E0.19555 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.674 Y89.602 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.014 Y89.471 E2.01677 ; support material
G1 X90.353 Y89.602 E2.03355 ; support material
G1 X89.794 Y89.976 E2.05032 ; support material
G1 X89.419 Y90.536 E2.06710 ; support material
G1 X89.288 Y91.197 E2.08387 ; support material
G1 X89.419 Y91.857 E2.10064 ; support material
G1 X89.794 Y92.417 E2.11742 ; support material
G1 X90.353 Y92.791 E2.13419 ; support material
G1 X91.014 Y92.923 E2.15097 ; support material
G1 X91.674 Y92.791 E2.16774 ; support material
G1 X92.234 Y92.417 E2.18452 ; support material
G1 X92.608 Y91.857 E2.20129 ; support material
G1 X92.740 Y91.197 E2.21806 ; support material
G1 X92.608 Y90.536 E2.23484 ; support material
G1 X92.234 Y89.976 E2.25161 ; support material
G1 X91.674 Y89.602 E2.26839 ; support material
G1 E0.26839 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.715 Y95.758 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.091 Y95.668 E2.01570 ; support material
G1 X90.517 Y95.930 E2.03140 ; support material
G1 X90.177 Y96.461 E2.04711 ; support material
G1 X90.177 Y97.091 E2.06281 ; support material
G1 X90.331 Y97.332 E2.06994 ; support material
G1 X90.177 Y97.573 E2.07707 ; support material
G1 X90.177 Y98.203 E2.09277 ; support material
G1 X90.517 Y98.733 E2.10847 ; support material
G1 X91.091 Y98.995 E2.12418 ; support material
G1 X91.715 Y98.905 E2.13988 ; support material
G1 X92.191 Y98.493 E2.15558 ; support material
G1 X92.369 Y97.888 E2.17128 ; support material
G1 X92.206 Y97.332 E2.18572 ; support material
G1 X92.369 Y96.776 E2.20015 ; support material
G1 X92.191 Y96.171 E2.21586 ; support material
G1 X91.715 Y95.758 E2.23156 ; support material
G1 E0.23156 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.715 Y99.870 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.091 Y99.780 E2.01570 ; support material
G1 X90.517 Y100.042 E2.03140 ; support material
G1 X90.177 Y100.573 E2.04711 ; support material
G1 X90.177 Y101.203 E2.06281 ; support material
G1 X90.517 Y101.733 E2.07851 ; support material
G1 X91.091 Y101.995 E2.09421 ; support material
G1 X91.715 Y101.905 E2.10992 ; support material
G1 X92.191 Y101.493 E2.12562 ; support material
G1 X92.369 Y100.888 E2.14132 ; support material
G1 X92.191 Y100.283 E2.15702 ; support material
G1 X91.715 Y99.870 E2.17272 ; support material
G1 E0.17272 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.715 Y102.870 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.091 Y102.780 E2.01570 ; support material
G1 X90.517 Y103.042 E2.03140 ; support material
G1 X90.177 Y103.573 E2.04711 ; support material
G1 X90.177 Y104.203 E2.06281 ; support material
G1 X90.517 Y104.733 E2.07851 ; support material
G1 X91.091 Y104.995 E2.09421 ; support material
G1 X91.715 Y104.905 E2.10992 ; support material
G1 X92.191 Y104.493 E2.12562 ; support material
G1 X92.369 Y103.888 E2.14132 ; support material
G1 X92.191 Y103.283 E2.15702 ; support material
G1 X91.715 Y102.870 E2.17272 ; support material
G1 E0.17272 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.715 Y105.870 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.091 Y105.780 E2.01570 ; support material
G1 X90.517 Y106.042 E2.03140 ; support material
G1 X90.177 Y106.573 E2.04711 ; support material
G1 X90.177 Y107.203 E2.06281 ; support material
G1 X90.517 Y107.733 E2.07851 ; support material
G1 X91.091 Y107.995 E2.09421 ; support material
G1 X91.715 Y107.905 E2.10992 ; support material
G1 X92.191 Y107.493 E2.12562 ; support material
G1 X92.369 Y106.888 E2.14132 ; support material
G1 X92.191 Y106.283 E2.15702 ; support material
G1 X91.715 Y105.870 E2.17272 ; support material
G1 E0.17272 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.715 Y108.870 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.091 Y108.780 E2.01570 ; support material
G1 X90.517 Y109.042 E2.03140 ; support material
G1 X90.177 Y109.573 E2.04711 ; support material
G1 X90.177 Y110.203 E2.06281 ; support material
G1 X90.517 Y110.733 E2.07851 ; support material
G1 X91.091 Y110.995 E2.09421 ; support material
G1 X91.715 Y110.905 E2.10992 ; support material
G1 X92.191 Y110.493 E2.12562 ; support material
G1 X92.369 Y109.888 E2.14132 ; support material
G1 X92.191 Y109.283 E2.15702 ; support material
G1 X91.715 Y108.870 E2.17272 ; support material
G1 E0.17272 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.698 Y101.757 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X106.074 Y101.667 E2.01570 ; support material
G1 X105.501 Y101.929 E2.03140 ; support material
G1 X105.160 Y102.459 E2.04711 ; support material
G1 X105.160 Y103.090 E2.06281 ; support material
G1 X105.627 Y103.817 E2.08435 ; support material
G1 X105.392 Y104.097 E2.09346 ; support material
G1 X105.392 Y104.646 E2.10713 ; support material
G1 X105.745 Y105.066 E2.12080 ; support material
G1 X106.286 Y105.162 E2.13447 ; support material
G1 X106.761 Y104.887 E2.14814 ; support material
G1 X106.949 Y104.372 E2.16181 ; support material
G1 X106.728 Y103.766 E2.17787 ; support material
G1 X107.175 Y103.379 E2.19258 ; support material
G1 X107.352 Y102.774 E2.20828 ; support material
G1 X107.175 Y102.170 E2.22398 ; support material
G1 X106.698 Y101.757 E2.23969 ; support material
G1 E0.23969 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X109.969 Y102.403 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X109.494 Y102.128 E2.01367 ; support material
G1 X108.953 Y102.223 E2.02734 ; support material
G1 X108.600 Y102.644 E2.04101 ; support material
G1 X108.600 Y103.193 E2.05468 ; support material
G1 X108.896 Y103.546 E2.06616 ; support material
G1 X108.431 Y104.100 E2.08420 ; support material
G1 X108.431 Y104.649 E2.09787 ; support material
G1 X108.784 Y105.070 E2.11154 ; support material
G1 X109.324 Y105.165 E2.12522 ; support material
G1 X109.799 Y104.891 E2.13889 ; support material
G1 X109.987 Y104.375 E2.15256 ; support material
G1 X109.701 Y103.589 E2.17340 ; support material
G1 X109.969 Y103.434 E2.18110 ; support material
G1 X110.157 Y102.918 E2.19478 ; support material
G1 X109.969 Y102.403 E2.20845 ; support material
G1 E0.20845 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.541 Y96.470 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X109.909 Y96.301 E2.01630 ; support material
G1 X109.277 Y96.470 E2.03259 ; support material
G1 X108.814 Y96.933 E2.04889 ; support material
G1 X108.645 Y97.565 E2.06518 ; support material
G1 X108.814 Y98.197 E2.08148 ; support material
G1 X109.277 Y98.659 E2.09778 ; support material
G1 X109.909 Y98.829 E2.11407 ; support material
G1 X110.541 Y98.659 E2.13037 ; support material
G1 X111.003 Y98.197 E2.14666 ; support material
G1 X111.173 Y97.565 E2.16296 ; support material
G1 X111.003 Y96.933 E2.17926 ; support material
G1 X110.541 Y96.470 E2.19555 ; support material
G1 E0.19555 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X109.097 Y92.484 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X108.622 Y92.209 E2.01367 ; support material
G1 X108.082 Y92.305 E2.02734 ; support material
G1 X107.729 Y92.725 E2.04101 ; support material
G1 X107.729 Y93.274 E2.05468 ; support material
G1 X108.082 Y93.694 E2.06836 ; support material
G1 X108.622 Y93.790 E2.08203 ; support material
G1 X109.097 Y93.515 E2.09570 ; support material
G1 X109.285 Y93.000 E2.10937 ; support material
G1 X109.097 Y92.484 E2.12304 ; support material
G1 E0.12304 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X109.097 Y89.485 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X108.622 Y89.210 E2.01367 ; support material
G1 X108.082 Y89.306 E2.02734 ; support material
G1 X107.729 Y89.726 E2.04101 ; support material
G1 X107.729 Y90.275 E2.05468 ; support material
G1 X108.082 Y90.695 E2.06836 ; support material
G1 X108.622 Y90.791 E2.08203 ; support material
G1 X109.097 Y90.516 E2.09570 ; support material
G1 X109.285 Y90.000 E2.10937 ; support material
G1 X109.097 Y89.485 E2.12304 ; support material
M106 S255 ; enable fan
G1 Z5.450 F7800.000 ; move to next layer (32)
G1 E0.12304 F2400.00000 ; retract extruder 0
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
G1 X103.349 Y104.573 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X102.809 Y104.349 E2.01456 ; support material
G1 X102.269 Y104.573 E2.02912 ; support material
G1 X102.045 Y105.113 E2.04367 ; support material
G1 X102.269 Y105.653 E2.05823 ; support material
G1 X102.809 Y105.876 E2.07279 ; support material
G1 X103.349 Y105.653 E2.08735 ; support material
G1 X103.572 Y105.113 E2.10190 ; support material
G1 X103.349 Y104.573 E2.11646 ; support material
G1 E0.11646 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X101.281 Y105.404 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X100.741 Y105.180 E2.01456 ; support material
G1 X100.201 Y105.404 E2.02912 ; support material
G1 X99.978 Y105.944 E2.04367 ; support material
G1 X100.208 Y106.500 E2.05866 ; support material
G1 X99.978 Y107.056 E2.07365 ; support material
G1 X100.201 Y107.596 E2.08821 ; support material
G1 X100.741 Y107.820 E2.10277 ; support material
G1 X101.281 Y107.596 E2.11733 ; support material
G1 X101.505 Y107.056 E2.13188 ; support material
G1 X101.275 Y106.500 E2.14688 ; support material
G1 X101.505 Y105.944 E2.16187 ; support material
G1 X101.281 Y105.404 E2.17642 ; support material
G1 E0.17642 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.349 Y107.347 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X102.809 Y107.124 E2.01456 ; support material
G1 X102.269 Y107.347 E2.02912 ; support material
G1 X102.045 Y107.887 E2.04367 ; support material
G1 X102.269 Y108.427 E2.05823 ; support material
G1 X102.809 Y108.651 E2.07279 ; support material
G1 X103.349 Y108.427 E2.08735 ; support material
G1 X103.572 Y107.887 E2.10190 ; support material
G1 X103.349 Y107.347 E2.11646 ; support material
G1 E0.11646 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.337 Y107.456 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X105.797 Y107.233 E2.01456 ; support material
G1 X105.257 Y107.456 E2.02912 ; support material
G1 X105.034 Y107.996 E2.04367 ; support material
G1 X105.257 Y108.536 E2.05823 ; support material
G1 X105.797 Y108.760 E2.07279 ; support material
G1 X106.337 Y108.536 E2.08735 ; support material
G1 X106.561 Y107.996 E2.10190 ; support material
G1 X106.337 Y107.456 E2.11646 ; support material
G1 E0.11646 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X109.337 Y107.460 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X108.797 Y107.236 E2.01456 ; support material
G1 X108.257 Y107.460 E2.02912 ; support material
G1 X108.034 Y108.000 E2.04367 ; support material
G1 X108.257 Y108.540 E2.05823 ; support material
G1 X108.797 Y108.764 E2.07279 ; support material
G1 X109.337 Y108.540 E2.08735 ; support material
G1 X109.561 Y108.000 E2.10190 ; support material
G1 X109.337 Y107.460 E2.11646 ; support material
G1 E0.11646 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X109.337 Y110.460 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X108.797 Y110.236 E2.01456 ; support material
G1 X108.257 Y110.460 E2.02912 ; support material
G1 X108.034 Y111.000 E2.04367 ; support material
G1 X108.257 Y111.540 E2.05823 ; support material
G1 X108.797 Y111.764 E2.07279 ; support material
G1 X109.337 Y111.540 E2.08735 ; support material
G1 X109.561 Y111.000 E2.10190 ; support material
G1 X109.337 Y110.460 E2.11646 ; support material
G1 E0.11646 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.337 Y110.456 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X105.797 Y110.233 E2.01456 ; support material
G1 X105.257 Y110.456 E2.02912 ; support material
G1 X105.034 Y110.996 E2.04367 ; support material
G1 X105.257 Y111.536 E2.05823 ; support material
G1 X105.797 Y111.760 E2.07279 ; support material
G1 X106.337 Y111.536 E2.08735 ; support material
G1 X106.561 Y110.996 E2.10190 ; support material
G1 X106.337 Y110.456 E2.11646 ; support material
G1 E0.11646 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X101.906 Y110.219 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X101.366 Y109.995 E2.01456 ; support material
G1 X100.826 Y110.219 E2.02912 ; support material
G1 X100.603 Y110.759 E2.04367 ; support material
G1 X100.826 Y111.299 E2.05823 ; support material
G1 X101.366 Y111.522 E2.07279 ; support material
G1 X102.150 Y111.198 E2.09392 ; support material
G1 X102.262 Y111.467 E2.10118 ; support material
G1 X102.802 Y111.690 E2.11574 ; support material
G1 X103.342 Y111.467 E2.13029 ; support material
G1 X103.565 Y110.927 E2.14485 ; support material
G1 X103.342 Y110.387 E2.15941 ; support material
G1 X102.802 Y110.163 E2.17397 ; support material
G1 X102.018 Y110.488 E2.19510 ; support material
G1 X101.906 Y110.219 E2.20236 ; support material
G1 E0.20236 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X97.337 Y110.454 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X96.797 Y110.231 E2.01456 ; support material
G1 X96.257 Y110.454 E2.02912 ; support material
G1 X96.034 Y110.994 E2.04367 ; support material
G1 X96.257 Y111.534 E2.05823 ; support material
G1 X96.797 Y111.758 E2.07279 ; support material
G1 X97.337 Y111.534 E2.08735 ; support material
G1 X97.561 Y110.994 E2.10190 ; support material
G1 X97.337 Y110.454 E2.11646 ; support material
G1 X95.596 Y110.443 F7800.000 ; move to first support material point
G1 F3600.000
G1 X95.056 Y110.219 E2.13102 ; support material
G1 X94.516 Y110.443 E2.14558 ; support material
G1 X94.293 Y110.983 E2.16013 ; support material
G1 X94.516 Y111.523 E2.17469 ; support material
G1 X95.056 Y111.746 E2.18925 ; support material
G1 X95.596 Y111.523 E2.20381 ; support material
G1 X95.820 Y110.983 E2.21836 ; support material
G1 X95.596 Y110.443 E2.23292 ; support material
G1 E0.23292 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.596 Y107.443 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X95.056 Y107.219 E2.01456 ; support material
G1 X94.516 Y107.443 E2.02912 ; support material
G1 X94.293 Y107.983 E2.04367 ; support material
G1 X94.516 Y108.523 E2.05823 ; support material
G1 X95.056 Y108.746 E2.07279 ; support material
G1 X95.596 Y108.523 E2.08735 ; support material
G1 X95.820 Y107.983 E2.10190 ; support material
G1 X95.596 Y107.443 E2.11646 ; support material
G1 X97.337 Y107.454 F7800.000 ; move to first support material point
G1 F3600.000
G1 X96.797 Y107.231 E2.13102 ; support material
G1 X96.257 Y107.454 E2.14558 ; support material
G1 X96.034 Y107.994 E2.16013 ; support material
G1 X96.257 Y108.534 E2.17469 ; support material
G1 X96.797 Y108.758 E2.18925 ; support material
G1 X97.337 Y108.534 E2.20381 ; support material
G1 X97.561 Y107.994 E2.21836 ; support material
G1 X97.337 Y107.454 E2.23292 ; support material
G1 E0.23292 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X97.337 Y104.454 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X96.797 Y104.231 E2.01456 ; support material
G1 X96.257 Y104.454 E2.02912 ; support material
G1 X96.034 Y104.994 E2.04367 ; support material
G1 X96.257 Y105.534 E2.05823 ; support material
G1 X96.797 Y105.758 E2.07279 ; support material
G1 X97.337 Y105.534 E2.08735 ; support material
G1 X97.561 Y104.994 E2.10190 ; support material
G1 X97.337 Y104.454 E2.11646 ; support material
G1 X95.596 Y104.443 F7800.000 ; move to first support material point
G1 F3600.000
G1 X95.056 Y104.219 E2.13102 ; support material
G1 X94.516 Y104.443 E2.14558 ; support material
G1 X94.293 Y104.983 E2.16013 ; support material
G1 X94.516 Y105.523 E2.17469 ; support material
G1 X95.056 Y105.746 E2.18925 ; support material
G1 X95.596 Y105.523 E2.20381 ; support material
G1 X95.820 Y104.983 E2.21836 ; support material
G1 X95.596 Y104.443 E2.23292 ; support material
G1 E0.23292 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X94.967 Y100.809 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.427 Y100.586 E2.01456 ; support material
G1 X93.887 Y100.809 E2.02912 ; support material
G1 X93.663 Y101.349 E2.04367 ; support material
G1 X93.887 Y101.889 E2.05823 ; support material
G1 X94.427 Y102.113 E2.07279 ; support material
G1 X94.967 Y101.889 E2.08735 ; support material
G1 X95.191 Y101.349 E2.10190 ; support material
G1 X94.967 Y100.809 E2.11646 ; support material
G1 E0.11646 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.004 Y97.811 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.464 Y97.588 E2.01456 ; support material
G1 X93.924 Y97.811 E2.02912 ; support material
G1 X93.700 Y98.351 E2.04367 ; support material
G1 X93.924 Y98.891 E2.05823 ; support material
G1 X94.464 Y99.115 E2.07279 ; support material
G1 X95.004 Y98.891 E2.08735 ; support material
G1 X95.227 Y98.351 E2.10190 ; support material
G1 X95.004 Y97.811 E2.11646 ; support material
G1 E0.11646 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.596 Y95.436 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X95.056 Y95.212 E2.01456 ; support material
G1 X94.516 Y95.436 E2.02912 ; support material
G1 X94.293 Y95.976 E2.04367 ; support material
G1 X94.516 Y96.516 E2.05823 ; support material
G1 X95.056 Y96.739 E2.07279 ; support material
G1 X95.596 Y96.516 E2.08735 ; support material
G1 X95.820 Y95.976 E2.10190 ; support material
G1 X95.596 Y95.436 E2.11646 ; support material
G1 E0.11646 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X97.652 Y95.405 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X97.112 Y95.181 E2.01456 ; support material
G1 X96.572 Y95.405 E2.02912 ; support material
G1 X96.348 Y95.945 E2.04367 ; support material
G1 X96.572 Y96.485 E2.05823 ; support material
G1 X97.112 Y96.708 E2.07279 ; support material
G1 X97.652 Y96.485 E2.08735 ; support material
G1 X97.876 Y95.945 E2.10190 ; support material
G1 X97.652 Y95.405 E2.11646 ; support material
G1 E0.11646 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X101.281 Y94.516 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X100.741 Y94.292 E2.01456 ; support material
G1 X100.201 Y94.516 E2.02912 ; support material
G1 X99.978 Y95.056 E2.04367 ; support material
G1 X100.201 Y95.596 E2.05823 ; support material
G1 X100.741 Y95.820 E2.07279 ; support material
G1 X101.281 Y95.596 E2.08735 ; support material
G1 X101.505 Y95.056 E2.10190 ; support material
G1 X101.281 Y94.516 E2.11646 ; support material
G1 E0.11646 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.349 Y92.347 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X102.809 Y92.124 E2.01456 ; support material
G1 X102.269 Y92.347 E2.02912 ; support material
G1 X102.045 Y92.887 E2.04367 ; support material
G1 X102.269 Y93.427 E2.05823 ; support material
G1 X102.809 Y93.651 E2.07279 ; support material
G1 X103.349 Y93.427 E2.08735 ; support material
G1 X103.572 Y92.887 E2.10190 ; support material
G1 X103.349 Y92.347 E2.11646 ; support material
G1 E0.11646 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.349 Y89.573 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X102.809 Y89.349 E2.01456 ; support material
G1 X102.269 Y89.573 E2.02912 ; support material
G1 X102.045 Y90.113 E2.04367 ; support material
G1 X102.269 Y90.653 E2.05823 ; support material
G1 X102.809 Y90.876 E2.07279 ; support material
G1 X103.349 Y90.653 E2.08735 ; support material
G1 X103.572 Y90.113 E2.10190 ; support material
G1 X103.349 Y89.573 E2.11646 ; support material
G1 E0.11646 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X101.281 Y90.404 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X100.741 Y90.180 E2.01456 ; support material
G1 X100.201 Y90.404 E2.02912 ; support material
G1 X99.978 Y90.944 E2.04367 ; support material
G1 X100.208 Y91.500 E2.05866 ; support material
G1 X99.978 Y92.056 E2.07365 ; support material
G1 X100.201 Y92.596 E2.08821 ; support material
G1 X100.741 Y92.820 E2.10277 ; support material
G1 X101.281 Y92.596 E2.11733 ; support material
G1 X101.505 Y92.056 E2.13188 ; support material
G1 X101.275 Y91.500 E2.14688 ; support material
G1 X101.505 Y90.944 E2.16187 ; support material
G1 X101.281 Y90.404 E2.17642 ; support material
G1 E0.17642 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X98.281 Y90.404 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X97.741 Y90.181 E2.01456 ; support material
G1 X97.201 Y90.404 E2.02912 ; support material
G1 X96.978 Y90.944 E2.04367 ; support material
G1 X97.208 Y91.500 E2.05865 ; support material
G1 X96.978 Y92.056 E2.07363 ; support material
G1 X97.201 Y92.596 E2.08819 ; support material
G1 X97.741 Y92.819 E2.10275 ; support material
G1 X98.281 Y92.596 E2.11731 ; support material
G1 X98.505 Y92.056 E2.13186 ; support material
G1 X98.275 Y91.500 E2.14684 ; support material
G1 X98.505 Y90.944 E2.16182 ; support material
G1 X98.281 Y90.404 E2.17638 ; support material
G1 E0.17638 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.282 Y90.419 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.742 Y90.196 E2.01456 ; support material
G1 X94.202 Y90.419 E2.02912 ; support material
G1 X93.978 Y90.959 E2.04367 ; support material
G1 X94.202 Y91.500 E2.05825 ; support material
G1 X93.978 Y92.041 E2.07283 ; support material
G1 X94.202 Y92.581 E2.08739 ; support material
G1 X94.742 Y92.804 E2.10194 ; support material
G1 X95.282 Y92.581 E2.11650 ; support material
G1 X95.505 Y92.041 E2.13106 ; support material
G1 X95.281 Y91.500 E2.14564 ; support material
G1 X95.505 Y90.959 E2.16021 ; support material
G1 X95.282 Y90.419 E2.17477 ; support material
G1 E0.17477 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.360 Y89.622 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X90.700 Y89.491 E2.01677 ; support material
G1 X90.039 Y89.622 E2.03355 ; support material
G1 X89.480 Y89.996 E2.05032 ; support material
G1 X89.105 Y90.556 E2.06710 ; support material
G1 X88.974 Y91.217 E2.08387 ; support material
G1 X89.105 Y91.877 E2.10064 ; support material
G1 X89.480 Y92.437 E2.11742 ; support material
G1 X90.039 Y92.811 E2.13419 ; support material
G1 X90.700 Y92.943 E2.15097 ; support material
G1 X91.360 Y92.811 E2.16774 ; support material
G1 X91.920 Y92.437 E2.18452 ; support material
G1 X92.294 Y91.877 E2.20129 ; support material
G1 X92.426 Y91.217 E2.21806 ; support material
G1 X92.294 Y90.556 E2.23484 ; support material
G1 X91.920 Y89.996 E2.25161 ; support material
G1 X91.360 Y89.622 E2.26839 ; support material
G1 E0.26839 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.715 Y95.443 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.091 Y95.354 E2.01570 ; support material
G1 X90.517 Y95.616 E2.03140 ; support material
G1 X90.177 Y96.146 E2.04711 ; support material
G1 X90.177 Y96.776 E2.06281 ; support material
G1 X90.534 Y97.332 E2.07926 ; support material
G1 X90.177 Y97.887 E2.09570 ; support material
G1 X90.177 Y98.518 E2.11141 ; support material
G1 X90.517 Y99.048 E2.12711 ; support material
G1 X91.091 Y99.310 E2.14281 ; support material
G1 X91.715 Y99.220 E2.15851 ; support material
G1 X92.191 Y98.807 E2.17422 ; support material
G1 X92.369 Y98.202 E2.18992 ; support material
G1 X92.191 Y97.598 E2.20562 ; support material
G1 X91.884 Y97.332 E2.21573 ; support material
G1 X92.191 Y97.066 E2.22584 ; support material
G1 X92.369 Y96.461 E2.24154 ; support material
G1 X92.191 Y95.856 E2.25725 ; support material
G1 X91.715 Y95.443 E2.27295 ; support material
G1 E0.27295 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.715 Y100.185 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.091 Y100.095 E2.01570 ; support material
G1 X90.517 Y100.357 E2.03140 ; support material
G1 X90.177 Y100.887 E2.04711 ; support material
G1 X90.177 Y101.518 E2.06281 ; support material
G1 X90.517 Y102.048 E2.07851 ; support material
G1 X91.091 Y102.310 E2.09421 ; support material
G1 X91.715 Y102.220 E2.10992 ; support material
G1 X92.191 Y101.807 E2.12562 ; support material
G1 X92.369 Y101.202 E2.14132 ; support material
G1 X92.191 Y100.598 E2.15702 ; support material
G1 X91.715 Y100.185 E2.17272 ; support material
G1 E0.17272 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.715 Y103.185 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.091 Y103.095 E2.01570 ; support material
G1 X90.517 Y103.357 E2.03140 ; support material
G1 X90.177 Y103.887 E2.04711 ; support material
G1 X90.177 Y104.518 E2.06281 ; support material
G1 X90.517 Y105.048 E2.07851 ; support material
G1 X91.091 Y105.310 E2.09421 ; support material
G1 X91.715 Y105.220 E2.10992 ; support material
G1 X92.191 Y104.807 E2.12562 ; support material
G1 X92.369 Y104.202 E2.14132 ; support material
G1 X92.191 Y103.598 E2.15702 ; support material
G1 X91.715 Y103.185 E2.17272 ; support material
G1 E0.17272 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.715 Y106.185 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.091 Y106.095 E2.01570 ; support material
G1 X90.517 Y106.357 E2.03140 ; support material
G1 X90.177 Y106.887 E2.04711 ; support material
G1 X90.177 Y107.518 E2.06281 ; support material
G1 X90.517 Y108.048 E2.07851 ; support material
G1 X91.091 Y108.310 E2.09421 ; support material
G1 X91.715 Y108.220 E2.10992 ; support material
G1 X92.191 Y107.807 E2.12562 ; support material
G1 X92.369 Y107.202 E2.14132 ; support material
G1 X92.191 Y106.598 E2.15702 ; support material
G1 X91.715 Y106.185 E2.17272 ; support material
G1 E0.17272 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.715 Y109.185 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.091 Y109.095 E2.01570 ; support material
G1 X90.517 Y109.357 E2.03140 ; support material
G1 X90.177 Y109.887 E2.04711 ; support material
G1 X90.177 Y110.518 E2.06281 ; support material
G1 X90.517 Y111.048 E2.07851 ; support material
G1 X91.091 Y111.310 E2.09421 ; support material
G1 X91.715 Y111.220 E2.10992 ; support material
G1 X92.191 Y110.807 E2.12562 ; support material
G1 X92.369 Y110.202 E2.14132 ; support material
G1 X92.191 Y109.598 E2.15702 ; support material
G1 X91.715 Y109.185 E2.17272 ; support material
G1 E0.17272 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.216 Y103.958 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X106.226 Y103.882 E2.00191 ; support material
G1 X105.589 Y104.146 E2.01908 ; support material
G1 X105.366 Y104.686 E2.03364 ; support material
G1 X105.589 Y105.226 E2.04820 ; support material
G1 X106.129 Y105.449 E2.06276 ; support material
G1 X106.669 Y105.226 E2.07731 ; support material
G1 X106.893 Y104.686 E2.09187 ; support material
G1 X106.669 Y104.146 E2.10643 ; support material
G1 X106.216 Y103.958 E2.11863 ; support material
G1 X106.715 Y101.443 F7800.000 ; move to first support material point
G1 F3600.000
G1 X106.091 Y101.353 E2.13434 ; support material
G1 X105.518 Y101.615 E2.15004 ; support material
G1 X105.177 Y102.145 E2.16574 ; support material
G1 X105.177 Y102.775 E2.18144 ; support material
G1 X105.518 Y103.306 E2.19714 ; support material
G1 X106.256 Y103.643 E2.21736 ; support material
G1 X106.269 Y103.542 E2.21989 ; support material
G1 X106.715 Y103.478 E2.23113 ; support material
G1 X107.192 Y103.065 E2.24683 ; support material
G1 X107.369 Y102.460 E2.26253 ; support material
G1 X107.192 Y101.855 E2.27823 ; support material
G1 X106.715 Y101.443 E2.29394 ; support material
G1 E0.29394 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X109.931 Y102.066 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X109.391 Y101.842 E2.01456 ; support material
G1 X108.851 Y102.066 E2.02912 ; support material
G1 X108.627 Y102.606 E2.04367 ; support material
G1 X108.851 Y103.146 E2.05823 ; support material
G1 X109.391 Y103.369 E2.07279 ; support material
G1 X109.931 Y103.146 E2.08735 ; support material
G1 X110.154 Y102.606 E2.10190 ; support material
G1 X109.931 Y102.066 E2.11646 ; support material
G1 E0.11646 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X109.688 Y104.148 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X109.148 Y103.924 E2.01456 ; support material
G1 X108.608 Y104.148 E2.02912 ; support material
G1 X108.385 Y104.687 E2.04367 ; support material
G1 X108.608 Y105.227 E2.05823 ; support material
G1 X109.148 Y105.451 E2.07279 ; support material
G1 X109.688 Y105.227 E2.08735 ; support material
G1 X109.912 Y104.687 E2.10190 ; support material
G1 X109.688 Y104.148 E2.11646 ; support material
G1 E0.11646 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.486 Y96.712 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X109.946 Y96.489 E2.01456 ; support material
G1 X109.406 Y96.712 E2.02912 ; support material
G1 X109.182 Y97.252 E2.04367 ; support material
G1 X109.300 Y97.537 E2.05134 ; support material
G1 X109.088 Y98.047 E2.06511 ; support material
G1 X109.312 Y98.587 E2.07967 ; support material
G1 X109.852 Y98.811 E2.09423 ; support material
G1 X110.392 Y98.587 E2.10878 ; support material
G1 X110.616 Y98.047 E2.12334 ; support material
G1 X110.498 Y97.763 E2.13101 ; support material
G1 X110.709 Y97.252 E2.14478 ; support material
G1 X110.486 Y96.712 E2.15934 ; support material
G1 E0.15934 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.289 Y95.762 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X105.696 Y95.476 E2.01640 ; support material
G1 X105.037 Y95.476 E2.03279 ; support material
G1 X104.444 Y95.762 E2.04919 ; support material
G1 X104.034 Y96.276 E2.06558 ; support material
G1 X103.887 Y96.918 E2.08198 ; support material
G1 X104.034 Y97.560 E2.09837 ; support material
G1 X104.444 Y98.074 E2.11477 ; support material
G1 X105.037 Y98.360 E2.13116 ; support material
G1 X105.358 Y98.360 E2.13915 ; support material
G1 X105.509 Y98.726 E2.14901 ; support material
G1 X106.049 Y98.949 E2.16357 ; support material
G1 X106.589 Y98.726 E2.17812 ; support material
G1 X106.813 Y98.186 E2.19268 ; support material
G1 X106.603 Y97.680 E2.20632 ; support material
G1 X106.699 Y97.560 E2.21015 ; support material
G1 X106.845 Y96.918 E2.22654 ; support material
G1 X106.699 Y96.276 E2.24294 ; support material
G1 X106.289 Y95.762 E2.25933 ; support material
G1 E0.25933 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.337 Y92.456 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X105.797 Y92.233 E2.01456 ; support material
G1 X105.257 Y92.456 E2.02912 ; support material
G1 X105.034 Y92.996 E2.04367 ; support material
G1 X105.257 Y93.536 E2.05823 ; support material
G1 X105.797 Y93.760 E2.07279 ; support material
G1 X106.337 Y93.536 E2.08735 ; support material
G1 X106.561 Y92.996 E2.10190 ; support material
G1 X106.337 Y92.456 E2.11646 ; support material
G1 E0.11646 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.337 Y89.464 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X105.797 Y89.240 E2.01456 ; support material
G1 X105.257 Y89.464 E2.02912 ; support material
G1 X105.034 Y90.004 E2.04367 ; support material
G1 X105.257 Y90.544 E2.05823 ; support material
G1 X105.797 Y90.767 E2.07279 ; support material
G1 X106.337 Y90.544 E2.08735 ; support material
G1 X106.561 Y90.004 E2.10190 ; support material
G1 X106.337 Y89.464 E2.11646 ; support material
G1 E0.11646 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X109.337 Y89.460 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X108.797 Y89.236 E2.01456 ; support material
G1 X108.257 Y89.460 E2.02912 ; support material
G1 X108.034 Y90.000 E2.04367 ; support material
G1 X108.257 Y90.540 E2.05823 ; support material
G1 X108.797 Y90.764 E2.07279 ; support material
G1 X109.337 Y90.540 E2.08735 ; support material
G1 X109.561 Y90.000 E2.10190 ; support material
G1 X109.337 Y89.460 E2.11646 ; support material
G1 E0.11646 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X109.337 Y92.460 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X108.797 Y92.236 E2.01456 ; support material
G1 X108.257 Y92.460 E2.02912 ; support material
G1 X108.034 Y93.000 E2.04367 ; support material
G1 X108.257 Y93.540 E2.05823 ; support material
G1 X108.797 Y93.764 E2.07279 ; support material
G1 X109.337 Y93.540 E2.08735 ; support material
G1 X109.561 Y93.000 E2.10190 ; support material
G1 X109.337 Y92.460 E2.11646 ; support material
G1 Z6.050 F7800.000 ; move to next layer (35)
G1 E0.11646 F2400.00000 ; retract extruder 0
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
G1 X103.630 Y104.521 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X103.114 Y104.307 E2.01391 ; support material
G1 X102.598 Y104.521 E2.02783 ; support material
G1 X102.384 Y105.037 E2.04174 ; support material
G1 X102.598 Y105.553 E2.05566 ; support material
G1 X103.114 Y105.766 E2.06957 ; support material
G1 X103.630 Y105.553 E2.08348 ; support material
G1 X103.844 Y105.037 E2.09740 ; support material
G1 X103.630 Y104.521 E2.11131 ; support material
G1 E0.11131 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X101.257 Y105.113 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X100.741 Y104.899 E2.01391 ; support material
G1 X100.225 Y105.113 E2.02783 ; support material
G1 X100.012 Y105.629 E2.04174 ; support material
G1 X100.225 Y106.145 E2.05566 ; support material
G1 X100.741 Y106.359 E2.06957 ; support material
G1 X101.257 Y106.145 E2.08348 ; support material
G1 X101.471 Y105.629 E2.09740 ; support material
G1 X101.257 Y105.113 E2.11131 ; support material
G1 X101.257 Y106.855 F7800.000 ; move to first support material point
G1 F3600.000
G1 X100.741 Y106.641 E2.12523 ; support material
G1 X100.225 Y106.855 E2.13914 ; support material
G1 X100.012 Y107.371 E2.15306 ; support material
G1 X100.225 Y107.887 E2.16697 ; support material
G1 X100.741 Y108.101 E2.18088 ; support material
G1 X101.257 Y107.887 E2.19480 ; support material
G1 X101.471 Y107.371 E2.20871 ; support material
G1 X101.257 Y106.855 E2.22263 ; support material
G1 E0.22263 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.630 Y107.447 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X103.114 Y107.234 E2.01391 ; support material
G1 X102.598 Y107.447 E2.02783 ; support material
G1 X102.384 Y107.963 E2.04174 ; support material
G1 X102.598 Y108.479 E2.05566 ; support material
G1 X103.114 Y108.693 E2.06957 ; support material
G1 X103.630 Y108.479 E2.08348 ; support material
G1 X103.844 Y107.963 E2.09740 ; support material
G1 X103.630 Y107.447 E2.11131 ; support material
G1 E0.11131 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.628 Y107.484 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X106.112 Y107.270 E2.01391 ; support material
G1 X105.596 Y107.484 E2.02783 ; support material
G1 X105.382 Y108.000 E2.04174 ; support material
G1 X105.596 Y108.516 E2.05566 ; support material
G1 X106.112 Y108.730 E2.06957 ; support material
G1 X106.628 Y108.516 E2.08348 ; support material
G1 X106.842 Y108.000 E2.09740 ; support material
G1 X106.628 Y107.484 E2.11131 ; support material
G1 E0.11131 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.628 Y104.484 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X106.112 Y104.270 E2.01391 ; support material
G1 X105.596 Y104.484 E2.02783 ; support material
G1 X105.382 Y105.000 E2.04174 ; support material
G1 X105.596 Y105.516 E2.05566 ; support material
G1 X106.112 Y105.730 E2.06957 ; support material
G1 X106.628 Y105.516 E2.08348 ; support material
G1 X106.842 Y105.000 E2.09740 ; support material
G1 X106.628 Y104.484 E2.11131 ; support material
G1 X109.628 Y104.484 F7800.000 ; move to first support material point
G1 F3600.000
G1 X109.112 Y104.270 E2.12523 ; support material
G1 X108.596 Y104.484 E2.13914 ; support material
G1 X108.382 Y105.000 E2.15306 ; support material
G1 X108.596 Y105.516 E2.16697 ; support material
G1 X109.112 Y105.730 E2.18088 ; support material
G1 X109.628 Y105.516 E2.19480 ; support material
G1 X109.842 Y105.000 E2.20871 ; support material
G1 X109.628 Y104.484 E2.22263 ; support material
G1 E0.22263 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X109.943 Y101.777 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X109.427 Y101.563 E2.01391 ; support material
G1 X108.911 Y101.777 E2.02783 ; support material
G1 X108.697 Y102.293 E2.04174 ; support material
G1 X108.911 Y102.809 E2.05566 ; support material
G1 X109.427 Y103.023 E2.06957 ; support material
G1 X109.943 Y102.809 E2.08348 ; support material
G1 X110.157 Y102.293 E2.09740 ; support material
G1 X109.943 Y101.777 E2.11131 ; support material
G1 E0.11131 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.732 Y101.128 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X106.108 Y101.039 E2.01570 ; support material
G1 X105.535 Y101.300 E2.03140 ; support material
G1 X105.194 Y101.831 E2.04711 ; support material
G1 X105.194 Y102.461 E2.06281 ; support material
G1 X105.535 Y102.991 E2.07851 ; support material
G1 X106.108 Y103.253 E2.09421 ; support material
G1 X106.732 Y103.164 E2.10992 ; support material
G1 X107.209 Y102.751 E2.12562 ; support material
G1 X107.386 Y102.146 E2.14132 ; support material
G1 X107.209 Y101.541 E2.15702 ; support material
G1 X106.732 Y101.128 E2.17273 ; support material
G1 E0.17273 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.712 Y95.887 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X106.196 Y95.673 E2.01391 ; support material
G1 X105.680 Y95.887 E2.02783 ; support material
G1 X105.603 Y96.072 E2.03283 ; support material
G1 X104.940 Y95.977 E2.04952 ; support material
G1 X104.366 Y96.239 E2.06522 ; support material
G1 X104.026 Y96.769 E2.08092 ; support material
G1 X104.026 Y97.399 E2.09662 ; support material
G1 X104.366 Y97.930 E2.11232 ; support material
G1 X104.940 Y98.191 E2.12803 ; support material
G1 X105.401 Y98.125 E2.13963 ; support material
G1 X105.739 Y98.940 E2.16161 ; support material
G1 X106.255 Y99.154 E2.17552 ; support material
G1 X106.771 Y98.940 E2.18943 ; support material
G1 X106.985 Y98.424 E2.20335 ; support material
G1 X106.771 Y97.908 E2.21726 ; support material
G1 X106.062 Y97.614 E2.23637 ; support material
G1 X106.205 Y97.129 E2.24897 ; support material
G1 X106.712 Y96.919 E2.26265 ; support material
G1 X106.926 Y96.403 E2.27656 ; support material
G1 X106.712 Y95.887 E2.29048 ; support material
G1 E0.29048 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.628 Y92.484 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X106.112 Y92.270 E2.01391 ; support material
G1 X105.596 Y92.484 E2.02783 ; support material
G1 X105.382 Y93.000 E2.04174 ; support material
G1 X105.596 Y93.516 E2.05566 ; support material
G1 X106.112 Y93.730 E2.06957 ; support material
G1 X106.628 Y93.516 E2.08348 ; support material
G1 X106.842 Y93.000 E2.09740 ; support material
G1 X106.628 Y92.484 E2.11131 ; support material
G1 E0.11131 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.630 Y92.447 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X103.114 Y92.234 E2.01391 ; support material
G1 X102.598 Y92.447 E2.02783 ; support material
G1 X102.384 Y92.963 E2.04174 ; support material
G1 X102.598 Y93.479 E2.05566 ; support material
G1 X103.114 Y93.693 E2.06957 ; support material
G1 X103.630 Y93.479 E2.08348 ; support material
G1 X103.844 Y92.963 E2.09740 ; support material
G1 X103.630 Y92.447 E2.11131 ; support material
G1 E0.11131 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X101.257 Y91.855 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X100.741 Y91.641 E2.01391 ; support material
G1 X100.225 Y91.855 E2.02783 ; support material
G1 X100.012 Y92.371 E2.04174 ; support material
G1 X100.225 Y92.887 E2.05566 ; support material
G1 X100.741 Y93.101 E2.06957 ; support material
G1 X101.257 Y92.887 E2.08348 ; support material
G1 X101.471 Y92.371 E2.09740 ; support material
G1 X101.257 Y91.855 E2.11131 ; support material
G1 X101.257 Y90.113 F7800.000 ; move to first support material point
G1 F3600.000
G1 X100.741 Y89.899 E2.12523 ; support material
G1 X100.225 Y90.113 E2.13914 ; support material
G1 X100.012 Y90.629 E2.15306 ; support material
G1 X100.225 Y91.145 E2.16697 ; support material
G1 X100.741 Y91.359 E2.18088 ; support material
G1 X101.257 Y91.145 E2.19480 ; support material
G1 X101.471 Y90.629 E2.20871 ; support material
G1 X101.257 Y90.113 E2.22263 ; support material
G1 E0.22263 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.630 Y89.521 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X103.114 Y89.307 E2.01391 ; support material
G1 X102.598 Y89.521 E2.02783 ; support material
G1 X102.384 Y90.037 E2.04174 ; support material
G1 X102.598 Y90.553 E2.05566 ; support material
G1 X103.114 Y90.766 E2.06957 ; support material
G1 X103.630 Y90.553 E2.08348 ; support material
G1 X103.844 Y90.037 E2.09740 ; support material
G1 X103.630 Y89.521 E2.11131 ; support material
G1 E0.11131 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.628 Y89.484 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X106.112 Y89.270 E2.01391 ; support material
G1 X105.596 Y89.484 E2.02783 ; support material
G1 X105.382 Y90.000 E2.04174 ; support material
G1 X105.596 Y90.516 E2.05566 ; support material
G1 X106.112 Y90.730 E2.06957 ; support material
G1 X106.628 Y90.516 E2.08348 ; support material
G1 X106.842 Y90.000 E2.09740 ; support material
G1 X106.628 Y89.484 E2.11131 ; support material
G1 X109.628 Y89.484 F7800.000 ; move to first support material point
G1 F3600.000
G1 X109.112 Y89.270 E2.12523 ; support material
G1 X108.596 Y89.484 E2.13914 ; support material
G1 X108.382 Y90.000 E2.15306 ; support material
G1 X108.596 Y90.516 E2.16697 ; support material
G1 X109.112 Y90.730 E2.18088 ; support material
G1 X109.628 Y90.516 E2.19480 ; support material
G1 X109.842 Y90.000 E2.20871 ; support material
G1 X109.628 Y89.484 E2.22263 ; support material
G1 E0.22263 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X109.628 Y92.484 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X109.112 Y92.270 E2.01391 ; support material
G1 X108.596 Y92.484 E2.02783 ; support material
G1 X108.382 Y93.000 E2.04174 ; support material
G1 X108.596 Y93.516 E2.05566 ; support material
G1 X109.112 Y93.730 E2.06957 ; support material
G1 X109.628 Y93.516 E2.08348 ; support material
G1 X109.842 Y93.000 E2.09740 ; support material
G1 X109.628 Y92.484 E2.11131 ; support material
G1 E0.11131 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.498 Y96.424 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X109.982 Y96.210 E2.01391 ; support material
G1 X109.466 Y96.424 E2.02783 ; support material
G1 X109.253 Y96.940 E2.04174 ; support material
G1 X109.579 Y97.728 E2.06299 ; support material
G1 X109.299 Y97.844 E2.07054 ; support material
G1 X109.085 Y98.360 E2.08445 ; support material
G1 X109.299 Y98.876 E2.09837 ; support material
G1 X109.815 Y99.090 E2.11228 ; support material
G1 X110.331 Y98.876 E2.12620 ; support material
G1 X110.545 Y98.360 E2.14011 ; support material
G1 X110.219 Y97.572 E2.16136 ; support material
G1 X110.498 Y97.456 E2.16891 ; support material
G1 X110.712 Y96.940 E2.18282 ; support material
G1 X110.498 Y96.424 E2.19673 ; support material
G1 E0.19673 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X101.257 Y94.855 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X100.741 Y94.641 E2.01391 ; support material
G1 X100.225 Y94.855 E2.02783 ; support material
G1 X100.012 Y95.371 E2.04174 ; support material
G1 X100.225 Y95.887 E2.05566 ; support material
G1 X100.741 Y96.101 E2.06957 ; support material
G1 X101.257 Y95.887 E2.08348 ; support material
G1 X101.471 Y95.371 E2.09740 ; support material
G1 X101.257 Y94.855 E2.11131 ; support material
G1 E0.11131 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X97.943 Y95.424 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X97.427 Y95.210 E2.01391 ; support material
G1 X96.911 Y95.424 E2.02783 ; support material
G1 X96.697 Y95.940 E2.04174 ; support material
G1 X96.911 Y96.456 E2.05566 ; support material
G1 X97.427 Y96.670 E2.06957 ; support material
G1 X97.943 Y96.456 E2.08348 ; support material
G1 X98.157 Y95.940 E2.09740 ; support material
G1 X97.943 Y95.424 E2.11131 ; support material
G1 E0.11131 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.258 Y95.465 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.742 Y95.251 E2.01391 ; support material
G1 X94.226 Y95.465 E2.02783 ; support material
G1 X94.012 Y95.981 E2.04174 ; support material
G1 X94.226 Y96.497 E2.05566 ; support material
G1 X94.742 Y96.710 E2.06957 ; support material
G1 X95.258 Y96.497 E2.08348 ; support material
G1 X95.471 Y95.981 E2.09740 ; support material
G1 X95.258 Y95.465 E2.11131 ; support material
G1 E0.11131 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X94.943 Y98.148 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.427 Y97.934 E2.01391 ; support material
G1 X93.911 Y98.148 E2.02783 ; support material
G1 X93.697 Y98.664 E2.04174 ; support material
G1 X93.911 Y99.180 E2.05566 ; support material
G1 X94.427 Y99.394 E2.06957 ; support material
G1 X94.943 Y99.180 E2.08348 ; support material
G1 X95.157 Y98.664 E2.09740 ; support material
G1 X94.943 Y98.148 E2.11131 ; support material
G1 E0.11131 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X94.943 Y101.148 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.427 Y100.934 E2.01391 ; support material
G1 X93.911 Y101.148 E2.02783 ; support material
G1 X93.697 Y101.664 E2.04174 ; support material
G1 X93.911 Y102.180 E2.05566 ; support material
G1 X94.427 Y102.394 E2.06957 ; support material
G1 X94.943 Y102.180 E2.08348 ; support material
G1 X95.157 Y101.664 E2.09740 ; support material
G1 X94.943 Y101.148 E2.11131 ; support material
G1 E0.11131 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.715 Y100.499 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.091 Y100.410 E2.01570 ; support material
G1 X90.517 Y100.672 E2.03140 ; support material
G1 X90.177 Y101.202 E2.04711 ; support material
G1 X90.177 Y101.832 E2.06281 ; support material
G1 X90.517 Y102.363 E2.07851 ; support material
G1 X91.091 Y102.625 E2.09421 ; support material
G1 X91.715 Y102.535 E2.10992 ; support material
G1 X92.191 Y102.122 E2.12562 ; support material
G1 X92.369 Y101.517 E2.14132 ; support material
G1 X92.191 Y100.912 E2.15702 ; support material
G1 X91.715 Y100.499 E2.17272 ; support material
G1 E0.17272 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.715 Y103.499 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.091 Y103.410 E2.01570 ; support material
G1 X90.517 Y103.672 E2.03140 ; support material
G1 X90.177 Y104.202 E2.04711 ; support material
G1 X90.177 Y104.832 E2.06281 ; support material
G1 X90.517 Y105.363 E2.07851 ; support material
G1 X91.091 Y105.625 E2.09421 ; support material
G1 X91.715 Y105.535 E2.10992 ; support material
G1 X92.191 Y105.122 E2.12562 ; support material
G1 X92.369 Y104.517 E2.14132 ; support material
G1 X92.191 Y103.912 E2.15702 ; support material
G1 X91.715 Y103.499 E2.17272 ; support material
G1 E0.17272 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.715 Y106.499 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.091 Y106.410 E2.01570 ; support material
G1 X90.517 Y106.672 E2.03140 ; support material
G1 X90.177 Y107.202 E2.04711 ; support material
G1 X90.177 Y107.832 E2.06281 ; support material
G1 X90.517 Y108.363 E2.07851 ; support material
G1 X91.091 Y108.625 E2.09421 ; support material
G1 X91.715 Y108.535 E2.10992 ; support material
G1 X92.191 Y108.122 E2.12562 ; support material
G1 X92.369 Y107.517 E2.14132 ; support material
G1 X92.191 Y106.912 E2.15702 ; support material
G1 X91.715 Y106.499 E2.17272 ; support material
G1 E0.17272 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.715 Y109.499 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.091 Y109.410 E2.01570 ; support material
G1 X90.517 Y109.672 E2.03140 ; support material
G1 X90.177 Y110.202 E2.04711 ; support material
G1 X90.177 Y110.832 E2.06281 ; support material
G1 X90.517 Y111.363 E2.07851 ; support material
G1 X91.091 Y111.625 E2.09421 ; support material
G1 X91.715 Y111.535 E2.10992 ; support material
G1 X92.191 Y111.122 E2.12562 ; support material
G1 X92.369 Y110.517 E2.14132 ; support material
G1 X92.191 Y109.912 E2.15702 ; support material
G1 X91.715 Y109.499 E2.17272 ; support material
G1 E0.17272 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.258 Y110.465 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.742 Y110.251 E2.01391 ; support material
G1 X94.226 Y110.465 E2.02783 ; support material
G1 X94.012 Y110.981 E2.04174 ; support material
G1 X94.226 Y111.497 E2.05566 ; support material
G1 X94.742 Y111.710 E2.06957 ; support material
G1 X95.258 Y111.497 E2.08348 ; support material
G1 X95.471 Y110.981 E2.09740 ; support material
G1 X95.258 Y110.465 E2.11131 ; support material
G1 E0.11131 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X97.628 Y110.480 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X97.112 Y110.267 E2.01391 ; support material
G1 X96.596 Y110.480 E2.02783 ; support material
G1 X96.382 Y110.996 E2.04174 ; support material
G1 X96.596 Y111.512 E2.05566 ; support material
G1 X97.112 Y111.726 E2.06957 ; support material
G1 X97.628 Y111.512 E2.08348 ; support material
G1 X97.842 Y110.996 E2.09740 ; support material
G1 X97.628 Y110.480 E2.11131 ; support material
G1 E0.11131 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X97.628 Y107.480 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X97.112 Y107.267 E2.01391 ; support material
G1 X96.596 Y107.480 E2.02783 ; support material
G1 X96.382 Y107.996 E2.04174 ; support material
G1 X96.596 Y108.512 E2.05566 ; support material
G1 X97.112 Y108.726 E2.06957 ; support material
G1 X97.628 Y108.512 E2.08348 ; support material
G1 X97.842 Y107.996 E2.09740 ; support material
G1 X97.628 Y107.480 E2.11131 ; support material
G1 E0.11131 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.258 Y107.465 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.742 Y107.251 E2.01391 ; support material
G1 X94.226 Y107.465 E2.02783 ; support material
G1 X94.012 Y107.981 E2.04174 ; support material
G1 X94.226 Y108.497 E2.05566 ; support material
G1 X94.742 Y108.710 E2.06957 ; support material
G1 X95.258 Y108.497 E2.08348 ; support material
G1 X95.471 Y107.981 E2.09740 ; support material
G1 X95.258 Y107.465 E2.11131 ; support material
G1 E0.11131 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.258 Y104.465 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.742 Y104.251 E2.01391 ; support material
G1 X94.226 Y104.465 E2.02783 ; support material
G1 X94.012 Y104.981 E2.04174 ; support material
G1 X94.226 Y105.497 E2.05566 ; support material
G1 X94.742 Y105.710 E2.06957 ; support material
G1 X95.258 Y105.497 E2.08348 ; support material
G1 X95.471 Y104.981 E2.09740 ; support material
G1 X95.258 Y104.465 E2.11131 ; support material
G1 E0.11131 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X97.628 Y104.480 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X97.112 Y104.267 E2.01391 ; support material
G1 X96.596 Y104.480 E2.02783 ; support material
G1 X96.382 Y104.996 E2.04174 ; support material
G1 X96.596 Y105.512 E2.05566 ; support material
G1 X97.112 Y105.726 E2.06957 ; support material
G1 X97.628 Y105.512 E2.08348 ; support material
G1 X97.842 Y104.996 E2.09740 ; support material
G1 X97.628 Y104.480 E2.11131 ; support material
G1 E0.11131 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X101.570 Y110.206 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X101.054 Y109.992 E2.01391 ; support material
G1 X100.538 Y110.206 E2.02783 ; support material
G1 X100.324 Y110.722 E2.04174 ; support material
G1 X100.538 Y111.238 E2.05566 ; support material
G1 X101.054 Y111.452 E2.06957 ; support material
G1 X101.570 Y111.238 E2.08348 ; support material
G1 X101.784 Y110.722 E2.09740 ; support material
G1 X101.570 Y110.206 E2.11131 ; support material
G1 E0.11131 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.630 Y110.447 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X103.114 Y110.234 E2.01391 ; support material
G1 X102.598 Y110.447 E2.02783 ; support material
G1 X102.384 Y110.963 E2.04174 ; support material
G1 X102.598 Y111.479 E2.05566 ; support material
G1 X103.114 Y111.693 E2.06957 ; support material
G1 X103.630 Y111.479 E2.08348 ; support material
G1 X103.844 Y110.963 E2.09740 ; support material
G1 X103.630 Y110.447 E2.11131 ; support material
G1 E0.11131 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.628 Y110.484 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X106.112 Y110.270 E2.01391 ; support material
G1 X105.596 Y110.484 E2.02783 ; support material
G1 X105.382 Y111.000 E2.04174 ; support material
G1 X105.596 Y111.516 E2.05566 ; support material
G1 X106.112 Y111.730 E2.06957 ; support material
G1 X106.628 Y111.516 E2.08348 ; support material
G1 X106.842 Y111.000 E2.09740 ; support material
G1 X106.628 Y110.484 E2.11131 ; support material
G1 E0.11131 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X109.628 Y110.484 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X109.112 Y110.270 E2.01391 ; support material
G1 X108.596 Y110.484 E2.02783 ; support material
G1 X108.382 Y111.000 E2.04174 ; support material
G1 X108.596 Y111.516 E2.05566 ; support material
G1 X109.112 Y111.730 E2.06957 ; support material
G1 X109.628 Y111.516 E2.08348 ; support material
G1 X109.842 Y111.000 E2.09740 ; support material
G1 X109.628 Y110.484 E2.11131 ; support material
G1 E0.11131 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X109.628 Y107.484 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X109.112 Y107.270 E2.01391 ; support material
G1 X108.596 Y107.484 E2.02783 ; support material
G1 X108.382 Y108.000 E2.04174 ; support material
G1 X108.596 Y108.516 E2.05566 ; support material
G1 X109.112 Y108.730 E2.06957 ; support material
G1 X109.628 Y108.516 E2.08348 ; support material
G1 X109.842 Y108.000 E2.09740 ; support material
G1 X109.628 Y107.484 E2.11131 ; support material
G1 E0.11131 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X98.257 Y91.854 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X97.741 Y91.640 E2.01391 ; support material
G1 X97.225 Y91.854 E2.02783 ; support material
G1 X97.012 Y92.370 E2.04174 ; support material
G1 X97.225 Y92.886 E2.05566 ; support material
G1 X97.741 Y93.100 E2.06957 ; support material
G1 X98.257 Y92.886 E2.08348 ; support material
G1 X98.471 Y92.370 E2.09740 ; support material
G1 X98.257 Y91.854 E2.11131 ; support material
G1 X98.257 Y90.114 F7800.000 ; move to first support material point
G1 F3600.000
G1 X97.741 Y89.900 E2.12523 ; support material
G1 X97.225 Y90.114 E2.13914 ; support material
G1 X97.012 Y90.630 E2.15306 ; support material
G1 X97.225 Y91.146 E2.16697 ; support material
G1 X97.741 Y91.360 E2.18088 ; support material
G1 X98.257 Y91.146 E2.19480 ; support material
G1 X98.471 Y90.630 E2.20871 ; support material
G1 X98.257 Y90.114 E2.22263 ; support material
G1 E0.22263 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.258 Y90.129 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.742 Y89.915 E2.01391 ; support material
G1 X94.226 Y90.129 E2.02783 ; support material
G1 X94.012 Y90.645 E2.04174 ; support material
G1 X94.226 Y91.161 E2.05566 ; support material
G1 X94.742 Y91.374 E2.06957 ; support material
G1 X95.258 Y91.161 E2.08348 ; support material
G1 X95.471 Y90.645 E2.09740 ; support material
G1 X95.258 Y90.129 E2.11131 ; support material
G1 X95.258 Y91.839 F7800.000 ; move to first support material point
G1 F3600.000
G1 X94.742 Y91.626 E2.12523 ; support material
G1 X94.226 Y91.839 E2.13914 ; support material
G1 X94.012 Y92.355 E2.15306 ; support material
G1 X94.226 Y92.871 E2.16697 ; support material
G1 X94.742 Y93.085 E2.18088 ; support material
G1 X95.258 Y92.871 E2.19480 ; support material
G1 X95.471 Y92.355 E2.20871 ; support material
G1 X95.258 Y91.839 E2.22263 ; support material
G1 E0.22263 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.351 Y89.775 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X90.716 Y89.534 E2.01692 ; support material
G1 X90.041 Y89.616 E2.03384 ; support material
G1 X89.482 Y90.002 E2.05077 ; support material
G1 X89.166 Y90.604 E2.06769 ; support material
G1 X89.166 Y91.283 E2.08461 ; support material
G1 X89.482 Y91.884 E2.10153 ; support material
G1 X90.041 Y92.270 E2.11846 ; support material
G1 X90.605 Y92.339 E2.13261 ; support material
G1 X90.814 Y92.844 E2.14622 ; support material
G1 X91.330 Y93.057 E2.16013 ; support material
G1 X91.846 Y92.844 E2.17405 ; support material
G1 X92.060 Y92.328 E2.18796 ; support material
G1 X91.786 Y91.665 E2.20581 ; support material
G1 X91.964 Y90.943 E2.22434 ; support material
G1 X91.801 Y90.284 E2.24126 ; support material
G1 X91.351 Y89.775 E2.25819 ; support material
G1 E0.25819 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.715 Y95.129 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.091 Y95.039 E2.01570 ; support material
G1 X90.517 Y95.301 E2.03140 ; support material
G1 X90.177 Y95.831 E2.04711 ; support material
G1 X90.177 Y96.462 E2.06281 ; support material
G1 X90.517 Y96.992 E2.07851 ; support material
G1 X91.262 Y97.332 E2.09889 ; support material
G1 X90.517 Y97.672 E2.11927 ; support material
G1 X90.177 Y98.202 E2.13497 ; support material
G1 X90.177 Y98.832 E2.15067 ; support material
G1 X90.517 Y99.363 E2.16637 ; support material
G1 X91.091 Y99.625 E2.18207 ; support material
G1 X91.715 Y99.535 E2.19778 ; support material
G1 X92.191 Y99.122 E2.21348 ; support material
G1 X92.369 Y98.517 E2.22918 ; support material
G1 X92.191 Y97.912 E2.24488 ; support material
G1 X91.521 Y97.332 E2.26696 ; support material
G1 X92.191 Y96.751 E2.28904 ; support material
G1 X92.369 Y96.146 E2.30475 ; support material
G1 X92.191 Y95.542 E2.32045 ; support material
G1 X91.715 Y95.129 E2.33615 ; support material
G1 Z6.350 F7800.000 ; move to next layer (37)
G1 E0.33615 F2400.00000 ; retract extruder 0
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
G1 X101.234 Y104.822 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X100.741 Y104.619 E2.01327 ; support material
G1 X100.249 Y104.822 E2.02654 ; support material
G1 X100.045 Y105.315 E2.03981 ; support material
G1 X100.249 Y105.807 E2.05308 ; support material
G1 X100.741 Y106.011 E2.06635 ; support material
G1 X101.234 Y105.807 E2.07962 ; support material
G1 X101.437 Y105.315 E2.09289 ; support material
G1 X101.234 Y104.822 E2.10617 ; support material
G1 E0.10617 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X101.234 Y107.193 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X100.741 Y106.989 E2.01327 ; support material
G1 X100.249 Y107.193 E2.02654 ; support material
G1 X100.045 Y107.685 E2.03981 ; support material
G1 X100.249 Y108.178 E2.05308 ; support material
G1 X100.741 Y108.381 E2.06635 ; support material
G1 X101.234 Y108.178 E2.07962 ; support material
G1 X101.437 Y107.685 E2.09289 ; support material
G1 X101.234 Y107.193 E2.10617 ; support material
G1 E0.10617 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.919 Y107.508 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X103.427 Y107.304 E2.01327 ; support material
G1 X102.934 Y107.508 E2.02654 ; support material
G1 X102.731 Y108.000 E2.03981 ; support material
G1 X102.934 Y108.492 E2.05308 ; support material
G1 X103.427 Y108.696 E2.06635 ; support material
G1 X103.919 Y108.492 E2.07962 ; support material
G1 X104.123 Y108.000 E2.09289 ; support material
G1 X103.919 Y107.508 E2.10617 ; support material
G1 E0.10617 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.919 Y104.508 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X103.427 Y104.304 E2.01327 ; support material
G1 X102.934 Y104.508 E2.02654 ; support material
G1 X102.731 Y105.000 E2.03981 ; support material
G1 X102.934 Y105.492 E2.05308 ; support material
G1 X103.427 Y105.696 E2.06635 ; support material
G1 X103.919 Y105.492 E2.07962 ; support material
G1 X104.123 Y105.000 E2.09289 ; support material
G1 X103.919 Y104.508 E2.10617 ; support material
G1 X106.919 Y104.508 F7800.000 ; move to first support material point
G1 F3600.000
G1 X106.427 Y104.304 E2.11944 ; support material
G1 X105.934 Y104.508 E2.13271 ; support material
G1 X105.731 Y105.000 E2.14598 ; support material
G1 X105.934 Y105.492 E2.15925 ; support material
G1 X106.427 Y105.696 E2.17252 ; support material
G1 X106.919 Y105.492 E2.18579 ; support material
G1 X107.123 Y105.000 E2.19906 ; support material
G1 X106.919 Y104.508 E2.21233 ; support material
G1 X109.919 Y104.508 F7800.000 ; move to first support material point
G1 F3600.000
G1 X109.427 Y104.304 E2.22560 ; support material
G1 X108.934 Y104.508 E2.23887 ; support material
G1 X108.731 Y105.000 E2.25214 ; support material
G1 X108.934 Y105.492 E2.26541 ; support material
G1 X109.427 Y105.696 E2.27868 ; support material
G1 X109.919 Y105.492 E2.29196 ; support material
G1 X110.123 Y105.000 E2.30523 ; support material
G1 X109.919 Y104.508 E2.31850 ; support material
G1 E0.31850 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X109.919 Y107.508 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X109.427 Y107.304 E2.01327 ; support material
G1 X108.934 Y107.508 E2.02654 ; support material
G1 X108.731 Y108.000 E2.03981 ; support material
G1 X108.934 Y108.492 E2.05308 ; support material
G1 X109.427 Y108.696 E2.06635 ; support material
G1 X109.919 Y108.492 E2.07962 ; support material
G1 X110.123 Y108.000 E2.09289 ; support material
G1 X109.919 Y107.508 E2.10617 ; support material
G1 X106.919 Y107.508 F7800.000 ; move to first support material point
G1 F3600.000
G1 X106.427 Y107.304 E2.11944 ; support material
G1 X105.934 Y107.508 E2.13271 ; support material
G1 X105.731 Y108.000 E2.14598 ; support material
G1 X105.934 Y108.492 E2.15925 ; support material
G1 X106.427 Y108.696 E2.17252 ; support material
G1 X106.919 Y108.492 E2.18579 ; support material
G1 X107.123 Y108.000 E2.19906 ; support material
G1 X106.919 Y107.508 E2.21233 ; support material
G1 E0.21233 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.919 Y110.508 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X106.427 Y110.304 E2.01327 ; support material
G1 X105.934 Y110.508 E2.02654 ; support material
G1 X105.731 Y111.000 E2.03981 ; support material
G1 X105.934 Y111.492 E2.05308 ; support material
G1 X106.427 Y111.696 E2.06635 ; support material
G1 X106.919 Y111.492 E2.07962 ; support material
G1 X107.123 Y111.000 E2.09289 ; support material
G1 X106.919 Y110.508 E2.10617 ; support material
G1 E0.10617 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X109.919 Y110.508 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X109.427 Y110.304 E2.01327 ; support material
G1 X108.934 Y110.508 E2.02654 ; support material
G1 X108.731 Y111.000 E2.03981 ; support material
G1 X108.934 Y111.492 E2.05308 ; support material
G1 X109.427 Y111.696 E2.06635 ; support material
G1 X109.919 Y111.492 E2.07962 ; support material
G1 X110.123 Y111.000 E2.09289 ; support material
G1 X109.919 Y110.508 E2.10617 ; support material
G1 E0.10617 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.919 Y110.508 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X103.427 Y110.304 E2.01327 ; support material
G1 X102.934 Y110.508 E2.02654 ; support material
G1 X102.731 Y111.000 E2.03981 ; support material
G1 X102.934 Y111.492 E2.05308 ; support material
G1 X103.427 Y111.696 E2.06635 ; support material
G1 X103.919 Y111.492 E2.07962 ; support material
G1 X104.123 Y111.000 E2.09289 ; support material
G1 X103.919 Y110.508 E2.10617 ; support material
G1 E0.10617 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X101.234 Y110.193 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X100.741 Y109.989 E2.01327 ; support material
G1 X100.249 Y110.193 E2.02654 ; support material
G1 X100.045 Y110.685 E2.03981 ; support material
G1 X100.249 Y111.178 E2.05308 ; support material
G1 X100.741 Y111.381 E2.06635 ; support material
G1 X101.234 Y111.178 E2.07962 ; support material
G1 X101.437 Y110.685 E2.09289 ; support material
G1 X101.234 Y110.193 E2.10617 ; support material
G1 E0.10617 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X97.919 Y110.506 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X97.427 Y110.302 E2.01327 ; support material
G1 X96.934 Y110.506 E2.02654 ; support material
G1 X96.731 Y110.998 E2.03981 ; support material
G1 X96.934 Y111.491 E2.05308 ; support material
G1 X97.427 Y111.695 E2.06635 ; support material
G1 X97.919 Y111.491 E2.07962 ; support material
G1 X98.123 Y110.998 E2.09289 ; support material
G1 X97.919 Y110.506 E2.10617 ; support material
G1 E0.10617 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X94.919 Y110.486 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.427 Y110.282 E2.01327 ; support material
G1 X93.935 Y110.486 E2.02654 ; support material
G1 X93.731 Y110.978 E2.03981 ; support material
G1 X93.935 Y111.471 E2.05308 ; support material
G1 X94.427 Y111.675 E2.06635 ; support material
G1 X94.919 Y111.471 E2.07962 ; support material
G1 X95.123 Y110.978 E2.09289 ; support material
G1 X94.919 Y110.486 E2.10617 ; support material
G1 E0.10617 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X94.919 Y107.486 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.427 Y107.282 E2.01327 ; support material
G1 X93.935 Y107.486 E2.02654 ; support material
G1 X93.731 Y107.978 E2.03981 ; support material
G1 X93.935 Y108.471 E2.05308 ; support material
G1 X94.427 Y108.675 E2.06635 ; support material
G1 X94.919 Y108.471 E2.07962 ; support material
G1 X95.123 Y107.978 E2.09289 ; support material
G1 X94.919 Y107.486 E2.10617 ; support material
G1 E0.10617 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X97.919 Y107.506 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X97.427 Y107.302 E2.01327 ; support material
G1 X96.934 Y107.506 E2.02654 ; support material
G1 X96.731 Y107.998 E2.03981 ; support material
G1 X96.934 Y108.491 E2.05308 ; support material
G1 X97.427 Y108.695 E2.06635 ; support material
G1 X97.919 Y108.491 E2.07962 ; support material
G1 X98.123 Y107.998 E2.09289 ; support material
G1 X97.919 Y107.506 E2.10617 ; support material
G1 E0.10617 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X97.919 Y104.506 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X97.427 Y104.302 E2.01327 ; support material
G1 X96.934 Y104.506 E2.02654 ; support material
G1 X96.731 Y104.998 E2.03981 ; support material
G1 X96.934 Y105.491 E2.05308 ; support material
G1 X97.427 Y105.695 E2.06635 ; support material
G1 X97.919 Y105.491 E2.07962 ; support material
G1 X98.123 Y104.998 E2.09289 ; support material
G1 X97.919 Y104.506 E2.10617 ; support material
G1 E0.10617 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X94.919 Y104.486 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.427 Y104.282 E2.01327 ; support material
G1 X93.935 Y104.486 E2.02654 ; support material
G1 X93.731 Y104.978 E2.03981 ; support material
G1 X93.935 Y105.471 E2.05308 ; support material
G1 X94.427 Y105.675 E2.06635 ; support material
G1 X94.919 Y105.471 E2.07962 ; support material
G1 X95.123 Y104.978 E2.09289 ; support material
G1 X94.919 Y104.486 E2.10617 ; support material
G1 E0.10617 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X94.919 Y101.486 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.427 Y101.282 E2.01327 ; support material
G1 X93.935 Y101.486 E2.02654 ; support material
G1 X93.731 Y101.978 E2.03981 ; support material
G1 X93.935 Y102.471 E2.05308 ; support material
G1 X94.427 Y102.675 E2.06635 ; support material
G1 X94.919 Y102.471 E2.07962 ; support material
G1 X95.123 Y101.978 E2.09289 ; support material
G1 X94.919 Y101.486 E2.10617 ; support material
G1 E0.10617 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X94.919 Y98.486 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.427 Y98.282 E2.01327 ; support material
G1 X93.935 Y98.486 E2.02654 ; support material
G1 X93.731 Y98.978 E2.03981 ; support material
G1 X93.935 Y99.471 E2.05308 ; support material
G1 X94.427 Y99.675 E2.06635 ; support material
G1 X94.919 Y99.471 E2.07962 ; support material
G1 X95.123 Y98.978 E2.09289 ; support material
G1 X94.919 Y98.486 E2.10617 ; support material
G1 E0.10617 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X94.919 Y95.486 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.427 Y95.282 E2.01327 ; support material
G1 X93.935 Y95.486 E2.02654 ; support material
G1 X93.731 Y95.978 E2.03981 ; support material
G1 X93.935 Y96.471 E2.05308 ; support material
G1 X94.427 Y96.675 E2.06635 ; support material
G1 X94.919 Y96.471 E2.07962 ; support material
G1 X95.123 Y95.978 E2.09289 ; support material
G1 X94.919 Y95.486 E2.10617 ; support material
G1 E0.10617 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X97.919 Y95.506 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X97.427 Y95.302 E2.01327 ; support material
G1 X96.934 Y95.506 E2.02654 ; support material
G1 X96.731 Y95.998 E2.03981 ; support material
G1 X96.934 Y96.491 E2.05308 ; support material
G1 X97.427 Y96.695 E2.06635 ; support material
G1 X97.919 Y96.491 E2.07962 ; support material
G1 X98.123 Y95.998 E2.09289 ; support material
G1 X97.919 Y95.506 E2.10617 ; support material
G1 E0.10617 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X98.234 Y92.193 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X97.741 Y91.989 E2.01327 ; support material
G1 X97.249 Y92.193 E2.02654 ; support material
G1 X97.045 Y92.685 E2.03981 ; support material
G1 X97.249 Y93.177 E2.05308 ; support material
G1 X97.741 Y93.381 E2.06635 ; support material
G1 X98.234 Y93.177 E2.07962 ; support material
G1 X98.437 Y92.685 E2.09289 ; support material
G1 X98.234 Y92.193 E2.10617 ; support material
G1 E0.10617 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X98.234 Y89.823 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X97.741 Y89.619 E2.01327 ; support material
G1 X97.249 Y89.823 E2.02654 ; support material
G1 X97.045 Y90.315 E2.03981 ; support material
G1 X97.249 Y90.807 E2.05308 ; support material
G1 X97.741 Y91.011 E2.06635 ; support material
G1 X98.234 Y90.807 E2.07962 ; support material
G1 X98.437 Y90.315 E2.09289 ; support material
G1 X98.234 Y89.823 E2.10617 ; support material
G1 E0.10617 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.234 Y89.838 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.742 Y89.634 E2.01327 ; support material
G1 X94.249 Y89.838 E2.02654 ; support material
G1 X94.045 Y90.330 E2.03981 ; support material
G1 X94.249 Y90.822 E2.05308 ; support material
G1 X94.742 Y91.026 E2.06635 ; support material
G1 X95.234 Y90.822 E2.07962 ; support material
G1 X95.438 Y90.330 E2.09289 ; support material
G1 X95.234 Y89.838 E2.10617 ; support material
G1 E0.10617 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.234 Y92.178 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.742 Y91.974 E2.01327 ; support material
G1 X94.249 Y92.178 E2.02654 ; support material
G1 X94.045 Y92.670 E2.03981 ; support material
G1 X94.249 Y93.162 E2.05308 ; support material
G1 X94.742 Y93.366 E2.06635 ; support material
G1 X95.234 Y93.162 E2.07962 ; support material
G1 X95.438 Y92.670 E2.09289 ; support material
G1 X95.234 Y92.178 E2.10617 ; support material
G1 E0.10617 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.995 Y89.896 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.503 Y89.692 E2.01327 ; support material
G1 X91.011 Y89.896 E2.02654 ; support material
G1 X90.904 Y90.154 E2.03349 ; support material
G1 X90.120 Y90.041 E2.05323 ; support material
G1 X89.571 Y90.292 E2.06827 ; support material
G1 X89.245 Y90.799 E2.08330 ; support material
G1 X89.245 Y91.403 E2.09833 ; support material
G1 X89.571 Y91.910 E2.11336 ; support material
G1 X90.120 Y92.161 E2.12839 ; support material
G1 X91.064 Y92.025 E2.15215 ; support material
G1 X90.840 Y92.566 E2.16672 ; support material
G1 X91.044 Y93.058 E2.17999 ; support material
G1 X91.536 Y93.262 E2.19326 ; support material
G1 X92.028 Y93.058 E2.20653 ; support material
G1 X92.232 Y92.566 E2.21980 ; support material
G1 X92.028 Y92.074 E2.23307 ; support material
G1 X91.536 Y91.870 E2.24634 ; support material
G1 X91.060 Y92.067 E2.25918 ; support material
G1 X91.327 Y91.157 E2.28281 ; support material
G1 X91.995 Y90.880 E2.30083 ; support material
G1 X92.199 Y90.388 E2.31410 ; support material
G1 X91.995 Y89.896 E2.32738 ; support material
G1 E0.32738 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.715 Y94.814 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.091 Y94.724 E2.01570 ; support material
G1 X90.517 Y94.986 E2.03140 ; support material
G1 X90.177 Y95.517 E2.04711 ; support material
G1 X90.177 Y96.147 E2.06281 ; support material
G1 X90.517 Y96.677 E2.07851 ; support material
G1 X91.091 Y96.939 E2.09421 ; support material
G1 X91.715 Y96.849 E2.10992 ; support material
G1 X92.191 Y96.437 E2.12562 ; support material
G1 X92.369 Y95.832 E2.14132 ; support material
G1 X92.191 Y95.227 E2.15702 ; support material
G1 X91.715 Y94.814 E2.17272 ; support material
G1 E0.17272 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.715 Y97.814 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.091 Y97.724 E2.01570 ; support material
G1 X90.517 Y97.986 E2.03140 ; support material
G1 X90.177 Y98.517 E2.04711 ; support material
G1 X90.177 Y99.147 E2.06281 ; support material
G1 X90.517 Y99.677 E2.07851 ; support material
G1 X91.091 Y99.939 E2.09421 ; support material
G1 X91.715 Y99.849 E2.10992 ; support material
G1 X92.191 Y99.437 E2.12562 ; support material
G1 X92.369 Y98.832 E2.14132 ; support material
G1 X92.191 Y98.227 E2.15702 ; support material
G1 X91.715 Y97.814 E2.17272 ; support material
G1 E0.17272 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.715 Y100.814 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.091 Y100.724 E2.01570 ; support material
G1 X90.517 Y100.986 E2.03140 ; support material
G1 X90.177 Y101.517 E2.04711 ; support material
G1 X90.177 Y102.147 E2.06281 ; support material
G1 X90.517 Y102.677 E2.07851 ; support material
G1 X91.091 Y102.939 E2.09421 ; support material
G1 X91.715 Y102.849 E2.10992 ; support material
G1 X92.191 Y102.437 E2.12562 ; support material
G1 X92.369 Y101.832 E2.14132 ; support material
G1 X92.191 Y101.227 E2.15702 ; support material
G1 X91.715 Y100.814 E2.17272 ; support material
G1 E0.17272 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.715 Y103.814 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.091 Y103.724 E2.01570 ; support material
G1 X90.517 Y103.986 E2.03140 ; support material
G1 X90.177 Y104.517 E2.04711 ; support material
G1 X90.177 Y105.147 E2.06281 ; support material
G1 X90.517 Y105.677 E2.07851 ; support material
G1 X91.091 Y105.939 E2.09421 ; support material
G1 X91.715 Y105.849 E2.10992 ; support material
G1 X92.191 Y105.437 E2.12562 ; support material
G1 X92.369 Y104.832 E2.14132 ; support material
G1 X92.191 Y104.227 E2.15702 ; support material
G1 X91.715 Y103.814 E2.17272 ; support material
G1 E0.17272 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.715 Y106.814 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.091 Y106.724 E2.01570 ; support material
G1 X90.517 Y106.986 E2.03140 ; support material
G1 X90.177 Y107.517 E2.04711 ; support material
G1 X90.177 Y108.147 E2.06281 ; support material
G1 X90.517 Y108.677 E2.07851 ; support material
G1 X91.091 Y108.939 E2.09421 ; support material
G1 X91.715 Y108.849 E2.10992 ; support material
G1 X92.191 Y108.437 E2.12562 ; support material
G1 X92.369 Y107.832 E2.14132 ; support material
G1 X92.191 Y107.227 E2.15702 ; support material
G1 X91.715 Y106.814 E2.17272 ; support material
G1 E0.17272 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.715 Y109.814 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.091 Y109.724 E2.01570 ; support material
G1 X90.517 Y109.986 E2.03140 ; support material
G1 X90.177 Y110.517 E2.04711 ; support material
G1 X90.177 Y111.147 E2.06281 ; support material
G1 X90.517 Y111.677 E2.07851 ; support material
G1 X91.091 Y111.939 E2.09421 ; support material
G1 X91.715 Y111.849 E2.10992 ; support material
G1 X92.191 Y111.437 E2.12562 ; support material
G1 X92.369 Y110.832 E2.14132 ; support material
G1 X92.191 Y110.227 E2.15702 ; support material
G1 X91.715 Y109.814 E2.17272 ; support material
G1 E0.17272 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X101.234 Y95.193 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X100.741 Y94.989 E2.01327 ; support material
G1 X100.249 Y95.193 E2.02654 ; support material
G1 X100.045 Y95.685 E2.03981 ; support material
G1 X100.249 Y96.178 E2.05308 ; support material
G1 X100.741 Y96.381 E2.06635 ; support material
G1 X101.234 Y96.178 E2.07962 ; support material
G1 X101.437 Y95.685 E2.09289 ; support material
G1 X101.234 Y95.193 E2.10617 ; support material
G1 E0.10617 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X101.234 Y92.193 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X100.741 Y91.989 E2.01327 ; support material
G1 X100.249 Y92.193 E2.02654 ; support material
G1 X100.045 Y92.685 E2.03981 ; support material
G1 X100.249 Y93.178 E2.05308 ; support material
G1 X100.741 Y93.381 E2.06635 ; support material
G1 X101.234 Y93.178 E2.07962 ; support material
G1 X101.437 Y92.685 E2.09289 ; support material
G1 X101.234 Y92.193 E2.10617 ; support material
G1 E0.10617 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X101.234 Y89.822 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X100.741 Y89.619 E2.01327 ; support material
G1 X100.249 Y89.822 E2.02654 ; support material
G1 X100.045 Y90.315 E2.03981 ; support material
G1 X100.249 Y90.807 E2.05308 ; support material
G1 X100.741 Y91.011 E2.06635 ; support material
G1 X101.234 Y90.807 E2.07962 ; support material
G1 X101.437 Y90.315 E2.09289 ; support material
G1 X101.234 Y89.822 E2.10617 ; support material
G1 E0.10617 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.919 Y89.508 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X103.427 Y89.304 E2.01327 ; support material
G1 X102.934 Y89.508 E2.02654 ; support material
G1 X102.731 Y90.000 E2.03981 ; support material
G1 X102.934 Y90.492 E2.05308 ; support material
G1 X103.427 Y90.696 E2.06635 ; support material
G1 X103.919 Y90.492 E2.07962 ; support material
G1 X104.123 Y90.000 E2.09289 ; support material
G1 X103.919 Y89.508 E2.10617 ; support material
G1 E0.10617 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X103.919 Y92.508 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X103.427 Y92.304 E2.01327 ; support material
G1 X102.934 Y92.508 E2.02654 ; support material
G1 X102.731 Y93.000 E2.03981 ; support material
G1 X102.934 Y93.492 E2.05308 ; support material
G1 X103.427 Y93.696 E2.06635 ; support material
G1 X103.919 Y93.492 E2.07962 ; support material
G1 X104.123 Y93.000 E2.09289 ; support material
G1 X103.919 Y92.508 E2.10617 ; support material
G1 X106.919 Y92.508 F7800.000 ; move to first support material point
G1 F3600.000
G1 X106.427 Y92.304 E2.11944 ; support material
G1 X105.934 Y92.508 E2.13271 ; support material
G1 X105.731 Y93.000 E2.14598 ; support material
G1 X105.934 Y93.492 E2.15925 ; support material
G1 X106.427 Y93.696 E2.17252 ; support material
G1 X106.919 Y93.492 E2.18579 ; support material
G1 X107.123 Y93.000 E2.19906 ; support material
G1 X106.919 Y92.508 E2.21233 ; support material
G1 E0.21233 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.919 Y89.508 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X106.427 Y89.304 E2.01327 ; support material
G1 X105.934 Y89.508 E2.02654 ; support material
G1 X105.731 Y90.000 E2.03981 ; support material
G1 X105.934 Y90.492 E2.05308 ; support material
G1 X106.427 Y90.696 E2.06635 ; support material
G1 X106.919 Y90.492 E2.07962 ; support material
G1 X107.123 Y90.000 E2.09289 ; support material
G1 X106.919 Y89.508 E2.10617 ; support material
G1 X109.919 Y89.508 F7800.000 ; move to first support material point
G1 F3600.000
G1 X109.427 Y89.304 E2.11944 ; support material
G1 X108.934 Y89.508 E2.13271 ; support material
G1 X108.731 Y90.000 E2.14598 ; support material
G1 X108.934 Y90.492 E2.15925 ; support material
G1 X109.427 Y90.696 E2.17252 ; support material
G1 X109.919 Y90.492 E2.18579 ; support material
G1 X110.123 Y90.000 E2.19906 ; support material
G1 X109.919 Y89.508 E2.21233 ; support material
G1 E0.21233 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X109.919 Y92.508 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X109.427 Y92.304 E2.01327 ; support material
G1 X108.934 Y92.508 E2.02654 ; support material
G1 X108.731 Y93.000 E2.03981 ; support material
G1 X108.934 Y93.492 E2.05308 ; support material
G1 X109.427 Y93.696 E2.06635 ; support material
G1 X109.919 Y93.492 E2.07962 ; support material
G1 X110.123 Y93.000 E2.09289 ; support material
G1 X109.919 Y92.508 E2.10617 ; support material
G1 E0.10617 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.511 Y96.135 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X110.019 Y95.931 E2.01327 ; support material
G1 X109.527 Y96.135 E2.02654 ; support material
G1 X109.323 Y96.627 E2.03981 ; support material
G1 X109.527 Y97.119 E2.05308 ; support material
G1 X110.019 Y97.323 E2.06635 ; support material
G1 X110.511 Y97.119 E2.07962 ; support material
G1 X110.715 Y96.627 E2.09289 ; support material
G1 X110.511 Y96.135 E2.10617 ; support material
G1 E0.10617 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.271 Y98.180 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X109.778 Y97.976 E2.01327 ; support material
G1 X109.286 Y98.180 E2.02654 ; support material
G1 X109.082 Y98.672 E2.03981 ; support material
G1 X109.286 Y99.165 E2.05308 ; support material
G1 X109.778 Y99.368 E2.06635 ; support material
G1 X110.271 Y99.165 E2.07962 ; support material
G1 X110.474 Y98.672 E2.09289 ; support material
G1 X110.271 Y98.180 E2.10617 ; support material
G1 E0.10617 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.990 Y98.132 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X106.497 Y97.928 E2.01327 ; support material
G1 X105.859 Y98.193 E2.03050 ; support material
G1 X105.952 Y98.260 E2.03337 ; support material
G1 X105.801 Y98.624 E2.04318 ; support material
G1 X106.005 Y99.116 E2.05645 ; support material
G1 X106.497 Y99.320 E2.06972 ; support material
G1 X106.990 Y99.116 E2.08299 ; support material
G1 X107.194 Y98.624 E2.09627 ; support material
G1 X106.990 Y98.132 E2.10954 ; support material
G1 E0.10954 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.955 Y95.745 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X106.463 Y95.541 E2.01327 ; support material
G1 X105.971 Y95.745 E2.02654 ; support material
G1 X105.644 Y96.534 E2.04782 ; support material
G1 X105.297 Y96.232 E2.05927 ; support material
G1 X104.673 Y96.143 E2.07498 ; support material
G1 X104.099 Y96.405 E2.09068 ; support material
G1 X103.758 Y96.935 E2.10638 ; support material
G1 X103.758 Y97.565 E2.12208 ; support material
G1 X104.099 Y98.096 E2.13778 ; support material
G1 X104.673 Y98.357 E2.15349 ; support material
G1 X105.297 Y98.268 E2.16919 ; support material
G1 X105.599 Y98.006 E2.17916 ; support material
G1 X105.706 Y98.083 E2.18245 ; support material
G1 X105.951 Y97.250 E2.20406 ; support material
G1 X105.774 Y96.647 E2.21972 ; support material
G1 X106.463 Y96.933 E2.23831 ; support material
G1 X106.955 Y96.729 E2.25158 ; support material
G1 X107.159 Y96.237 E2.26485 ; support material
G1 X106.955 Y95.745 E2.27812 ; support material
G1 E0.27812 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.715 Y100.814 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X106.091 Y100.724 E2.01570 ; support material
G1 X105.517 Y100.986 E2.03140 ; support material
G1 X105.177 Y101.517 E2.04711 ; support material
G1 X105.177 Y102.147 E2.06281 ; support material
G1 X105.517 Y102.677 E2.07851 ; support material
G1 X106.091 Y102.939 E2.09421 ; support material
G1 X106.715 Y102.849 E2.10992 ; support material
G1 X107.191 Y102.437 E2.12562 ; support material
G1 X107.369 Y101.832 E2.14132 ; support material
G1 X107.191 Y101.227 E2.15702 ; support material
G1 X106.715 Y100.814 E2.17273 ; support material
G1 E0.17273 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X109.919 Y101.486 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X109.427 Y101.282 E2.01327 ; support material
G1 X108.935 Y101.486 E2.02654 ; support material
G1 X108.731 Y101.978 E2.03981 ; support material
G1 X108.935 Y102.471 E2.05308 ; support material
G1 X109.427 Y102.675 E2.06635 ; support material
G1 X109.919 Y102.471 E2.07962 ; support material
G1 X110.123 Y101.978 E2.09289 ; support material
G1 X109.919 Y101.486 E2.10617 ; support material
G1 Z6.650 F7800.000 ; move to next layer (39)
G1 E0.10617 F2400.00000 ; retract extruder 0
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
G1 X101.210 Y104.532 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X100.741 Y104.338 E2.01263 ; support material
G1 X100.273 Y104.532 E2.02525 ; support material
G1 X100.079 Y105.000 E2.03788 ; support material
G1 X100.273 Y105.468 E2.05051 ; support material
G1 X100.741 Y105.662 E2.06314 ; support material
G1 X101.210 Y105.468 E2.07576 ; support material
G1 X101.404 Y105.000 E2.08839 ; support material
G1 X101.210 Y104.532 E2.10102 ; support material
G1 X104.210 Y104.532 F7800.000 ; move to first support material point
G1 F3600.000
G1 X103.741 Y104.338 E2.11365 ; support material
G1 X103.273 Y104.532 E2.12627 ; support material
G1 X103.079 Y105.000 E2.13890 ; support material
G1 X103.273 Y105.468 E2.15153 ; support material
G1 X103.741 Y105.662 E2.16415 ; support material
G1 X104.210 Y105.468 E2.17678 ; support material
G1 X104.404 Y105.000 E2.18941 ; support material
G1 X104.210 Y104.532 E2.20204 ; support material
G1 X107.210 Y104.532 F7800.000 ; move to first support material point
G1 F3600.000
G1 X106.741 Y104.338 E2.21466 ; support material
G1 X106.273 Y104.532 E2.22729 ; support material
G1 X106.079 Y105.000 E2.23992 ; support material
G1 X106.273 Y105.468 E2.25255 ; support material
G1 X106.741 Y105.662 E2.26517 ; support material
G1 X107.210 Y105.468 E2.27780 ; support material
G1 X107.404 Y105.000 E2.29043 ; support material
G1 X107.210 Y104.532 E2.30305 ; support material
G1 X110.210 Y104.532 F7800.000 ; move to first support material point
G1 F3600.000
G1 X109.741 Y104.338 E2.31568 ; support material
G1 X109.273 Y104.532 E2.32831 ; support material
G1 X109.079 Y105.000 E2.34094 ; support material
G1 X109.273 Y105.468 E2.35356 ; support material
G1 X109.741 Y105.662 E2.36619 ; support material
G1 X110.210 Y105.468 E2.37882 ; support material
G1 X110.404 Y105.000 E2.39145 ; support material
G1 X110.210 Y104.532 E2.40407 ; support material
G1 E0.40407 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.210 Y107.532 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X109.741 Y107.338 E2.01263 ; support material
G1 X109.273 Y107.532 E2.02525 ; support material
G1 X109.079 Y108.000 E2.03788 ; support material
G1 X109.273 Y108.468 E2.05051 ; support material
G1 X109.741 Y108.662 E2.06314 ; support material
G1 X110.210 Y108.468 E2.07576 ; support material
G1 X110.404 Y108.000 E2.08839 ; support material
G1 X110.210 Y107.532 E2.10102 ; support material
G1 X107.210 Y107.532 F7800.000 ; move to first support material point
G1 F3600.000
G1 X106.741 Y107.338 E2.11365 ; support material
G1 X106.273 Y107.532 E2.12627 ; support material
G1 X106.079 Y108.000 E2.13890 ; support material
G1 X106.273 Y108.468 E2.15153 ; support material
G1 X106.741 Y108.662 E2.16415 ; support material
G1 X107.210 Y108.468 E2.17678 ; support material
G1 X107.404 Y108.000 E2.18941 ; support material
G1 X107.210 Y107.532 E2.20204 ; support material
G1 X104.210 Y107.532 F7800.000 ; move to first support material point
G1 F3600.000
G1 X103.741 Y107.338 E2.21466 ; support material
G1 X103.273 Y107.532 E2.22729 ; support material
G1 X103.079 Y108.000 E2.23992 ; support material
G1 X103.273 Y108.468 E2.25255 ; support material
G1 X103.741 Y108.662 E2.26517 ; support material
G1 X104.210 Y108.468 E2.27780 ; support material
G1 X104.404 Y108.000 E2.29043 ; support material
G1 X104.210 Y107.532 E2.30305 ; support material
G1 X101.210 Y107.532 F7800.000 ; move to first support material point
G1 F3600.000
G1 X100.741 Y107.338 E2.31568 ; support material
G1 X100.273 Y107.532 E2.32831 ; support material
G1 X100.079 Y108.000 E2.34094 ; support material
G1 X100.273 Y108.468 E2.35356 ; support material
G1 X100.741 Y108.662 E2.36619 ; support material
G1 X101.210 Y108.468 E2.37882 ; support material
G1 X101.404 Y108.000 E2.39145 ; support material
G1 X101.210 Y107.532 E2.40407 ; support material
G1 E0.40407 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X101.210 Y110.532 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X100.741 Y110.338 E2.01263 ; support material
G1 X100.273 Y110.532 E2.02525 ; support material
G1 X100.079 Y111.000 E2.03788 ; support material
G1 X100.273 Y111.468 E2.05051 ; support material
G1 X100.741 Y111.662 E2.06314 ; support material
G1 X101.210 Y111.468 E2.07576 ; support material
G1 X101.404 Y111.000 E2.08839 ; support material
G1 X101.210 Y110.532 E2.10102 ; support material
G1 E0.10102 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X104.210 Y110.532 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X103.741 Y110.338 E2.01263 ; support material
G1 X103.273 Y110.532 E2.02525 ; support material
G1 X103.079 Y111.000 E2.03788 ; support material
G1 X103.273 Y111.468 E2.05051 ; support material
G1 X103.741 Y111.662 E2.06314 ; support material
G1 X104.210 Y111.468 E2.07576 ; support material
G1 X104.404 Y111.000 E2.08839 ; support material
G1 X104.210 Y110.532 E2.10102 ; support material
G1 E0.10102 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X107.210 Y110.532 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X106.741 Y110.338 E2.01263 ; support material
G1 X106.273 Y110.532 E2.02525 ; support material
G1 X106.079 Y111.000 E2.03788 ; support material
G1 X106.273 Y111.468 E2.05051 ; support material
G1 X106.741 Y111.662 E2.06314 ; support material
G1 X107.210 Y111.468 E2.07576 ; support material
G1 X107.404 Y111.000 E2.08839 ; support material
G1 X107.210 Y110.532 E2.10102 ; support material
G1 E0.10102 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.210 Y110.532 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X109.741 Y110.338 E2.01263 ; support material
G1 X109.273 Y110.532 E2.02525 ; support material
G1 X109.079 Y111.000 E2.03788 ; support material
G1 X109.273 Y111.468 E2.05051 ; support material
G1 X109.741 Y111.662 E2.06314 ; support material
G1 X110.210 Y111.468 E2.07576 ; support material
G1 X110.404 Y111.000 E2.08839 ; support material
G1 X110.210 Y110.532 E2.10102 ; support material
G1 E0.10102 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.210 Y101.521 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X109.741 Y101.327 E2.01263 ; support material
G1 X109.273 Y101.521 E2.02525 ; support material
G1 X109.079 Y101.989 E2.03788 ; support material
G1 X109.273 Y102.457 E2.05051 ; support material
G1 X109.741 Y102.651 E2.06314 ; support material
G1 X110.210 Y102.457 E2.07576 ; support material
G1 X110.404 Y101.989 E2.08839 ; support material
G1 X110.210 Y101.521 E2.10102 ; support material
G1 E0.10102 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.210 Y98.516 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X109.742 Y98.322 E2.01263 ; support material
G1 X109.273 Y98.516 E2.02525 ; support material
G1 X109.079 Y98.985 E2.03788 ; support material
G1 X109.273 Y99.453 E2.05051 ; support material
G1 X109.742 Y99.647 E2.06314 ; support material
G1 X110.210 Y99.453 E2.07576 ; support material
G1 X110.404 Y98.985 E2.08839 ; support material
G1 X110.210 Y98.516 E2.10102 ; support material
G1 E0.10102 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.524 Y95.846 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X110.056 Y95.652 E2.01263 ; support material
G1 X109.588 Y95.846 E2.02525 ; support material
G1 X109.394 Y96.315 E2.03788 ; support material
G1 X109.588 Y96.783 E2.05051 ; support material
G1 X110.056 Y96.977 E2.06314 ; support material
G1 X110.524 Y96.783 E2.07576 ; support material
G1 X110.718 Y96.315 E2.08839 ; support material
G1 X110.524 Y95.846 E2.10102 ; support material
G1 E0.10102 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X107.222 Y95.646 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X106.753 Y95.452 E2.01263 ; support material
G1 X106.285 Y95.646 E2.02525 ; support material
G1 X106.091 Y96.115 E2.03788 ; support material
G1 X106.285 Y96.583 E2.05051 ; support material
G1 X106.753 Y96.777 E2.06314 ; support material
G1 X107.222 Y96.583 E2.07576 ; support material
G1 X107.416 Y96.115 E2.08839 ; support material
G1 X107.222 Y95.646 E2.10102 ; support material
G1 E0.10102 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X105.264 Y96.469 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X104.795 Y96.275 E2.01263 ; support material
G1 X104.327 Y96.469 E2.02525 ; support material
G1 X104.133 Y96.938 E2.03788 ; support material
G1 X104.348 Y97.457 E2.05189 ; support material
G1 X104.228 Y97.748 E2.05973 ; support material
G1 X104.422 Y98.216 E2.07235 ; support material
G1 X104.890 Y98.410 E2.08498 ; support material
G1 X105.358 Y98.216 E2.09761 ; support material
G1 X105.552 Y97.748 E2.11023 ; support material
G1 X105.337 Y97.228 E2.12425 ; support material
G1 X105.458 Y96.938 E2.13208 ; support material
G1 X105.264 Y96.469 E2.14471 ; support material
G1 E0.14471 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X107.242 Y98.307 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X106.774 Y98.113 E2.01263 ; support material
G1 X106.305 Y98.307 E2.02525 ; support material
G1 X106.111 Y98.775 E2.03788 ; support material
G1 X106.305 Y99.243 E2.05051 ; support material
G1 X106.774 Y99.437 E2.06314 ; support material
G1 X107.242 Y99.243 E2.07576 ; support material
G1 X107.436 Y98.775 E2.08839 ; support material
G1 X107.242 Y98.307 E2.10102 ; support material
G1 E0.10102 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.457 Y101.348 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X105.938 Y101.133 E2.01401 ; support material
G1 X105.469 Y101.327 E2.02664 ; support material
G1 X105.275 Y101.795 E2.03927 ; support material
G1 X105.469 Y102.264 E2.05189 ; support material
G1 X105.938 Y102.458 E2.06452 ; support material
G1 X106.228 Y102.337 E2.07235 ; support material
G1 X106.748 Y102.552 E2.08636 ; support material
G1 X107.216 Y102.358 E2.09899 ; support material
G1 X107.410 Y101.890 E2.11162 ; support material
G1 X107.216 Y101.422 E2.12425 ; support material
G1 X106.748 Y101.228 E2.13687 ; support material
G1 X106.457 Y101.348 E2.14471 ; support material
G1 E0.14471 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X101.210 Y95.532 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X100.741 Y95.338 E2.01263 ; support material
G1 X100.273 Y95.532 E2.02525 ; support material
G1 X100.079 Y96.000 E2.03788 ; support material
G1 X100.273 Y96.468 E2.05051 ; support material
G1 X100.741 Y96.662 E2.06314 ; support material
G1 X101.210 Y96.468 E2.07576 ; support material
G1 X101.404 Y96.000 E2.08839 ; support material
G1 X101.210 Y95.532 E2.10102 ; support material
G1 E0.10102 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X101.210 Y92.532 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X100.741 Y92.338 E2.01263 ; support material
G1 X100.273 Y92.532 E2.02525 ; support material
G1 X100.079 Y93.000 E2.03788 ; support material
G1 X100.273 Y93.468 E2.05051 ; support material
G1 X100.741 Y93.662 E2.06314 ; support material
G1 X101.210 Y93.468 E2.07576 ; support material
G1 X101.404 Y93.000 E2.08839 ; support material
G1 X101.210 Y92.532 E2.10102 ; support material
G1 E0.10102 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X101.210 Y89.532 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X100.741 Y89.338 E2.01263 ; support material
G1 X100.273 Y89.532 E2.02525 ; support material
G1 X100.079 Y90.000 E2.03788 ; support material
G1 X100.273 Y90.468 E2.05051 ; support material
G1 X100.741 Y90.662 E2.06314 ; support material
G1 X101.210 Y90.468 E2.07576 ; support material
G1 X101.404 Y90.000 E2.08839 ; support material
G1 X101.210 Y89.532 E2.10102 ; support material
G1 X104.210 Y89.532 F7800.000 ; move to first support material point
G1 F3600.000
G1 X103.741 Y89.338 E2.11365 ; support material
G1 X103.273 Y89.532 E2.12627 ; support material
G1 X103.079 Y90.000 E2.13890 ; support material
G1 X103.273 Y90.468 E2.15153 ; support material
G1 X103.741 Y90.662 E2.16415 ; support material
G1 X104.210 Y90.468 E2.17678 ; support material
G1 X104.404 Y90.000 E2.18941 ; support material
G1 X104.210 Y89.532 E2.20204 ; support material
G1 E0.20204 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X104.210 Y92.532 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X103.741 Y92.338 E2.01263 ; support material
G1 X103.273 Y92.532 E2.02525 ; support material
G1 X103.079 Y93.000 E2.03788 ; support material
G1 X103.273 Y93.468 E2.05051 ; support material
G1 X103.741 Y93.662 E2.06314 ; support material
G1 X104.210 Y93.468 E2.07576 ; support material
G1 X104.404 Y93.000 E2.08839 ; support material
G1 X104.210 Y92.532 E2.10102 ; support material
G1 X107.210 Y92.532 F7800.000 ; move to first support material point
G1 F3600.000
G1 X106.741 Y92.338 E2.11365 ; support material
G1 X106.273 Y92.532 E2.12627 ; support material
G1 X106.079 Y93.000 E2.13890 ; support material
G1 X106.273 Y93.468 E2.15153 ; support material
G1 X106.741 Y93.662 E2.16415 ; support material
G1 X107.210 Y93.468 E2.17678 ; support material
G1 X107.404 Y93.000 E2.18941 ; support material
G1 X107.210 Y92.532 E2.20204 ; support material
G1 E0.20204 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X107.210 Y89.532 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X106.741 Y89.338 E2.01263 ; support material
G1 X106.273 Y89.532 E2.02525 ; support material
G1 X106.079 Y90.000 E2.03788 ; support material
G1 X106.273 Y90.468 E2.05051 ; support material
G1 X106.741 Y90.662 E2.06314 ; support material
G1 X107.210 Y90.468 E2.07576 ; support material
G1 X107.404 Y90.000 E2.08839 ; support material
G1 X107.210 Y89.532 E2.10102 ; support material
G1 X110.210 Y89.532 F7800.000 ; move to first support material point
G1 F3600.000
G1 X109.741 Y89.338 E2.11365 ; support material
G1 X109.273 Y89.532 E2.12627 ; support material
G1 X109.079 Y90.000 E2.13890 ; support material
G1 X109.273 Y90.468 E2.15153 ; support material
G1 X109.741 Y90.662 E2.16415 ; support material
G1 X110.210 Y90.468 E2.17678 ; support material
G1 X110.404 Y90.000 E2.18941 ; support material
G1 X110.210 Y89.532 E2.20204 ; support material
G1 E0.20204 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.210 Y92.532 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X109.741 Y92.338 E2.01263 ; support material
G1 X109.273 Y92.532 E2.02525 ; support material
G1 X109.079 Y93.000 E2.03788 ; support material
G1 X109.273 Y93.468 E2.05051 ; support material
G1 X109.741 Y93.662 E2.06314 ; support material
G1 X110.210 Y93.468 E2.07576 ; support material
G1 X110.404 Y93.000 E2.08839 ; support material
G1 X110.210 Y92.532 E2.10102 ; support material
G1 E0.10102 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X98.210 Y92.531 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X97.741 Y92.337 E2.01263 ; support material
G1 X97.273 Y92.531 E2.02525 ; support material
G1 X97.079 Y93.000 E2.03788 ; support material
G1 X97.273 Y93.468 E2.05051 ; support material
G1 X97.741 Y93.662 E2.06314 ; support material
G1 X98.210 Y93.468 E2.07576 ; support material
G1 X98.404 Y93.000 E2.08839 ; support material
G1 X98.210 Y92.531 E2.10102 ; support material
G1 E0.10102 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X98.210 Y89.532 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X97.741 Y89.338 E2.01263 ; support material
G1 X97.273 Y89.532 E2.02525 ; support material
G1 X97.079 Y90.000 E2.03788 ; support material
G1 X97.273 Y90.469 E2.05051 ; support material
G1 X97.741 Y90.663 E2.06314 ; support material
G1 X98.210 Y90.469 E2.07576 ; support material
G1 X98.404 Y90.000 E2.08839 ; support material
G1 X98.210 Y89.532 E2.10102 ; support material
G1 E0.10102 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.210 Y89.547 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.742 Y89.353 E2.01263 ; support material
G1 X94.273 Y89.547 E2.02525 ; support material
G1 X94.079 Y90.015 E2.03788 ; support material
G1 X94.273 Y90.484 E2.05051 ; support material
G1 X94.742 Y90.678 E2.06314 ; support material
G1 X95.210 Y90.484 E2.07576 ; support material
G1 X95.404 Y90.015 E2.08839 ; support material
G1 X95.210 Y89.547 E2.10102 ; support material
G1 E0.10102 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.210 Y92.516 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.742 Y92.322 E2.01263 ; support material
G1 X94.273 Y92.516 E2.02525 ; support material
G1 X94.079 Y92.985 E2.03788 ; support material
G1 X94.273 Y93.453 E2.05051 ; support material
G1 X94.742 Y93.647 E2.06314 ; support material
G1 X95.210 Y93.453 E2.07576 ; support material
G1 X95.404 Y92.985 E2.08839 ; support material
G1 X95.210 Y92.516 E2.10102 ; support material
G1 E0.10102 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X92.244 Y92.301 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.776 Y92.107 E2.01263 ; support material
G1 X91.307 Y92.301 E2.02525 ; support material
G1 X91.113 Y92.770 E2.03788 ; support material
G1 X91.307 Y93.238 E2.05051 ; support material
G1 X91.776 Y93.432 E2.06314 ; support material
G1 X92.244 Y93.238 E2.07576 ; support material
G1 X92.438 Y92.770 E2.08839 ; support material
G1 X92.244 Y92.301 E2.10102 ; support material
G1 E0.10102 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X92.244 Y89.762 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.776 Y89.568 E2.01263 ; support material
G1 X91.307 Y89.762 E2.02525 ; support material
G1 X91.113 Y90.230 E2.03788 ; support material
G1 X91.160 Y90.344 E2.04094 ; support material
G1 X90.901 Y90.530 E2.04889 ; support material
G1 X91.776 Y90.893 E2.07247 ; support material
G1 X92.244 Y90.699 E2.08510 ; support material
G1 X92.438 Y90.230 E2.09772 ; support material
G1 X92.244 Y89.762 E2.11035 ; support material
G1 X90.445 Y90.284 F7800.000 ; move to first support material point
G1 F3600.000
G1 X89.848 Y90.199 E2.12538 ; support material
G1 X89.299 Y90.449 E2.14042 ; support material
G1 X88.972 Y90.957 E2.15545 ; support material
G1 X88.972 Y91.560 E2.17048 ; support material
G1 X89.299 Y92.068 E2.18551 ; support material
G1 X89.848 Y92.319 E2.20054 ; support material
G1 X90.445 Y92.233 E2.21558 ; support material
G1 X90.901 Y91.838 E2.23061 ; support material
G1 X91.071 Y91.259 E2.24564 ; support material
G1 X90.865 Y90.557 E2.26387 ; support material
G1 X90.807 Y90.598 E2.26564 ; support material
G1 X90.445 Y90.284 E2.27758 ; support material
G1 E0.27758 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.457 Y95.348 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X90.938 Y95.133 E2.01401 ; support material
G1 X90.469 Y95.327 E2.02664 ; support material
G1 X90.275 Y95.795 E2.03927 ; support material
G1 X90.469 Y96.264 E2.05189 ; support material
G1 X90.938 Y96.458 E2.06452 ; support material
G1 X91.228 Y96.337 E2.07235 ; support material
G1 X91.748 Y96.552 E2.08636 ; support material
G1 X92.216 Y96.358 E2.09899 ; support material
G1 X92.410 Y95.890 E2.11162 ; support material
G1 X92.216 Y95.422 E2.12425 ; support material
G1 X91.748 Y95.228 E2.13687 ; support material
G1 X91.457 Y95.348 E2.14471 ; support material
G1 E0.14471 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.457 Y98.348 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X90.938 Y98.133 E2.01401 ; support material
G1 X90.469 Y98.327 E2.02664 ; support material
G1 X90.275 Y98.795 E2.03927 ; support material
G1 X90.469 Y99.264 E2.05189 ; support material
G1 X90.938 Y99.458 E2.06452 ; support material
G1 X91.228 Y99.337 E2.07235 ; support material
G1 X91.748 Y99.552 E2.08636 ; support material
G1 X92.216 Y99.358 E2.09899 ; support material
G1 X92.410 Y98.890 E2.11162 ; support material
G1 X92.216 Y98.422 E2.12425 ; support material
G1 X91.748 Y98.228 E2.13687 ; support material
G1 X91.457 Y98.348 E2.14471 ; support material
G1 E0.14471 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.457 Y101.348 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X90.938 Y101.133 E2.01401 ; support material
G1 X90.469 Y101.327 E2.02664 ; support material
G1 X90.275 Y101.795 E2.03927 ; support material
G1 X90.469 Y102.264 E2.05189 ; support material
G1 X90.938 Y102.458 E2.06452 ; support material
G1 X91.228 Y102.337 E2.07235 ; support material
G1 X91.748 Y102.552 E2.08636 ; support material
G1 X92.216 Y102.358 E2.09899 ; support material
G1 X92.410 Y101.890 E2.11162 ; support material
G1 X92.216 Y101.422 E2.12425 ; support material
G1 X91.748 Y101.228 E2.13687 ; support material
G1 X91.457 Y101.348 E2.14471 ; support material
G1 E0.14471 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.457 Y104.348 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X90.938 Y104.133 E2.01401 ; support material
G1 X90.469 Y104.327 E2.02664 ; support material
G1 X90.275 Y104.795 E2.03927 ; support material
G1 X90.469 Y105.264 E2.05189 ; support material
G1 X90.938 Y105.458 E2.06452 ; support material
G1 X91.228 Y105.337 E2.07235 ; support material
G1 X91.748 Y105.552 E2.08636 ; support material
G1 X92.216 Y105.358 E2.09899 ; support material
G1 X92.410 Y104.890 E2.11162 ; support material
G1 X92.216 Y104.422 E2.12425 ; support material
G1 X91.748 Y104.228 E2.13687 ; support material
G1 X91.457 Y104.348 E2.14471 ; support material
G1 E0.14471 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.457 Y107.348 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X90.938 Y107.133 E2.01401 ; support material
G1 X90.469 Y107.327 E2.02664 ; support material
G1 X90.275 Y107.795 E2.03927 ; support material
G1 X90.469 Y108.264 E2.05189 ; support material
G1 X90.938 Y108.458 E2.06452 ; support material
G1 X91.228 Y108.337 E2.07235 ; support material
G1 X91.748 Y108.552 E2.08636 ; support material
G1 X92.216 Y108.358 E2.09899 ; support material
G1 X92.410 Y107.890 E2.11162 ; support material
G1 X92.216 Y107.422 E2.12425 ; support material
G1 X91.748 Y107.228 E2.13687 ; support material
G1 X91.457 Y107.348 E2.14471 ; support material
G1 E0.14471 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.457 Y110.348 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X90.938 Y110.133 E2.01401 ; support material
G1 X90.469 Y110.327 E2.02664 ; support material
G1 X90.275 Y110.795 E2.03927 ; support material
G1 X90.469 Y111.264 E2.05189 ; support material
G1 X90.938 Y111.458 E2.06452 ; support material
G1 X91.228 Y111.337 E2.07235 ; support material
G1 X91.748 Y111.552 E2.08636 ; support material
G1 X92.216 Y111.358 E2.09899 ; support material
G1 X92.410 Y110.890 E2.11162 ; support material
G1 X92.216 Y110.422 E2.12425 ; support material
G1 X91.748 Y110.228 E2.13687 ; support material
G1 X91.457 Y110.348 E2.14471 ; support material
G1 E0.14471 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.210 Y110.521 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.741 Y110.327 E2.01263 ; support material
G1 X94.273 Y110.521 E2.02525 ; support material
G1 X94.079 Y110.989 E2.03788 ; support material
G1 X94.273 Y111.457 E2.05051 ; support material
G1 X94.741 Y111.651 E2.06314 ; support material
G1 X95.210 Y111.457 E2.07576 ; support material
G1 X95.404 Y110.989 E2.08839 ; support material
G1 X95.210 Y110.521 E2.10102 ; support material
G1 E0.10102 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X98.210 Y110.531 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X97.741 Y110.337 E2.01263 ; support material
G1 X97.273 Y110.531 E2.02525 ; support material
G1 X97.079 Y111.000 E2.03788 ; support material
G1 X97.273 Y111.468 E2.05051 ; support material
G1 X97.741 Y111.662 E2.06314 ; support material
G1 X98.210 Y111.468 E2.07576 ; support material
G1 X98.404 Y111.000 E2.08839 ; support material
G1 X98.210 Y110.531 E2.10102 ; support material
G1 E0.10102 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X98.210 Y107.531 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X97.741 Y107.337 E2.01263 ; support material
G1 X97.273 Y107.531 E2.02525 ; support material
G1 X97.079 Y108.000 E2.03788 ; support material
G1 X97.273 Y108.468 E2.05051 ; support material
G1 X97.741 Y108.662 E2.06314 ; support material
G1 X98.210 Y108.468 E2.07576 ; support material
G1 X98.404 Y108.000 E2.08839 ; support material
G1 X98.210 Y107.531 E2.10102 ; support material
G1 E0.10102 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.210 Y107.521 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.741 Y107.327 E2.01263 ; support material
G1 X94.273 Y107.521 E2.02525 ; support material
G1 X94.079 Y107.989 E2.03788 ; support material
G1 X94.273 Y108.457 E2.05051 ; support material
G1 X94.741 Y108.651 E2.06314 ; support material
G1 X95.210 Y108.457 E2.07576 ; support material
G1 X95.404 Y107.989 E2.08839 ; support material
G1 X95.210 Y107.521 E2.10102 ; support material
G1 E0.10102 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.210 Y104.521 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.741 Y104.327 E2.01263 ; support material
G1 X94.273 Y104.521 E2.02525 ; support material
G1 X94.079 Y104.989 E2.03788 ; support material
G1 X94.273 Y105.457 E2.05051 ; support material
G1 X94.741 Y105.651 E2.06314 ; support material
G1 X95.210 Y105.457 E2.07576 ; support material
G1 X95.404 Y104.989 E2.08839 ; support material
G1 X95.210 Y104.521 E2.10102 ; support material
G1 E0.10102 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X98.210 Y104.531 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X97.741 Y104.337 E2.01263 ; support material
G1 X97.273 Y104.531 E2.02525 ; support material
G1 X97.079 Y105.000 E2.03788 ; support material
G1 X97.273 Y105.468 E2.05051 ; support material
G1 X97.741 Y105.662 E2.06314 ; support material
G1 X98.210 Y105.468 E2.07576 ; support material
G1 X98.404 Y105.000 E2.08839 ; support material
G1 X98.210 Y104.531 E2.10102 ; support material
G1 E0.10102 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.210 Y101.521 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.741 Y101.327 E2.01263 ; support material
G1 X94.273 Y101.521 E2.02525 ; support material
G1 X94.079 Y101.989 E2.03788 ; support material
G1 X94.273 Y102.457 E2.05051 ; support material
G1 X94.741 Y102.651 E2.06314 ; support material
G1 X95.210 Y102.457 E2.07576 ; support material
G1 X95.404 Y101.989 E2.08839 ; support material
G1 X95.210 Y101.521 E2.10102 ; support material
G1 E0.10102 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.210 Y98.521 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.741 Y98.327 E2.01263 ; support material
G1 X94.273 Y98.521 E2.02525 ; support material
G1 X94.079 Y98.989 E2.03788 ; support material
G1 X94.273 Y99.457 E2.05051 ; support material
G1 X94.741 Y99.651 E2.06314 ; support material
G1 X95.210 Y99.457 E2.07576 ; support material
G1 X95.404 Y98.989 E2.08839 ; support material
G1 X95.210 Y98.521 E2.10102 ; support material
G1 E0.10102 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.210 Y95.521 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.741 Y95.327 E2.01263 ; support material
G1 X94.273 Y95.521 E2.02525 ; support material
G1 X94.079 Y95.989 E2.03788 ; support material
G1 X94.273 Y96.457 E2.05051 ; support material
G1 X94.741 Y96.651 E2.06314 ; support material
G1 X95.210 Y96.457 E2.07576 ; support material
G1 X95.404 Y95.989 E2.08839 ; support material
G1 X95.210 Y95.521 E2.10102 ; support material
G1 E0.10102 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X98.210 Y95.531 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X97.741 Y95.337 E2.01263 ; support material
G1 X97.273 Y95.531 E2.02525 ; support material
G1 X97.079 Y96.000 E2.03788 ; support material
G1 X97.273 Y96.468 E2.05051 ; support material
G1 X97.741 Y96.662 E2.06314 ; support material
G1 X98.210 Y96.468 E2.07576 ; support material
G1 X98.404 Y96.000 E2.08839 ; support material
G1 X98.210 Y95.531 E2.10102 ; support material
M106 S255 ; enable fan
G1 Z6.950 F7800.000 ; move to next layer (41)
G1 E0.10102 F2400.00000 ; retract extruder 0
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
G1 X101.443 Y104.514 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X100.918 Y104.395 E2.01342 ; support material
G1 X100.496 Y104.731 E2.02685 ; support material
G1 X100.496 Y105.269 E2.04027 ; support material
G1 X100.918 Y105.605 E2.05369 ; support material
G1 X101.443 Y105.486 E2.06712 ; support material
G1 X101.677 Y105.000 E2.08054 ; support material
G1 X101.443 Y104.514 E2.09396 ; support material
G1 X104.443 Y104.514 F7800.000 ; move to first support material point
G1 F3600.000
G1 X103.918 Y104.395 E2.10739 ; support material
G1 X103.496 Y104.731 E2.12081 ; support material
G1 X103.496 Y105.269 E2.13424 ; support material
G1 X103.918 Y105.605 E2.14766 ; support material
G1 X104.443 Y105.486 E2.16108 ; support material
G1 X104.677 Y105.000 E2.17451 ; support material
G1 X104.443 Y104.514 E2.18793 ; support material
G1 X107.443 Y104.514 F7800.000 ; move to first support material point
G1 F3600.000
G1 X106.918 Y104.395 E2.20135 ; support material
G1 X106.496 Y104.731 E2.21478 ; support material
G1 X106.496 Y105.269 E2.22820 ; support material
G1 X106.918 Y105.605 E2.24162 ; support material
G1 X107.443 Y105.486 E2.25505 ; support material
G1 X107.677 Y105.000 E2.26847 ; support material
G1 X107.443 Y104.514 E2.28189 ; support material
G1 X110.443 Y104.514 F7800.000 ; move to first support material point
G1 F3600.000
G1 X109.918 Y104.395 E2.29532 ; support material
G1 X109.496 Y104.731 E2.30874 ; support material
G1 X109.496 Y105.269 E2.32217 ; support material
G1 X109.918 Y105.605 E2.33559 ; support material
G1 X110.443 Y105.486 E2.34901 ; support material
G1 X110.677 Y105.000 E2.36244 ; support material
G1 X110.443 Y104.514 E2.37586 ; support material
G1 E0.37586 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.443 Y107.514 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X109.918 Y107.395 E2.01342 ; support material
G1 X109.496 Y107.731 E2.02685 ; support material
G1 X109.496 Y108.269 E2.04027 ; support material
G1 X109.918 Y108.605 E2.05369 ; support material
G1 X110.443 Y108.486 E2.06712 ; support material
G1 X110.677 Y108.000 E2.08054 ; support material
G1 X110.443 Y107.514 E2.09396 ; support material
G1 X107.443 Y107.514 F7800.000 ; move to first support material point
G1 F3600.000
G1 X106.918 Y107.395 E2.10739 ; support material
G1 X106.496 Y107.731 E2.12081 ; support material
G1 X106.496 Y108.269 E2.13424 ; support material
G1 X106.918 Y108.605 E2.14766 ; support material
G1 X107.443 Y108.486 E2.16108 ; support material
G1 X107.677 Y108.000 E2.17451 ; support material
G1 X107.443 Y107.514 E2.18793 ; support material
G1 X104.443 Y107.514 F7800.000 ; move to first support material point
G1 F3600.000
G1 X103.918 Y107.395 E2.20135 ; support material
G1 X103.496 Y107.731 E2.21478 ; support material
G1 X103.496 Y108.269 E2.22820 ; support material
G1 X103.918 Y108.605 E2.24162 ; support material
G1 X104.443 Y108.486 E2.25505 ; support material
G1 X104.677 Y108.000 E2.26847 ; support material
G1 X104.443 Y107.514 E2.28189 ; support material
G1 X101.443 Y107.514 F7800.000 ; move to first support material point
G1 F3600.000
G1 X100.918 Y107.395 E2.29532 ; support material
G1 X100.496 Y107.731 E2.30874 ; support material
G1 X100.496 Y108.269 E2.32217 ; support material
G1 X100.918 Y108.605 E2.33559 ; support material
G1 X101.443 Y108.486 E2.34901 ; support material
G1 X101.677 Y108.000 E2.36244 ; support material
G1 X101.443 Y107.514 E2.37586 ; support material
G1 X98.443 Y107.514 F7800.000 ; move to first support material point
G1 F3600.000
G1 X97.918 Y107.395 E2.38928 ; support material
G1 X97.496 Y107.731 E2.40271 ; support material
G1 X97.496 Y108.269 E2.41613 ; support material
G1 X97.918 Y108.605 E2.42955 ; support material
G1 X98.443 Y108.486 E2.44298 ; support material
G1 X98.677 Y108.000 E2.45640 ; support material
G1 X98.443 Y107.514 E2.46982 ; support material
G1 E0.46982 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.443 Y107.511 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.918 Y107.391 E2.01342 ; support material
G1 X94.497 Y107.727 E2.02685 ; support material
G1 X94.497 Y108.266 E2.04027 ; support material
G1 X94.918 Y108.602 E2.05369 ; support material
G1 X95.443 Y108.482 E2.06712 ; support material
G1 X95.677 Y107.996 E2.08054 ; support material
G1 X95.443 Y107.511 E2.09396 ; support material
G1 E0.09396 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.443 Y104.511 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.918 Y104.391 E2.01342 ; support material
G1 X94.497 Y104.727 E2.02685 ; support material
G1 X94.497 Y105.266 E2.04027 ; support material
G1 X94.918 Y105.602 E2.05369 ; support material
G1 X95.443 Y105.482 E2.06712 ; support material
G1 X95.677 Y104.996 E2.08054 ; support material
G1 X95.443 Y104.511 E2.09396 ; support material
G1 E0.09396 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X98.443 Y104.514 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X97.918 Y104.395 E2.01342 ; support material
G1 X97.496 Y104.731 E2.02685 ; support material
G1 X97.496 Y105.269 E2.04027 ; support material
G1 X97.918 Y105.605 E2.05369 ; support material
G1 X98.443 Y105.486 E2.06712 ; support material
G1 X98.677 Y105.000 E2.08054 ; support material
G1 X98.443 Y104.514 E2.09396 ; support material
G1 E0.09396 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.443 Y101.511 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.918 Y101.391 E2.01342 ; support material
G1 X94.497 Y101.727 E2.02685 ; support material
G1 X94.497 Y102.266 E2.04027 ; support material
G1 X94.918 Y102.602 E2.05369 ; support material
G1 X95.443 Y102.482 E2.06712 ; support material
G1 X95.677 Y101.996 E2.08054 ; support material
G1 X95.443 Y101.511 E2.09396 ; support material
G1 E0.09396 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.443 Y98.511 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.918 Y98.391 E2.01342 ; support material
G1 X94.497 Y98.727 E2.02685 ; support material
G1 X94.497 Y99.266 E2.04027 ; support material
G1 X94.918 Y99.602 E2.05369 ; support material
G1 X95.443 Y99.482 E2.06712 ; support material
G1 X95.677 Y98.996 E2.08054 ; support material
G1 X95.443 Y98.511 E2.09396 ; support material
G1 E0.09396 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.443 Y95.511 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.918 Y95.391 E2.01342 ; support material
G1 X94.497 Y95.727 E2.02685 ; support material
G1 X94.497 Y96.266 E2.04027 ; support material
G1 X94.918 Y96.602 E2.05369 ; support material
G1 X95.443 Y96.482 E2.06712 ; support material
G1 X95.677 Y95.996 E2.08054 ; support material
G1 X95.443 Y95.511 E2.09396 ; support material
G1 E0.09396 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X98.443 Y95.514 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X97.918 Y95.395 E2.01342 ; support material
G1 X97.496 Y95.731 E2.02685 ; support material
G1 X97.496 Y96.269 E2.04027 ; support material
G1 X97.918 Y96.605 E2.05369 ; support material
G1 X98.443 Y96.486 E2.06712 ; support material
G1 X98.677 Y96.000 E2.08054 ; support material
G1 X98.443 Y95.514 E2.09396 ; support material
G1 E0.09396 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X98.443 Y92.514 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X97.918 Y92.395 E2.01342 ; support material
G1 X97.496 Y92.731 E2.02685 ; support material
G1 X97.496 Y93.269 E2.04027 ; support material
G1 X97.918 Y93.605 E2.05369 ; support material
G1 X98.443 Y93.486 E2.06712 ; support material
G1 X98.677 Y93.000 E2.08054 ; support material
G1 X98.443 Y92.514 E2.09396 ; support material
G1 E0.09396 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.443 Y92.511 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.918 Y92.391 E2.01342 ; support material
G1 X94.497 Y92.727 E2.02685 ; support material
G1 X94.497 Y93.266 E2.04027 ; support material
G1 X94.918 Y93.602 E2.05369 ; support material
G1 X95.443 Y93.482 E2.06712 ; support material
G1 X95.677 Y92.996 E2.08054 ; support material
G1 X95.443 Y92.511 E2.09396 ; support material
G1 E0.09396 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X92.455 Y92.402 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.929 Y92.282 E2.01342 ; support material
G1 X91.508 Y92.618 E2.02685 ; support material
G1 X91.508 Y93.157 E2.04027 ; support material
G1 X91.929 Y93.493 E2.05369 ; support material
G1 X92.455 Y93.373 E2.06712 ; support material
G1 X92.689 Y92.887 E2.08054 ; support material
G1 X92.455 Y92.402 E2.09396 ; support material
G1 E0.09396 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X92.455 Y89.627 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.929 Y89.507 E2.01342 ; support material
G1 X91.508 Y89.843 E2.02685 ; support material
G1 X91.508 Y90.382 E2.04027 ; support material
G1 X91.929 Y90.718 E2.05369 ; support material
G1 X92.455 Y90.598 E2.06712 ; support material
G1 X92.689 Y90.113 E2.08054 ; support material
G1 X92.455 Y89.627 E2.09396 ; support material
G1 E0.09396 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.387 Y90.458 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X89.862 Y90.339 E2.01342 ; support material
G1 X89.440 Y90.675 E2.02685 ; support material
G1 X89.440 Y91.213 E2.04027 ; support material
G1 X89.800 Y91.500 E2.05172 ; support material
G1 X89.440 Y91.787 E2.06317 ; support material
G1 X89.440 Y92.325 E2.07659 ; support material
G1 X89.862 Y92.661 E2.09001 ; support material
G1 X90.387 Y92.542 E2.10344 ; support material
G1 X90.621 Y92.056 E2.11686 ; support material
G1 X90.353 Y91.500 E2.13223 ; support material
G1 X90.621 Y90.944 E2.14761 ; support material
G1 X90.387 Y90.458 E2.16103 ; support material
G1 E0.16103 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.012 Y95.273 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X90.487 Y95.153 E2.01342 ; support material
G1 X90.066 Y95.489 E2.02685 ; support material
G1 X90.066 Y96.028 E2.04027 ; support material
G1 X90.487 Y96.364 E2.05369 ; support material
G1 X91.012 Y96.244 E2.06712 ; support material
G1 X91.164 Y95.928 E2.07586 ; support material
G1 X91.922 Y96.532 E2.09999 ; support material
G1 X92.447 Y96.412 E2.11342 ; support material
G1 X92.681 Y95.927 E2.12684 ; support material
G1 X92.447 Y95.441 E2.14027 ; support material
G1 X91.922 Y95.321 E2.15369 ; support material
G1 X91.282 Y95.832 E2.17410 ; support material
G1 X91.012 Y95.273 E2.18956 ; support material
G1 E0.18956 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.012 Y98.273 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X90.487 Y98.153 E2.01342 ; support material
G1 X90.066 Y98.489 E2.02685 ; support material
G1 X90.066 Y99.028 E2.04027 ; support material
G1 X90.487 Y99.364 E2.05369 ; support material
G1 X91.012 Y99.244 E2.06712 ; support material
G1 X91.164 Y98.928 E2.07586 ; support material
G1 X91.922 Y99.532 E2.09999 ; support material
G1 X92.447 Y99.412 E2.11342 ; support material
G1 X92.681 Y98.927 E2.12684 ; support material
G1 X92.447 Y98.441 E2.14027 ; support material
G1 X91.922 Y98.321 E2.15369 ; support material
G1 X91.282 Y98.832 E2.17410 ; support material
G1 X91.012 Y98.273 E2.18956 ; support material
G1 E0.18956 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.012 Y101.273 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X90.487 Y101.153 E2.01342 ; support material
G1 X90.066 Y101.489 E2.02685 ; support material
G1 X90.066 Y102.028 E2.04027 ; support material
G1 X90.487 Y102.364 E2.05369 ; support material
G1 X91.012 Y102.244 E2.06712 ; support material
G1 X91.164 Y101.928 E2.07586 ; support material
G1 X91.922 Y102.532 E2.09999 ; support material
G1 X92.447 Y102.412 E2.11342 ; support material
G1 X92.681 Y101.927 E2.12684 ; support material
G1 X92.447 Y101.441 E2.14027 ; support material
G1 X91.922 Y101.321 E2.15369 ; support material
G1 X91.282 Y101.832 E2.17410 ; support material
G1 X91.012 Y101.273 E2.18956 ; support material
G1 E0.18956 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.012 Y104.273 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X90.487 Y104.153 E2.01342 ; support material
G1 X90.066 Y104.489 E2.02685 ; support material
G1 X90.066 Y105.028 E2.04027 ; support material
G1 X90.487 Y105.364 E2.05369 ; support material
G1 X91.012 Y105.244 E2.06712 ; support material
G1 X91.164 Y104.928 E2.07586 ; support material
G1 X91.922 Y105.532 E2.09999 ; support material
G1 X92.447 Y105.412 E2.11342 ; support material
G1 X92.681 Y104.927 E2.12684 ; support material
G1 X92.447 Y104.441 E2.14027 ; support material
G1 X91.922 Y104.321 E2.15369 ; support material
G1 X91.282 Y104.832 E2.17410 ; support material
G1 X91.012 Y104.273 E2.18956 ; support material
G1 E0.18956 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.012 Y107.273 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X90.487 Y107.153 E2.01342 ; support material
G1 X90.066 Y107.489 E2.02685 ; support material
G1 X90.066 Y108.028 E2.04027 ; support material
G1 X90.487 Y108.364 E2.05369 ; support material
G1 X91.012 Y108.244 E2.06712 ; support material
G1 X91.164 Y107.928 E2.07586 ; support material
G1 X91.922 Y108.532 E2.09999 ; support material
G1 X92.447 Y108.412 E2.11342 ; support material
G1 X92.681 Y107.927 E2.12684 ; support material
G1 X92.447 Y107.441 E2.14027 ; support material
G1 X91.922 Y107.321 E2.15369 ; support material
G1 X91.282 Y107.832 E2.17410 ; support material
G1 X91.012 Y107.273 E2.18956 ; support material
G1 E0.18956 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X91.012 Y110.273 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X90.487 Y110.153 E2.01342 ; support material
G1 X90.066 Y110.489 E2.02685 ; support material
G1 X90.066 Y111.028 E2.04027 ; support material
G1 X90.487 Y111.364 E2.05369 ; support material
G1 X91.012 Y111.244 E2.06712 ; support material
G1 X91.164 Y110.928 E2.07586 ; support material
G1 X91.922 Y111.532 E2.09999 ; support material
G1 X92.447 Y111.412 E2.11342 ; support material
G1 X92.681 Y110.927 E2.12684 ; support material
G1 X92.447 Y110.441 E2.14027 ; support material
G1 X91.922 Y110.321 E2.15369 ; support material
G1 X91.282 Y110.832 E2.17410 ; support material
G1 X91.012 Y110.273 E2.18956 ; support material
G1 E0.18956 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.443 Y110.511 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.918 Y110.391 E2.01342 ; support material
G1 X94.497 Y110.727 E2.02685 ; support material
G1 X94.497 Y111.266 E2.04027 ; support material
G1 X94.918 Y111.602 E2.05369 ; support material
G1 X95.443 Y111.482 E2.06712 ; support material
G1 X95.677 Y110.996 E2.08054 ; support material
G1 X95.443 Y110.511 E2.09396 ; support material
G1 E0.09396 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X98.443 Y110.514 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X97.918 Y110.395 E2.01342 ; support material
G1 X97.496 Y110.731 E2.02685 ; support material
G1 X97.496 Y111.269 E2.04027 ; support material
G1 X97.918 Y111.605 E2.05369 ; support material
G1 X98.443 Y111.486 E2.06712 ; support material
G1 X98.677 Y111.000 E2.08054 ; support material
G1 X98.443 Y110.514 E2.09396 ; support material
G1 E0.09396 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X101.443 Y110.514 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X100.918 Y110.395 E2.01342 ; support material
G1 X100.496 Y110.731 E2.02685 ; support material
G1 X100.496 Y111.269 E2.04027 ; support material
G1 X100.918 Y111.605 E2.05369 ; support material
G1 X101.443 Y111.486 E2.06712 ; support material
G1 X101.677 Y111.000 E2.08054 ; support material
G1 X101.443 Y110.514 E2.09396 ; support material
G1 E0.09396 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X104.443 Y110.514 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X103.918 Y110.395 E2.01342 ; support material
G1 X103.496 Y110.731 E2.02685 ; support material
G1 X103.496 Y111.269 E2.04027 ; support material
G1 X103.918 Y111.605 E2.05369 ; support material
G1 X104.443 Y111.486 E2.06712 ; support material
G1 X104.677 Y111.000 E2.08054 ; support material
G1 X104.443 Y110.514 E2.09396 ; support material
G1 E0.09396 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X107.443 Y110.514 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X106.918 Y110.395 E2.01342 ; support material
G1 X106.496 Y110.731 E2.02685 ; support material
G1 X106.496 Y111.269 E2.04027 ; support material
G1 X106.918 Y111.605 E2.05369 ; support material
G1 X107.443 Y111.486 E2.06712 ; support material
G1 X107.677 Y111.000 E2.08054 ; support material
G1 X107.443 Y110.514 E2.09396 ; support material
G1 E0.09396 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.443 Y110.514 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X109.918 Y110.395 E2.01342 ; support material
G1 X109.496 Y110.731 E2.02685 ; support material
G1 X109.496 Y111.269 E2.04027 ; support material
G1 X109.918 Y111.605 E2.05369 ; support material
G1 X110.443 Y111.486 E2.06712 ; support material
G1 X110.677 Y111.000 E2.08054 ; support material
G1 X110.443 Y110.514 E2.09396 ; support material
G1 E0.09396 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.443 Y101.511 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X109.918 Y101.391 E2.01342 ; support material
G1 X109.497 Y101.727 E2.02685 ; support material
G1 X109.497 Y102.266 E2.04027 ; support material
G1 X109.918 Y102.602 E2.05369 ; support material
G1 X110.443 Y102.482 E2.06712 ; support material
G1 X110.677 Y101.996 E2.08054 ; support material
G1 X110.443 Y101.511 E2.09396 ; support material
G1 E0.09396 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.443 Y98.511 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X109.918 Y98.391 E2.01342 ; support material
G1 X109.497 Y98.727 E2.02685 ; support material
G1 X109.497 Y99.266 E2.04027 ; support material
G1 X109.918 Y99.602 E2.05369 ; support material
G1 X110.443 Y99.482 E2.06712 ; support material
G1 X110.677 Y98.996 E2.08054 ; support material
G1 X110.443 Y98.511 E2.09396 ; support material
G1 E0.09396 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X107.454 Y98.403 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X106.929 Y98.283 E2.01342 ; support material
G1 X106.508 Y98.619 E2.02685 ; support material
G1 X106.508 Y99.158 E2.04027 ; support material
G1 X106.929 Y99.494 E2.05369 ; support material
G1 X107.454 Y99.374 E2.06712 ; support material
G1 X107.688 Y98.888 E2.08054 ; support material
G1 X107.454 Y98.403 E2.09396 ; support material
G1 E0.09396 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X107.445 Y95.551 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X106.920 Y95.431 E2.01342 ; support material
G1 X106.499 Y95.767 E2.02685 ; support material
G1 X106.499 Y96.306 E2.04027 ; support material
G1 X106.920 Y96.642 E2.05369 ; support material
G1 X107.445 Y96.522 E2.06712 ; support material
G1 X107.679 Y96.037 E2.08054 ; support material
G1 X107.445 Y95.551 E2.09396 ; support material
G1 E0.09396 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X105.146 Y96.140 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X104.620 Y96.020 E2.01342 ; support material
G1 X104.199 Y96.356 E2.02685 ; support material
G1 X104.199 Y96.894 E2.04027 ; support material
G1 X104.845 Y97.410 E2.06085 ; support material
G1 X104.367 Y97.791 E2.07608 ; support material
G1 X104.367 Y98.330 E2.08950 ; support material
G1 X104.789 Y98.666 E2.10293 ; support material
G1 X105.314 Y98.546 E2.11635 ; support material
G1 X105.548 Y98.060 E2.12977 ; support material
G1 X105.314 Y97.575 E2.14320 ; support material
G1 X104.961 Y97.494 E2.15222 ; support material
G1 X105.380 Y96.625 E2.17624 ; support material
G1 X105.146 Y96.140 E2.18967 ; support material
G1 E0.18967 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X104.443 Y92.514 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X103.918 Y92.395 E2.01342 ; support material
G1 X103.496 Y92.731 E2.02685 ; support material
G1 X103.496 Y93.269 E2.04027 ; support material
G1 X103.918 Y93.605 E2.05369 ; support material
G1 X104.443 Y93.486 E2.06712 ; support material
G1 X104.677 Y93.000 E2.08054 ; support material
G1 X104.443 Y92.514 E2.09396 ; support material
G1 E0.09396 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X104.443 Y89.514 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X103.918 Y89.395 E2.01342 ; support material
G1 X103.496 Y89.731 E2.02685 ; support material
G1 X103.496 Y90.269 E2.04027 ; support material
G1 X103.918 Y90.605 E2.05369 ; support material
G1 X104.443 Y90.486 E2.06712 ; support material
G1 X104.677 Y90.000 E2.08054 ; support material
G1 X104.443 Y89.514 E2.09396 ; support material
G1 X107.443 Y89.514 F7800.000 ; move to first support material point
G1 F3600.000
G1 X106.918 Y89.395 E2.10739 ; support material
G1 X106.496 Y89.731 E2.12081 ; support material
G1 X106.496 Y90.269 E2.13424 ; support material
G1 X106.918 Y90.605 E2.14766 ; support material
G1 X107.443 Y90.486 E2.16108 ; support material
G1 X107.677 Y90.000 E2.17451 ; support material
G1 X107.443 Y89.514 E2.18793 ; support material
G1 E0.18793 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X107.443 Y92.514 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X106.918 Y92.395 E2.01342 ; support material
G1 X106.496 Y92.731 E2.02685 ; support material
G1 X106.496 Y93.269 E2.04027 ; support material
G1 X106.918 Y93.605 E2.05369 ; support material
G1 X107.443 Y93.486 E2.06712 ; support material
G1 X107.677 Y93.000 E2.08054 ; support material
G1 X107.443 Y92.514 E2.09396 ; support material
G1 X110.443 Y92.514 F7800.000 ; move to first support material point
G1 F3600.000
G1 X109.918 Y92.395 E2.10739 ; support material
G1 X109.496 Y92.731 E2.12081 ; support material
G1 X109.496 Y93.269 E2.13424 ; support material
G1 X109.918 Y93.605 E2.14766 ; support material
G1 X110.443 Y93.486 E2.16108 ; support material
G1 X110.677 Y93.000 E2.17451 ; support material
G1 X110.443 Y92.514 E2.18793 ; support material
G1 E0.18793 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.443 Y89.514 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X109.918 Y89.395 E2.01342 ; support material
G1 X109.496 Y89.731 E2.02685 ; support material
G1 X109.496 Y90.269 E2.04027 ; support material
G1 X109.918 Y90.605 E2.05369 ; support material
G1 X110.443 Y90.486 E2.06712 ; support material
G1 X110.677 Y90.000 E2.08054 ; support material
G1 X110.443 Y89.514 E2.09396 ; support material
G1 E0.09396 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.443 Y95.514 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X109.918 Y95.395 E2.01342 ; support material
G1 X109.496 Y95.731 E2.02685 ; support material
G1 X109.496 Y96.269 E2.04027 ; support material
G1 X109.918 Y96.605 E2.05369 ; support material
G1 X110.443 Y96.486 E2.06712 ; support material
G1 X110.677 Y96.000 E2.08054 ; support material
G1 X110.443 Y95.514 E2.09396 ; support material
G1 E0.09396 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X106.012 Y101.273 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X105.487 Y101.153 E2.01342 ; support material
G1 X105.066 Y101.489 E2.02685 ; support material
G1 X105.066 Y102.028 E2.04027 ; support material
G1 X105.487 Y102.364 E2.05369 ; support material
G1 X106.012 Y102.244 E2.06712 ; support material
G1 X106.164 Y101.928 E2.07586 ; support material
G1 X106.922 Y102.532 E2.09999 ; support material
G1 X107.447 Y102.412 E2.11342 ; support material
G1 X107.681 Y101.927 E2.12684 ; support material
G1 X107.447 Y101.441 E2.14027 ; support material
G1 X106.922 Y101.321 E2.15369 ; support material
G1 X106.282 Y101.832 E2.17410 ; support material
G1 X106.012 Y101.273 E2.18956 ; support material
G1 E0.18956 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X101.443 Y95.514 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X100.918 Y95.395 E2.01342 ; support material
G1 X100.496 Y95.731 E2.02685 ; support material
G1 X100.496 Y96.269 E2.04027 ; support material
G1 X100.918 Y96.605 E2.05369 ; support material
G1 X101.443 Y96.486 E2.06712 ; support material
G1 X101.677 Y96.000 E2.08054 ; support material
G1 X101.443 Y95.514 E2.09396 ; support material
G1 E0.09396 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X101.443 Y92.514 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X100.918 Y92.395 E2.01342 ; support material
G1 X100.496 Y92.731 E2.02685 ; support material
G1 X100.496 Y93.269 E2.04027 ; support material
G1 X100.918 Y93.605 E2.05369 ; support material
G1 X101.443 Y93.486 E2.06712 ; support material
G1 X101.677 Y93.000 E2.08054 ; support material
G1 X101.443 Y92.514 E2.09396 ; support material
G1 E0.09396 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X101.443 Y89.514 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X100.918 Y89.395 E2.01342 ; support material
G1 X100.496 Y89.731 E2.02685 ; support material
G1 X100.496 Y90.269 E2.04027 ; support material
G1 X100.918 Y90.605 E2.05369 ; support material
G1 X101.443 Y90.486 E2.06712 ; support material
G1 X101.677 Y90.000 E2.08054 ; support material
G1 X101.443 Y89.514 E2.09396 ; support material
G1 X98.443 Y89.514 F7800.000 ; move to first support material point
G1 F3600.000
G1 X97.918 Y89.395 E2.10739 ; support material
G1 X97.496 Y89.731 E2.12081 ; support material
G1 X97.496 Y90.269 E2.13424 ; support material
G1 X97.918 Y90.605 E2.14766 ; support material
G1 X98.443 Y90.486 E2.16108 ; support material
G1 X98.677 Y90.000 E2.17451 ; support material
G1 X98.443 Y89.514 E2.18793 ; support material
G1 E0.18793 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.443 Y89.518 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X94.918 Y89.398 E2.01342 ; support material
G1 X94.497 Y89.734 E2.02685 ; support material
G1 X94.497 Y90.273 E2.04027 ; support material
G1 X94.918 Y90.609 E2.05369 ; support material
G1 X95.443 Y90.489 E2.06712 ; support material
G1 X95.677 Y90.004 E2.08054 ; support material
G1 X95.443 Y89.518 E2.09396 ; support material
G1 Z7.550 F7800.000 ; move to next layer (44)
G1 E0.09396 F2400.00000 ; retract extruder 0
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
G1 X101.737 Y104.541 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X101.240 Y104.427 E2.01269 ; support material
G1 X100.842 Y104.745 E2.02539 ; support material
G1 X100.842 Y105.255 E2.03808 ; support material
G1 X101.240 Y105.573 E2.05078 ; support material
G1 X101.737 Y105.459 E2.06347 ; support material
G1 X101.958 Y105.000 E2.07616 ; support material
G1 X101.737 Y104.541 E2.08886 ; support material
G1 X104.737 Y104.541 F7800.000 ; move to first support material point
G1 F3600.000
G1 X104.240 Y104.427 E2.10155 ; support material
G1 X103.842 Y104.745 E2.11425 ; support material
G1 X103.842 Y105.255 E2.12694 ; support material
G1 X104.240 Y105.573 E2.13963 ; support material
G1 X104.737 Y105.459 E2.15233 ; support material
G1 X104.958 Y105.000 E2.16502 ; support material
G1 X104.737 Y104.541 E2.17772 ; support material
G1 X107.737 Y104.541 F7800.000 ; move to first support material point
G1 F3600.000
G1 X107.240 Y104.427 E2.19041 ; support material
G1 X106.842 Y104.745 E2.20310 ; support material
G1 X106.842 Y105.255 E2.21580 ; support material
G1 X107.240 Y105.573 E2.22849 ; support material
G1 X107.737 Y105.459 E2.24119 ; support material
G1 X107.958 Y105.000 E2.25388 ; support material
G1 X107.737 Y104.541 E2.26658 ; support material
G1 X110.737 Y104.541 F7800.000 ; move to first support material point
G1 F3600.000
G1 X110.240 Y104.427 E2.27927 ; support material
G1 X109.842 Y104.745 E2.29196 ; support material
G1 X109.842 Y105.255 E2.30466 ; support material
G1 X110.240 Y105.573 E2.31735 ; support material
G1 X110.737 Y105.459 E2.33005 ; support material
G1 X110.958 Y105.000 E2.34274 ; support material
G1 X110.737 Y104.541 E2.35543 ; support material
G1 E0.35543 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.737 Y101.541 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X110.240 Y101.427 E2.01269 ; support material
G1 X109.842 Y101.745 E2.02539 ; support material
G1 X109.842 Y102.255 E2.03808 ; support material
G1 X110.240 Y102.573 E2.05078 ; support material
G1 X110.737 Y102.459 E2.06347 ; support material
G1 X110.958 Y102.000 E2.07616 ; support material
G1 X110.737 Y101.541 E2.08886 ; support material
G1 E0.08886 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X107.739 Y101.504 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X107.242 Y101.391 E2.01269 ; support material
G1 X106.844 Y101.709 E2.02539 ; support material
G1 X106.844 Y102.218 E2.03808 ; support material
G1 X107.242 Y102.536 E2.05078 ; support material
G1 X107.739 Y102.423 E2.06347 ; support material
G1 X107.960 Y101.963 E2.07616 ; support material
G1 X107.739 Y101.504 E2.08886 ; support material
G1 E0.08886 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X105.679 Y101.263 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X105.182 Y101.149 E2.01269 ; support material
G1 X104.783 Y101.467 E2.02539 ; support material
G1 X104.783 Y101.977 E2.03808 ; support material
G1 X105.182 Y102.295 E2.05078 ; support material
G1 X105.679 Y102.181 E2.06347 ; support material
G1 X105.900 Y101.722 E2.07616 ; support material
G1 X105.679 Y101.263 E2.08886 ; support material
G1 E0.08886 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X105.330 Y97.914 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X104.833 Y97.800 E2.01269 ; support material
G1 X104.434 Y98.118 E2.02539 ; support material
G1 X104.434 Y98.628 E2.03808 ; support material
G1 X104.833 Y98.945 E2.05078 ; support material
G1 X105.330 Y98.832 E2.06347 ; support material
G1 X105.551 Y98.373 E2.07616 ; support material
G1 X105.330 Y97.914 E2.08886 ; support material
G1 E0.08886 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X105.088 Y95.853 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X104.591 Y95.740 E2.01269 ; support material
G1 X104.193 Y96.058 E2.02539 ; support material
G1 X104.193 Y96.567 E2.03808 ; support material
G1 X104.591 Y96.885 E2.05078 ; support material
G1 X105.088 Y96.772 E2.06347 ; support material
G1 X105.309 Y96.313 E2.07616 ; support material
G1 X105.088 Y95.853 E2.08886 ; support material
G1 E0.08886 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X107.737 Y95.541 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X107.240 Y95.427 E2.01269 ; support material
G1 X106.842 Y95.745 E2.02539 ; support material
G1 X106.842 Y96.255 E2.03808 ; support material
G1 X107.240 Y96.573 E2.05078 ; support material
G1 X107.737 Y96.459 E2.06347 ; support material
G1 X107.958 Y96.000 E2.07616 ; support material
G1 X107.737 Y95.541 E2.08886 ; support material
G1 E0.08886 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X107.739 Y98.504 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X107.242 Y98.391 E2.01269 ; support material
G1 X106.844 Y98.709 E2.02539 ; support material
G1 X106.844 Y99.218 E2.03808 ; support material
G1 X107.242 Y99.536 E2.05078 ; support material
G1 X107.739 Y99.423 E2.06347 ; support material
G1 X107.960 Y98.963 E2.07616 ; support material
G1 X107.739 Y98.504 E2.08886 ; support material
G1 E0.08886 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.737 Y98.541 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X110.240 Y98.427 E2.01269 ; support material
G1 X109.842 Y98.745 E2.02539 ; support material
G1 X109.842 Y99.255 E2.03808 ; support material
G1 X110.240 Y99.573 E2.05078 ; support material
G1 X110.737 Y99.459 E2.06347 ; support material
G1 X110.958 Y99.000 E2.07616 ; support material
G1 X110.737 Y98.541 E2.08886 ; support material
G1 E0.08886 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.737 Y95.541 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X110.240 Y95.427 E2.01269 ; support material
G1 X109.842 Y95.745 E2.02539 ; support material
G1 X109.842 Y96.255 E2.03808 ; support material
G1 X110.240 Y96.573 E2.05078 ; support material
G1 X110.737 Y96.459 E2.06347 ; support material
G1 X110.958 Y96.000 E2.07616 ; support material
G1 X110.737 Y95.541 E2.08886 ; support material
G1 E0.08886 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.737 Y92.541 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X110.240 Y92.427 E2.01269 ; support material
G1 X109.842 Y92.745 E2.02539 ; support material
G1 X109.842 Y93.255 E2.03808 ; support material
G1 X110.240 Y93.573 E2.05078 ; support material
G1 X110.737 Y93.459 E2.06347 ; support material
G1 X110.958 Y93.000 E2.07616 ; support material
G1 X110.737 Y92.541 E2.08886 ; support material
G1 E0.08886 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.737 Y89.541 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X110.240 Y89.427 E2.01269 ; support material
G1 X109.842 Y89.745 E2.02539 ; support material
G1 X109.842 Y90.255 E2.03808 ; support material
G1 X110.240 Y90.573 E2.05078 ; support material
G1 X110.737 Y90.459 E2.06347 ; support material
G1 X110.958 Y90.000 E2.07616 ; support material
G1 X110.737 Y89.541 E2.08886 ; support material
G1 X107.737 Y89.541 F7800.000 ; move to first support material point
G1 F3600.000
G1 X107.240 Y89.427 E2.10155 ; support material
G1 X106.842 Y89.745 E2.11425 ; support material
G1 X106.842 Y90.255 E2.12694 ; support material
G1 X107.240 Y90.573 E2.13963 ; support material
G1 X107.737 Y90.459 E2.15233 ; support material
G1 X107.958 Y90.000 E2.16502 ; support material
G1 X107.737 Y89.541 E2.17772 ; support material
G1 E0.17772 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X107.737 Y92.541 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X107.240 Y92.427 E2.01269 ; support material
G1 X106.842 Y92.745 E2.02539 ; support material
G1 X106.842 Y93.255 E2.03808 ; support material
G1 X107.240 Y93.573 E2.05078 ; support material
G1 X107.737 Y93.459 E2.06347 ; support material
G1 X107.958 Y93.000 E2.07616 ; support material
G1 X107.737 Y92.541 E2.08886 ; support material
G1 X104.737 Y92.541 F7800.000 ; move to first support material point
G1 F3600.000
G1 X104.240 Y92.427 E2.10155 ; support material
G1 X103.842 Y92.745 E2.11425 ; support material
G1 X103.842 Y93.255 E2.12694 ; support material
G1 X104.240 Y93.573 E2.13963 ; support material
G1 X104.737 Y93.459 E2.15233 ; support material
G1 X104.958 Y93.000 E2.16502 ; support material
G1 X104.737 Y92.541 E2.17772 ; support material
G1 E0.17772 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X104.737 Y89.541 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X104.240 Y89.427 E2.01269 ; support material
G1 X103.842 Y89.745 E2.02539 ; support material
G1 X103.842 Y90.255 E2.03808 ; support material
G1 X104.240 Y90.573 E2.05078 ; support material
G1 X104.737 Y90.459 E2.06347 ; support material
G1 X104.958 Y90.000 E2.07616 ; support material
G1 X104.737 Y89.541 E2.08886 ; support material
G1 X101.737 Y89.541 F7800.000 ; move to first support material point
G1 F3600.000
G1 X101.240 Y89.427 E2.10155 ; support material
G1 X100.842 Y89.745 E2.11425 ; support material
G1 X100.842 Y90.255 E2.12694 ; support material
G1 X101.240 Y90.573 E2.13963 ; support material
G1 X101.737 Y90.459 E2.15233 ; support material
G1 X101.958 Y90.000 E2.16502 ; support material
G1 X101.737 Y89.541 E2.17772 ; support material
G1 E0.17772 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X101.737 Y92.541 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X101.240 Y92.427 E2.01269 ; support material
G1 X100.842 Y92.745 E2.02539 ; support material
G1 X100.842 Y93.255 E2.03808 ; support material
G1 X101.240 Y93.573 E2.05078 ; support material
G1 X101.737 Y93.459 E2.06347 ; support material
G1 X101.958 Y93.000 E2.07616 ; support material
G1 X101.737 Y92.541 E2.08886 ; support material
G1 X98.737 Y92.541 F7800.000 ; move to first support material point
G1 F3600.000
G1 X98.240 Y92.427 E2.10155 ; support material
G1 X97.842 Y92.745 E2.11425 ; support material
G1 X97.842 Y93.255 E2.12694 ; support material
G1 X98.240 Y93.573 E2.13963 ; support material
G1 X98.737 Y93.459 E2.15233 ; support material
G1 X98.958 Y93.000 E2.16502 ; support material
G1 X98.737 Y92.541 E2.17772 ; support material
G1 E0.17772 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X98.737 Y89.541 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X98.240 Y89.427 E2.01269 ; support material
G1 X97.842 Y89.745 E2.02539 ; support material
G1 X97.842 Y90.255 E2.03808 ; support material
G1 X98.240 Y90.573 E2.05078 ; support material
G1 X98.737 Y90.459 E2.06347 ; support material
G1 X98.958 Y90.000 E2.07616 ; support material
G1 X98.737 Y89.541 E2.08886 ; support material
G1 X95.737 Y89.541 F7800.000 ; move to first support material point
G1 F3600.000
G1 X95.240 Y89.427 E2.10155 ; support material
G1 X94.842 Y89.745 E2.11425 ; support material
G1 X94.842 Y90.255 E2.12694 ; support material
G1 X95.240 Y90.573 E2.13963 ; support material
G1 X95.737 Y90.459 E2.15233 ; support material
G1 X95.958 Y90.000 E2.16502 ; support material
G1 X95.737 Y89.541 E2.17772 ; support material
G1 E0.17772 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X92.739 Y89.577 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X92.242 Y89.464 E2.01269 ; support material
G1 X91.844 Y89.782 E2.02539 ; support material
G1 X91.844 Y90.291 E2.03808 ; support material
G1 X92.242 Y90.609 E2.05078 ; support material
G1 X92.739 Y90.496 E2.06347 ; support material
G1 X92.960 Y90.037 E2.07616 ; support material
G1 X92.739 Y89.577 E2.08886 ; support material
G1 E0.08886 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.366 Y90.170 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X89.869 Y90.057 E2.01269 ; support material
G1 X89.471 Y90.375 E2.02539 ; support material
G1 X89.471 Y90.884 E2.03808 ; support material
G1 X89.869 Y91.202 E2.05078 ; support material
G1 X90.366 Y91.088 E2.06347 ; support material
G1 X90.587 Y90.629 E2.07616 ; support material
G1 X90.366 Y90.170 E2.08886 ; support material
G1 X90.366 Y91.912 F7800.000 ; move to first support material point
G1 F3600.000
G1 X89.869 Y91.798 E2.10155 ; support material
G1 X89.471 Y92.116 E2.11425 ; support material
G1 X89.471 Y92.625 E2.12694 ; support material
G1 X89.869 Y92.943 E2.13963 ; support material
G1 X90.366 Y92.830 E2.15233 ; support material
G1 X90.587 Y92.371 E2.16502 ; support material
G1 X90.366 Y91.912 E2.17772 ; support material
G1 E0.17772 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X92.739 Y92.504 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X92.242 Y92.391 E2.01269 ; support material
G1 X91.844 Y92.709 E2.02539 ; support material
G1 X91.844 Y93.218 E2.03808 ; support material
G1 X92.242 Y93.536 E2.05078 ; support material
G1 X92.739 Y93.423 E2.06347 ; support material
G1 X92.960 Y92.963 E2.07616 ; support material
G1 X92.739 Y92.504 E2.08886 ; support material
G1 E0.08886 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.737 Y92.541 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X95.240 Y92.427 E2.01269 ; support material
G1 X94.842 Y92.745 E2.02539 ; support material
G1 X94.842 Y93.255 E2.03808 ; support material
G1 X95.240 Y93.573 E2.05078 ; support material
G1 X95.737 Y93.459 E2.06347 ; support material
G1 X95.958 Y93.000 E2.07616 ; support material
G1 X95.737 Y92.541 E2.08886 ; support material
G1 E0.08886 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.737 Y95.541 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X95.240 Y95.427 E2.01269 ; support material
G1 X94.842 Y95.745 E2.02539 ; support material
G1 X94.842 Y96.255 E2.03808 ; support material
G1 X95.240 Y96.573 E2.05078 ; support material
G1 X95.737 Y96.459 E2.06347 ; support material
G1 X95.958 Y96.000 E2.07616 ; support material
G1 X95.737 Y95.541 E2.08886 ; support material
G1 E0.08886 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X92.739 Y95.504 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X92.242 Y95.391 E2.01269 ; support material
G1 X91.844 Y95.709 E2.02539 ; support material
G1 X91.844 Y96.218 E2.03808 ; support material
G1 X92.242 Y96.536 E2.05078 ; support material
G1 X92.739 Y96.423 E2.06347 ; support material
G1 X92.960 Y95.963 E2.07616 ; support material
G1 X92.739 Y95.504 E2.08886 ; support material
G1 E0.08886 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.679 Y95.263 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X90.182 Y95.149 E2.01269 ; support material
G1 X89.783 Y95.467 E2.02539 ; support material
G1 X89.783 Y95.977 E2.03808 ; support material
G1 X90.182 Y96.295 E2.05078 ; support material
G1 X90.679 Y96.181 E2.06347 ; support material
G1 X90.900 Y95.722 E2.07616 ; support material
G1 X90.679 Y95.263 E2.08886 ; support material
G1 E0.08886 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.679 Y98.263 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X90.182 Y98.149 E2.01269 ; support material
G1 X89.783 Y98.467 E2.02539 ; support material
G1 X89.783 Y98.977 E2.03808 ; support material
G1 X90.182 Y99.295 E2.05078 ; support material
G1 X90.679 Y99.181 E2.06347 ; support material
G1 X90.900 Y98.722 E2.07616 ; support material
G1 X90.679 Y98.263 E2.08886 ; support material
G1 E0.08886 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X92.739 Y98.504 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X92.242 Y98.391 E2.01269 ; support material
G1 X91.844 Y98.709 E2.02539 ; support material
G1 X91.844 Y99.218 E2.03808 ; support material
G1 X92.242 Y99.536 E2.05078 ; support material
G1 X92.739 Y99.423 E2.06347 ; support material
G1 X92.960 Y98.963 E2.07616 ; support material
G1 X92.739 Y98.504 E2.08886 ; support material
G1 E0.08886 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.737 Y98.541 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X95.240 Y98.427 E2.01269 ; support material
G1 X94.842 Y98.745 E2.02539 ; support material
G1 X94.842 Y99.255 E2.03808 ; support material
G1 X95.240 Y99.573 E2.05078 ; support material
G1 X95.737 Y99.459 E2.06347 ; support material
G1 X95.958 Y99.000 E2.07616 ; support material
G1 X95.737 Y98.541 E2.08886 ; support material
G1 E0.08886 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.737 Y101.541 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X95.240 Y101.427 E2.01269 ; support material
G1 X94.842 Y101.745 E2.02539 ; support material
G1 X94.842 Y102.255 E2.03808 ; support material
G1 X95.240 Y102.573 E2.05078 ; support material
G1 X95.737 Y102.459 E2.06347 ; support material
G1 X95.958 Y102.000 E2.07616 ; support material
G1 X95.737 Y101.541 E2.08886 ; support material
G1 E0.08886 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X92.739 Y101.504 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X92.242 Y101.391 E2.01269 ; support material
G1 X91.844 Y101.709 E2.02539 ; support material
G1 X91.844 Y102.218 E2.03808 ; support material
G1 X92.242 Y102.536 E2.05078 ; support material
G1 X92.739 Y102.423 E2.06347 ; support material
G1 X92.960 Y101.963 E2.07616 ; support material
G1 X92.739 Y101.504 E2.08886 ; support material
G1 E0.08886 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.679 Y101.263 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X90.182 Y101.149 E2.01269 ; support material
G1 X89.783 Y101.467 E2.02539 ; support material
G1 X89.783 Y101.977 E2.03808 ; support material
G1 X90.182 Y102.295 E2.05078 ; support material
G1 X90.679 Y102.181 E2.06347 ; support material
G1 X90.900 Y101.722 E2.07616 ; support material
G1 X90.679 Y101.263 E2.08886 ; support material
G1 E0.08886 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.679 Y104.263 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X90.182 Y104.149 E2.01269 ; support material
G1 X89.783 Y104.467 E2.02539 ; support material
G1 X89.783 Y104.977 E2.03808 ; support material
G1 X90.182 Y105.295 E2.05078 ; support material
G1 X90.679 Y105.181 E2.06347 ; support material
G1 X90.900 Y104.722 E2.07616 ; support material
G1 X90.679 Y104.263 E2.08886 ; support material
G1 E0.08886 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X92.739 Y104.504 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X92.242 Y104.391 E2.01269 ; support material
G1 X91.844 Y104.709 E2.02539 ; support material
G1 X91.844 Y105.218 E2.03808 ; support material
G1 X92.242 Y105.536 E2.05078 ; support material
G1 X92.739 Y105.423 E2.06347 ; support material
G1 X92.960 Y104.963 E2.07616 ; support material
G1 X92.739 Y104.504 E2.08886 ; support material
G1 E0.08886 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.737 Y104.541 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X95.240 Y104.427 E2.01269 ; support material
G1 X94.842 Y104.745 E2.02539 ; support material
G1 X94.842 Y105.255 E2.03808 ; support material
G1 X95.240 Y105.573 E2.05078 ; support material
G1 X95.737 Y105.459 E2.06347 ; support material
G1 X95.958 Y105.000 E2.07616 ; support material
G1 X95.737 Y104.541 E2.08886 ; support material
G1 X98.737 Y104.541 F7800.000 ; move to first support material point
G1 F3600.000
G1 X98.240 Y104.427 E2.10155 ; support material
G1 X97.842 Y104.745 E2.11425 ; support material
G1 X97.842 Y105.255 E2.12694 ; support material
G1 X98.240 Y105.573 E2.13963 ; support material
G1 X98.737 Y105.459 E2.15233 ; support material
G1 X98.958 Y105.000 E2.16502 ; support material
G1 X98.737 Y104.541 E2.17772 ; support material
G1 E0.17772 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X98.737 Y107.541 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X98.240 Y107.427 E2.01269 ; support material
G1 X97.842 Y107.745 E2.02539 ; support material
G1 X97.842 Y108.255 E2.03808 ; support material
G1 X98.240 Y108.573 E2.05078 ; support material
G1 X98.737 Y108.459 E2.06347 ; support material
G1 X98.958 Y108.000 E2.07616 ; support material
G1 X98.737 Y107.541 E2.08886 ; support material
G1 X101.737 Y107.541 F7800.000 ; move to first support material point
G1 F3600.000
G1 X101.240 Y107.427 E2.10155 ; support material
G1 X100.842 Y107.745 E2.11425 ; support material
G1 X100.842 Y108.255 E2.12694 ; support material
G1 X101.240 Y108.573 E2.13963 ; support material
G1 X101.737 Y108.459 E2.15233 ; support material
G1 X101.958 Y108.000 E2.16502 ; support material
G1 X101.737 Y107.541 E2.17772 ; support material
G1 X104.737 Y107.541 F7800.000 ; move to first support material point
G1 F3600.000
G1 X104.240 Y107.427 E2.19041 ; support material
G1 X103.842 Y107.745 E2.20310 ; support material
G1 X103.842 Y108.255 E2.21580 ; support material
G1 X104.240 Y108.573 E2.22849 ; support material
G1 X104.737 Y108.459 E2.24119 ; support material
G1 X104.958 Y108.000 E2.25388 ; support material
G1 X104.737 Y107.541 E2.26658 ; support material
G1 X107.737 Y107.541 F7800.000 ; move to first support material point
G1 F3600.000
G1 X107.240 Y107.427 E2.27927 ; support material
G1 X106.842 Y107.745 E2.29196 ; support material
G1 X106.842 Y108.255 E2.30466 ; support material
G1 X107.240 Y108.573 E2.31735 ; support material
G1 X107.737 Y108.459 E2.33005 ; support material
G1 X107.958 Y108.000 E2.34274 ; support material
G1 X107.737 Y107.541 E2.35543 ; support material
G1 X110.737 Y107.541 F7800.000 ; move to first support material point
G1 F3600.000
G1 X110.240 Y107.427 E2.36813 ; support material
G1 X109.842 Y107.745 E2.38082 ; support material
G1 X109.842 Y108.255 E2.39352 ; support material
G1 X110.240 Y108.573 E2.40621 ; support material
G1 X110.737 Y108.459 E2.41890 ; support material
G1 X110.958 Y108.000 E2.43160 ; support material
G1 X110.737 Y107.541 E2.44429 ; support material
G1 E0.44429 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X110.737 Y110.541 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X110.240 Y110.427 E2.01269 ; support material
G1 X109.842 Y110.745 E2.02539 ; support material
G1 X109.842 Y111.255 E2.03808 ; support material
G1 X110.240 Y111.573 E2.05078 ; support material
G1 X110.737 Y111.459 E2.06347 ; support material
G1 X110.958 Y111.000 E2.07616 ; support material
G1 X110.737 Y110.541 E2.08886 ; support material
G1 E0.08886 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X107.737 Y110.541 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X107.240 Y110.427 E2.01269 ; support material
G1 X106.842 Y110.745 E2.02539 ; support material
G1 X106.842 Y111.255 E2.03808 ; support material
G1 X107.240 Y111.573 E2.05078 ; support material
G1 X107.737 Y111.459 E2.06347 ; support material
G1 X107.958 Y111.000 E2.07616 ; support material
G1 X107.737 Y110.541 E2.08886 ; support material
G1 E0.08886 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X104.737 Y110.541 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X104.240 Y110.427 E2.01269 ; support material
G1 X103.842 Y110.745 E2.02539 ; support material
G1 X103.842 Y111.255 E2.03808 ; support material
G1 X104.240 Y111.573 E2.05078 ; support material
G1 X104.737 Y111.459 E2.06347 ; support material
G1 X104.958 Y111.000 E2.07616 ; support material
G1 X104.737 Y110.541 E2.08886 ; support material
G1 E0.08886 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X101.737 Y110.541 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X101.240 Y110.427 E2.01269 ; support material
G1 X100.842 Y110.745 E2.02539 ; support material
G1 X100.842 Y111.255 E2.03808 ; support material
G1 X101.240 Y111.573 E2.05078 ; support material
G1 X101.737 Y111.459 E2.06347 ; support material
G1 X101.958 Y111.000 E2.07616 ; support material
G1 X101.737 Y110.541 E2.08886 ; support material
G1 E0.08886 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X98.737 Y110.541 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X98.240 Y110.427 E2.01269 ; support material
G1 X97.842 Y110.745 E2.02539 ; support material
G1 X97.842 Y111.255 E2.03808 ; support material
G1 X98.240 Y111.573 E2.05078 ; support material
G1 X98.737 Y111.459 E2.06347 ; support material
G1 X98.958 Y111.000 E2.07616 ; support material
G1 X98.737 Y110.541 E2.08886 ; support material
G1 E0.08886 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.737 Y110.541 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X95.240 Y110.427 E2.01269 ; support material
G1 X94.842 Y110.745 E2.02539 ; support material
G1 X94.842 Y111.255 E2.03808 ; support material
G1 X95.240 Y111.573 E2.05078 ; support material
G1 X95.737 Y111.459 E2.06347 ; support material
G1 X95.958 Y111.000 E2.07616 ; support material
G1 X95.737 Y110.541 E2.08886 ; support material
G1 E0.08886 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X92.739 Y110.504 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X92.242 Y110.391 E2.01269 ; support material
G1 X91.844 Y110.709 E2.02539 ; support material
G1 X91.844 Y111.218 E2.03808 ; support material
G1 X92.242 Y111.536 E2.05078 ; support material
G1 X92.739 Y111.423 E2.06347 ; support material
G1 X92.960 Y110.963 E2.07616 ; support material
G1 X92.739 Y110.504 E2.08886 ; support material
G1 E0.08886 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.679 Y110.263 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X90.182 Y110.149 E2.01269 ; support material
G1 X89.783 Y110.467 E2.02539 ; support material
G1 X89.783 Y110.977 E2.03808 ; support material
G1 X90.182 Y111.295 E2.05078 ; support material
G1 X90.679 Y111.181 E2.06347 ; support material
G1 X90.900 Y110.722 E2.07616 ; support material
G1 X90.679 Y110.263 E2.08886 ; support material
G1 E0.08886 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.679 Y107.263 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X90.182 Y107.149 E2.01269 ; support material
G1 X89.783 Y107.467 E2.02539 ; support material
G1 X89.783 Y107.977 E2.03808 ; support material
G1 X90.182 Y108.295 E2.05078 ; support material
G1 X90.679 Y108.181 E2.06347 ; support material
G1 X90.900 Y107.722 E2.07616 ; support material
G1 X90.679 Y107.263 E2.08886 ; support material
G1 E0.08886 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X92.739 Y107.504 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X92.242 Y107.391 E2.01269 ; support material
G1 X91.844 Y107.709 E2.02539 ; support material
G1 X91.844 Y108.218 E2.03808 ; support material
G1 X92.242 Y108.536 E2.05078 ; support material
G1 X92.739 Y108.423 E2.06347 ; support material
G1 X92.960 Y107.963 E2.07616 ; support material
G1 X92.739 Y107.504 E2.08886 ; support material
G1 E0.08886 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X95.737 Y107.541 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X95.240 Y107.427 E2.01269 ; support material
G1 X94.842 Y107.745 E2.02539 ; support material
G1 X94.842 Y108.255 E2.03808 ; support material
G1 X95.240 Y108.573 E2.05078 ; support material
G1 X95.737 Y108.459 E2.06347 ; support material
G1 X95.958 Y108.000 E2.07616 ; support material
G1 X95.737 Y107.541 E2.08886 ; support material
G1 E0.08886 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X98.737 Y95.541 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X98.240 Y95.427 E2.01269 ; support material
G1 X97.842 Y95.745 E2.02539 ; support material
G1 X97.842 Y96.255 E2.03808 ; support material
G1 X98.240 Y96.573 E2.05078 ; support material
G1 X98.737 Y96.459 E2.06347 ; support material
G1 X98.958 Y96.000 E2.07616 ; support material
G1 X98.737 Y95.541 E2.08886 ; support material
G1 X101.737 Y95.541 F7800.000 ; move to first support material point
G1 F3600.000
G1 X101.240 Y95.427 E2.10155 ; support material
G1 X100.842 Y95.745 E2.11425 ; support material
G1 X100.842 Y96.255 E2.12694 ; support material
G1 X101.240 Y96.573 E2.13963 ; support material
G1 X101.737 Y96.459 E2.15233 ; support material
G1 X101.958 Y96.000 E2.16502 ; support material
G1 X101.737 Y95.541 E2.17772 ; support material
G1 Z7.850 F7800.000 ; move to next layer (46)
G1 E0.17772 F2400.00000 ; retract extruder 0
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
G1 X102.030 Y104.567 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X101.562 Y104.460 E2.01196 ; support material
G1 X101.187 Y104.760 E2.02393 ; support material
G1 X101.187 Y105.240 E2.03589 ; support material
G1 X101.562 Y105.540 E2.04786 ; support material
G1 X102.030 Y105.433 E2.05982 ; support material
G1 X102.239 Y105.000 E2.07179 ; support material
G1 X102.030 Y104.567 E2.08375 ; support material
G1 X105.030 Y104.567 F7800.000 ; move to first support material point
G1 F3600.000
G1 X104.562 Y104.460 E2.09572 ; support material
G1 X104.187 Y104.760 E2.10768 ; support material
G1 X104.187 Y105.240 E2.11965 ; support material
G1 X104.562 Y105.540 E2.13161 ; support material
G1 X105.030 Y105.433 E2.14357 ; support material
G1 X105.239 Y105.000 E2.15554 ; support material
G1 X105.030 Y104.567 E2.16750 ; support material
G1 X108.030 Y104.567 F7800.000 ; move to first support material point
G1 F3600.000
G1 X107.562 Y104.460 E2.17947 ; support material
G1 X107.187 Y104.760 E2.19143 ; support material
G1 X107.187 Y105.240 E2.20340 ; support material
G1 X107.562 Y105.540 E2.21536 ; support material
G1 X108.030 Y105.433 E2.22733 ; support material
G1 X108.239 Y105.000 E2.23929 ; support material
G1 X108.030 Y104.567 E2.25126 ; support material
G1 E0.25126 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X108.030 Y101.567 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X107.562 Y101.460 E2.01196 ; support material
G1 X107.187 Y101.760 E2.02393 ; support material
G1 X107.187 Y102.240 E2.03589 ; support material
G1 X107.562 Y102.540 E2.04786 ; support material
G1 X108.030 Y102.433 E2.05982 ; support material
G1 X108.239 Y102.000 E2.07179 ; support material
G1 X108.030 Y101.567 E2.08375 ; support material
G1 E0.08375 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X105.345 Y101.253 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X104.877 Y101.146 E2.01196 ; support material
G1 X104.501 Y101.445 E2.02393 ; support material
G1 X104.501 Y101.926 E2.03589 ; support material
G1 X104.877 Y102.225 E2.04786 ; support material
G1 X105.345 Y102.118 E2.05982 ; support material
G1 X105.554 Y101.685 E2.07179 ; support material
G1 X105.345 Y101.253 E2.08375 ; support material
G1 E0.08375 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X105.345 Y98.253 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X104.877 Y98.146 E2.01196 ; support material
G1 X104.501 Y98.445 E2.02393 ; support material
G1 X104.501 Y98.926 E2.03589 ; support material
G1 X104.877 Y99.225 E2.04786 ; support material
G1 X105.345 Y99.118 E2.05982 ; support material
G1 X105.554 Y98.685 E2.07179 ; support material
G1 X105.345 Y98.253 E2.08375 ; support material
G1 E0.08375 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X105.030 Y95.567 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X104.562 Y95.460 E2.01196 ; support material
G1 X104.187 Y95.760 E2.02393 ; support material
G1 X104.187 Y96.240 E2.03589 ; support material
G1 X104.562 Y96.540 E2.04786 ; support material
G1 X105.030 Y96.433 E2.05982 ; support material
G1 X105.239 Y96.000 E2.07179 ; support material
G1 X105.030 Y95.567 E2.08375 ; support material
G1 E0.08375 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X105.030 Y92.567 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X104.562 Y92.460 E2.01196 ; support material
G1 X104.187 Y92.760 E2.02393 ; support material
G1 X104.187 Y93.240 E2.03589 ; support material
G1 X104.562 Y93.540 E2.04786 ; support material
G1 X105.030 Y93.433 E2.05982 ; support material
G1 X105.239 Y93.000 E2.07179 ; support material
G1 X105.030 Y92.567 E2.08375 ; support material
G1 E0.08375 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X105.030 Y89.567 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X104.562 Y89.460 E2.01196 ; support material
G1 X104.187 Y89.760 E2.02393 ; support material
G1 X104.187 Y90.240 E2.03589 ; support material
G1 X104.562 Y90.540 E2.04786 ; support material
G1 X105.030 Y90.433 E2.05982 ; support material
G1 X105.239 Y90.000 E2.07179 ; support material
G1 X105.030 Y89.567 E2.08375 ; support material
G1 X108.030 Y89.567 F7800.000 ; move to first support material point
G1 F3600.000
G1 X107.562 Y89.460 E2.09572 ; support material
G1 X107.187 Y89.760 E2.10768 ; support material
G1 X107.187 Y90.240 E2.11965 ; support material
G1 X107.562 Y90.540 E2.13161 ; support material
G1 X108.030 Y90.433 E2.14357 ; support material
G1 X108.239 Y90.000 E2.15554 ; support material
G1 X108.030 Y89.567 E2.16750 ; support material
G1 E0.16750 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X108.030 Y92.567 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X107.562 Y92.460 E2.01196 ; support material
G1 X107.187 Y92.760 E2.02393 ; support material
G1 X107.187 Y93.240 E2.03589 ; support material
G1 X107.562 Y93.540 E2.04786 ; support material
G1 X108.030 Y93.433 E2.05982 ; support material
G1 X108.239 Y93.000 E2.07179 ; support material
G1 X108.030 Y92.567 E2.08375 ; support material
G1 X111.030 Y92.567 F7800.000 ; move to first support material point
G1 F3600.000
G1 X110.562 Y92.460 E2.09572 ; support material
G1 X110.187 Y92.760 E2.10768 ; support material
G1 X110.187 Y93.240 E2.11965 ; support material
G1 X110.562 Y93.540 E2.13161 ; support material
G1 X111.030 Y93.433 E2.14357 ; support material
G1 X111.239 Y93.000 E2.15554 ; support material
G1 X111.030 Y92.567 E2.16750 ; support material
G1 E0.16750 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X111.030 Y89.567 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X110.562 Y89.460 E2.01196 ; support material
G1 X110.187 Y89.760 E2.02393 ; support material
G1 X110.187 Y90.240 E2.03589 ; support material
G1 X110.562 Y90.540 E2.04786 ; support material
G1 X111.030 Y90.433 E2.05982 ; support material
G1 X111.239 Y90.000 E2.07179 ; support material
G1 X111.030 Y89.567 E2.08375 ; support material
G1 E0.08375 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X111.030 Y95.567 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X110.562 Y95.460 E2.01196 ; support material
G1 X110.187 Y95.760 E2.02393 ; support material
G1 X110.187 Y96.240 E2.03589 ; support material
G1 X110.562 Y96.540 E2.04786 ; support material
G1 X111.030 Y96.433 E2.05982 ; support material
G1 X111.239 Y96.000 E2.07179 ; support material
G1 X111.030 Y95.567 E2.08375 ; support material
G1 X108.030 Y95.567 F7800.000 ; move to first support material point
G1 F3600.000
G1 X107.562 Y95.460 E2.09572 ; support material
G1 X107.187 Y95.760 E2.10768 ; support material
G1 X107.187 Y96.240 E2.11965 ; support material
G1 X107.562 Y96.540 E2.13161 ; support material
G1 X108.030 Y96.433 E2.14357 ; support material
G1 X108.239 Y96.000 E2.15554 ; support material
G1 X108.030 Y95.567 E2.16750 ; support material
G1 E0.16750 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X108.030 Y98.567 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X107.562 Y98.460 E2.01196 ; support material
G1 X107.187 Y98.760 E2.02393 ; support material
G1 X107.187 Y99.240 E2.03589 ; support material
G1 X107.562 Y99.540 E2.04786 ; support material
G1 X108.030 Y99.433 E2.05982 ; support material
G1 X108.239 Y99.000 E2.07179 ; support material
G1 X108.030 Y98.567 E2.08375 ; support material
G1 X111.030 Y98.567 F7800.000 ; move to first support material point
G1 F3600.000
G1 X110.562 Y98.460 E2.09572 ; support material
G1 X110.187 Y98.760 E2.10768 ; support material
G1 X110.187 Y99.240 E2.11965 ; support material
G1 X110.562 Y99.540 E2.13161 ; support material
G1 X111.030 Y99.433 E2.14357 ; support material
G1 X111.239 Y99.000 E2.15554 ; support material
G1 X111.030 Y98.567 E2.16750 ; support material
G1 E0.16750 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X111.030 Y101.567 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X110.562 Y101.460 E2.01196 ; support material
G1 X110.187 Y101.760 E2.02393 ; support material
G1 X110.187 Y102.240 E2.03589 ; support material
G1 X110.562 Y102.540 E2.04786 ; support material
G1 X111.030 Y102.433 E2.05982 ; support material
G1 X111.239 Y102.000 E2.07179 ; support material
G1 X111.030 Y101.567 E2.08375 ; support material
G1 E0.08375 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X111.030 Y104.567 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X110.562 Y104.460 E2.01196 ; support material
G1 X110.187 Y104.760 E2.02393 ; support material
G1 X110.187 Y105.240 E2.03589 ; support material
G1 X110.562 Y105.540 E2.04786 ; support material
G1 X111.030 Y105.433 E2.05982 ; support material
G1 X111.239 Y105.000 E2.07179 ; support material
G1 X111.030 Y104.567 E2.08375 ; support material
G1 E0.08375 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X111.030 Y107.567 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X110.562 Y107.460 E2.01196 ; support material
G1 X110.187 Y107.760 E2.02393 ; support material
G1 X110.187 Y108.240 E2.03589 ; support material
G1 X110.562 Y108.540 E2.04786 ; support material
G1 X111.030 Y108.433 E2.05982 ; support material
G1 X111.239 Y108.000 E2.07179 ; support material
G1 X111.030 Y107.567 E2.08375 ; support material
G1 X108.030 Y107.567 F7800.000 ; move to first support material point
G1 F3600.000
G1 X107.562 Y107.460 E2.09572 ; support material
G1 X107.187 Y107.760 E2.10768 ; support material
G1 X107.187 Y108.240 E2.11965 ; support material
G1 X107.562 Y108.540 E2.13161 ; support material
G1 X108.030 Y108.433 E2.14357 ; support material
G1 X108.239 Y108.000 E2.15554 ; support material
G1 X108.030 Y107.567 E2.16750 ; support material
G1 X105.030 Y107.567 F7800.000 ; move to first support material point
G1 F3600.000
G1 X104.562 Y107.460 E2.17947 ; support material
G1 X104.187 Y107.760 E2.19143 ; support material
G1 X104.187 Y108.240 E2.20340 ; support material
G1 X104.562 Y108.540 E2.21536 ; support material
G1 X105.030 Y108.433 E2.22733 ; support material
G1 X105.239 Y108.000 E2.23929 ; support material
G1 X105.030 Y107.567 E2.25126 ; support material
G1 X102.030 Y107.567 F7800.000 ; move to first support material point
G1 F3600.000
G1 X101.562 Y107.460 E2.26322 ; support material
G1 X101.187 Y107.760 E2.27518 ; support material
G1 X101.187 Y108.240 E2.28715 ; support material
G1 X101.562 Y108.540 E2.29911 ; support material
G1 X102.030 Y108.433 E2.31108 ; support material
G1 X102.239 Y108.000 E2.32304 ; support material
G1 X102.030 Y107.567 E2.33501 ; support material
G1 X99.030 Y107.567 F7800.000 ; move to first support material point
G1 F3600.000
G1 X98.562 Y107.460 E2.34697 ; support material
G1 X98.187 Y107.760 E2.35894 ; support material
G1 X98.187 Y108.240 E2.37090 ; support material
G1 X98.562 Y108.540 E2.38287 ; support material
G1 X99.030 Y108.433 E2.39483 ; support material
G1 X99.239 Y108.000 E2.40679 ; support material
G1 X99.030 Y107.567 E2.41876 ; support material
G1 E0.41876 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X99.030 Y104.567 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X98.562 Y104.460 E2.01196 ; support material
G1 X98.187 Y104.760 E2.02393 ; support material
G1 X98.187 Y105.240 E2.03589 ; support material
G1 X98.562 Y105.540 E2.04786 ; support material
G1 X99.030 Y105.433 E2.05982 ; support material
G1 X99.239 Y105.000 E2.07179 ; support material
G1 X99.030 Y104.567 E2.08375 ; support material
G1 X96.030 Y104.567 F7800.000 ; move to first support material point
G1 F3600.000
G1 X95.562 Y104.460 E2.09572 ; support material
G1 X95.187 Y104.760 E2.10768 ; support material
G1 X95.187 Y105.240 E2.11965 ; support material
G1 X95.562 Y105.540 E2.13161 ; support material
G1 X96.030 Y105.433 E2.14357 ; support material
G1 X96.239 Y105.000 E2.15554 ; support material
G1 X96.030 Y104.567 E2.16750 ; support material
G1 E0.16750 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X96.030 Y101.567 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X95.562 Y101.460 E2.01196 ; support material
G1 X95.187 Y101.760 E2.02393 ; support material
G1 X95.187 Y102.240 E2.03589 ; support material
G1 X95.562 Y102.540 E2.04786 ; support material
G1 X96.030 Y102.433 E2.05982 ; support material
G1 X96.239 Y102.000 E2.07179 ; support material
G1 X96.030 Y101.567 E2.08375 ; support material
G1 E0.08375 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X96.030 Y98.567 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X95.562 Y98.460 E2.01196 ; support material
G1 X95.187 Y98.760 E2.02393 ; support material
G1 X95.187 Y99.240 E2.03589 ; support material
G1 X95.562 Y99.540 E2.04786 ; support material
G1 X96.030 Y99.433 E2.05982 ; support material
G1 X96.239 Y99.000 E2.07179 ; support material
G1 X96.030 Y98.567 E2.08375 ; support material
G1 E0.08375 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X96.030 Y95.567 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X95.562 Y95.460 E2.01196 ; support material
G1 X95.187 Y95.760 E2.02393 ; support material
G1 X95.187 Y96.240 E2.03589 ; support material
G1 X95.562 Y96.540 E2.04786 ; support material
G1 X96.030 Y96.433 E2.05982 ; support material
G1 X96.239 Y96.000 E2.07179 ; support material
G1 X96.030 Y95.567 E2.08375 ; support material
G1 E0.08375 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X96.030 Y92.567 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X95.562 Y92.460 E2.01196 ; support material
G1 X95.187 Y92.760 E2.02393 ; support material
G1 X95.187 Y93.240 E2.03589 ; support material
G1 X95.562 Y93.540 E2.04786 ; support material
G1 X96.030 Y93.433 E2.05982 ; support material
G1 X96.239 Y93.000 E2.07179 ; support material
G1 X96.030 Y92.567 E2.08375 ; support material
G1 E0.08375 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X96.030 Y89.567 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X95.562 Y89.460 E2.01196 ; support material
G1 X95.187 Y89.760 E2.02393 ; support material
G1 X95.187 Y90.240 E2.03589 ; support material
G1 X95.562 Y90.540 E2.04786 ; support material
G1 X96.030 Y90.433 E2.05982 ; support material
G1 X96.239 Y90.000 E2.07179 ; support material
G1 X96.030 Y89.567 E2.08375 ; support material
G1 X99.030 Y89.567 F7800.000 ; move to first support material point
G1 F3600.000
G1 X98.562 Y89.460 E2.09572 ; support material
G1 X98.187 Y89.760 E2.10768 ; support material
G1 X98.187 Y90.240 E2.11965 ; support material
G1 X98.562 Y90.540 E2.13161 ; support material
G1 X99.030 Y90.433 E2.14357 ; support material
G1 X99.239 Y90.000 E2.15554 ; support material
G1 X99.030 Y89.567 E2.16750 ; support material
G1 E0.16750 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X99.030 Y92.567 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X98.562 Y92.460 E2.01196 ; support material
G1 X98.187 Y92.760 E2.02393 ; support material
G1 X98.187 Y93.240 E2.03589 ; support material
G1 X98.562 Y93.540 E2.04786 ; support material
G1 X99.030 Y93.433 E2.05982 ; support material
G1 X99.239 Y93.000 E2.07179 ; support material
G1 X99.030 Y92.567 E2.08375 ; support material
G1 X102.030 Y92.567 F7800.000 ; move to first support material point
G1 F3600.000
G1 X101.562 Y92.460 E2.09572 ; support material
G1 X101.187 Y92.760 E2.10768 ; support material
G1 X101.187 Y93.240 E2.11965 ; support material
G1 X101.562 Y93.540 E2.13161 ; support material
G1 X102.030 Y93.433 E2.14357 ; support material
G1 X102.239 Y93.000 E2.15554 ; support material
G1 X102.030 Y92.567 E2.16750 ; support material
G1 E0.16750 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X102.030 Y89.567 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X101.562 Y89.460 E2.01196 ; support material
G1 X101.187 Y89.760 E2.02393 ; support material
G1 X101.187 Y90.240 E2.03589 ; support material
G1 X101.562 Y90.540 E2.04786 ; support material
G1 X102.030 Y90.433 E2.05982 ; support material
G1 X102.239 Y90.000 E2.07179 ; support material
G1 X102.030 Y89.567 E2.08375 ; support material
G1 E0.08375 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X102.030 Y95.567 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X101.562 Y95.460 E2.01196 ; support material
G1 X101.187 Y95.760 E2.02393 ; support material
G1 X101.187 Y96.240 E2.03589 ; support material
G1 X101.562 Y96.540 E2.04786 ; support material
G1 X102.030 Y96.433 E2.05982 ; support material
G1 X102.239 Y96.000 E2.07179 ; support material
G1 X102.030 Y95.567 E2.08375 ; support material
G1 X99.030 Y95.567 F7800.000 ; move to first support material point
G1 F3600.000
G1 X98.562 Y95.460 E2.09572 ; support material
G1 X98.187 Y95.760 E2.10768 ; support material
G1 X98.187 Y96.240 E2.11965 ; support material
G1 X98.562 Y96.540 E2.13161 ; support material
G1 X99.030 Y96.433 E2.14357 ; support material
G1 X99.239 Y96.000 E2.15554 ; support material
G1 X99.030 Y95.567 E2.16750 ; support material
G1 X93.030 Y95.567 F7800.000 ; move to first support material point
G1 F3600.000
G1 X92.562 Y95.460 E2.17947 ; support material
G1 X92.187 Y95.760 E2.19143 ; support material
G1 X92.187 Y96.240 E2.20340 ; support material
G1 X92.562 Y96.540 E2.21536 ; support material
G1 X93.030 Y96.433 E2.22733 ; support material
G1 X93.239 Y96.000 E2.23929 ; support material
G1 X93.030 Y95.567 E2.25126 ; support material
G1 E0.25126 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.345 Y95.253 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X89.877 Y95.146 E2.01196 ; support material
G1 X89.501 Y95.445 E2.02393 ; support material
G1 X89.501 Y95.926 E2.03589 ; support material
G1 X89.877 Y96.225 E2.04786 ; support material
G1 X90.345 Y96.118 E2.05982 ; support material
G1 X90.554 Y95.685 E2.07179 ; support material
G1 X90.345 Y95.253 E2.08375 ; support material
G1 E0.08375 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.345 Y92.253 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X89.877 Y92.146 E2.01196 ; support material
G1 X89.501 Y92.445 E2.02393 ; support material
G1 X89.501 Y92.926 E2.03589 ; support material
G1 X89.877 Y93.225 E2.04786 ; support material
G1 X90.345 Y93.118 E2.05982 ; support material
G1 X90.554 Y92.685 E2.07179 ; support material
G1 X90.345 Y92.253 E2.08375 ; support material
G1 E0.08375 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.345 Y89.882 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X89.877 Y89.775 E2.01196 ; support material
G1 X89.501 Y90.074 E2.02393 ; support material
G1 X89.501 Y90.555 E2.03589 ; support material
G1 X89.877 Y90.854 E2.04786 ; support material
G1 X90.345 Y90.747 E2.05982 ; support material
G1 X90.554 Y90.315 E2.07179 ; support material
G1 X90.345 Y89.882 E2.08375 ; support material
G1 E0.08375 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X93.030 Y89.567 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X92.562 Y89.460 E2.01196 ; support material
G1 X92.187 Y89.760 E2.02393 ; support material
G1 X92.187 Y90.240 E2.03589 ; support material
G1 X92.562 Y90.540 E2.04786 ; support material
G1 X93.030 Y90.433 E2.05982 ; support material
G1 X93.239 Y90.000 E2.07179 ; support material
G1 X93.030 Y89.567 E2.08375 ; support material
G1 E0.08375 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X93.030 Y92.567 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X92.562 Y92.460 E2.01196 ; support material
G1 X92.187 Y92.760 E2.02393 ; support material
G1 X92.187 Y93.240 E2.03589 ; support material
G1 X92.562 Y93.540 E2.04786 ; support material
G1 X93.030 Y93.433 E2.05982 ; support material
G1 X93.239 Y93.000 E2.07179 ; support material
G1 X93.030 Y92.567 E2.08375 ; support material
G1 E0.08375 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X93.030 Y98.567 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X92.562 Y98.460 E2.01196 ; support material
G1 X92.187 Y98.760 E2.02393 ; support material
G1 X92.187 Y99.240 E2.03589 ; support material
G1 X92.562 Y99.540 E2.04786 ; support material
G1 X93.030 Y99.433 E2.05982 ; support material
G1 X93.239 Y99.000 E2.07179 ; support material
G1 X93.030 Y98.567 E2.08375 ; support material
G1 E0.08375 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.345 Y98.253 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X89.877 Y98.146 E2.01196 ; support material
G1 X89.501 Y98.445 E2.02393 ; support material
G1 X89.501 Y98.926 E2.03589 ; support material
G1 X89.877 Y99.225 E2.04786 ; support material
G1 X90.345 Y99.118 E2.05982 ; support material
G1 X90.554 Y98.685 E2.07179 ; support material
G1 X90.345 Y98.253 E2.08375 ; support material
G1 E0.08375 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.345 Y101.253 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X89.877 Y101.146 E2.01196 ; support material
G1 X89.501 Y101.445 E2.02393 ; support material
G1 X89.501 Y101.926 E2.03589 ; support material
G1 X89.877 Y102.225 E2.04786 ; support material
G1 X90.345 Y102.118 E2.05982 ; support material
G1 X90.554 Y101.685 E2.07179 ; support material
G1 X90.345 Y101.253 E2.08375 ; support material
G1 E0.08375 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X93.030 Y101.567 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X92.562 Y101.460 E2.01196 ; support material
G1 X92.187 Y101.760 E2.02393 ; support material
G1 X92.187 Y102.240 E2.03589 ; support material
G1 X92.562 Y102.540 E2.04786 ; support material
G1 X93.030 Y102.433 E2.05982 ; support material
G1 X93.239 Y102.000 E2.07179 ; support material
G1 X93.030 Y101.567 E2.08375 ; support material
G1 E0.08375 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X93.030 Y104.567 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X92.562 Y104.460 E2.01196 ; support material
G1 X92.187 Y104.760 E2.02393 ; support material
G1 X92.187 Y105.240 E2.03589 ; support material
G1 X92.562 Y105.540 E2.04786 ; support material
G1 X93.030 Y105.433 E2.05982 ; support material
G1 X93.239 Y105.000 E2.07179 ; support material
G1 X93.030 Y104.567 E2.08375 ; support material
G1 E0.08375 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.345 Y104.253 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X89.877 Y104.146 E2.01196 ; support material
G1 X89.501 Y104.445 E2.02393 ; support material
G1 X89.501 Y104.926 E2.03589 ; support material
G1 X89.877 Y105.225 E2.04786 ; support material
G1 X90.345 Y105.118 E2.05982 ; support material
G1 X90.554 Y104.685 E2.07179 ; support material
G1 X90.345 Y104.253 E2.08375 ; support material
G1 E0.08375 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.345 Y107.253 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X89.877 Y107.146 E2.01196 ; support material
G1 X89.501 Y107.445 E2.02393 ; support material
G1 X89.501 Y107.926 E2.03589 ; support material
G1 X89.877 Y108.225 E2.04786 ; support material
G1 X90.345 Y108.118 E2.05982 ; support material
G1 X90.554 Y107.685 E2.07179 ; support material
G1 X90.345 Y107.253 E2.08375 ; support material
G1 E0.08375 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X93.030 Y107.567 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X92.562 Y107.460 E2.01196 ; support material
G1 X92.187 Y107.760 E2.02393 ; support material
G1 X92.187 Y108.240 E2.03589 ; support material
G1 X92.562 Y108.540 E2.04786 ; support material
G1 X93.030 Y108.433 E2.05982 ; support material
G1 X93.239 Y108.000 E2.07179 ; support material
G1 X93.030 Y107.567 E2.08375 ; support material
G1 X96.030 Y107.567 F7800.000 ; move to first support material point
G1 F3600.000
G1 X95.562 Y107.460 E2.09572 ; support material
G1 X95.187 Y107.760 E2.10768 ; support material
G1 X95.187 Y108.240 E2.11965 ; support material
G1 X95.562 Y108.540 E2.13161 ; support material
G1 X96.030 Y108.433 E2.14357 ; support material
G1 X96.239 Y108.000 E2.15554 ; support material
G1 X96.030 Y107.567 E2.16750 ; support material
G1 E0.16750 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X96.030 Y110.567 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X95.562 Y110.460 E2.01196 ; support material
G1 X95.187 Y110.760 E2.02393 ; support material
G1 X95.187 Y111.240 E2.03589 ; support material
G1 X95.562 Y111.540 E2.04786 ; support material
G1 X96.030 Y111.433 E2.05982 ; support material
G1 X96.239 Y111.000 E2.07179 ; support material
G1 X96.030 Y110.567 E2.08375 ; support material
G1 E0.08375 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X99.030 Y110.567 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X98.562 Y110.460 E2.01196 ; support material
G1 X98.187 Y110.760 E2.02393 ; support material
G1 X98.187 Y111.240 E2.03589 ; support material
G1 X98.562 Y111.540 E2.04786 ; support material
G1 X99.030 Y111.433 E2.05982 ; support material
G1 X99.239 Y111.000 E2.07179 ; support material
G1 X99.030 Y110.567 E2.08375 ; support material
G1 E0.08375 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X102.030 Y110.567 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X101.562 Y110.460 E2.01196 ; support material
G1 X101.187 Y110.760 E2.02393 ; support material
G1 X101.187 Y111.240 E2.03589 ; support material
G1 X101.562 Y111.540 E2.04786 ; support material
G1 X102.030 Y111.433 E2.05982 ; support material
G1 X102.239 Y111.000 E2.07179 ; support material
G1 X102.030 Y110.567 E2.08375 ; support material
G1 E0.08375 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X105.030 Y110.567 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X104.562 Y110.460 E2.01196 ; support material
G1 X104.187 Y110.760 E2.02393 ; support material
G1 X104.187 Y111.240 E2.03589 ; support material
G1 X104.562 Y111.540 E2.04786 ; support material
G1 X105.030 Y111.433 E2.05982 ; support material
G1 X105.239 Y111.000 E2.07179 ; support material
G1 X105.030 Y110.567 E2.08375 ; support material
G1 E0.08375 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X108.030 Y110.567 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X107.562 Y110.460 E2.01196 ; support material
G1 X107.187 Y110.760 E2.02393 ; support material
G1 X107.187 Y111.240 E2.03589 ; support material
G1 X107.562 Y111.540 E2.04786 ; support material
G1 X108.030 Y111.433 E2.05982 ; support material
G1 X108.239 Y111.000 E2.07179 ; support material
G1 X108.030 Y110.567 E2.08375 ; support material
G1 E0.08375 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X111.030 Y110.567 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X110.562 Y110.460 E2.01196 ; support material
G1 X110.187 Y110.760 E2.02393 ; support material
G1 X110.187 Y111.240 E2.03589 ; support material
G1 X110.562 Y111.540 E2.04786 ; support material
G1 X111.030 Y111.433 E2.05982 ; support material
G1 X111.239 Y111.000 E2.07179 ; support material
G1 X111.030 Y110.567 E2.08375 ; support material
G1 E0.08375 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X93.030 Y110.567 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X92.562 Y110.460 E2.01196 ; support material
G1 X92.187 Y110.760 E2.02393 ; support material
G1 X92.187 Y111.240 E2.03589 ; support material
G1 X92.562 Y111.540 E2.04786 ; support material
G1 X93.030 Y111.433 E2.05982 ; support material
G1 X93.239 Y111.000 E2.07179 ; support material
G1 X93.030 Y110.567 E2.08375 ; support material
G1 E0.08375 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.345 Y110.253 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X89.877 Y110.146 E2.01196 ; support material
G1 X89.501 Y110.445 E2.02393 ; support material
G1 X89.501 Y110.926 E2.03589 ; support material
G1 X89.877 Y111.225 E2.04786 ; support material
G1 X90.345 Y111.118 E2.05982 ; support material
G1 X90.554 Y110.685 E2.07179 ; support material
G1 X90.345 Y110.253 E2.08375 ; support material
M106 S255 ; enable fan
G1 Z8.150 F7800.000 ; move to next layer (48)
G1 E0.08375 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F867.559
G1 X99.471 Y100.529 E2.02853 ; small perimeter
G1 X99.471 Y99.471 E2.05706 ; small perimeter
G1 X100.529 Y99.471 E2.08558 ; small perimeter
G1 X100.529 Y100.454 E2.11209 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F867.559
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
G1 X102.507 Y105.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3470.235
G1 X102.254 Y104.561 E2.01264 ; support material
G1 X101.746 Y104.561 E2.02528 ; support material
G1 X101.493 Y105.000 E2.03792 ; support material
G1 X101.746 Y105.439 E2.05056 ; support material
G1 X102.254 Y105.439 E2.06320 ; support material
G1 X102.507 Y105.000 E2.07584 ; support material
G1 X99.507 Y105.000 F7800.000 ; move to first support material point
G1 F3470.235
G1 X99.254 Y104.561 E2.08848 ; support material
G1 X98.746 Y104.561 E2.10112 ; support material
G1 X98.493 Y105.000 E2.11376 ; support material
G1 X98.746 Y105.439 E2.12640 ; support material
G1 X99.254 Y105.439 E2.13904 ; support material
G1 X99.507 Y105.000 E2.15168 ; support material
G1 X96.507 Y105.000 F7800.000 ; move to first support material point
G1 F3470.235
G1 X96.254 Y104.561 E2.16432 ; support material
G1 X95.746 Y104.561 E2.17696 ; support material
G1 X95.493 Y105.000 E2.18960 ; support material
G1 X95.746 Y105.439 E2.20224 ; support material
G1 X96.254 Y105.439 E2.21488 ; support material
G1 X96.507 Y105.000 E2.22752 ; support material
G1 E0.22752 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X96.507 Y102.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3470.235
G1 X96.254 Y101.561 E2.01264 ; support material
G1 X95.746 Y101.561 E2.02528 ; support material
G1 X95.493 Y102.000 E2.03792 ; support material
G1 X95.746 Y102.439 E2.05056 ; support material
G1 X96.254 Y102.439 E2.06320 ; support material
G1 X96.507 Y102.000 E2.07584 ; support material
G1 E0.07584 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X96.507 Y99.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3470.235
G1 X96.254 Y98.561 E2.01264 ; support material
G1 X95.746 Y98.561 E2.02528 ; support material
G1 X95.493 Y99.000 E2.03792 ; support material
G1 X95.746 Y99.439 E2.05056 ; support material
G1 X96.254 Y99.439 E2.06320 ; support material
G1 X96.507 Y99.000 E2.07584 ; support material
G1 E0.07584 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X96.507 Y96.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3470.235
G1 X96.254 Y95.561 E2.01264 ; support material
G1 X95.746 Y95.561 E2.02528 ; support material
G1 X95.493 Y96.000 E2.03792 ; support material
G1 X95.746 Y96.439 E2.05056 ; support material
G1 X96.254 Y96.439 E2.06320 ; support material
G1 X96.507 Y96.000 E2.07584 ; support material
G1 E0.07584 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X96.507 Y93.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3470.235
G1 X96.254 Y92.561 E2.01264 ; support material
G1 X95.746 Y92.561 E2.02528 ; support material
G1 X95.493 Y93.000 E2.03792 ; support material
G1 X95.746 Y93.439 E2.05056 ; support material
G1 X96.254 Y93.439 E2.06320 ; support material
G1 X96.507 Y93.000 E2.07584 ; support material
G1 E0.07584 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X96.507 Y90.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3470.235
G1 X96.254 Y89.561 E2.01264 ; support material
G1 X95.746 Y89.561 E2.02528 ; support material
G1 X95.493 Y90.000 E2.03792 ; support material
G1 X95.746 Y90.439 E2.05056 ; support material
G1 X96.254 Y90.439 E2.06320 ; support material
G1 X96.507 Y90.000 E2.07584 ; support material
G1 X93.507 Y90.000 F7800.000 ; move to first support material point
G1 F3470.235
G1 X93.254 Y89.561 E2.08848 ; support material
G1 X92.746 Y89.561 E2.10112 ; support material
G1 X92.493 Y90.000 E2.11376 ; support material
G1 X92.746 Y90.439 E2.12640 ; support material
G1 X93.254 Y90.439 E2.13904 ; support material
G1 X93.507 Y90.000 E2.15168 ; support material
G1 E0.15168 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X93.507 Y93.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3470.235
G1 X93.254 Y92.561 E2.01264 ; support material
G1 X92.746 Y92.561 E2.02528 ; support material
G1 X92.493 Y93.000 E2.03792 ; support material
G1 X92.746 Y93.439 E2.05056 ; support material
G1 X93.254 Y93.439 E2.06320 ; support material
G1 X93.507 Y93.000 E2.07584 ; support material
G1 X90.507 Y93.000 F7800.000 ; move to first support material point
G1 F3470.235
G1 X90.254 Y92.561 E2.08848 ; support material
G1 X89.746 Y92.561 E2.10112 ; support material
G1 X89.493 Y93.000 E2.11376 ; support material
G1 X89.746 Y93.439 E2.12640 ; support material
G1 X90.254 Y93.439 E2.13904 ; support material
G1 X90.507 Y93.000 E2.15168 ; support material
G1 E0.15168 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.507 Y90.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3470.235
G1 X90.254 Y89.561 E2.01264 ; support material
G1 X89.746 Y89.561 E2.02528 ; support material
G1 X89.493 Y90.000 E2.03792 ; support material
G1 X89.746 Y90.439 E2.05056 ; support material
G1 X90.254 Y90.439 E2.06320 ; support material
G1 X90.507 Y90.000 E2.07584 ; support material
G1 E0.07584 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.507 Y96.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3470.235
G1 X90.254 Y95.561 E2.01264 ; support material
G1 X89.746 Y95.561 E2.02528 ; support material
G1 X89.493 Y96.000 E2.03792 ; support material
G1 X89.746 Y96.439 E2.05056 ; support material
G1 X90.254 Y96.439 E2.06320 ; support material
G1 X90.507 Y96.000 E2.07584 ; support material
G1 X93.507 Y96.000 F7800.000 ; move to first support material point
G1 F3470.235
G1 X93.254 Y95.561 E2.08848 ; support material
G1 X92.746 Y95.561 E2.10112 ; support material
G1 X92.493 Y96.000 E2.11376 ; support material
G1 X92.746 Y96.439 E2.12640 ; support material
G1 X93.254 Y96.439 E2.13904 ; support material
G1 X93.507 Y96.000 E2.15168 ; support material
G1 E0.15168 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X93.507 Y99.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3470.235
G1 X93.254 Y98.561 E2.01264 ; support material
G1 X92.746 Y98.561 E2.02528 ; support material
G1 X92.493 Y99.000 E2.03792 ; support material
G1 X92.746 Y99.439 E2.05056 ; support material
G1 X93.254 Y99.439 E2.06320 ; support material
G1 X93.507 Y99.000 E2.07584 ; support material
G1 X90.507 Y99.000 F7800.000 ; move to first support material point
G1 F3470.235
G1 X90.254 Y98.561 E2.08848 ; support material
G1 X89.746 Y98.561 E2.10112 ; support material
G1 X89.493 Y99.000 E2.11376 ; support material
G1 X89.746 Y99.439 E2.12640 ; support material
G1 X90.254 Y99.439 E2.13904 ; support material
G1 X90.507 Y99.000 E2.15168 ; support material
G1 E0.15168 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.507 Y102.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3470.235
G1 X90.254 Y101.561 E2.01264 ; support material
G1 X89.746 Y101.561 E2.02528 ; support material
G1 X89.493 Y102.000 E2.03792 ; support material
G1 X89.746 Y102.439 E2.05056 ; support material
G1 X90.254 Y102.439 E2.06320 ; support material
G1 X90.507 Y102.000 E2.07584 ; support material
G1 X93.507 Y102.000 F7800.000 ; move to first support material point
G1 F3470.235
G1 X93.254 Y101.561 E2.08848 ; support material
G1 X92.746 Y101.561 E2.10112 ; support material
G1 X92.493 Y102.000 E2.11376 ; support material
G1 X92.746 Y102.439 E2.12640 ; support material
G1 X93.254 Y102.439 E2.13904 ; support material
G1 X93.507 Y102.000 E2.15168 ; support material
G1 E0.15168 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X93.507 Y105.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3470.235
G1 X93.254 Y104.561 E2.01264 ; support material
G1 X92.746 Y104.561 E2.02528 ; support material
G1 X92.493 Y105.000 E2.03792 ; support material
G1 X92.746 Y105.439 E2.05056 ; support material
G1 X93.254 Y105.439 E2.06320 ; support material
G1 X93.507 Y105.000 E2.07584 ; support material
G1 X90.507 Y105.000 F7800.000 ; move to first support material point
G1 F3470.235
G1 X90.254 Y104.561 E2.08848 ; support material
G1 X89.746 Y104.561 E2.10112 ; support material
G1 X89.493 Y105.000 E2.11376 ; support material
G1 X89.746 Y105.439 E2.12640 ; support material
G1 X90.254 Y105.439 E2.13904 ; support material
G1 X90.507 Y105.000 E2.15168 ; support material
G1 E0.15168 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.507 Y108.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3470.235
G1 X90.254 Y107.561 E2.01264 ; support material
G1 X89.746 Y107.561 E2.02528 ; support material
G1 X89.493 Y108.000 E2.03792 ; support material
G1 X89.746 Y108.439 E2.05056 ; support material
G1 X90.254 Y108.439 E2.06320 ; support material
G1 X90.507 Y108.000 E2.07584 ; support material
G1 X93.507 Y108.000 F7800.000 ; move to first support material point
G1 F3470.235
G1 X93.254 Y107.561 E2.08848 ; support material
G1 X92.746 Y107.561 E2.10112 ; support material
G1 X92.493 Y108.000 E2.11376 ; support material
G1 X92.746 Y108.439 E2.12640 ; support material
G1 X93.254 Y108.439 E2.13904 ; support material
G1 X93.507 Y108.000 E2.15168 ; support material
G1 X96.507 Y108.000 F7800.000 ; move to first support material point
G1 F3470.235
G1 X96.254 Y107.561 E2.16432 ; support material
G1 X95.746 Y107.561 E2.17696 ; support material
G1 X95.493 Y108.000 E2.18960 ; support material
G1 X95.746 Y108.439 E2.20224 ; support material
G1 X96.254 Y108.439 E2.21488 ; support material
G1 X96.507 Y108.000 E2.22752 ; support material
G1 X99.507 Y108.000 F7800.000 ; move to first support material point
G1 F3470.235
G1 X99.254 Y107.561 E2.24017 ; support material
G1 X98.746 Y107.561 E2.25281 ; support material
G1 X98.493 Y108.000 E2.26545 ; support material
G1 X98.746 Y108.439 E2.27809 ; support material
G1 X99.254 Y108.439 E2.29073 ; support material
G1 X99.507 Y108.000 E2.30337 ; support material
G1 X102.507 Y108.000 F7800.000 ; move to first support material point
G1 F3470.235
G1 X102.254 Y107.561 E2.31601 ; support material
G1 X101.746 Y107.561 E2.32865 ; support material
G1 X101.493 Y108.000 E2.34129 ; support material
G1 X101.746 Y108.439 E2.35393 ; support material
G1 X102.254 Y108.439 E2.36657 ; support material
G1 X102.507 Y108.000 E2.37921 ; support material
G1 X105.507 Y108.000 F7800.000 ; move to first support material point
G1 F3470.235
G1 X105.254 Y107.561 E2.39185 ; support material
G1 X104.746 Y107.561 E2.40449 ; support material
G1 X104.493 Y108.000 E2.41713 ; support material
G1 X104.746 Y108.439 E2.42977 ; support material
G1 X105.254 Y108.439 E2.44241 ; support material
G1 X105.507 Y108.000 E2.45505 ; support material
G1 E0.45505 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X105.507 Y105.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3470.235
G1 X105.254 Y104.561 E2.01264 ; support material
G1 X104.746 Y104.561 E2.02528 ; support material
G1 X104.493 Y105.000 E2.03792 ; support material
G1 X104.746 Y105.439 E2.05056 ; support material
G1 X105.254 Y105.439 E2.06320 ; support material
G1 X105.507 Y105.000 E2.07584 ; support material
G1 E0.07584 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X105.507 Y102.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3470.235
G1 X105.254 Y101.561 E2.01264 ; support material
G1 X104.746 Y101.561 E2.02528 ; support material
G1 X104.493 Y102.000 E2.03792 ; support material
G1 X104.746 Y102.439 E2.05056 ; support material
G1 X105.254 Y102.439 E2.06320 ; support material
G1 X105.507 Y102.000 E2.07584 ; support material
G1 E0.07584 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X105.507 Y99.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3470.235
G1 X105.254 Y98.561 E2.01264 ; support material
G1 X104.746 Y98.561 E2.02528 ; support material
G1 X104.493 Y99.000 E2.03792 ; support material
G1 X104.746 Y99.439 E2.05056 ; support material
G1 X105.254 Y99.439 E2.06320 ; support material
G1 X105.507 Y99.000 E2.07584 ; support material
G1 E0.07584 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X105.507 Y96.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3470.235
G1 X105.254 Y95.561 E2.01264 ; support material
G1 X104.746 Y95.561 E2.02528 ; support material
G1 X104.493 Y96.000 E2.03792 ; support material
G1 X104.746 Y96.439 E2.05056 ; support material
G1 X105.254 Y96.439 E2.06320 ; support material
G1 X105.507 Y96.000 E2.07584 ; support material
G1 E0.07584 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X105.507 Y93.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3470.235
G1 X105.254 Y92.561 E2.01264 ; support material
G1 X104.746 Y92.561 E2.02528 ; support material
G1 X104.493 Y93.000 E2.03792 ; support material
G1 X104.746 Y93.439 E2.05056 ; support material
G1 X105.254 Y93.439 E2.06320 ; support material
G1 X105.507 Y93.000 E2.07584 ; support material
G1 E0.07584 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X105.507 Y90.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3470.235
G1 X105.254 Y89.561 E2.01264 ; support material
G1 X104.746 Y89.561 E2.02528 ; support material
G1 X104.493 Y90.000 E2.03792 ; support material
G1 X104.746 Y90.439 E2.05056 ; support material
G1 X105.254 Y90.439 E2.06320 ; support material
G1 X105.507 Y90.000 E2.07584 ; support material
G1 X102.507 Y90.000 F7800.000 ; move to first support material point
G1 F3470.235
G1 X102.254 Y89.561 E2.08848 ; support material
G1 X101.746 Y89.561 E2.10112 ; support material
G1 X101.493 Y90.000 E2.11376 ; support material
G1 X101.746 Y90.439 E2.12640 ; support material
G1 X102.254 Y90.439 E2.13904 ; support material
G1 X102.507 Y90.000 E2.15168 ; support material
G1 E0.15168 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X102.507 Y93.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3470.235
G1 X102.254 Y92.561 E2.01264 ; support material
G1 X101.746 Y92.561 E2.02528 ; support material
G1 X101.493 Y93.000 E2.03792 ; support material
G1 X101.746 Y93.439 E2.05056 ; support material
G1 X102.254 Y93.439 E2.06320 ; support material
G1 X102.507 Y93.000 E2.07584 ; support material
G1 X99.507 Y93.000 F7800.000 ; move to first support material point
G1 F3470.235
G1 X99.254 Y92.561 E2.08848 ; support material
G1 X98.746 Y92.561 E2.10112 ; support material
G1 X98.493 Y93.000 E2.11376 ; support material
G1 X98.746 Y93.439 E2.12640 ; support material
G1 X99.254 Y93.439 E2.13904 ; support material
G1 X99.507 Y93.000 E2.15168 ; support material
G1 E0.15168 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X99.507 Y90.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3470.235
G1 X99.254 Y89.561 E2.01264 ; support material
G1 X98.746 Y89.561 E2.02528 ; support material
G1 X98.493 Y90.000 E2.03792 ; support material
G1 X98.746 Y90.439 E2.05056 ; support material
G1 X99.254 Y90.439 E2.06320 ; support material
G1 X99.507 Y90.000 E2.07584 ; support material
G1 E0.07584 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X99.507 Y96.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3470.235
G1 X99.254 Y95.561 E2.01264 ; support material
G1 X98.746 Y95.561 E2.02528 ; support material
G1 X98.493 Y96.000 E2.03792 ; support material
G1 X98.746 Y96.439 E2.05056 ; support material
G1 X99.254 Y96.439 E2.06320 ; support material
G1 X99.507 Y96.000 E2.07584 ; support material
G1 X102.507 Y96.000 F7800.000 ; move to first support material point
G1 F3470.235
G1 X102.254 Y95.561 E2.08848 ; support material
G1 X101.746 Y95.561 E2.10112 ; support material
G1 X101.493 Y96.000 E2.11376 ; support material
G1 X101.746 Y96.439 E2.12640 ; support material
G1 X102.254 Y96.439 E2.13904 ; support material
G1 X102.507 Y96.000 E2.15168 ; support material
G1 X108.507 Y96.000 F7800.000 ; move to first support material point
G1 F3470.235
G1 X108.254 Y95.561 E2.16432 ; support material
G1 X107.746 Y95.561 E2.17696 ; support material
G1 X107.493 Y96.000 E2.18960 ; support material
G1 X107.746 Y96.439 E2.20224 ; support material
G1 X108.254 Y96.439 E2.21488 ; support material
G1 X108.507 Y96.000 E2.22752 ; support material
G1 E0.22752 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X108.507 Y93.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3470.235
G1 X108.254 Y92.561 E2.01264 ; support material
G1 X107.746 Y92.561 E2.02528 ; support material
G1 X107.493 Y93.000 E2.03792 ; support material
G1 X107.746 Y93.439 E2.05056 ; support material
G1 X108.254 Y93.439 E2.06320 ; support material
G1 X108.507 Y93.000 E2.07584 ; support material
G1 E0.07584 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X108.507 Y90.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3470.235
G1 X108.254 Y89.561 E2.01264 ; support material
G1 X107.746 Y89.561 E2.02528 ; support material
G1 X107.493 Y90.000 E2.03792 ; support material
G1 X107.746 Y90.439 E2.05056 ; support material
G1 X108.254 Y90.439 E2.06320 ; support material
G1 X108.507 Y90.000 E2.07584 ; support material
G1 X111.507 Y90.000 F7800.000 ; move to first support material point
G1 F3470.235
G1 X111.254 Y89.561 E2.08848 ; support material
G1 X110.746 Y89.561 E2.10112 ; support material
G1 X110.493 Y90.000 E2.11376 ; support material
G1 X110.746 Y90.439 E2.12640 ; support material
G1 X111.254 Y90.439 E2.13904 ; support material
G1 X111.507 Y90.000 E2.15168 ; support material
G1 E0.15168 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X111.507 Y93.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3470.235
G1 X111.254 Y92.561 E2.01264 ; support material
G1 X110.746 Y92.561 E2.02528 ; support material
G1 X110.493 Y93.000 E2.03792 ; support material
G1 X110.746 Y93.439 E2.05056 ; support material
G1 X111.254 Y93.439 E2.06320 ; support material
G1 X111.507 Y93.000 E2.07584 ; support material
G1 E0.07584 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X111.507 Y96.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3470.235
G1 X111.254 Y95.561 E2.01264 ; support material
G1 X110.746 Y95.561 E2.02528 ; support material
G1 X110.493 Y96.000 E2.03792 ; support material
G1 X110.746 Y96.439 E2.05056 ; support material
G1 X111.254 Y96.439 E2.06320 ; support material
G1 X111.507 Y96.000 E2.07584 ; support material
G1 E0.07584 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X111.507 Y99.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3470.235
G1 X111.254 Y98.561 E2.01264 ; support material
G1 X110.746 Y98.561 E2.02528 ; support material
G1 X110.493 Y99.000 E2.03792 ; support material
G1 X110.746 Y99.439 E2.05056 ; support material
G1 X111.254 Y99.439 E2.06320 ; support material
G1 X111.507 Y99.000 E2.07584 ; support material
G1 X108.507 Y99.000 F7800.000 ; move to first support material point
G1 F3470.235
G1 X108.254 Y98.561 E2.08848 ; support material
G1 X107.746 Y98.561 E2.10112 ; support material
G1 X107.493 Y99.000 E2.11376 ; support material
G1 X107.746 Y99.439 E2.12640 ; support material
G1 X108.254 Y99.439 E2.13904 ; support material
G1 X108.507 Y99.000 E2.15168 ; support material
G1 E0.15168 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X108.507 Y102.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3470.235
G1 X108.254 Y101.561 E2.01264 ; support material
G1 X107.746 Y101.561 E2.02528 ; support material
G1 X107.493 Y102.000 E2.03792 ; support material
G1 X107.746 Y102.439 E2.05056 ; support material
G1 X108.254 Y102.439 E2.06320 ; support material
G1 X108.507 Y102.000 E2.07584 ; support material
G1 X111.507 Y102.000 F7800.000 ; move to first support material point
G1 F3470.235
G1 X111.254 Y101.561 E2.08848 ; support material
G1 X110.746 Y101.561 E2.10112 ; support material
G1 X110.493 Y102.000 E2.11376 ; support material
G1 X110.746 Y102.439 E2.12640 ; support material
G1 X111.254 Y102.439 E2.13904 ; support material
G1 X111.507 Y102.000 E2.15168 ; support material
G1 E0.15168 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X111.507 Y105.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3470.235
G1 X111.254 Y104.561 E2.01264 ; support material
G1 X110.746 Y104.561 E2.02528 ; support material
G1 X110.493 Y105.000 E2.03792 ; support material
G1 X110.746 Y105.439 E2.05056 ; support material
G1 X111.254 Y105.439 E2.06320 ; support material
G1 X111.507 Y105.000 E2.07584 ; support material
G1 X108.507 Y105.000 F7800.000 ; move to first support material point
G1 F3470.235
G1 X108.254 Y104.561 E2.08848 ; support material
G1 X107.746 Y104.561 E2.10112 ; support material
G1 X107.493 Y105.000 E2.11376 ; support material
G1 X107.746 Y105.439 E2.12640 ; support material
G1 X108.254 Y105.439 E2.13904 ; support material
G1 X108.507 Y105.000 E2.15168 ; support material
G1 E0.15168 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X108.507 Y108.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3470.235
G1 X108.254 Y107.561 E2.01264 ; support material
G1 X107.746 Y107.561 E2.02528 ; support material
G1 X107.493 Y108.000 E2.03792 ; support material
G1 X107.746 Y108.439 E2.05056 ; support material
G1 X108.254 Y108.439 E2.06320 ; support material
G1 X108.507 Y108.000 E2.07584 ; support material
G1 X111.507 Y108.000 F7800.000 ; move to first support material point
G1 F3470.235
G1 X111.254 Y107.561 E2.08848 ; support material
G1 X110.746 Y107.561 E2.10112 ; support material
G1 X110.493 Y108.000 E2.11376 ; support material
G1 X110.746 Y108.439 E2.12640 ; support material
G1 X111.254 Y108.439 E2.13904 ; support material
G1 X111.507 Y108.000 E2.15168 ; support material
G1 E0.15168 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X111.507 Y111.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3470.235
G1 X111.254 Y110.561 E2.01264 ; support material
G1 X110.746 Y110.561 E2.02528 ; support material
G1 X110.493 Y111.000 E2.03792 ; support material
G1 X110.746 Y111.439 E2.05056 ; support material
G1 X111.254 Y111.439 E2.06320 ; support material
G1 X111.507 Y111.000 E2.07584 ; support material
G1 E0.07584 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X108.507 Y111.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3470.235
G1 X108.254 Y110.561 E2.01264 ; support material
G1 X107.746 Y110.561 E2.02528 ; support material
G1 X107.493 Y111.000 E2.03792 ; support material
G1 X107.746 Y111.439 E2.05056 ; support material
G1 X108.254 Y111.439 E2.06320 ; support material
G1 X108.507 Y111.000 E2.07584 ; support material
G1 E0.07584 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X105.507 Y111.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3470.235
G1 X105.254 Y110.561 E2.01264 ; support material
G1 X104.746 Y110.561 E2.02528 ; support material
G1 X104.493 Y111.000 E2.03792 ; support material
G1 X104.746 Y111.439 E2.05056 ; support material
G1 X105.254 Y111.439 E2.06320 ; support material
G1 X105.507 Y111.000 E2.07584 ; support material
G1 E0.07584 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X102.507 Y111.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3470.235
G1 X102.254 Y110.561 E2.01264 ; support material
G1 X101.746 Y110.561 E2.02528 ; support material
G1 X101.493 Y111.000 E2.03792 ; support material
G1 X101.746 Y111.439 E2.05056 ; support material
G1 X102.254 Y111.439 E2.06320 ; support material
G1 X102.507 Y111.000 E2.07584 ; support material
G1 E0.07584 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X99.507 Y111.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3470.235
G1 X99.254 Y110.561 E2.01264 ; support material
G1 X98.746 Y110.561 E2.02528 ; support material
G1 X98.493 Y111.000 E2.03792 ; support material
G1 X98.746 Y111.439 E2.05056 ; support material
G1 X99.254 Y111.439 E2.06320 ; support material
G1 X99.507 Y111.000 E2.07584 ; support material
G1 E0.07584 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X96.507 Y111.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3470.235
G1 X96.254 Y110.561 E2.01264 ; support material
G1 X95.746 Y110.561 E2.02528 ; support material
G1 X95.493 Y111.000 E2.03792 ; support material
G1 X95.746 Y111.439 E2.05056 ; support material
G1 X96.254 Y111.439 E2.06320 ; support material
G1 X96.507 Y111.000 E2.07584 ; support material
G1 E0.07584 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X93.507 Y111.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3470.235
G1 X93.254 Y110.561 E2.01264 ; support material
G1 X92.746 Y110.561 E2.02528 ; support material
G1 X92.493 Y111.000 E2.03792 ; support material
G1 X92.746 Y111.439 E2.05056 ; support material
G1 X93.254 Y111.439 E2.06320 ; support material
G1 X93.507 Y111.000 E2.07584 ; support material
G1 E0.07584 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X90.507 Y111.000 F7800.000 ; move to first support material point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3470.235
G1 X90.254 Y110.561 E2.01264 ; support material
G1 X89.746 Y110.561 E2.02528 ; support material
G1 X89.493 Y111.000 E2.03792 ; support material
G1 X89.746 Y111.439 E2.05056 ; support material
G1 X90.254 Y111.439 E2.06320 ; support material
G1 X90.507 Y111.000 E2.07584 ; support material
G1 Z8.450 F7800.000 ; move to next layer (50)
G1 E0.07584 F2400.00000 ; retract extruder 0
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
M106 S209.1 ; enable fan
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
G1 X97.363 Y103.060 F7800.000 ; move to first support material interface point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X96.940 Y103.060 E2.01054 ; support material interface
G1 X96.940 Y96.940 E2.16297 ; support material interface
G1 X97.363 Y96.940 E2.17351 ; support material interface
G1 X97.363 Y88.735 E2.37790 ; support material interface
G1 X97.843 Y88.735 E2.38984 ; support material interface
G1 X97.843 Y96.940 E2.59424 ; support material interface
G1 X98.322 Y96.940 E2.60618 ; support material interface
G1 X98.322 Y88.735 E2.81057 ; support material interface
G1 X98.802 Y88.735 E2.82252 ; support material interface
G1 X98.802 Y96.940 E3.02691 ; support material interface
G1 X99.281 Y96.940 E3.03885 ; support material interface
G1 X99.281 Y88.735 E3.24325 ; support material interface
G1 X99.760 Y88.735 E3.25519 ; support material interface
G1 X99.760 Y96.940 E3.45958 ; support material interface
G1 X100.240 Y96.940 E3.47152 ; support material interface
G1 X100.240 Y88.735 E3.67592 ; support material interface
G1 X100.719 Y88.735 E3.68786 ; support material interface
G1 X100.719 Y96.940 E3.89226 ; support material interface
G1 X101.198 Y96.940 E3.90420 ; support material interface
G1 X101.198 Y88.735 E4.10859 ; support material interface
G1 X101.678 Y88.735 E4.12053 ; support material interface
G1 X101.678 Y96.940 E4.32493 ; support material interface
G1 X102.157 Y96.940 E4.33687 ; support material interface
G1 X102.157 Y88.735 E4.54126 ; support material interface
G1 X102.637 Y88.735 E4.55320 ; support material interface
G1 X102.637 Y96.940 E4.75760 ; support material interface
G1 E2.75760 F2400.00000 ; retract extruder 0
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
G1 X96.405 Y88.735 E12.29297 ; support material interface
G1 X96.884 Y88.735 E12.30491 ; support material interface
G1 X96.884 Y111.265 E12.86612 ; support material interface
G1 X97.363 Y111.265 E12.87806 ; support material interface
G1 X97.363 Y103.060 E13.08246 ; support material interface
G1 X97.843 Y103.060 E13.09440 ; support material interface
G1 X97.843 Y111.265 E13.29880 ; support material interface
G1 X98.322 Y111.265 E13.31074 ; support material interface
G1 X98.322 Y103.060 E13.51513 ; support material interface
G1 X98.802 Y103.060 E13.52707 ; support material interface
G1 X98.802 Y111.265 E13.73147 ; support material interface
G1 X99.281 Y111.265 E13.74341 ; support material interface
G1 X99.281 Y103.060 E13.94780 ; support material interface
G1 X99.760 Y103.060 E13.95974 ; support material interface
G1 X99.760 Y111.265 E14.16414 ; support material interface
G1 X100.240 Y111.265 E14.17608 ; support material interface
G1 X100.240 Y103.060 E14.38048 ; support material interface
G1 X100.719 Y103.060 E14.39242 ; support material interface
G1 X100.719 Y111.265 E14.59681 ; support material interface
G1 X101.198 Y111.265 E14.60875 ; support material interface
G1 X101.198 Y103.060 E14.81315 ; support material interface
G1 X101.678 Y103.060 E14.82509 ; support material interface
G1 X101.678 Y111.265 E15.02948 ; support material interface
G1 X102.157 Y111.265 E15.04143 ; support material interface
G1 X102.157 Y103.060 E15.24582 ; support material interface
G1 X102.637 Y103.060 E15.25776 ; support material interface
G1 X102.637 Y111.265 E15.46216 ; support material interface
G1 X103.116 Y111.265 E15.47410 ; support material interface
G1 X103.116 Y88.735 E16.03532 ; support material interface
G1 X103.595 Y88.735 E16.04726 ; support material interface
G1 X103.595 Y111.265 E16.60847 ; support material interface
G1 X104.075 Y111.265 E16.62041 ; support material interface
G1 X104.075 Y88.735 E17.18163 ; support material interface
G1 X104.554 Y88.735 E17.19357 ; support material interface
G1 X104.554 Y111.265 E17.75479 ; support material interface
G1 X105.033 Y111.265 E17.76673 ; support material interface
G1 X105.033 Y88.735 E18.32795 ; support material interface
G1 X105.513 Y88.735 E18.33989 ; support material interface
G1 X105.513 Y111.265 E18.90111 ; support material interface
G1 X105.992 Y111.265 E18.91305 ; support material interface
G1 X105.992 Y88.735 E19.47426 ; support material interface
G1 X106.472 Y88.735 E19.48620 ; support material interface
G1 X106.472 Y111.265 E20.04742 ; support material interface
G1 X106.951 Y111.265 E20.05936 ; support material interface
G1 X106.951 Y88.735 E20.62058 ; support material interface
G1 X107.430 Y88.735 E20.63252 ; support material interface
G1 X107.430 Y111.265 E21.19374 ; support material interface
G1 X107.910 Y111.265 E21.20568 ; support material interface
G1 X107.910 Y88.735 E21.76690 ; support material interface
G1 X108.389 Y88.735 E21.77884 ; support material interface
G1 X108.389 Y111.265 E22.34006 ; support material interface
G1 X108.868 Y111.265 E22.35200 ; support material interface
G1 X108.868 Y88.735 E22.91321 ; support material interface
G1 X109.348 Y88.735 E22.92515 ; support material interface
G1 X109.348 Y111.265 E23.48637 ; support material interface
G1 X109.827 Y111.265 E23.49831 ; support material interface
G1 X109.827 Y88.735 E24.05953 ; support material interface
G1 X110.306 Y88.735 E24.07147 ; support material interface
G1 X110.306 Y111.265 E24.63269 ; support material interface
G1 X110.786 Y111.265 E24.64463 ; support material interface
G1 X110.786 Y88.735 E25.20585 ; support material interface
G1 X111.265 Y88.735 E25.21779 ; support material interface
G1 X111.265 Y111.265 E25.77900 ; support material interface
G1 Z9.050 F7800.000 ; move to next layer (53)
G1 E23.77900 F2400.00000 ; retract extruder 0
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
G1 X103.060 Y102.637 F7800.000 ; move to first support material interface point
G1 F3600.000
G1 X111.265 Y102.637 E2.84863 ; support material interface
G1 X111.265 Y102.157 E2.86057 ; support material interface
G1 X103.060 Y102.157 E3.06496 ; support material interface
G1 X103.060 Y101.678 E3.07690 ; support material interface
G1 X111.265 Y101.678 E3.28130 ; support material interface
G1 X111.265 Y101.198 E3.29324 ; support material interface
G1 X103.060 Y101.198 E3.49764 ; support material interface
G1 X103.060 Y100.719 E3.50958 ; support material interface
G1 X111.265 Y100.719 E3.71397 ; support material interface
G1 X111.265 Y100.240 E3.72591 ; support material interface
G1 X103.060 Y100.240 E3.93031 ; support material interface
G1 X103.060 Y99.760 E3.94225 ; support material interface
G1 X111.265 Y99.760 E4.14664 ; support material interface
G1 X111.265 Y99.281 E4.15858 ; support material interface
G1 X103.060 Y99.281 E4.36298 ; support material interface
G1 X103.060 Y98.802 E4.37492 ; support material interface
G1 X111.265 Y98.802 E4.57932 ; support material interface
G1 X111.265 Y98.322 E4.59126 ; support material interface
G1 X103.060 Y98.322 E4.79565 ; support material interface
G1 X103.060 Y97.843 E4.80759 ; support material interface
G1 X111.265 Y97.843 E5.01199 ; support material interface
G1 X111.265 Y97.363 E5.02393 ; support material interface
G1 X103.060 Y97.363 E5.22832 ; support material interface
G1 X103.060 Y96.940 E5.23886 ; support material interface
G1 X96.940 Y96.940 E5.39129 ; support material interface
G1 X96.940 Y97.363 E5.40183 ; support material interface
G1 E3.40183 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X88.735 Y111.265 F7800.000 ; move to first support material interface point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X111.265 Y111.265 E2.56122 ; support material interface
G1 X111.265 Y110.786 E2.57316 ; support material interface
G1 X88.735 Y110.786 E3.13438 ; support material interface
G1 X88.735 Y110.306 E3.14632 ; support material interface
G1 X111.265 Y110.306 E3.70753 ; support material interface
G1 X111.265 Y109.827 E3.71947 ; support material interface
G1 X88.735 Y109.827 E4.28069 ; support material interface
G1 X88.735 Y109.348 E4.29263 ; support material interface
G1 X111.265 Y109.348 E4.85385 ; support material interface
G1 X111.265 Y108.868 E4.86579 ; support material interface
G1 X88.735 Y108.868 E5.42701 ; support material interface
G1 X88.735 Y108.389 E5.43895 ; support material interface
G1 X111.265 Y108.389 E6.00017 ; support material interface
G1 X111.265 Y107.910 E6.01211 ; support material interface
G1 X88.735 Y107.910 E6.57332 ; support material interface
G1 X88.735 Y107.430 E6.58527 ; support material interface
G1 X111.265 Y107.430 E7.14648 ; support material interface
G1 X111.265 Y106.951 E7.15842 ; support material interface
G1 X88.735 Y106.951 E7.71964 ; support material interface
G1 X88.735 Y106.472 E7.73158 ; support material interface
G1 X111.265 Y106.472 E8.29280 ; support material interface
G1 X111.265 Y105.992 E8.30474 ; support material interface
G1 X88.735 Y105.992 E8.86596 ; support material interface
G1 X88.735 Y105.513 E8.87790 ; support material interface
G1 X111.265 Y105.513 E9.43912 ; support material interface
G1 X111.265 Y105.033 E9.45106 ; support material interface
G1 X88.735 Y105.033 E10.01227 ; support material interface
G1 X88.735 Y104.554 E10.02421 ; support material interface
G1 X111.265 Y104.554 E10.58543 ; support material interface
G1 X111.265 Y104.075 E10.59737 ; support material interface
G1 X88.735 Y104.075 E11.15859 ; support material interface
G1 X88.735 Y103.595 E11.17053 ; support material interface
G1 X111.265 Y103.595 E11.73175 ; support material interface
G1 X111.265 Y103.116 E11.74369 ; support material interface
G1 X88.735 Y103.116 E12.30491 ; support material interface
G1 X88.735 Y102.637 E12.31685 ; support material interface
G1 X96.940 Y102.637 E12.52124 ; support material interface
G1 X96.940 Y102.157 E12.53318 ; support material interface
G1 X88.735 Y102.157 E12.73758 ; support material interface
G1 X88.735 Y101.678 E12.74952 ; support material interface
G1 X96.940 Y101.678 E12.95392 ; support material interface
G1 X96.940 Y101.198 E12.96586 ; support material interface
G1 X88.735 Y101.198 E13.17025 ; support material interface
G1 X88.735 Y100.719 E13.18219 ; support material interface
G1 X96.940 Y100.719 E13.38659 ; support material interface
G1 X96.940 Y100.240 E13.39853 ; support material interface
G1 X88.735 Y100.240 E13.60292 ; support material interface
G1 X88.735 Y99.760 E13.61486 ; support material interface
G1 X96.940 Y99.760 E13.81926 ; support material interface
G1 X96.940 Y99.281 E13.83120 ; support material interface
G1 X88.735 Y99.281 E14.03560 ; support material interface
G1 X88.735 Y98.802 E14.04754 ; support material interface
G1 X96.940 Y98.802 E14.25193 ; support material interface
G1 X96.940 Y98.322 E14.26387 ; support material interface
G1 X88.735 Y98.322 E14.46827 ; support material interface
G1 X88.735 Y97.843 E14.48021 ; support material interface
G1 X96.940 Y97.843 E14.68460 ; support material interface
G1 X96.940 Y97.363 E14.69655 ; support material interface
G1 X88.735 Y97.363 E14.90094 ; support material interface
G1 X88.735 Y96.884 E14.91288 ; support material interface
G1 X111.265 Y96.884 E15.47410 ; support material interface
G1 X111.265 Y96.405 E15.48604 ; support material interface
G1 X88.735 Y96.405 E16.04726 ; support material interface
G1 X88.735 Y95.925 E16.05920 ; support material interface
G1 X111.265 Y95.925 E16.62042 ; support material interface
G1 X111.265 Y95.446 E16.63236 ; support material interface
G1 X88.735 Y95.446 E17.19357 ; support material interface
G1 X88.735 Y94.967 E17.20551 ; support material interface
G1 X111.265 Y94.967 E17.76673 ; support material interface
G1 X111.265 Y94.487 E17.77867 ; support material interface
G1 X88.735 Y94.487 E18.33989 ; support material interface
G1 X88.735 Y94.008 E18.35183 ; support material interface
G1 X111.265 Y94.008 E18.91305 ; support material interface
G1 X111.265 Y93.529 E18.92499 ; support material interface
G1 X88.735 Y93.529 E19.48621 ; support material interface
G1 X88.735 Y93.049 E19.49815 ; support material interface
G1 X111.265 Y93.049 E20.05936 ; support material interface
G1 X111.265 Y92.570 E20.07131 ; support material interface
G1 X88.735 Y92.570 E20.63252 ; support material interface
G1 X88.735 Y92.090 E20.64446 ; support material interface
G1 X111.265 Y92.090 E21.20568 ; support material interface
G1 X111.265 Y91.611 E21.21762 ; support material interface
G1 X88.735 Y91.611 E21.77884 ; support material interface
G1 X88.735 Y91.132 E21.79078 ; support material interface
G1 X111.265 Y91.132 E22.35200 ; support material interface
G1 X111.265 Y90.652 E22.36394 ; support material interface
G1 X88.735 Y90.652 E22.92516 ; support material interface
G1 X88.735 Y90.173 E22.93710 ; support material interface
G1 X111.265 Y90.173 E23.49831 ; support material interface
G1 X111.265 Y89.694 E23.51025 ; support material interface
G1 X88.735 Y89.694 E24.07147 ; support material interface
G1 X88.735 Y89.214 E24.08341 ; support material interface
G1 X111.265 Y89.214 E24.64463 ; support material interface
G1 X111.265 Y88.735 E24.65657 ; support material interface
G1 X88.735 Y88.735 E25.21779 ; support material interface
G1 X111.265 Y88.735 E25.77901 ; support material interface
G1 Z9.350 F7800.000 ; move to next layer (55)
G1 E23.77901 F2400.00000 ; retract extruder 0
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
; cog_x = 99.907862
; cog_y = 100.120300
; cog_z = 7.993383
; material used = 332.36mm (2.35cm3)
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
; machine_acceleration = 0
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
; support_material_style = tree
; support_material_threshold = 60%
; support_material_tree_angle = 40
; support_material_tree_branch_diameter = 5
; support_material_tree_tip_spacing = 3
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
; fuzzy_skin = 0
; fuzzy_skin_point_dist = 0.8
; fuzzy_skin_thickness = 0.3
; gap_fill_speed = 20
; infill_every_layers = 1
; infill_extruder = 1
; infill_extrusion_width = 0
; infill_overlap = 55%
; infill_speed = 80
; ironing = 0
; ironing_flowrate = 15%
; ironing_spacing = 0.1
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
; estimated printing time = 8m 18s
