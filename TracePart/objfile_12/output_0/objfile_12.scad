
// Define parameters for coupling dimensions
module layer_1() {
    rotate([90, 0, 0])
    union() {
        cylinder(h=10, r=15);
    }
}

module layer_2() {
    rotate([90, 0, 0])
    union(); {
        cylinder(h=5);
    }
 )

translate([0])

layer_1()

