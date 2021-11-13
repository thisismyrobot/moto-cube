include <servo.scad>;
include <magicbox.scad>;

$fn = 10;

box_size = 100;

module single_hinge_box() {
    rotate([90, 0, 0]) translate([0, 0, -box_size/2]) side_with_servo_mount_slot();
    rotate([0, -90, 0]) translate([0, 0, -box_size/2]) {
        side_with_servo_rear_mount();
        rotate([0, 0, 0]) servo_with_cam(0);
    }
}

module double_close_hinge_box() {
    rotate([90, 0, 0]) translate([0, 0, -box_size/2]) side_with_servo_mount_slot();
    rotate([0, -90, 0]) translate([0, 0, -box_size/2]) {
        side_with_servo_rear_mount();
        rotate([0, 0, 0]) servo_with_cam(0);
        rotate([0, 0, 90]) servo_with_cam(0);
    }
    rotate([-90, 0, 0]) translate([0, 0, -box_size/2]) side_with_servo_mount_slot();
}

rotate([90, 0, 0]) {
    translate([-box_size, -box_size/2, 0]) {
        single_hinge_box();
        rotate([90, 0, 90]) translate([0, 0, -box_size/2]) side_with_servo_mount_slot();
        rotate([90, 0, 180]) translate([0, 0, -box_size/2]) side_with_servo_mount_slot();
    }

    translate([0, box_size/2, 0]) {
        rotate([180, 0, -90]) {
            double_close_hinge_box();
            rotate([0, 90, 0]) translate([0, 0, -box_size/2]) side_with_servo_mount_slot();
        }
    }

    translate([0, -box_size/2, box_size]) rotate([0, 90, 0]){
        single_hinge_box();
        rotate([90, 0, 90]) translate([0, 0, -box_size/2]) side_with_servo_mount_slot();
        rotate([90, 0, 180]) translate([0, 0, -box_size/2]) side_with_servo_mount_slot();
    }
}