include <servo.scad>;
include <magicbox.scad>;

$fn = 50;
$t = 0.48;

cam_rotation = $t < 0.5 ? $t * 180 : 180 - ($t * 180);

function separation_angle(d, r, c) =
    d < acos(r/c) ?
        -2 * atan((c * sin(90 - acos(r/c) + d) - r) / (r + sqrt(pow(c,2)- pow(c * sin(90 - acos(r/c) + d), 2))))
        :
        -2 * atan((c * sin(90 - acos(r/c) + d) - r) / (r - sqrt(pow(c,2)- pow(c * sin(90 - acos(r/c) + d), 2))));

box_angle = $t < 0.5 ? separation_angle(cam_rotation, cam_radius, cam_outer_radius) : 180; 

box(cam_rotation);
rotate([0, 180, -box_angle]) box(cam_rotation);