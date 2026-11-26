

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
G1 X92.915 Y93.753 F7800.000 ; move to first skirt point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F905.737
G1 X94.668 Y92.274 E2.07096 ; skirt
G1 X96.820 Y91.481 E2.14192 ; skirt
G1 X98.000 Y91.375 E2.17858 ; skirt
G1 X102.000 Y91.375 E2.30234 ; skirt
G1 X104.259 Y91.772 E2.37330 ; skirt
G1 X106.247 Y92.915 E2.44427 ; skirt
G1 X107.726 Y94.668 E2.51523 ; skirt
G1 X108.519 Y96.820 E2.58619 ; skirt
G1 X108.625 Y98.000 E2.62284 ; skirt
G1 X108.625 Y102.000 E2.74661 ; skirt
G1 X108.228 Y104.259 E2.81757 ; skirt
G1 X107.085 Y106.247 E2.88853 ; skirt
G1 X105.332 Y107.726 E2.95949 ; skirt
G1 X103.180 Y108.519 E3.03046 ; skirt
G1 X102.000 Y108.625 E3.06711 ; skirt
G1 X98.000 Y108.625 E3.19087 ; skirt
G1 X95.741 Y108.228 E3.26183 ; skirt
G1 X93.753 Y107.085 E3.33280 ; skirt
G1 X92.274 Y105.332 E3.40376 ; skirt
G1 X91.481 Y103.180 E3.47472 ; skirt
G1 X91.375 Y102.000 E3.51137 ; skirt
G1 X91.375 Y98.000 E3.63514 ; skirt
G1 X91.772 Y95.741 E3.70610 ; skirt
G1 X92.915 Y93.753 E3.77706 ; skirt
G1 E1.77706 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X100.400 Y100.400 F7800.000 ; move to first small perimeter point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F905.737
G1 X99.600 Y100.400 E2.02477 ; small perimeter
G1 X99.600 Y99.600 E2.04953 ; small perimeter
G1 X100.400 Y99.600 E2.07430 ; small perimeter
G1 X100.400 Y100.400 E2.09907 ; small perimeter
G1 X101.025 Y101.025 F7800.000 ; move to first small perimeter point
G1 F905.737
G1 X98.975 Y101.025 E2.16250 ; small perimeter
G1 X98.975 Y98.975 E2.22594 ; small perimeter
G1 X101.025 Y98.975 E2.28938 ; small perimeter
G1 X101.025 Y101.025 E2.35281 ; small perimeter
G1 X101.650 Y101.650 F7800.000 ; move to first external small perimeter point
G1 F1800.000
G1 X98.350 Y101.650 E2.45492 ; external small perimeter
G1 X98.350 Y98.350 E2.55703 ; external small perimeter
G1 X101.650 Y98.350 E2.65913 ; external small perimeter
G1 X101.650 Y101.650 E2.76124 ; external small perimeter
G1 X101.167 Y101.521 F7800.000 ; move inwards before travel
G1 Z0.350 F7800.000 ; move to next layer (1)
G1 Z0.650 F7800.000 ; move to next layer (2)
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X99.471 Y100.529 E2.78977 ; small perimeter
G1 X99.471 Y99.471 E2.81830 ; small perimeter
G1 X100.529 Y99.471 E2.84682 ; small perimeter
G1 X100.529 Y100.529 E2.87535 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X98.836 Y101.164 E2.93817 ; small perimeter
G1 X98.836 Y98.836 E3.00100 ; small perimeter
G1 X101.164 Y98.836 E3.06382 ; small perimeter
G1 X101.164 Y101.164 E3.12664 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F600.000
G1 X98.275 Y101.725 E3.19775 ; external small perimeter
G1 X98.275 Y98.275 E3.26885 ; external small perimeter
G1 X101.725 Y98.275 E3.33996 ; external small perimeter
G1 X101.725 Y101.725 E3.41106 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z0.950 F7800.000 ; move to next layer (3)
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X99.471 Y100.529 E3.43959 ; small perimeter
G1 X99.471 Y99.471 E3.46812 ; small perimeter
G1 X100.529 Y99.471 E3.49665 ; small perimeter
G1 X100.529 Y100.529 E3.52518 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X98.836 Y101.164 E3.58800 ; small perimeter
G1 X98.836 Y98.836 E3.65082 ; small perimeter
G1 X101.164 Y98.836 E3.71364 ; small perimeter
G1 X101.164 Y101.164 E3.77646 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F600.000
G1 X98.275 Y101.725 E3.84757 ; external small perimeter
G1 X98.275 Y98.275 E3.91868 ; external small perimeter
G1 X101.725 Y98.275 E3.98978 ; external small perimeter
G1 X101.725 Y101.725 E4.06089 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
M106 S255 ; enable fan
G1 Z1.250 F7800.000 ; move to next layer (4)
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X99.471 Y100.529 E4.08941 ; small perimeter
G1 X99.471 Y99.471 E4.11794 ; small perimeter
G1 X100.529 Y99.471 E4.14647 ; small perimeter
G1 X100.529 Y100.529 E4.17500 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X98.836 Y101.164 E4.23782 ; small perimeter
G1 X98.836 Y98.836 E4.30064 ; small perimeter
G1 X101.164 Y98.836 E4.36347 ; small perimeter
G1 X101.164 Y101.164 E4.42629 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F600.000
G1 X98.275 Y101.725 E4.49739 ; external small perimeter
G1 X98.275 Y98.275 E4.56850 ; external small perimeter
G1 X101.725 Y98.275 E4.63960 ; external small perimeter
G1 X101.725 Y101.725 E4.71071 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z1.550 F7800.000 ; move to next layer (5)
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X99.471 Y100.529 E4.73924 ; small perimeter
G1 X99.471 Y99.471 E4.76777 ; small perimeter
G1 X100.529 Y99.471 E4.79630 ; small perimeter
G1 X100.529 Y100.529 E4.82482 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X98.836 Y101.164 E4.88765 ; small perimeter
G1 X98.836 Y98.836 E4.95047 ; small perimeter
G1 X101.164 Y98.836 E5.01329 ; small perimeter
G1 X101.164 Y101.164 E5.07611 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F600.000
G1 X98.275 Y101.725 E5.14722 ; external small perimeter
G1 X98.275 Y98.275 E5.21832 ; external small perimeter
G1 X101.725 Y98.275 E5.28943 ; external small perimeter
G1 X101.725 Y101.725 E5.36053 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z1.850 F7800.000 ; move to next layer (6)
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X99.471 Y100.529 E5.38906 ; small perimeter
G1 X99.471 Y99.471 E5.41759 ; small perimeter
G1 X100.529 Y99.471 E5.44612 ; small perimeter
G1 X100.529 Y100.529 E5.47465 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X98.836 Y101.164 E5.53747 ; small perimeter
G1 X98.836 Y98.836 E5.60029 ; small perimeter
G1 X101.164 Y98.836 E5.66311 ; small perimeter
G1 X101.164 Y101.164 E5.72593 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F600.000
G1 X98.275 Y101.725 E5.79704 ; external small perimeter
G1 X98.275 Y98.275 E5.86815 ; external small perimeter
G1 X101.725 Y98.275 E5.93925 ; external small perimeter
G1 X101.725 Y101.725 E6.01036 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z2.150 F7800.000 ; move to next layer (7)
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X99.471 Y100.529 E6.03889 ; small perimeter
G1 X99.471 Y99.471 E6.06741 ; small perimeter
G1 X100.529 Y99.471 E6.09594 ; small perimeter
G1 X100.529 Y100.529 E6.12447 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X98.836 Y101.164 E6.18729 ; small perimeter
G1 X98.836 Y98.836 E6.25011 ; small perimeter
G1 X101.164 Y98.836 E6.31294 ; small perimeter
G1 X101.164 Y101.164 E6.37576 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F600.000
G1 X98.275 Y101.725 E6.44686 ; external small perimeter
G1 X98.275 Y98.275 E6.51797 ; external small perimeter
G1 X101.725 Y98.275 E6.58907 ; external small perimeter
G1 X101.725 Y101.725 E6.66018 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z2.450 F7800.000 ; move to next layer (8)
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X99.471 Y100.529 E6.68871 ; small perimeter
G1 X99.471 Y99.471 E6.71724 ; small perimeter
G1 X100.529 Y99.471 E6.74577 ; small perimeter
G1 X100.529 Y100.529 E6.77429 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X98.836 Y101.164 E6.83712 ; small perimeter
G1 X98.836 Y98.836 E6.89994 ; small perimeter
G1 X101.164 Y98.836 E6.96276 ; small perimeter
G1 X101.164 Y101.164 E7.02558 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F600.000
G1 X98.275 Y101.725 E7.09669 ; external small perimeter
G1 X98.275 Y98.275 E7.16779 ; external small perimeter
G1 X101.725 Y98.275 E7.23890 ; external small perimeter
G1 X101.725 Y101.725 E7.31000 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z2.750 F7800.000 ; move to next layer (9)
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X99.471 Y100.529 E7.33853 ; small perimeter
G1 X99.471 Y99.471 E7.36706 ; small perimeter
G1 X100.529 Y99.471 E7.39559 ; small perimeter
G1 X100.529 Y100.529 E7.42412 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X98.836 Y101.164 E7.48694 ; small perimeter
G1 X98.836 Y98.836 E7.54976 ; small perimeter
G1 X101.164 Y98.836 E7.61258 ; small perimeter
G1 X101.164 Y101.164 E7.67541 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F600.000
G1 X98.275 Y101.725 E7.74651 ; external small perimeter
G1 X98.275 Y98.275 E7.81762 ; external small perimeter
G1 X101.725 Y98.275 E7.88872 ; external small perimeter
G1 X101.725 Y101.725 E7.95983 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z3.050 F7800.000 ; move to next layer (10)
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X99.471 Y100.529 E7.98836 ; small perimeter
G1 X99.471 Y99.471 E8.01688 ; small perimeter
G1 X100.529 Y99.471 E8.04541 ; small perimeter
G1 X100.529 Y100.529 E8.07394 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X98.836 Y101.164 E8.13676 ; small perimeter
G1 X98.836 Y98.836 E8.19958 ; small perimeter
G1 X101.164 Y98.836 E8.26241 ; small perimeter
G1 X101.164 Y101.164 E8.32523 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F600.000
G1 X98.275 Y101.725 E8.39633 ; external small perimeter
G1 X98.275 Y98.275 E8.46744 ; external small perimeter
G1 X101.725 Y98.275 E8.53855 ; external small perimeter
G1 X101.725 Y101.725 E8.60965 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z3.350 F7800.000 ; move to next layer (11)
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X99.471 Y100.529 E8.63818 ; small perimeter
G1 X99.471 Y99.471 E8.66671 ; small perimeter
G1 X100.529 Y99.471 E8.69524 ; small perimeter
G1 X100.529 Y100.529 E8.72376 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X98.836 Y101.164 E8.78659 ; small perimeter
G1 X98.836 Y98.836 E8.84941 ; small perimeter
G1 X101.164 Y98.836 E8.91223 ; small perimeter
G1 X101.164 Y101.164 E8.97505 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F600.000
G1 X98.275 Y101.725 E9.04616 ; external small perimeter
G1 X98.275 Y98.275 E9.11726 ; external small perimeter
G1 X101.725 Y98.275 E9.18837 ; external small perimeter
G1 X101.725 Y101.725 E9.25947 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z3.650 F7800.000 ; move to next layer (12)
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X99.471 Y100.529 E9.28800 ; small perimeter
G1 X99.471 Y99.471 E9.31653 ; small perimeter
G1 X100.529 Y99.471 E9.34506 ; small perimeter
G1 X100.529 Y100.529 E9.37359 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X98.836 Y101.164 E9.43641 ; small perimeter
G1 X98.836 Y98.836 E9.49923 ; small perimeter
G1 X101.164 Y98.836 E9.56205 ; small perimeter
G1 X101.164 Y101.164 E9.62488 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F600.000
G1 X98.275 Y101.725 E9.69598 ; external small perimeter
G1 X98.275 Y98.275 E9.76709 ; external small perimeter
G1 X101.725 Y98.275 E9.83819 ; external small perimeter
G1 X101.725 Y101.725 E9.90930 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z3.950 F7800.000 ; move to next layer (13)
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X99.471 Y100.529 E9.93783 ; small perimeter
G1 X99.471 Y99.471 E9.96635 ; small perimeter
G1 X100.529 Y99.471 E9.99488 ; small perimeter
G1 X100.529 Y100.529 E10.02341 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X98.836 Y101.164 E10.08623 ; small perimeter
G1 X98.836 Y98.836 E10.14906 ; small perimeter
G1 X101.164 Y98.836 E10.21188 ; small perimeter
G1 X101.164 Y101.164 E10.27470 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F600.000
G1 X98.275 Y101.725 E10.34580 ; external small perimeter
G1 X98.275 Y98.275 E10.41691 ; external small perimeter
G1 X101.725 Y98.275 E10.48802 ; external small perimeter
G1 X101.725 Y101.725 E10.55912 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z4.250 F7800.000 ; move to next layer (14)
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X99.471 Y100.529 E10.58765 ; small perimeter
G1 X99.471 Y99.471 E10.61618 ; small perimeter
G1 X100.529 Y99.471 E10.64471 ; small perimeter
G1 X100.529 Y100.529 E10.67324 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X98.836 Y101.164 E10.73606 ; small perimeter
G1 X98.836 Y98.836 E10.79888 ; small perimeter
G1 X101.164 Y98.836 E10.86170 ; small perimeter
G1 X101.164 Y101.164 E10.92452 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F600.000
G1 X98.275 Y101.725 E10.99563 ; external small perimeter
G1 X98.275 Y98.275 E11.06673 ; external small perimeter
G1 X101.725 Y98.275 E11.13784 ; external small perimeter
G1 X101.725 Y101.725 E11.20895 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z4.550 F7800.000 ; move to next layer (15)
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X99.471 Y100.529 E11.23747 ; small perimeter
G1 X99.471 Y99.471 E11.26600 ; small perimeter
G1 X100.529 Y99.471 E11.29453 ; small perimeter
G1 X100.529 Y100.529 E11.32306 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X98.836 Y101.164 E11.38588 ; small perimeter
G1 X98.836 Y98.836 E11.44870 ; small perimeter
G1 X101.164 Y98.836 E11.51152 ; small perimeter
G1 X101.164 Y101.164 E11.57435 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F600.000
G1 X98.275 Y101.725 E11.64545 ; external small perimeter
G1 X98.275 Y98.275 E11.71656 ; external small perimeter
G1 X101.725 Y98.275 E11.78766 ; external small perimeter
G1 X101.725 Y101.725 E11.85877 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z4.850 F7800.000 ; move to next layer (16)
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X99.471 Y100.529 E11.88730 ; small perimeter
G1 X99.471 Y99.471 E11.91583 ; small perimeter
G1 X100.529 Y99.471 E11.94435 ; small perimeter
G1 X100.529 Y100.529 E11.97288 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X98.836 Y101.164 E12.03570 ; small perimeter
G1 X98.836 Y98.836 E12.09853 ; small perimeter
G1 X101.164 Y98.836 E12.16135 ; small perimeter
G1 X101.164 Y101.164 E12.22417 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F600.000
G1 X98.275 Y101.725 E12.29528 ; external small perimeter
G1 X98.275 Y98.275 E12.36638 ; external small perimeter
G1 X101.725 Y98.275 E12.43749 ; external small perimeter
G1 X101.725 Y101.725 E12.50859 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z5.150 F7800.000 ; move to next layer (17)
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X99.471 Y100.529 E12.53712 ; small perimeter
G1 X99.471 Y99.471 E12.56565 ; small perimeter
G1 X100.529 Y99.471 E12.59418 ; small perimeter
G1 X100.529 Y100.529 E12.62271 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X98.836 Y101.164 E12.68553 ; small perimeter
G1 X98.836 Y98.836 E12.74835 ; small perimeter
G1 X101.164 Y98.836 E12.81117 ; small perimeter
G1 X101.164 Y101.164 E12.87399 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F600.000
G1 X98.275 Y101.725 E12.94510 ; external small perimeter
G1 X98.275 Y98.275 E13.01620 ; external small perimeter
G1 X101.725 Y98.275 E13.08731 ; external small perimeter
G1 X101.725 Y101.725 E13.15842 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z5.450 F7800.000 ; move to next layer (18)
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X99.471 Y100.529 E13.18694 ; small perimeter
G1 X99.471 Y99.471 E13.21547 ; small perimeter
G1 X100.529 Y99.471 E13.24400 ; small perimeter
G1 X100.529 Y100.529 E13.27253 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X98.836 Y101.164 E13.33535 ; small perimeter
G1 X98.836 Y98.836 E13.39817 ; small perimeter
G1 X101.164 Y98.836 E13.46099 ; small perimeter
G1 X101.164 Y101.164 E13.52382 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F600.000
G1 X98.275 Y101.725 E13.59492 ; external small perimeter
G1 X98.275 Y98.275 E13.66603 ; external small perimeter
G1 X101.725 Y98.275 E13.73713 ; external small perimeter
G1 X101.725 Y101.725 E13.80824 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z5.750 F7800.000 ; move to next layer (19)
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X99.471 Y100.529 E13.83677 ; small perimeter
G1 X99.471 Y99.471 E13.86530 ; small perimeter
G1 X100.529 Y99.471 E13.89382 ; small perimeter
G1 X100.529 Y100.529 E13.92235 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X98.836 Y101.164 E13.98517 ; small perimeter
G1 X98.836 Y98.836 E14.04800 ; small perimeter
G1 X101.164 Y98.836 E14.11082 ; small perimeter
G1 X101.164 Y101.164 E14.17364 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F600.000
G1 X98.275 Y101.725 E14.24475 ; external small perimeter
G1 X98.275 Y98.275 E14.31585 ; external small perimeter
G1 X101.725 Y98.275 E14.38696 ; external small perimeter
G1 X101.725 Y101.725 E14.45806 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z6.050 F7800.000 ; move to next layer (20)
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X99.471 Y100.529 E14.48659 ; small perimeter
G1 X99.471 Y99.471 E14.51512 ; small perimeter
G1 X100.529 Y99.471 E14.54365 ; small perimeter
G1 X100.529 Y100.529 E14.57218 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X98.836 Y101.164 E14.63500 ; small perimeter
G1 X98.836 Y98.836 E14.69782 ; small perimeter
G1 X101.164 Y98.836 E14.76064 ; small perimeter
G1 X101.164 Y101.164 E14.82346 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F600.000
G1 X98.275 Y101.725 E14.89457 ; external small perimeter
G1 X98.275 Y98.275 E14.96568 ; external small perimeter
G1 X101.725 Y98.275 E15.03678 ; external small perimeter
G1 X101.725 Y101.725 E15.10789 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z6.350 F7800.000 ; move to next layer (21)
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X99.471 Y100.529 E15.13641 ; small perimeter
G1 X99.471 Y99.471 E15.16494 ; small perimeter
G1 X100.529 Y99.471 E15.19347 ; small perimeter
G1 X100.529 Y100.529 E15.22200 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X98.836 Y101.164 E15.28482 ; small perimeter
G1 X98.836 Y98.836 E15.34764 ; small perimeter
G1 X101.164 Y98.836 E15.41047 ; small perimeter
G1 X101.164 Y101.164 E15.47329 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F600.000
G1 X98.275 Y101.725 E15.54439 ; external small perimeter
G1 X98.275 Y98.275 E15.61550 ; external small perimeter
G1 X101.725 Y98.275 E15.68660 ; external small perimeter
G1 X101.725 Y101.725 E15.75771 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z6.650 F7800.000 ; move to next layer (22)
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X99.471 Y100.529 E15.78624 ; small perimeter
G1 X99.471 Y99.471 E15.81477 ; small perimeter
G1 X100.529 Y99.471 E15.84329 ; small perimeter
G1 X100.529 Y100.529 E15.87182 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X98.836 Y101.164 E15.93465 ; small perimeter
G1 X98.836 Y98.836 E15.99747 ; small perimeter
G1 X101.164 Y98.836 E16.06029 ; small perimeter
G1 X101.164 Y101.164 E16.12311 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F600.000
G1 X98.275 Y101.725 E16.19422 ; external small perimeter
G1 X98.275 Y98.275 E16.26532 ; external small perimeter
G1 X101.725 Y98.275 E16.33643 ; external small perimeter
G1 X101.725 Y101.725 E16.40753 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z6.950 F7800.000 ; move to next layer (23)
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X99.471 Y100.529 E16.43606 ; small perimeter
G1 X99.471 Y99.471 E16.46459 ; small perimeter
G1 X100.529 Y99.471 E16.49312 ; small perimeter
G1 X100.529 Y100.529 E16.52165 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X98.836 Y101.164 E16.58447 ; small perimeter
G1 X98.836 Y98.836 E16.64729 ; small perimeter
G1 X101.164 Y98.836 E16.71011 ; small perimeter
G1 X101.164 Y101.164 E16.77293 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F600.000
G1 X98.275 Y101.725 E16.84404 ; external small perimeter
G1 X98.275 Y98.275 E16.91515 ; external small perimeter
G1 X101.725 Y98.275 E16.98625 ; external small perimeter
G1 X101.725 Y101.725 E17.05736 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z7.250 F7800.000 ; move to next layer (24)
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X99.471 Y100.529 E17.08589 ; small perimeter
G1 X99.471 Y99.471 E17.11441 ; small perimeter
G1 X100.529 Y99.471 E17.14294 ; small perimeter
G1 X100.529 Y100.529 E17.17147 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X98.836 Y101.164 E17.23429 ; small perimeter
G1 X98.836 Y98.836 E17.29711 ; small perimeter
G1 X101.164 Y98.836 E17.35994 ; small perimeter
G1 X101.164 Y101.164 E17.42276 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F600.000
G1 X98.275 Y101.725 E17.49386 ; external small perimeter
G1 X98.275 Y98.275 E17.56497 ; external small perimeter
G1 X101.725 Y98.275 E17.63607 ; external small perimeter
G1 X101.725 Y101.725 E17.70718 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z7.550 F7800.000 ; move to next layer (25)
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X99.471 Y100.529 E17.73571 ; small perimeter
G1 X99.471 Y99.471 E17.76424 ; small perimeter
G1 X100.529 Y99.471 E17.79277 ; small perimeter
G1 X100.529 Y100.529 E17.82129 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X98.836 Y101.164 E17.88412 ; small perimeter
G1 X98.836 Y98.836 E17.94694 ; small perimeter
G1 X101.164 Y98.836 E18.00976 ; small perimeter
G1 X101.164 Y101.164 E18.07258 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F600.000
G1 X98.275 Y101.725 E18.14369 ; external small perimeter
G1 X98.275 Y98.275 E18.21479 ; external small perimeter
G1 X101.725 Y98.275 E18.28590 ; external small perimeter
G1 X101.725 Y101.725 E18.35700 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z7.850 F7800.000 ; move to next layer (26)
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X99.471 Y100.529 E18.38553 ; small perimeter
G1 X99.471 Y99.471 E18.41406 ; small perimeter
G1 X100.529 Y99.471 E18.44259 ; small perimeter
G1 X100.529 Y100.529 E18.47112 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X98.836 Y101.164 E18.53394 ; small perimeter
G1 X98.836 Y98.836 E18.59676 ; small perimeter
G1 X101.164 Y98.836 E18.65958 ; small perimeter
G1 X101.164 Y101.164 E18.72240 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F600.000
G1 X98.275 Y101.725 E18.79351 ; external small perimeter
G1 X98.275 Y98.275 E18.86462 ; external small perimeter
G1 X101.725 Y98.275 E18.93572 ; external small perimeter
G1 X101.725 Y101.725 E19.00683 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z8.150 F7800.000 ; move to next layer (27)
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X99.471 Y100.529 E19.03536 ; small perimeter
G1 X99.471 Y99.471 E19.06388 ; small perimeter
G1 X100.529 Y99.471 E19.09241 ; small perimeter
G1 X100.529 Y100.529 E19.12094 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X98.836 Y101.164 E19.18376 ; small perimeter
G1 X98.836 Y98.836 E19.24658 ; small perimeter
G1 X101.164 Y98.836 E19.30941 ; small perimeter
G1 X101.164 Y101.164 E19.37223 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F600.000
G1 X98.275 Y101.725 E19.44333 ; external small perimeter
G1 X98.275 Y98.275 E19.51444 ; external small perimeter
G1 X101.725 Y98.275 E19.58555 ; external small perimeter
G1 X101.725 Y101.725 E19.65665 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z8.450 F7800.000 ; move to next layer (28)
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X99.471 Y100.529 E19.68518 ; small perimeter
G1 X99.471 Y99.471 E19.71371 ; small perimeter
G1 X100.529 Y99.471 E19.74224 ; small perimeter
G1 X100.529 Y100.529 E19.77076 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X98.836 Y101.164 E19.83359 ; small perimeter
G1 X98.836 Y98.836 E19.89641 ; small perimeter
G1 X101.164 Y98.836 E19.95923 ; small perimeter
G1 X101.164 Y101.164 E20.02205 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F600.000
G1 X98.275 Y101.725 E20.09316 ; external small perimeter
G1 X98.275 Y98.275 E20.16426 ; external small perimeter
G1 X101.725 Y98.275 E20.23537 ; external small perimeter
G1 X101.725 Y101.725 E20.30647 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z8.750 F7800.000 ; move to next layer (29)
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X99.471 Y100.529 E20.33500 ; small perimeter
G1 X99.471 Y99.471 E20.36353 ; small perimeter
G1 X100.529 Y99.471 E20.39206 ; small perimeter
G1 X100.529 Y100.529 E20.42059 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X98.836 Y101.164 E20.48341 ; small perimeter
G1 X98.836 Y98.836 E20.54623 ; small perimeter
G1 X101.164 Y98.836 E20.60905 ; small perimeter
G1 X101.164 Y101.164 E20.67188 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F600.000
G1 X98.275 Y101.725 E20.74298 ; external small perimeter
G1 X98.275 Y98.275 E20.81409 ; external small perimeter
G1 X101.725 Y98.275 E20.88519 ; external small perimeter
G1 X101.725 Y101.725 E20.95630 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z9.050 F7800.000 ; move to next layer (30)
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X99.471 Y100.529 E20.98483 ; small perimeter
G1 X99.471 Y99.471 E21.01335 ; small perimeter
G1 X100.529 Y99.471 E21.04188 ; small perimeter
G1 X100.529 Y100.529 E21.07041 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X98.836 Y101.164 E21.13323 ; small perimeter
G1 X98.836 Y98.836 E21.19606 ; small perimeter
G1 X101.164 Y98.836 E21.25888 ; small perimeter
G1 X101.164 Y101.164 E21.32170 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F600.000
G1 X98.275 Y101.725 E21.39280 ; external small perimeter
G1 X98.275 Y98.275 E21.46391 ; external small perimeter
G1 X101.725 Y98.275 E21.53502 ; external small perimeter
G1 X101.725 Y101.725 E21.60612 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z9.350 F7800.000 ; move to next layer (31)
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X99.471 Y100.529 E21.63465 ; small perimeter
G1 X99.471 Y99.471 E21.66318 ; small perimeter
G1 X100.529 Y99.471 E21.69171 ; small perimeter
G1 X100.529 Y100.529 E21.72023 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X98.836 Y101.164 E21.78306 ; small perimeter
G1 X98.836 Y98.836 E21.84588 ; small perimeter
G1 X101.164 Y98.836 E21.90870 ; small perimeter
G1 X101.164 Y101.164 E21.97152 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F600.000
G1 X98.275 Y101.725 E22.04263 ; external small perimeter
G1 X98.275 Y98.275 E22.11373 ; external small perimeter
G1 X101.725 Y98.275 E22.18484 ; external small perimeter
G1 X101.725 Y101.725 E22.25595 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z9.650 F7800.000 ; move to next layer (32)
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X99.471 Y100.529 E22.28447 ; small perimeter
G1 X99.471 Y99.471 E22.31300 ; small perimeter
G1 X100.529 Y99.471 E22.34153 ; small perimeter
G1 X100.529 Y100.529 E22.37006 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X98.836 Y101.164 E22.43288 ; small perimeter
G1 X98.836 Y98.836 E22.49570 ; small perimeter
G1 X101.164 Y98.836 E22.55852 ; small perimeter
G1 X101.164 Y101.164 E22.62135 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F600.000
G1 X98.275 Y101.725 E22.69245 ; external small perimeter
G1 X98.275 Y98.275 E22.76356 ; external small perimeter
G1 X101.725 Y98.275 E22.83466 ; external small perimeter
G1 X101.725 Y101.725 E22.90577 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
G1 Z9.950 F7800.000 ; move to next layer (33)
G1 X100.529 Y100.529 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X99.471 Y100.529 E22.93430 ; small perimeter
G1 X99.471 Y99.471 E22.96283 ; small perimeter
G1 X100.529 Y99.471 E22.99135 ; small perimeter
G1 X100.529 Y100.529 E23.01988 ; small perimeter
G1 X101.164 Y101.164 F7800.000 ; move to first small perimeter point
G1 F600.000
G1 X98.836 Y101.164 E23.08270 ; small perimeter
G1 X98.836 Y98.836 E23.14553 ; small perimeter
G1 X101.164 Y98.836 E23.20835 ; small perimeter
G1 X101.164 Y101.164 E23.27117 ; small perimeter
G1 X101.725 Y101.725 F7800.000 ; move to first external small perimeter point
G1 F600.000
G1 X98.275 Y101.725 E23.34228 ; external small perimeter
G1 X98.275 Y98.275 E23.41338 ; external small perimeter
G1 X101.725 Y98.275 E23.48449 ; external small perimeter
G1 X101.725 Y101.725 E23.55559 ; external small perimeter
G1 X101.242 Y101.596 F7800.000 ; move inwards before travel
M106 S232.05 ; enable fan
G1 Z10.250 F7800.000 ; move to next layer (34)
G1 E21.55559 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X108.529 Y108.529 F7800.000 ; move to first perimeter (bridge) point
G1 E2.00000 F2400.00000 ; unretract extruder 0
M106 S255 ; enable fan

G1 F3600.000
G1 X91.471 Y108.529 E2.47382 ; perimeter (bridge)
G1 X91.471 Y91.471 E2.94764 ; perimeter (bridge)
G1 X108.529 Y91.471 E3.42146 ; perimeter (bridge)
G1 X108.529 Y108.529 E3.89528 ; perimeter (bridge)
M106 S232.05 ; enable fan

G1 X109.164 Y109.164 F7800.000 ; move to first perimeter (bridge) point
M106 S255 ; enable fan

G1 F3600.000
G1 X90.836 Y109.164 E4.40441 ; perimeter (bridge)
G1 X90.836 Y90.836 E4.91355 ; perimeter (bridge)
G1 X109.164 Y90.836 E5.42268 ; perimeter (bridge)
G1 X109.164 Y109.164 E5.93181 ; perimeter (bridge)
M106 S232.05 ; enable fan

G1 X109.725 Y109.725 F7800.000 ; move to first perimeter (bridge) point
M106 S255 ; enable fan

G1 F3600.000
G1 X90.275 Y109.725 E6.47209 ; perimeter (bridge)
G1 X90.275 Y90.275 E7.01237 ; perimeter (bridge)
G1 X109.725 Y90.275 E7.55264 ; perimeter (bridge)
G1 X109.725 Y109.725 E8.09292 ; perimeter (bridge)
M106 S232.05 ; enable fan

G1 E6.09292 F2400.00000 ; retract extruder 0
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
G1 Z10.550 F7800.000 ; move to next layer (35)
G1 X108.529 Y108.529 F7800.000 ; move to first perimeter point
G1 F3600.000
G1 X91.471 Y108.529 E17.19068 ; perimeter
G1 X91.471 Y91.471 E17.65083 ; perimeter
G1 X108.529 Y91.471 E18.11098 ; perimeter
G1 X108.529 Y108.529 E18.57114 ; perimeter
G1 X109.164 Y109.164 F7800.000 ; move to first perimeter point
G1 F3600.000
G1 X90.836 Y109.164 E19.06558 ; perimeter
G1 X90.836 Y90.836 E19.56003 ; perimeter
G1 X109.164 Y90.836 E20.05448 ; perimeter
G1 X109.164 Y109.164 E20.54892 ; perimeter
G1 X109.725 Y109.725 F7800.000 ; move to first external perimeter point
G1 F1800.000
G1 X90.275 Y109.725 E20.94979 ; external perimeter
G1 X90.275 Y90.275 E21.35066 ; external perimeter
G1 X109.725 Y90.275 E21.75154 ; external perimeter
G1 X109.725 Y109.725 E22.15241 ; external perimeter
G1 X109.242 Y109.596 F7800.000 ; move inwards before travel
G1 X107.646 Y108.140 F7800.000 ; move to first infill point
G1 F1200.000
G1 X108.140 Y107.646 E22.17134 ; infill
G1 X108.140 Y106.744 E22.19576 ; infill
G1 X106.744 Y108.140 E22.24923 ; infill
G1 X105.842 Y108.140 E22.27365 ; infill
G1 X108.140 Y105.842 E22.36165 ; infill
G1 X108.140 Y104.940 E22.38607 ; infill
G1 X104.940 Y108.140 E22.50861 ; infill
G1 X104.038 Y108.140 E22.53303 ; infill
G1 X108.140 Y104.038 E22.69011 ; infill
G1 X108.140 Y103.135 E22.71453 ; infill
G1 X103.135 Y108.140 E22.90614 ; infill
G1 X102.233 Y108.140 E22.93056 ; infill
G1 X108.140 Y102.233 E23.15671 ; infill
G1 X108.140 Y101.331 E23.18113 ; infill
G1 X101.331 Y108.140 E23.44181 ; infill
G1 X100.429 Y108.140 E23.46623 ; infill
G1 X108.140 Y100.429 E23.76145 ; infill
G1 X108.140 Y99.527 E23.78587 ; infill
G1 X99.527 Y108.140 E24.11562 ; infill
G1 X98.625 Y108.140 E24.14004 ; infill
G1 X108.140 Y98.625 E24.50433 ; infill
G1 X108.140 Y97.723 E24.52875 ; infill
G1 X97.723 Y108.140 E24.92758 ; infill
G1 X96.821 Y108.140 E24.95200 ; infill
G1 X108.140 Y96.821 E25.38536 ; infill
G1 X108.140 Y95.919 E25.40978 ; infill
G1 X95.919 Y108.140 E25.87768 ; infill
G1 X95.017 Y108.140 E25.90210 ; infill
G1 X108.140 Y95.017 E26.40453 ; infill
G1 X108.140 Y94.115 E26.42895 ; infill
G1 X94.115 Y108.140 E26.96591 ; infill
G1 X93.213 Y108.140 E26.99033 ; infill
G1 X108.140 Y93.213 E27.56184 ; infill
G1 X108.140 Y92.311 E27.58626 ; infill
G1 X92.311 Y108.140 E28.19230 ; infill
G1 X91.860 Y108.140 E28.20451 ; infill
G1 X91.860 Y107.689 E28.21672 ; infill
G1 X107.689 Y91.860 E28.82276 ; infill
G1 X106.787 Y91.860 E28.84718 ; infill
G1 X91.860 Y106.787 E29.41868 ; infill
G1 X91.860 Y105.885 E29.44310 ; infill
G1 X105.885 Y91.860 E29.98007 ; infill
G1 X104.983 Y91.860 E30.00449 ; infill
G1 X91.860 Y104.983 E30.50692 ; infill
G1 X91.860 Y104.081 E30.53134 ; infill
G1 X104.081 Y91.860 E30.99924 ; infill
G1 X103.179 Y91.860 E31.02366 ; infill
G1 X91.860 Y103.179 E31.45702 ; infill
G1 X91.860 Y102.277 E31.48144 ; infill
G1 X102.277 Y91.860 E31.88026 ; infill
G1 X101.375 Y91.860 E31.90468 ; infill
G1 X91.860 Y101.375 E32.26897 ; infill
G1 X91.860 Y100.473 E32.29339 ; infill
G1 X100.473 Y91.860 E32.62315 ; infill
G1 X99.571 Y91.860 E32.64757 ; infill
G1 X91.860 Y99.571 E32.94279 ; infill
G1 X91.860 Y98.669 E32.96721 ; infill
G1 X98.669 Y91.860 E33.22789 ; infill
G1 X97.767 Y91.860 E33.25231 ; infill
G1 X91.860 Y97.767 E33.47846 ; infill
G1 X91.860 Y96.865 E33.50288 ; infill
G1 X96.865 Y91.860 E33.69449 ; infill
G1 X95.962 Y91.860 E33.71891 ; infill
G1 X91.860 Y95.962 E33.87598 ; infill
G1 X91.860 Y95.060 E33.90040 ; infill
G1 X95.060 Y91.860 E34.02295 ; infill
G1 X94.158 Y91.860 E34.04737 ; infill
G1 X91.860 Y94.158 E34.13537 ; infill
G1 X91.860 Y93.256 E34.15979 ; infill
G1 X93.256 Y91.860 E34.21326 ; infill
G1 X92.354 Y91.860 E34.23768 ; infill
G1 X91.860 Y92.354 E34.25661 ; infill
G1 Z10.850 F7800.000 ; move to next layer (36)
G1 X108.529 Y108.529 F7800.000 ; move to first perimeter point
G1 F3600.000
G1 X91.471 Y108.529 E34.71676 ; perimeter
G1 X91.471 Y91.471 E35.17691 ; perimeter
G1 X108.529 Y91.471 E35.63707 ; perimeter
G1 X108.529 Y108.529 E36.09722 ; perimeter
G1 X109.164 Y109.164 F7800.000 ; move to first perimeter point
G1 F3600.000
G1 X90.836 Y109.164 E36.59167 ; perimeter
G1 X90.836 Y90.836 E37.08611 ; perimeter
G1 X109.164 Y90.836 E37.58056 ; perimeter
G1 X109.164 Y109.164 E38.07501 ; perimeter
G1 X109.725 Y109.725 F7800.000 ; move to first external perimeter point
G1 F1800.000
G1 X90.275 Y109.725 E38.47588 ; external perimeter
G1 X90.275 Y90.275 E38.87675 ; external perimeter
G1 X109.725 Y90.275 E39.27762 ; external perimeter
G1 X109.725 Y109.725 E39.67849 ; external perimeter
G1 X109.242 Y109.596 F7800.000 ; move inwards before travel
G1 X108.140 Y92.354 F7800.000 ; move to first infill point
G1 F1200.000
G1 X107.646 Y91.860 E39.69742 ; infill
G1 X106.744 Y91.860 E39.72184 ; infill
G1 X108.140 Y93.256 E39.77531 ; infill
G1 X108.140 Y94.158 E39.79973 ; infill
G1 X105.842 Y91.860 E39.88774 ; infill
G1 X104.940 Y91.860 E39.91216 ; infill
G1 X108.140 Y95.060 E40.03470 ; infill
G1 X108.140 Y95.962 E40.05912 ; infill
G1 X104.038 Y91.860 E40.21619 ; infill
G1 X103.135 Y91.860 E40.24061 ; infill
G1 X108.140 Y96.865 E40.43222 ; infill
G1 X108.140 Y97.767 E40.45664 ; infill
G1 X102.233 Y91.860 E40.68279 ; infill
G1 X101.331 Y91.860 E40.70721 ; infill
G1 X108.140 Y98.669 E40.96789 ; infill
G1 X108.140 Y99.571 E40.99231 ; infill
G1 X100.429 Y91.860 E41.28753 ; infill
G1 X99.527 Y91.860 E41.31195 ; infill
G1 X108.140 Y100.473 E41.64171 ; infill
G1 X108.140 Y101.375 E41.66613 ; infill
G1 X98.625 Y91.860 E42.03042 ; infill
G1 X97.723 Y91.860 E42.05484 ; infill
G1 X108.140 Y102.277 E42.45366 ; infill
G1 X108.140 Y103.179 E42.47808 ; infill
G1 X96.821 Y91.860 E42.91144 ; infill
G1 X95.919 Y91.860 E42.93586 ; infill
G1 X108.140 Y104.081 E43.40376 ; infill
G1 X108.140 Y104.983 E43.42818 ; infill
G1 X95.017 Y91.860 E43.93061 ; infill
G1 X94.115 Y91.860 E43.95503 ; infill
G1 X108.140 Y105.885 E44.49200 ; infill
G1 X108.140 Y106.787 E44.51642 ; infill
G1 X93.213 Y91.860 E45.08792 ; infill
G1 X92.311 Y91.860 E45.11234 ; infill
G1 X108.140 Y107.689 E45.71838 ; infill
G1 X108.140 Y108.140 E45.73059 ; infill
G1 X107.689 Y108.140 E45.74280 ; infill
G1 X91.860 Y92.311 E46.34884 ; infill
G1 X91.860 Y93.213 E46.37326 ; infill
G1 X106.787 Y108.140 E46.94476 ; infill
G1 X105.885 Y108.140 E46.96918 ; infill
G1 X91.860 Y94.115 E47.50615 ; infill
G1 X91.860 Y95.017 E47.53057 ; infill
G1 X104.983 Y108.140 E48.03300 ; infill
G1 X104.081 Y108.140 E48.05742 ; infill
G1 X91.860 Y95.919 E48.52532 ; infill
G1 X91.860 Y96.821 E48.54974 ; infill
G1 X103.179 Y108.140 E48.98310 ; infill
G1 X102.277 Y108.140 E49.00752 ; infill
G1 X91.860 Y97.723 E49.40635 ; infill
G1 X91.860 Y98.625 E49.43077 ; infill
G1 X101.375 Y108.140 E49.79506 ; infill
G1 X100.473 Y108.140 E49.81948 ; infill
G1 X91.860 Y99.527 E50.14923 ; infill
G1 X91.860 Y100.429 E50.17365 ; infill
G1 X99.571 Y108.140 E50.46887 ; infill
G1 X98.669 Y108.140 E50.49329 ; infill
G1 X91.860 Y101.331 E50.75397 ; infill
G1 X91.860 Y102.233 E50.77839 ; infill
G1 X97.767 Y108.140 E51.00454 ; infill
G1 X96.865 Y108.140 E51.02896 ; infill
G1 X91.860 Y103.135 E51.22057 ; infill
G1 X91.860 Y104.038 E51.24499 ; infill
G1 X95.962 Y108.140 E51.40207 ; infill
G1 X95.060 Y108.140 E51.42649 ; infill
G1 X91.860 Y104.940 E51.54903 ; infill
G1 X91.860 Y105.842 E51.57345 ; infill
G1 X94.158 Y108.140 E51.66145 ; infill
G1 X93.256 Y108.140 E51.68587 ; infill
G1 X91.860 Y106.744 E51.73934 ; infill
G1 X91.860 Y107.646 E51.76376 ; infill
G1 X92.354 Y108.140 E51.78269 ; infill
M106 S249.9 ; enable fan
G1 Z11.150 F7800.000 ; move to next layer (37)
G1 X108.529 Y108.529 F7800.000 ; move to first perimeter point
G1 F3600.000
G1 X91.471 Y108.529 E52.24285 ; perimeter
G1 X91.471 Y91.471 E52.70300 ; perimeter
G1 X108.529 Y91.471 E53.16315 ; perimeter
G1 X108.529 Y108.529 E53.62330 ; perimeter
G1 X109.164 Y109.164 F7800.000 ; move to first perimeter point
G1 F3600.000
G1 X90.836 Y109.164 E54.11775 ; perimeter
G1 X90.836 Y90.836 E54.61220 ; perimeter
G1 X109.164 Y90.836 E55.10664 ; perimeter
G1 X109.164 Y109.164 E55.60109 ; perimeter
G1 X109.725 Y109.725 F7800.000 ; move to first external perimeter point
G1 F1800.000
G1 X90.275 Y109.725 E56.00196 ; external perimeter
G1 X90.275 Y90.275 E56.40283 ; external perimeter
G1 X109.725 Y90.275 E56.80370 ; external perimeter
G1 X109.725 Y109.725 E57.20457 ; external perimeter
G1 X109.242 Y109.596 F7800.000 ; move inwards before travel
G1 X106.496 Y108.248 F7800.000 ; move to first infill point
G1 F4800.000
G1 X108.016 Y102.576 E57.34431 ; infill
G1 X108.248 Y102.143 F7800.000 ; move to first infill point
G1 F4800.000
G1 X91.752 Y106.563 E57.75067 ; infill
G1 X91.837 Y103.729 F7800.000 ; move to first infill point
G1 F4800.000
G1 X96.271 Y108.163 E57.89987 ; infill
G1 X108.163 Y108.163 E58.18284 ; infill
G1 X91.837 Y91.837 E58.73221 ; infill
G1 X103.729 Y91.837 E59.01517 ; infill
G1 X108.163 Y96.271 E59.16437 ; infill
G1 X108.248 Y93.437 F7800.000 ; move to first infill point
G1 F4800.000
G1 X91.752 Y97.857 E59.57073 ; infill
G1 X91.984 Y97.424 F7800.000 ; move to first infill point
G1 F4800.000
G1 X93.504 Y91.752 E59.71047 ; infill
G1 X102.210 Y91.752 F7800.000 ; move to first infill point
G1 F4800.000
G1 X97.790 Y108.248 E60.11683 ; infill
M106 S229.5 ; enable fan
G1 Z11.450 F7800.000 ; move to next layer (38)
G1 X108.529 Y108.529 F7800.000 ; move to first perimeter point
G1 F3600.000
G1 X91.471 Y108.529 E60.57698 ; perimeter
G1 X91.471 Y91.471 E61.03714 ; perimeter
G1 X108.529 Y91.471 E61.49729 ; perimeter
G1 X108.529 Y108.529 E61.95744 ; perimeter
G1 X109.164 Y109.164 F7800.000 ; move to first perimeter point
G1 F3600.000
G1 X90.836 Y109.164 E62.45189 ; perimeter
G1 X90.836 Y90.836 E62.94634 ; perimeter
G1 X109.164 Y90.836 E63.44078 ; perimeter
G1 X109.164 Y109.164 E63.93523 ; perimeter
G1 X109.725 Y109.725 F7800.000 ; move to first external perimeter point
G1 F1800.000
G1 X90.275 Y109.725 E64.33610 ; external perimeter
G1 X90.275 Y90.275 E64.73697 ; external perimeter
G1 X109.725 Y90.275 E65.13784 ; external perimeter
G1 X109.725 Y109.725 E65.53871 ; external perimeter
G1 X109.242 Y109.596 F7800.000 ; move inwards before travel
G1 X108.167 Y92.295 F7800.000 ; move to first infill (bridge) point
M106 S255 ; enable fan

G1 F3600.000
G1 X107.705 Y91.833 E65.55765 ; infill (bridge)
G1 X106.912 Y91.833 E65.58069 ; infill (bridge)
G1 X108.167 Y93.088 E65.63220 ; infill (bridge)
G1 X108.167 Y93.882 E65.65524 ; infill (bridge)
G1 X106.118 Y91.833 E65.73934 ; infill (bridge)
G1 X105.325 Y91.833 E65.76238 ; infill (bridge)
G1 X108.167 Y94.675 E65.87906 ; infill (bridge)
G1 X108.167 Y95.469 E65.90210 ; infill (bridge)
G1 X104.531 Y91.833 E66.05136 ; infill (bridge)
G1 X103.737 Y91.833 E66.07440 ; infill (bridge)
G1 X108.167 Y96.263 E66.25624 ; infill (bridge)
G1 X108.167 Y97.056 E66.27928 ; infill (bridge)
G1 X102.944 Y91.833 E66.49370 ; infill (bridge)
G1 X102.150 Y91.833 E66.51674 ; infill (bridge)
G1 X108.167 Y97.850 E66.76375 ; infill (bridge)
G1 X108.167 Y98.643 E66.78679 ; infill (bridge)
G1 X101.357 Y91.833 E67.06637 ; infill (bridge)
G1 X100.563 Y91.833 E67.08941 ; infill (bridge)
G1 X108.167 Y99.437 E67.40158 ; infill (bridge)
G1 X108.167 Y100.231 E67.42462 ; infill (bridge)
G1 X99.769 Y91.833 E67.76937 ; infill (bridge)
G1 X98.976 Y91.833 E67.79241 ; infill (bridge)
G1 X108.167 Y101.024 E68.16974 ; infill (bridge)
G1 X108.167 Y101.818 E68.19277 ; infill (bridge)
G1 X98.182 Y91.833 E68.60269 ; infill (bridge)
G1 X97.389 Y91.833 E68.62572 ; infill (bridge)
G1 X108.167 Y102.611 E69.06822 ; infill (bridge)
G1 X108.167 Y103.405 E69.09126 ; infill (bridge)
G1 X96.595 Y91.833 E69.56633 ; infill (bridge)
G1 X95.801 Y91.833 E69.58937 ; infill (bridge)
G1 X108.167 Y104.199 E70.09702 ; infill (bridge)
G1 X108.167 Y104.992 E70.12006 ; infill (bridge)
G1 X95.008 Y91.833 E70.66030 ; infill (bridge)
G1 X94.214 Y91.833 E70.68334 ; infill (bridge)
G1 X108.167 Y105.786 E71.25616 ; infill (bridge)
G1 X108.167 Y106.579 E71.27919 ; infill (bridge)
G1 X93.421 Y91.833 E71.88459 ; infill (bridge)
G1 X92.627 Y91.833 E71.90763 ; infill (bridge)
G1 X108.167 Y107.373 E72.54561 ; infill (bridge)
G1 X108.167 Y108.167 E72.56865 ; infill (bridge)
G1 X91.833 Y91.833 E73.23921 ; infill (bridge)
G1 X91.833 Y92.627 E73.26225 ; infill (bridge)
G1 X107.373 Y108.167 E73.90023 ; infill (bridge)
G1 X106.579 Y108.167 E73.92327 ; infill (bridge)
G1 X91.833 Y93.421 E74.52867 ; infill (bridge)
G1 X91.833 Y94.214 E74.55171 ; infill (bridge)
G1 X105.786 Y108.167 E75.12453 ; infill (bridge)
G1 X104.992 Y108.167 E75.14757 ; infill (bridge)
G1 X91.833 Y95.008 E75.68781 ; infill (bridge)
G1 X91.833 Y95.801 E75.71084 ; infill (bridge)
G1 X104.199 Y108.167 E76.21850 ; infill (bridge)
G1 X103.405 Y108.167 E76.24154 ; infill (bridge)
G1 X91.833 Y96.595 E76.71661 ; infill (bridge)
G1 X91.833 Y97.389 E76.73965 ; infill (bridge)
G1 X102.611 Y108.167 E77.18215 ; infill (bridge)
G1 X101.818 Y108.167 E77.20518 ; infill (bridge)
G1 X91.833 Y98.182 E77.61510 ; infill (bridge)
G1 X91.833 Y98.976 E77.63813 ; infill (bridge)
G1 X101.024 Y108.167 E78.01547 ; infill (bridge)
G1 X100.231 Y108.167 E78.03850 ; infill (bridge)
G1 X91.833 Y99.769 E78.38325 ; infill (bridge)
G1 X91.833 Y100.563 E78.40629 ; infill (bridge)
G1 X99.437 Y108.167 E78.71846 ; infill (bridge)
G1 X98.643 Y108.167 E78.74150 ; infill (bridge)
G1 X91.833 Y101.357 E79.02109 ; infill (bridge)
G1 X91.833 Y102.150 E79.04413 ; infill (bridge)
G1 X97.850 Y108.167 E79.29113 ; infill (bridge)
G1 X97.056 Y108.167 E79.31417 ; infill (bridge)
G1 X91.833 Y102.944 E79.52859 ; infill (bridge)
G1 X91.833 Y103.737 E79.55163 ; infill (bridge)
G1 X96.263 Y108.167 E79.73348 ; infill (bridge)
G1 X95.469 Y108.167 E79.75652 ; infill (bridge)
G1 X91.833 Y104.531 E79.90578 ; infill (bridge)
G1 X91.833 Y105.324 E79.92882 ; infill (bridge)
G1 X94.676 Y108.167 E80.04550 ; infill (bridge)
G1 X93.882 Y108.167 E80.06854 ; infill (bridge)
G1 X91.833 Y106.118 E80.15264 ; infill (bridge)
G1 X91.833 Y106.912 E80.17567 ; infill (bridge)
G1 X93.088 Y108.167 E80.22719 ; infill (bridge)
G1 X92.295 Y108.167 E80.25023 ; infill (bridge)
G1 X91.833 Y107.705 E80.26917 ; infill (bridge)
M106 S229.5 ; enable fan

M106 S186.15 ; enable fan
G1 Z11.750 F7800.000 ; move to next layer (39)
G1 X108.529 Y108.529 F7800.000 ; move to first perimeter point
G1 F3600.000
G1 X91.471 Y108.529 E80.72932 ; perimeter
G1 X91.471 Y91.471 E81.18947 ; perimeter
G1 X108.529 Y91.471 E81.64963 ; perimeter
G1 X108.529 Y108.529 E82.10978 ; perimeter
G1 X109.164 Y109.164 F7800.000 ; move to first perimeter point
G1 F3600.000
G1 X90.836 Y109.164 E82.60423 ; perimeter
G1 X90.836 Y90.836 E83.09867 ; perimeter
G1 X109.164 Y90.836 E83.59312 ; perimeter
G1 X109.164 Y109.164 E84.08756 ; perimeter
G1 X109.725 Y109.725 F7800.000 ; move to first external perimeter point
G1 F1800.000
G1 X90.275 Y109.725 E84.48844 ; external perimeter
G1 X90.275 Y90.275 E84.88931 ; external perimeter
G1 X109.725 Y90.275 E85.29018 ; external perimeter
G1 X109.725 Y109.725 E85.69105 ; external perimeter
G1 X109.242 Y109.596 F7800.000 ; move inwards before travel
G1 X107.646 Y108.140 F7800.000 ; move to first infill point
G1 F1200.000
G1 X108.140 Y107.646 E85.70998 ; infill
G1 X108.140 Y106.744 E85.73440 ; infill
G1 X106.744 Y108.140 E85.78787 ; infill
G1 X105.842 Y108.140 E85.81229 ; infill
G1 X108.140 Y105.842 E85.90030 ; infill
G1 X108.140 Y104.940 E85.92472 ; infill
G1 X104.940 Y108.140 E86.04726 ; infill
G1 X104.038 Y108.140 E86.07168 ; infill
G1 X108.140 Y104.038 E86.22875 ; infill
G1 X108.140 Y103.135 E86.25317 ; infill
G1 X103.135 Y108.140 E86.44478 ; infill
G1 X102.233 Y108.140 E86.46920 ; infill
G1 X108.140 Y102.233 E86.69535 ; infill
G1 X108.140 Y101.331 E86.71977 ; infill
G1 X101.331 Y108.140 E86.98045 ; infill
G1 X100.429 Y108.140 E87.00487 ; infill
G1 X108.140 Y100.429 E87.30009 ; infill
G1 X108.140 Y99.527 E87.32451 ; infill
G1 X99.527 Y108.140 E87.65427 ; infill
G1 X98.625 Y108.140 E87.67869 ; infill
G1 X108.140 Y98.625 E88.04298 ; infill
G1 X108.140 Y97.723 E88.06740 ; infill
G1 X97.723 Y108.140 E88.46622 ; infill
G1 X96.821 Y108.140 E88.49064 ; infill
G1 X108.140 Y96.821 E88.92400 ; infill
G1 X108.140 Y95.919 E88.94842 ; infill
G1 X95.919 Y108.140 E89.41632 ; infill
G1 X95.017 Y108.140 E89.44074 ; infill
G1 X108.140 Y95.017 E89.94317 ; infill
G1 X108.140 Y94.115 E89.96759 ; infill
G1 X94.115 Y108.140 E90.50456 ; infill
G1 X93.213 Y108.140 E90.52898 ; infill
G1 X108.140 Y93.213 E91.10048 ; infill
G1 X108.140 Y92.311 E91.12490 ; infill
G1 X92.311 Y108.140 E91.73094 ; infill
G1 X91.860 Y108.140 E91.74315 ; infill
G1 X91.860 Y107.689 E91.75536 ; infill
G1 X107.689 Y91.860 E92.36140 ; infill
G1 X106.787 Y91.860 E92.38582 ; infill
G1 X91.860 Y106.787 E92.95732 ; infill
G1 X91.860 Y105.885 E92.98174 ; infill
G1 X105.885 Y91.860 E93.51871 ; infill
G1 X104.983 Y91.860 E93.54313 ; infill
G1 X91.860 Y104.983 E94.04556 ; infill
G1 X91.860 Y104.081 E94.06998 ; infill
G1 X104.081 Y91.860 E94.53788 ; infill
G1 X103.179 Y91.860 E94.56230 ; infill
G1 X91.860 Y103.179 E94.99566 ; infill
G1 X91.860 Y102.277 E95.02008 ; infill
G1 X102.277 Y91.860 E95.41890 ; infill
G1 X101.375 Y91.860 E95.44332 ; infill
G1 X91.860 Y101.375 E95.80761 ; infill
G1 X91.860 Y100.473 E95.83203 ; infill
G1 X100.473 Y91.860 E96.16179 ; infill
G1 X99.571 Y91.860 E96.18621 ; infill
G1 X91.860 Y99.571 E96.48143 ; infill
G1 X91.860 Y98.669 E96.50585 ; infill
G1 X98.669 Y91.860 E96.76653 ; infill
G1 X97.767 Y91.860 E96.79095 ; infill
G1 X91.860 Y97.767 E97.01710 ; infill
G1 X91.860 Y96.865 E97.04152 ; infill
G1 X96.865 Y91.860 E97.23313 ; infill
G1 X95.962 Y91.860 E97.25755 ; infill
G1 X91.860 Y95.962 E97.41463 ; infill
G1 X91.860 Y95.060 E97.43905 ; infill
G1 X95.060 Y91.860 E97.56159 ; infill
G1 X94.158 Y91.860 E97.58601 ; infill
G1 X91.860 Y94.158 E97.67401 ; infill
G1 X91.860 Y93.256 E97.69843 ; infill
G1 X93.256 Y91.860 E97.75190 ; infill
G1 X92.354 Y91.860 E97.77632 ; infill
G1 X91.860 Y92.354 E97.79525 ; infill
M106 S163.2 ; enable fan
G1 Z12.050 F7800.000 ; move to next layer (40)
G1 E95.79525 F2400.00000 ; retract extruder 0
G92 E0 ; reset extrusion distance
G1 X108.529 Y108.529 F7800.000 ; move to first perimeter point
G1 E2.00000 F2400.00000 ; unretract extruder 0
G1 F3600.000
G1 X91.471 Y108.529 E2.46015 ; perimeter
G1 X91.471 Y91.471 E2.92031 ; perimeter
G1 X108.529 Y91.471 E3.38046 ; perimeter
G1 X108.529 Y108.529 E3.84061 ; perimeter
G1 X109.164 Y109.164 F7800.000 ; move to first perimeter point
G1 F3600.000
G1 X90.836 Y109.164 E4.33506 ; perimeter
G1 X90.836 Y90.836 E4.82950 ; perimeter
G1 X109.164 Y90.836 E5.32395 ; perimeter
G1 X109.164 Y109.164 E5.81840 ; perimeter
G1 X109.725 Y109.725 F7800.000 ; move to first external perimeter point
G1 F1800.000
G1 X90.275 Y109.725 E6.21927 ; external perimeter
G1 X90.275 Y90.275 E6.62014 ; external perimeter
G1 X109.725 Y90.275 E7.02101 ; external perimeter
G1 X109.725 Y109.725 E7.42188 ; external perimeter
G1 X109.242 Y109.596 F7800.000 ; move inwards before travel
G1 E5.42188 F2400.00000 ; retract extruder 0
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
; Filament-specific end gcode 
;END gcode for filament
M104 S0 ; turn off temperature
G28 X0  ; home X axis
M84     ; disable motors
; cog_x = 100.000166
; cog_y = 100.000075
; cog_z = 10.035037
; material used = 142.75mm (1.01142.75cm3)
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
; threads = 16
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
