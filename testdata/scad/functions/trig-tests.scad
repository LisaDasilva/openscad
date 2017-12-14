function isNan(x) = x != x;

module print_results(testname, results) {
  if (len(results) > 0)
    echo(str(testname, " FAILED at these angles: ", results));
  else
    echo(str(testname, " PASSED"));
} 

echo("***Test special angles***");
echo("sin(  0) == 0          ", sin(  0) == 0);
echo("sin( 30) == 1/2        ", sin( 30) == 1/2);
echo("sin( 45) == sqrt(2)/2  ", sin( 45) == sqrt(2)/2);
echo("sin( 60) == sqrt(3)/2  ", sin( 60) == sqrt(3)/2);
echo("sin( 90) == 1          ", sin( 90) == 1);
echo("sin(120) == sqrt(3)/2  ", sin(120) == sqrt(3)/2);
echo("sin(135) == sqrt(2)/2  ", sin(135) == sqrt(2)/2);
echo("sin(150) == 1/2        ", sin(150) == 1/2);
echo("sin(180) == 0          ", sin(180) == 0);
echo("sin(210) == -1/2       ", sin(210) == -1/2);
echo("sin(225) == -sqrt(2)/2 ", sin(225) == -sqrt(2)/2);
echo("sin(240) == -sqrt(3)/2 ", sin(240) == -sqrt(3)/2);
echo("sin(270) == -1         ", sin(270) == -1);
echo("sin(300) == -sqrt(3)/2 ", sin(300) == -sqrt(3)/2);
echo("sin(315) == -sqrt(2)/2 ", sin(315) == -sqrt(2)/2);
echo("sin(330) == -1/2       ", sin(330) == -1/2);
echo("sin(360) == 0          ", sin(360) == 0);
echo();


echo("cos(  0) == 1          ", cos(  0) == 1);
echo("cos( 30) == sqrt(3)/2  ", cos( 30) == sqrt(3)/2);
echo("cos( 45) == sqrt(2)/2  ", cos( 45) == sqrt(2)/2);
echo("cos( 60) == 1/2        ", cos( 60) == 1/2);
echo("cos( 90) == 0          ", cos( 90) == 0);
echo("cos(120) == -1/2       ", cos(120) == -1/2);
echo("cos(135) == -sqrt(2)/2 ", cos(135) == -sqrt(2)/2);
echo("cos(150) == -sqrt(3)/2 ", cos(150) == -sqrt(3)/2);
echo("cos(180) == -1         ", cos(180) == -1);
echo("cos(210) == -sqrt(3)/2 ", cos(210) == -sqrt(3)/2);
echo("cos(225) == -sqrt(2)/2 ", cos(225) == -sqrt(2)/2);
echo("cos(240) == -1/2       ", cos(240) == -1/2);
echo("cos(270) == 0          ", cos(270) == 0);
echo("cos(300) == 1/2        ", cos(300) == 1/2);
echo("cos(315) == sqrt(2)/2  ", cos(315) == sqrt(2)/2);
echo("cos(330) == sqrt(3)/2  ", cos(330) == sqrt(3)/2);
echo("cos(360) == 1          ", cos(360) == 1);


echo();
echo("isNan(tan(-90)) == 0   ", isNan(tan(-90)));
echo("tan(-60) == -sqrt(3)   ", tan(-60) == -sqrt(3));
echo("tan(-45) == -1         ", tan(-45) == -1);
echo("tan(-30) == -sqrt(3)/3 ", tan(-30) == -sqrt(3)/3);
echo("tan(  0) == 0          ", tan(  0) == 0);
echo("tan( 30) == sqrt(3)/3  ", tan( 30) == sqrt(3)/3);
echo("tan( 45) == 1          ", tan( 45) == 1);
echo("tan( 60) == sqrt(3)    ", tan( 60) == sqrt(3));
echo("isNan(tan(90))         ", isNan(tan( 90)));

echo();
echo("***Verify functions are Odd/Even***");
sin_fails = [for(a = [0:1:359]) if (sin(-a) != -sin(a)) a];
cos_fails = [for(a = [0:1:359]) if (cos(-a) != cos(a)) a];
tan_fails = [for(a = [0:1:359]) if (tan(-a) != -tan(a) && ((a+90) % 180) != 0) a]; // ignore where tan(a) would be nan
print_results("sin()  odd check", sin_fails);
print_results("cos() even check", cos_fails);
print_results("tan()  odd check", tan_fails);

echo();
echo("***Verify functions are Periodic over a few cycles***");
sin_aperiodic = [for(p = [-4:5], a=[0:1:359]) let(a1 = a+p*360, a2 = a+(p-1)*360) if (sin(a1) != sin(a2)) [a2,a1]];
cos_aperiodic = [for(p = [-4:5], a=[0:1:359]) let(a1 = a+p*360, a2 = a+(p-1)*360) if (cos(a1) != cos(a2)) [a2,a1]];
tan_aperiodic = [for(p = [-4:5], a=[0:1:359]) let(a1 = a+p*180, a2 = a+(p-1)*180) if (tan(a1) != tan(a2) && ((a+90) % 180) != 0) [a2,a1]]; // ignore where tan(a) would be nan
print_results("sin() periodic check", sin_aperiodic);
print_results("cos() periodic check", cos_aperiodic);
print_results("tan() periodic check", tan_aperiodic);

echo();
echo("***Verify Inverse Trigonometric functions***");
epsilon = 2e-13; // smallest value that passes
// Probably not feasible/useful to try making these exact
asin_fails = [for(a = [-90:1: 90]) if (abs(asin(sin(a)) - a) > epsilon) [a, asin(sin(a))] ];
acos_fails = [for(a = [  0:1:180]) if (abs(acos(cos(a)) - a) > epsilon) [a, acos(cos(a))] ];
atan_fails = [for(a = [-90:1: 90]) if (abs(atan(tan(a)) - a) > epsilon && ((a+90) % 180) != 0) [a, atan(tan(a))] ];
print_results("asin() inverse check", asin_fails);
print_results("acos() inverse check", acos_fails);
print_results("atan() inverse check", atan_fails);
