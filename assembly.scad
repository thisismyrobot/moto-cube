include <servo.scad>;
include <magicbox.scad>;

$fn = 50;

box_size = 100;

hinge1_cam_angle = 45;
hinge2_cam_angle = 25;

// Config A
//translate([-box_size/2, -box_size/2, 0]) hinge_pair(hinge1_cam_angle);

// Config B
//translate([-box_size/2, -box_size/2, 0]) hinge_pair(hinge1_cam_angle);
//rotate([0, 180, 0]) translate([-box_size/2, -box_size/2, 0]) hinge_pair(hinge2_cam_angle);

// Config C
translate([-box_size/2, -box_size/2, 0]) hinge_pair(hinge1_cam_angle);
rotate([180, -90, 0]) translate([-box_size/2, -box_size/2, 0]) hinge_pair(hinge2_cam_angle);

// Config D
//translate([-box_size/2, -box_size/2, 0]) hinge_pair(hinge1_cam_angle);
//rotate([0, 90, 0]) translate([-box_size/2, -box_size/2, 0]) hinge_pair(hinge2_cam_angle);
