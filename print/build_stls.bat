echo include ^<../magicbox.scad^>^; > cam.scad
echo $fn = 100^; box_size = 100^; rotate([0, 180, 0]) cam()^; >> cam.scad
"C:\Program Files\OpenSCAD\openscad.com" -o cam.stl cam.scad

echo include ^<../magicbox.scad^>^; > side_with_servo_mount_slot.scad
echo $fn = 100^; box_size = 100^; side_with_servo_mount_slot()^; >> side_with_servo_mount_slot.scad
"C:\Program Files\OpenSCAD\openscad.com" -o side_with_servo_mount_slot.stl side_with_servo_mount_slot.scad

echo include ^<../magicbox.scad^>^; > side_with_servo_rear_mount.scad
echo $fn = 100^; box_size = 100^; side_with_servo_rear_mount()^; >> side_with_servo_rear_mount.scad
"C:\Program Files\OpenSCAD\openscad.com" -o side_with_servo_rear_mount.stl side_with_servo_rear_mount.scad
