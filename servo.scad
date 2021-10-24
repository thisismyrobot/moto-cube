servo_length = 22.5;
servo_width = 12.3;
servo_height = 23.5;

servo_mountsTop = 19.3;
servo_mountsThickness = 2.3;
servo_mountsOut = 5.1;
servo_mountsHoleWidth = 2.8;
servo_mountsSlotWidth = 1;

servo_gearholderHeight = 4.3;
servo_gearholderRadius = servo_width / 2;
servo_gearholderInset = servo_gearholderRadius;
servo_gearholderSmallRadius = 2.5;
servo_gearholderSmallOffset = servo_gearholderRadius * 2;

servo_hornStubHeight = 3.5;
servo_hornStubRadius = 2.3;

servo_armThickness = 1.4;
servo_armStalkRadius = 3.3;
servo_armStalkHeight = 3.7;
servo_armStalkAboutBase = 0.75;
servo_armBigRadius = 2.8;
servo_armSmallRadius = 1.9;
servo_armCentersLength = 14.5;
servo_armEndholeRadius = 0.4;
servo_armHoleSpacing = 2;

servo_wireFromBottom = 1.5;
servo_wireWidth = 3.6;

servo_totalHeight = servo_height + servo_gearholderHeight + servo_armStalkAboutBase + servo_armStalkHeight;

module sg90Servo(rotation) {

    translate([-servo_gearholderRadius, -servo_gearholderRadius, -servo_totalHeight]) {
        color([0, 0, 0.7]) {
            _chassis();
            _clusterProtrusion();
        }

        _wireStub();

        color([1, 1, 1]) {
            _horn();
            _arm(rotation);
        }
    }
}

module _chassis() {
    cube([servo_length, servo_width, servo_height]);

    translate([-servo_mountsOut, 0, servo_mountsTop - servo_mountsThickness]) {
        difference() {
            cube([servo_length + (servo_mountsOut * 2), servo_width, servo_mountsThickness]);

            // Mount hole/slot.
            translate([servo_mountsOut / 2, servo_width / 2, -diff]) {
                cylinder(r=servo_mountsHoleWidth / 2, h=servo_mountsThickness + (diff*2));
            }
            translate([-diff, (servo_width / 2) - (servo_mountsSlotWidth / 2), -diff]) {
                cube([(servo_mountsOut / 2) + diff, servo_mountsSlotWidth, servo_mountsThickness + (diff*2)]);
            }
            translate([servo_length + servo_mountsOut, 0, 0]) {
                translate([servo_mountsOut / 2, servo_width / 2, -diff]) {
                    cylinder(r=servo_mountsHoleWidth / 2, h=servo_mountsThickness + (diff*2));
                }
                translate([(servo_mountsOut / 2), (servo_width / 2) - (servo_mountsSlotWidth / 2), -diff]) {
                    cube([(servo_mountsOut / 2) + diff, servo_mountsSlotWidth, servo_mountsThickness + (diff*2)]);
                }
            }
        }
    }
}

module _wireStub() {
    translate([0, servo_width / 2, servo_wireFromBottom]) {
        rotate([0, -90, 0]) {
            color([1, 0, 0]) cylinder(h=servo_wireWidth / 3, r=servo_wireWidth / 6);
            color([0.5, 0.25, 0.25]) translate([0, -servo_wireWidth / 3, 0]) cylinder(h=servo_wireWidth / 3, r=servo_wireWidth / 6);
            color([1, 1, 0.5]) translate([0, servo_wireWidth / 3, 0]) cylinder(h=servo_wireWidth / 3, r=servo_wireWidth / 6);
        }
    }
}

module _clusterProtrusion() {
    translate([servo_gearholderInset, servo_width / 2, servo_height]) {
        cylinder(h=servo_gearholderHeight, r=servo_gearholderRadius);
    }

    translate([servo_gearholderSmallOffset, servo_width / 2, servo_height]) {
        cylinder(h=servo_gearholderHeight, r=servo_gearholderSmallRadius);
    }
}

module _horn() {
    translate([servo_width / 2, servo_width / 2, servo_height + servo_gearholderHeight]) {
        cylinder(h=servo_hornStubHeight, r=servo_hornStubRadius);
    }
}

module _arm(rotation) {
    translate([servo_width / 2, servo_width / 2, servo_height + servo_gearholderHeight + servo_armStalkAboutBase]) {
        cylinder(h=servo_armStalkHeight, r=servo_armStalkRadius);

        difference() {
            hull() {
                translate([0, 0, servo_armStalkHeight - servo_armThickness]) {
                    cylinder(h=servo_armThickness, r=servo_armBigRadius);

                    rotate([0, 0, rotation]) {
                        translate([servo_armCentersLength, 0, 0]) {
                            cylinder(h=servo_armThickness, r=servo_armSmallRadius);
                        }
                    }
                }
            }

            for(offset = [0:5])  {
                translate([0, 0, servo_armStalkHeight - servo_armThickness - 1]) {
                    rotate([0, 0, rotation]) {
                        translate([servo_armCentersLength - (servo_armHoleSpacing * offset), 0, 0]) {
                            cylinder(h=servo_armThickness + 2, r=servo_armEndholeRadius);
                        }
                    }
                }
            }
        }
    }
}
