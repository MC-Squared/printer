$fn=64;
color("BurlyWood"){difference(){difference(){translate(v = [-12.500, -12.500])
cube(size = [25, 25, 20]);
translate(v = [0, 0, 40])
mirror(v = [0, 0, 1])
union(){color("Gainsboro"){translate(v = [0, 0, -4])
cylinder(h = 4, r = 3.500);
}
color("Gainsboro"){cylinder(h = 20, r = 2.150);
}
color("DarkGray"){translate(v = [0, 0, 20])
cylinder(h = 20, r = 2.150);
}
}
}
color("Gainsboro"){difference(){cylinder(h = 3.200, $fn = 6, r = 4.215);
union(){cylinder(h = 2.900, r = 2.200);
cylinder(h = 0.300, r = 3.150);
}
}
}
}
}
