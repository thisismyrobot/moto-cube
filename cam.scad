$fn = 200;
wall_thickness = 3;
cam_axis_inset_from_wall_outside = 10;
cam_radius = cam_axis_inset_from_wall_outside;
cam_thickness = 3;
min_cam_width = 5;
flat_length = 20;
outer_radius = sqrt(pow(cam_radius, 2) + pow(flat_length, 2));

//$t=0;
cam_rotation = $t < 0.5 ? $t * 180 : 180 - ($t * 180);

module box(cam_radius, flat_len, camangle) {
    length = wall_thickness * 30;
    height = wall_thickness * 15;
    translate([0, 0, -height]) {
        rotate([0, 0, 180]) color("silver") cube([length, wall_thickness, height]);
        rotate([0, 0, -90]) translate([0, -wall_thickness, 0]) color("silver") cube([length, wall_thickness, height]);
        rotate([0, 0, 180]) color("silver") cube([length, length, 5]);
    }
    
    translate([-cam_radius, -cam_radius, 0]) color("yellow") cam(cam_radius, flat_len, camangle);
}

module cam(cam_radius, flat_len, camangle) {
    rotate([0, 0, -90]) {
        rotate([0, 0, camangle]) {
            cylinder(r=1, h=10);

            hull() {
                
                cylinder(r=cam_radius, h=cam_thickness);
                
                difference() {   
                    cylinder(r=outer_radius, h=cam_thickness);
                    union() {
                        rotate([0, 0, 90]) translate([0, -flat_len, -1]) cube([outer_radius * 2, outer_radius * 2, cam_thickness * 2]);
                        rotate([0, 0, 90]) mirror([1, -1, 0]) translate([0, -flat_len, -1]) cube([outer_radius * 2, outer_radius * 2, cam_thickness * 2]);
                    }
                }
            }
        }
    }
}

function separation_angle(d, r, c) =
    d < acos(cam_radius/outer_radius) ?
        -2 * atan((c * sin(90 - acos(r/c) + d) - r) / (r + sqrt(pow(c,2)- pow(c * sin(90 - acos(r/c) + d), 2))))
        :
        -2 * atan((c * sin(90 - acos(r/c) + d) - r) / (r - sqrt(pow(c,2)- pow(c * sin(90 - acos(r/c) + d), 2))));

box_angle = $t < 0.5 ? separation_angle(cam_rotation, cam_radius, outer_radius) : 180; 
echo(box_angle);
echo(acos(cam_radius/outer_radius));

rotate([0, 0, box_angle]) box(cam_axis_inset_from_wall_outside, flat_length, cam_rotation);

mirror([1, 0, 0]) color("grey") box(cam_axis_inset_from_wall_outside, flat_length, cam_rotation);