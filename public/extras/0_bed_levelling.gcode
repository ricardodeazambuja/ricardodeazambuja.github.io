;
; Bed leveling - "automatic"
; http://ricardodeazambuja.com

M104 S0  ; extruder heater off
M140 S0  ; heated bed heater off

G28  ; home all axes

M0 BED LEV. STARTED!  ; wait for user

G1 Z50 ; move to Z=50mm

M0 FIRST POSITION  ; wait for user

G1 X60 Y50

M0 Z=1.0mm ; wait for user

G0 Z1

M0 Z=0.5mm ; wait for user

G0 Z0.5

M0 Z=0.0mm ; wait for user

G0 Z0

M0

G1 Z50

M0 SECOND POSITION  ; wait for user

G1 X-60 Y50

M0 Z=1.0mm ; wait for user

G0 Z1

M0 Z=0.5mm ; wait for user

G0 Z0.5

M0 Z=0.0mm ; wait for user

G0 Z0

M0

G1 Z50

M0 THIRD POSITION  ; wait for user

G1 X0 Y-60

M0 Z=1.0mm ; wait for user

G0 Z1

M0 Z=0.5mm ; wait for user

G0 Z0.5

M0 Z=0.0mm ; wait for user

G0 Z0

M0

M0 BED LEV. FINISHED!  ; wait for user

M0 ricardodeazambuja.com :)

G28
