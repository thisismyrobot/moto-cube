include <magicbox.scad>;

$fn = 100;

rotate([90, 0, 0]) side_with_servo_rear_mount();
translate([0, box_size + 10, 0]) rotate([-90, 0, 0]) side_with_servo_mount_slot();
translate([cam_outer_radius, -box_size/2 -cam_outer_radius/2 - 10, 0]) rotate([0, 180, 0]) cam();

rotate([0, 0, 180]) translate([10, 0, 0]) {
    rotate([90, 0, 0]) side_with_servo_rear_mount();
    translate([0, box_size + 10, 0]) rotate([-90, 0, 0]) side_with_servo_mount_slot();
    translate([cam_outer_radius, -box_size/2 -cam_outer_radius/2 - 10, 0]) rotate([0, 180, 0]) cam();
}
