include <servo.scad>;

$fn = 50;
$t = 0.2;

// For making holes.
slot_diff = 1;

// For spacing moving parts.
fit_gaps = 0.1;
motion_gaps = 0.5;

cam_axis_inset_from_wall_outside = servo_mountsOut + servo_gearholderInset;
cam_radius = cam_axis_inset_from_wall_outside;
cam_flat_length = 20;
cam_outer_radius = sqrt(pow(cam_radius, 2) + pow(cam_flat_length, 2));
cam_thickness = 3;

wall_thickness = 3;
box_size = (servo_totalHeight + wall_thickness + (cam_thickness / 2) - servo_armThickness) * 2;

cam_rotation = $t < 0.5 ? $t * 180 : 180 - ($t * 180);

module box(cam_angle) {
    height = box_size;
    difference() {
        translate([0, 0, -height/2]) color("silver") {
            cube([box_size, wall_thickness, height]);
            rotate([0, 0, 90]) translate([0, -wall_thickness, 0]) cube([box_size, wall_thickness, height]);
            cube([box_size, box_size, wall_thickness]);
        }
        union() {
            translate([cam_axis_inset_from_wall_outside, cam_axis_inset_from_wall_outside, -(cam_thickness/2 + motion_gaps)]) {
                cylinder(r=cam_outer_radius + motion_gaps, h=cam_thickness + (motion_gaps*2));
            }
            translate([-slot_diff, cam_axis_inset_from_wall_outside - (servo_width/2) - fit_gaps, -servo_mountsTop+servo_mountsThickness]) {
                cube([wall_thickness + slot_diff*2, servo_width + fit_gaps*2, servo_mountsThickness + fit_gaps*2]);
            }
        }
    }
    
    translate([cam_radius, cam_radius, -cam_thickness/2]) color("yellow") cam(cam_angle + 180);
    
    translate([cam_axis_inset_from_wall_outside, cam_axis_inset_from_wall_outside, -cam_thickness/2 + servo_armThickness]) sg90Servo(cam_angle);
}

module cam(camangle) {
    rotate([0, 0, -90]) {
        rotate([0, 0, camangle]) {
            hull() {
                cylinder(r=cam_radius, h=cam_thickness);
                difference() {   
                    cylinder(r=cam_outer_radius, h=cam_thickness);
                    union() {
                        rotate([0, 0, 90]) translate([0, -cam_flat_length, -slot_diff]) cube([cam_outer_radius * 2, cam_outer_radius * 2, cam_thickness * 2]);
                        rotate([0, 0, 90]) mirror([1, -1, 0]) translate([0, -cam_flat_length, -slot_diff]) cube([cam_outer_radius * 2, cam_outer_radius * 2, cam_thickness * 2]);
                    }
                }
            }
        }
    }
}

function separation_angle(d, r, c) =
    d < acos(r/c) ?
        -2 * atan((c * sin(90 - acos(r/c) + d) - r) / (r + sqrt(pow(c,2)- pow(c * sin(90 - acos(r/c) + d), 2))))
        :
        -2 * atan((c * sin(90 - acos(r/c) + d) - r) / (r - sqrt(pow(c,2)- pow(c * sin(90 - acos(r/c) + d), 2))));

box_angle = $t < 0.5 ? separation_angle(cam_rotation, cam_radius, cam_outer_radius) : 180; 

box(cam_rotation);
rotate([0, 180, -box_angle]) box(cam_rotation);