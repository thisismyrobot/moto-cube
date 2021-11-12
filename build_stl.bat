echo include ^<magicbox.scad^>^; > temp.scad
echo $fn = 100^; box_size = 100^; rotate([0, 180, 0]) cam()^; >> temp.scad
"C:\Program Files\OpenSCAD\openscad.com" -o stls\cam.stl temp.scad

echo include ^<magicbox.scad^>^; > temp.scad
echo $fn = 100^; box_size = 100^; rotate([-90, 0, 0]) side_with_servo_mount_slot();^; >> temp.scad
"C:\Program Files\OpenSCAD\openscad.com" -o stls\side_with_servo_mount_slot.stl temp.scad

echo include ^<magicbox.scad^>^; > temp.scad
echo $fn = 100^; box_size = 100^; rotate([90, 0, 0]) side_with_servo_rear_mount()^; >> temp.scad
"C:\Program Files\OpenSCAD\openscad.com" -o stls\side_with_servo_rear_mount.stl temp.scad

del temp.scad
