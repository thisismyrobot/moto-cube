include <magicbox.scad>;

$fn = 100;

rotate([90, 0, 0]) side();
translate([0, box_size + 10, 0]) rotate([90, 0, 0]) side_with_servo_mount_slot();
translate([cam_outer_radius, -box_size/2 -cam_outer_radius/2 - 10, 0]) cam();

mirror([1, 0, 0]) translate([10, 0, 0]) {
    rotate([90, 0, 0]) side();
    translate([0, box_size + 10, 0]) rotate([90, 0, 0]) side_with_servo_mount_slot();
    translate([cam_outer_radius, -box_size/2 -cam_outer_radius/2 - 10, 0]) cam();
}
