/*
 Carcasa para el crazyradio de bitcraze
 https://www.bitcraze.io/crazyradio/
 by edauksis
 */

ancho = 18.5;
largo = 33.5;
grueso = 10;
radio = 3;

usb_z = 4.5 + 0.5;
usb_y = 12 + 0.5;
usb_x = 4.5 + 3;

a = ancho + 4;
l = largo + 8;
g = grueso;
r = radio;

module cuerpo() {
    difference () {
        union() {
            hull() {
                translate([(l/2)-r,(a/2)-r,(g/2)-r]) sphere(r,$fn=50);
                translate([(l/2)-r,(-a/2)+r,(g/2)-r]) sphere(r,$fn=50);
                translate([(-l/2)+r,(a/2)-r,(g/2)-r]) sphere(r,$fn=50);
                translate([(-l/2)+r,(-a/2)+r,(g/2)-r]) sphere(r,$fn=50);
                translate([(l/2)-r,(a/2)-r,(-g/2)+r]) sphere(r,$fn=50);
                translate([(l/2)-r,(-a/2)+r,(-g/2)+r]) sphere(r,$fn=50);
                translate([(-l/2)+r,(a/2)-r,(-g/2)+r]) sphere(r,$fn=50);
                translate([(-l/2)+r,(-a/2)+r,(-g/2)+r]) sphere(r,$fn=50);
            }
            translate([-l/2,0,0]) rotate([0,90,0]) cylinder(d=10,h=10,$fn=40);
        }
        // hueco para el usb
        translate([l/2 - 3,0,0]) cube([usb_x,usb_y,usb_z],true);
        // hueco interior
        translate([1,0,-0.5]) cube([largo,ancho,6],true);
        
        // cuadradillo de la antena
        translate([(-largo+1)/2,0,0]) cube([3,7,7],true);
        // agujero de la antena
        translate([-l/2,0,0])  rotate([0,90,0]) cylinder(d=7,h=10,$fn=40);
   }   
}


module base() {
    difference () {
        cuerpo();
        translate([0,0,5-(2.5/2)]) cube([l,a,2.5], true);
        translate([-l/2+5,ancho/2-1,0]) rotate([0,90,0]) cylinder(d=3,h=largo,$fn=40);
        translate([-l/2+5,-ancho/2+1,0]) rotate([0,90,0]) cylinder(d=3,h=largo,$fn=40);
    }
}




module sujeta() {
    union() {
        translate([-l/2+6,ancho/2-1.2,0]) rotate([0,90,0]) cylinder(d=2.6,h=3,$fn=40);
        translate([-l/2+7.5,ancho/2-1.5,1.1]) cube([3,1.8,3],true);
        translate([-l/2+6,-ancho/2+1.2,0]) rotate([0,90,0]) cylinder(d=2.6,h=3,$fn=40);
        translate([-l/2+7.5,-ancho/2+1.5,1.1]) cube([3,1.8,3],true);
        translate([l/2-7,ancho/2-1.2,0]) rotate([0,90,0]) cylinder(d=2.6,h=3,$fn=40);
        translate([l/2-5.5,-ancho/2+1.5,1.1]) cube([3,1.8,3],true);
        translate([l/2-7,-ancho/2+1.2,0]) rotate([0,90,0]) cylinder(d=2.6,h=3,$fn=40);
        translate([l/2-5.5,ancho/2-1.5,1.1]) cube([3,1.8,3],true);
    }
}

module tapa() {
    difference() {
        union() {
            difference () {
                cuerpo();
                translate([0,0,7.5/2 - 5]) cube([l,a,7.5], true);
            }
            sujeta();
            translate([1,0,2.5]) cube([largo-1,ancho-1,1],true);
        }
        translate([(-largo+3)/2,0,0]) cube([5,7,7],true);
        translate([1,0,2.5]) cube([largo-5,ancho-5,1],true);
    }
}

translate([0,a/2 + 2,5]) base();
translate([0,-a/2 -2,5]) rotate([180,0,0]) tapa();
