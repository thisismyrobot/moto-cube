include <servo.scad>;

// For making holes.
slot_diff = 1;

// For spacing moving parts.
fit_gaps = 0.1;
motion_gaps = 0.5;

cam_axis_inset_from_wall_outside = servo_mountsOut + servo_gearholderInset;
cam_radius = cam_axis_inset_from_wall_outside;
cam_flat_length = 20;
cam_outer_radius = sqrt(pow(cam_radius, 2) + pow(cam_flat_length, 2));
cam_thickness = 5;

wall_thickness = 3;
box_size = (servo_totalHeight + wall_thickness + (cam_thickness / 2) - servo_armThickness) * 2;

hinge_radius = 3;
hinge_gap = 0.2;
hinge_height = 10;
hinge_axis_sep = 10;

wire_slot_height = servo_wireWidth + fit_gaps*2;
wire_slot_width = 1.2;

module box(cam_angle) {
    color("silver")  side_with_servo_rear_mount();
    rotate([0, 0, 90]) color("silver") rotate([90, 0, 0]) side_with_servo_mount_slot();

    translate([cam_axis_inset_from_wall_outside, cam_axis_inset_from_wall_outside, -cam_thickness/2 + servo_armThickness]) sg90Servo(cam_angle+45);
    translate([cam_radius, cam_radius, -cam_thickness/2]) color("yellow") rotate([0, 0, 180 + cam_angle]) cam();
}

module side_with_servo_mount_slot() {
    translate([-box_size/2, 0, 0]) rotate([-90, 0, 0]) mirror([0, 1, 0]) difference() {
        side();
        translate([box_size/2, 0, 0]) for(index = [0:4])  {
            rotate([0, index*90, 0]) {
                translate([-box_size/2, 0, 0]) translate([cam_axis_inset_from_wall_outside - (servo_width/2) - fit_gaps, -slot_diff, -servo_totalHeight + servo_mountsTop - cam_thickness/2 + servo_armThickness - servo_mountsThickness - fit_gaps]) {
                    cube([servo_width + fit_gaps*2, wall_thickness + slot_diff*2, servo_mountsThickness + fit_gaps*2]);

                    translate([servo_width + fit_gaps*2, slot_diff, 0]) rotate([0, 0, (45+22.5)]) translate([-slot_diff, 0, 0]) {
                        cube([servo_width / 2 + fit_gaps*2, wall_thickness*2 + slot_diff*2, servo_mountsThickness + fit_gaps*2]);
                    }
                }
            }
        }
    }
}

module side_with_servo_rear_mount() {
    translate([-box_size/2, 0, 0]) rotate([90, 0, 0]) {
        side();
        translate([box_size/2, 0, 0]) for(index = [0:4])  {
            rotate([0, index*90, 0]) {
                translate([-box_size/2, 0, 0]) translate([servo_length + servo_mountsOut + fit_gaps, 0, -servo_totalHeight + servo_mountsTop - cam_thickness/2 + servo_armThickness - servo_mountsThickness - fit_gaps - 10]) {
                     cube([servo_mountsOut, servo_mountsOut + 2, 10]);
                }
                translate([-box_size/2, 0, 0]) translate([servo_length + fit_gaps, 0, -servo_totalHeight + servo_mountsTop - cam_thickness/2 + servo_armThickness - servo_mountsThickness - fit_gaps - 10]) {
                     cube([servo_mountsOut, servo_mountsOut - fit_gaps, 10]);
                }
            }
        }
    }
}

module side() {
    height = box_size;
    difference() {
        translate([0, 0, -height/2]) cube([box_size, wall_thickness, height]);
        union() {
            translate([box_size/2, 0, 0]) for(index = [0:4])  {
                rotate([0, index*90, 0]) {
                    translate([-box_size/2, 0, 0]) {                        
                        translate([cam_axis_inset_from_wall_outside, cam_axis_inset_from_wall_outside, -(cam_thickness/2 + motion_gaps)]) {
                            cylinder(r=cam_outer_radius + motion_gaps*4, h=cam_thickness + (motion_gaps*2));
                        }
                        translate([0, 0, hinge_axis_sep]) hinge_slot();
                        translate([0, 0, servo_totalHeight - servo_wireFromBottom]) wire_slot();
                        translate([0, 0, -hinge_axis_sep-hinge_height]) hinge_slot();
                        translate([0, 0, -servo_totalHeight+servo_wireFromBottom-wire_slot_height]) wire_slot();
                        translate([0, 0, -height/2 - slot_diff]) rotate([0, 0, 45]) translate([-slot_diff, 0, 0]) cube([pow(wall_thickness,2), pow(wall_thickness,2), height + slot_diff*2]);
                    }
                }
            }
        }
    }
}

module hinge_slot() {
    inset = sqrt(2 * pow(hinge_radius + hinge_gap/2, 2));
    difference(){
        translate([-slot_diff, -slot_diff, 0]) cube([inset+slot_diff, inset+slot_diff, hinge_height]);
        union() {
            translate([inset, 0, -slot_diff]) {
                cylinder(r=hinge_radius, h=hinge_height + slot_diff*2);
                rotate([0, 0, 45]) translate([0, -hinge_radius, 0]) cube([hinge_radius*2, hinge_radius*2, hinge_height + slot_diff*2]);
            }
        }
    }
}

module wire_slot() {
    translate([0, 0, 0]) mirror([1, 0, 0]) rotate([0, 0, 45]) translate([-wire_slot_width/2, -slot_diff, 0]) cube([wall_thickness*3, wall_thickness*3, wire_slot_height]);
}

module cam() {
    rotate([0, 0, -90]) {
        difference() {
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
            translate([0, 0, - servo_armStalkHeight + servo_armThickness - 0.5]) {
                scale([1.02, 1.02, 1.02]) _arm(-45, false);
            }
        }
    }
}

function separation_angle(d, r, c) =
    d < acos(r/c) ?
        -2 * atan((c * sin(90 - acos(r/c) + d) - r) / (r + sqrt(pow(c,2)- pow(c * sin(90 - acos(r/c) + d), 2))))
        :
        -2 * atan((c * sin(90 - acos(r/c) + d) - r) / (r - sqrt(pow(c,2)- pow(c * sin(90 - acos(r/c) + d), 2))));

module hinge_pair(cam_rotation) {
    box_angle = separation_angle(cam_rotation, cam_radius, cam_outer_radius);
    box(cam_rotation);
    rotate([0, 180, -box_angle]) box(cam_rotation);
}

module servo_with_cam(cam_angle) {
    rotate([-90, 180, 90]) translate([-box_size/2, 0, 0]) {
        translate([cam_axis_inset_from_wall_outside, cam_axis_inset_from_wall_outside, -cam_thickness/2 + servo_armThickness]) sg90Servo(cam_angle+45);
        translate([cam_radius, cam_radius, -cam_thickness/2]) color("yellow") rotate([0, 0, 180 + cam_angle]) cam();
    }
}

//$fn=100;
//box_size = 100;
//cam();
//box(0);
//side();
//hinge_pair(15);
//side_with_servo_mount_slot();
//side_with_servo_rear_mount();
