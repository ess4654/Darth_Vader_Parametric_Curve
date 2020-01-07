import ddf.minim.*;

Minim minim;
AudioPlayer player;

float DefaultScale = 0.028;
float FR = 30;
float SampleRate = 13;

boolean running = true;
boolean DEBUGGING = false;
boolean SoundOn = true;

float t = 0;
float scale = DefaultScale;
/*color transparent = color(0, 0, 0, 0);
color HelmetBlack = color(8, 8, 8);
color EyeBlack = color(4, 4, 4);
color NoseBlack = color(10, 10, 10);
color white = color(255, 255, 255);
color ChinBlack = color(11, 11, 9);
color ChinFillBlack = color(14, 14, 14);
color CheekBlack = color(19, 19, 19);
color EyesOutlineBlack = color(12, 12, 12);
color RidgeBlack = color(13, 11, 11);
color GrillBlack = color(14, 12, 13);
color NoseRidgeBlack = color(14, 14, 14);
color EyebrowBlack = color(9, 9, 9);
color MaskBlack = color(24, 20, 19);*/
color transparent = color(0, 0, 0, 0);
color HelmetBlack = color(0, 0, 0);
color EyeBlack = color(0, 0, 0);
color NoseBlack = color(0, 0, 0);
color white = color(255, 255, 255);
color ChinBlack = color(0, 0, 0);
color ChinFillBlack = color(0, 0, 0);
color CheekBlack = color(0, 0, 0);
color EyesOutlineBlack = color(0, 0, 0);
color RidgeBlack = color(0, 0, 0);
color GrillBlack = color(0, 0, 0);
color NoseRidgeBlack = color(0, 0, 0);
color EyebrowBlack = color(0, 0, 0);
color MaskBlack = color(0, 0, 0);
int BG = 13;
ArrayList<PVector> points = new ArrayList<PVector>();
ArrayList<Integer> lineColor = new ArrayList<Integer>();
ArrayList<Integer> strokes = new ArrayList<Integer>();

void setup()
{
  fullScreen(P2D);
  //size(800, 800, P2D);
  background(BG);
  noFill();
  smooth();
  frameRate(FR);
  
  minim = new Minim(this);
  player = minim.loadFile("Darth Theme.mp3");
  if(SoundOn)
    player.loop();
}

void keyPressed() {
  if(key == ' ')
    running = !running;
  if(key == 'r')
    reset();
}

void reset()
{
  frameCount = -1;
  t = 0;
  lineColor.clear();
  strokes.clear();
  points.clear();
  minim.stop();
  minim = new Minim(this);
  if(SoundOn)
    player.loop();
  scale = DefaultScale;
}

float updateT(float T)
{
  T += 0.004;
  
  if(T >= 229.223) { //END
    strokes.add(1);
    lineColor.add(color(0, 0, 0));
    return 76 * PI;
  }
  if(T >= 226.337 && T < 229.223) { //NECK
    strokes.add(3);
    lineColor.add(EyebrowBlack);
    return T + 0.008;
  }
  if(T >= 216.714 && T < 226.337) { //SKIP
    strokes.add(3);
    lineColor.add(HelmetBlack);
    return 226.337;
  }
  if(T >= 213.644 && T < 216.714) { //RIGHT EYEBROW
    strokes.add(2);
    lineColor.add(EyebrowBlack);
    return T + 0.012;
  }
  if(T >= 204.197 && T < 213.644) { //SKIP
    strokes.add(1);
    lineColor.add(HelmetBlack);
    return 213.644;
  }
  if(T >= 201.075 && T < 204.197) { //LEFT EYEBROW
    strokes.add(2);
    lineColor.add(EyebrowBlack);
    return T + 0.012;
  }
  if(T >= 191.912 && T < 201.075) { //SKIP
    strokes.add(1);
    lineColor.add(HelmetBlack);
    return 201.075;
  }
  if(T >= 188.510 && T < 191.912) { //NOSE RIDGE
    strokes.add(2);
    lineColor.add(NoseRidgeBlack);
    return T + 0.004;
  }
  if(T >= 179.083 && T < 188.510) { //SKIP
    strokes.add(1);
    lineColor.add(HelmetBlack);
    return 188.510;
  }
  if(T >= 176.230 && T < 179.083) { //RIDGELINE
    strokes.add(2);
    lineColor.add(RidgeBlack);
    return T + 0.002;
  }
  if(T >= 166.786 && T < 176.230) { //SKIP
    strokes.add(1);
    lineColor.add(HelmetBlack);
    return 176.230;
  }
  if(T >= 163.251 && T < 166.786) { //CHIN FILL
    strokes.add(3);
    lineColor.add(ChinFillBlack);
    return T;
  }
  if(T >= 157.053 && T < 163.251) { //SKIP
    strokes.add(1);
    lineColor.add(HelmetBlack);
    return 163.251;
  }
  if(T >= 153.952 && T < 157.053) { //GRILL
    strokes.add(2);
    lineColor.add(GrillBlack);
    return T;
  }
  if(T >= 141.427 && T < 153.952) { //SKIP
    strokes.add(1);
    lineColor.add(HelmetBlack);
    return 153.952;
  }
  if(T >= 138.253 && T < 141.427) { //RIGHT FACE
    strokes.add(3);
    lineColor.add(RidgeBlack);
    return T + 0.002;
  }
  if(T >= 128.842 && T < 138.253) { //SKIP
    strokes.add(1);
    lineColor.add(HelmetBlack);
    return 138.253;
  }
  if(T >= 125.684 && T < 128.842) { //LEFT FACE
    strokes.add(3);
    lineColor.add(RidgeBlack);
    return T + 0.002;
  }
  if(T >= 119.404 && T < 125.684) { //SKIP
    strokes.add(1);
    lineColor.add(HelmetBlack);
    return 125.684;
  }
  if(T >= 113.099 && T < 119.404) { //INNER EYE MASK
    strokes.add(2);
    lineColor.add(MaskBlack);
    return T + 0.002;
  }
  if(T >= 106.755 && T < 113.099) { //SKIP
    strokes.add(1);
    lineColor.add(HelmetBlack);
    return 113.099;
  }
  if(T >= 100.554 && T < 106.755) { //RIGHT CHEEK
    strokes.add(2);
    lineColor.add(CheekBlack);
    return T + 0.002;
  }
  if(T >= 94.089 && T < 100.554) { //SKIP
    strokes.add(1);
    lineColor.add(HelmetBlack);
    return 100.554;
  }
  if(T >= 87.985 && T < 94.089) { //LEFT CHEEK
    strokes.add(2);
    lineColor.add(CheekBlack);
    return T + 0.002;
  }
  if(T >= 81.784 && T < 87.985) { //SKIP
    strokes.add(1);
    lineColor.add(HelmetBlack);
    return 87.985;
  }
  if(T >= 75.320 && T < 81.784) { //EYES OUTLINE
    strokes.add(4);
    lineColor.add(EyesOutlineBlack);
    return T + 0.002;
  }
  if(T >= 69.087 && T < 75.320) { //SKIP
    strokes.add(1);
    lineColor.add(HelmetBlack);
    return 75.320;
  }
  if(T >= 62.862 && T < 69.087) { //CHIN
    strokes.add(3);
    lineColor.add(ChinBlack);
    return T + 0.008;
  }
  if(T >= 56.555 && T < 62.862) { //SKIP
    strokes.add(1);
    lineColor.add(HelmetBlack);
    return 62.862;
  }
  if(T >= 50.224 && T < 56.555) { //NOSE
    strokes.add(3);
    lineColor.add(NoseBlack);
    return T;
  }
  if(T >= 43.946 && T < 50.224) { //SKIP
    strokes.add(1);
    lineColor.add(HelmetBlack);
    return 50.224;
  }
  if(T >= 37.723 && T < 43.946) { //RIGHT EYE
    strokes.add(3);
    lineColor.add(EyeBlack);
    return T + 0.004;
  }
  if(T >= 31.501 && T < 37.723) { //SKIP
    strokes.add(1);
    lineColor.add(HelmetBlack);
    return 37.723;
  }
  if(T >= 25.198 && T < 31.501) { //LEFT EYE
    strokes.add(3);
    lineColor.add(EyeBlack);
    return T + 0.004;
  }
  if(T >= 18.883 && T < 25.198) { //SKIP
    strokes.add(1);
    lineColor.add(HelmetBlack);
    return 25.198;
  }
  if(T >= 12.471 && T < 18.883) { //HELMET TOP
    strokes.add(4);
    lineColor.add(HelmetBlack);
    return T;
  }
  if(T >= 6.308 && T < 12.471) { //SKIP
    strokes.add(1);
    lineColor.add(HelmetBlack);
    return 12.471;
  }
  else { //HEAD OUTLINE
    strokes.add(4);
    lineColor.add(HelmetBlack);
  }
  
  return T;
}

void draw()
{ 
  if(frameCount < 30) return;
  if(t <= 76 * PI && running)
  {
    for(int z = 0; z<SampleRate; z++) {
      t = updateT(t);
      points.add(new PVector(x(t), -y(t)));
      if(DEBUGGING)
        print(t + "\n");
    }
  } else {
    if(!DEBUGGING)
      scale += 0.00005;
  }
  
  translate(width/2, height/2 - 100);
  background(BG);
  
  beginShape();
  for(int i = 0; i < points.size(); i++)
  {
    if(points.get(i).x == 0 && points.get(i).y == 0) continue;
    strokeWeight(strokes.get(i));
    stroke(lineColor.get(i));
    point(points.get(i).x * scale, points.get(i).y * scale);
  }
  endShape();
}

float sgn(float x)
{
  if(x == 0) return 0;
  else if(x > 0) return 1;
  else return -1;
}

float theta(float x)
{
  if(x == 0) return 0.5;
  else if(x > 0) return 1;
  else return 0;
}

float SIN(float x)
{
  return sin(x);
}

float x(float t)
{
  return ((-58.0/7*sin(14.0/9 - 16*t) - 61.0/11*sin(14.0/9 - 12*t) - 43.0/8*sin(3.0/2 - 10*t) - 108.0/7*sin(11.0/7 - 8*t) - 193.0/9*sin(14.0/9 - 6*t) - 53.0/4*sin(4.0/3 - 5*t) + 18741.0/4*sin(t + 11.0/7) + 356.0/5*sin(2*t + 47.0/10) + 359.0/5*sin(3*t + 11.0/7) + 659.0/47*sin(4*t + 33.0/7) + 237.0/7*sin(7*t + 11.0/7) + 445.0/7*sin(9*t + 8.0/5) + 147.0/5*sin(11*t + 8.0/5) + 13.0/2*sin(13*t + 3.0/2) + 14.0/9*sin(14*t + 9.0/7) + 3.0/4*sin(15*t + 3.0/5) - 3448.0/7)*theta(75*PI -t)*theta(t - 71*PI) + (18175.0/9*sin(t + 11.0/7) + 35.0/3*sin(2*t + 14.0/9) + 1195.0/6*sin(3*t + 11.0/7) + 199.0/22*sin(4*t + 11.0/7) + 16851.0/7)*theta(71*PI -t)*theta(t - 67*PI) + (-27.0/5*sin(14.0/9 - 8*t) - 23.0/3*sin(17.0/11 - 6*t) - 39.0/5*sin(14.0/9 - 4*t) + 12163.0/6*sin(t + 11.0/7) + 89.0/5*sin(2*t + 11.0/7) + 595.0/3*sin(3*t + 11.0/7) + 367.0/5*sin(5*t + 11.0/7) + 116.0/3*sin(7*t + 11.0/7) - 19148.0/5)*theta(67*PI -t)*theta(t - 63*PI) + (-881.0/7*sin(14.0/9 - 16*t) - 277.0/4*sin(14.0/9 - 12*t) - 117*sin(11.0/7 - 11*t) - 166*sin(11.0/7 - 10*t) - 624.0/7*sin(11.0/7 - 9*t) - 713.0/5*sin(11.0/7 - 4*t) - 353.0/5*sin(11.0/7 - 3*t) - 13.0/5*sin(11.0/7 - 2*t) + 199.0/4*sin(t + 11.0/7) + 18.0/5*sin(5*t + 37.0/8) + 437.0/10*sin(6*t + 8.0/5) + 155.0/12*sin(7*t + 5.0/3) + 23.0/12*sin(8*t + 13.0/6) + 121.0/8*sin(13*t + 14.0/3) + 760.0/9*sin(14*t + 8.0/5) + 75.0/4*sin(15*t + 14.0/9) + 797.0/7*sin(17*t + 8.0/5) - 5461.0/8)*theta(63*PI -t)*theta(t - 59*PI) + (-81.0/2*sin(3.0/2 - 6*t) - 209.0/16*sin(13.0/14 - 4*t) - 103.0/5*sin(9.0/8 - 2*t) + 24415.0/7*sin(t + 11.0/7) + 1571.0/3*sin(3*t + 11.0/7) + 463.0/4*sin(5*t + 11.0/7) + 428.0/7*sin(7*t + 11.0/7) + 172.0/9*sin(8*t + 11.0/8) + 95.0/3*sin(9*t + 3.0/2) + 284.0/7*sin(10*t + 37.0/8) - 10097.0/33)*theta(59*PI -t)*theta(t - 55*PI) + (-172.0/3*sin(11.0/7 - 13*t) - 807.0/7*sin(11.0/7 - 9*t) + 864.0/5*sin(t + 11.0/7) + 6045.0/7*sin(2*t + 11.0/7) + 136.0/3*sin(3*t + 14.0/9) + 25.0/6*sin(4*t + 30.0/7) + 657.0/8*sin(5*t + 11.0/7) + 8218.0/33*sin(6*t + 11.0/7) + 617.0/5*sin(7*t + 33.0/7) + 199.0/2*sin(8*t + 11.0/7) + 7744.0/29*sin(10*t + 11.0/7) + 235.0/4*sin(11*t + 14.0/9) + 335.0/6*sin(12*t + 33.0/7) + 683.0/5*sin(14*t + 33.0/7) + 42*sin(15*t + 11.0/7) + 285.0/8*sin(16*t + 11.0/7) + 280.0/31*sin(17*t + 47.0/10) + 427.0/4*sin(18*t + 11.0/7) + 282.0/5*sin(19*t + 11.0/7) + 32.0/5*sin(20*t + 14.0/3) + 17*sin(21*t + 11.0/7) - 2441.0/4)*theta(55*PI -t)*theta(t - 51*PI) + (-173.0/3*sin(20.0/13 - 8*t) - 80.0/3*sin(2.0/5 - 4*t) + 5601.0/5*sin(t + 11.0/7) + 173.0/8*sin(2*t + 3.0/4) + 1608.0/7*sin(3*t + 19.0/13) + 372.0/5*sin(5*t + 9.0/7) + 155.0/7*sin(6*t + 3.0/4) + 361.0/4*sin(7*t + 3.0/2) + 1373.0/28*sin(9*t + 14.0/3) + 122.0/5*sin(10*t + 35.0/8) + 179.0/10*sin(11*t + 29.0/7) + 147.0/10*sin(12*t + 12.0/5) + 53.0/4*sin(13*t + 13.0/6) + 83.0/5*sin(14*t + 17.0/10) - 5417.0/8)*theta(51*PI -t)*theta(t - 47*PI) + (-249.0/10*sin(13.0/9 - 6*t) - 2573.0/7*sin(11.0/7 - 4*t) - 76.0/3*sin(14.0/9 -t) + 2069.0/4*sin(2*t + 11.0/7) + 6079.0/9*sin(3*t + 11.0/7) + 1049.0/9*sin(5*t + 11.0/7) + 2623.0/46*sin(7*t + 8.0/5) + 39.0/2*sin(8*t + 3.0/2) + 79.0/2*sin(9*t + 14.0/3) + 91.0/5*sin(10*t + 33.0/7) + 99.0/4*sin(11*t + 8.0/5) + 30058.0/9)*theta(47*PI -t)*theta(t - 43*PI) + (-535.0/17*sin(14.0/9 - 10*t) - 1566.0/7*sin(11.0/7 - 4*t) + 1435.0/8*sin(t + 8.0/5) + 2383.0/9*sin(2*t + 8.0/5) + 2861.0/5*sin(3*t + 8.0/5) + 145.0/3*sin(5*t + 11.0/7) + 297.0/7*sin(6*t + 8.0/5) + 26.0/5*sin(7*t + 25.0/6) + 791.0/10*sin(8*t + 13.0/8) + 51.0/5*sin(9*t + 32.0/7) + 265.0/6*sin(11*t + 8.0/5) + 20.0/3*sin(12*t + 9.0/2) - 31695.0/7)*theta(43*PI -t)*theta(t - 39*PI) + (-151.0/7*sin(6.0/7 - 7*t) + 7955.0/2*sin(t + 5.0/3) + 411.0/8*sin(2*t + 1.0/9) + 4576.0/15*sin(3*t + 11.0/6) + 107.0/5*sin(4*t + 17.0/5) + 110.0/9*sin(5*t + 63.0/31) + 55.0/9*sin(6*t + 18.0/5) - 4994.0/7)*theta(39*PI -t)*theta(t - 35*PI) + (3476.0/5*sin(t + 4.0/3) + 433.0/5*sin(2*t + 25.0/6) + 579.0/7*sin(3*t + 5.0/3) + 113.0/5*sin(4*t + 23.0/5) + 6084.0/5)*theta(35*PI -t)*theta(t - 31*PI) + (-619.0/7*sin(9.0/7 - 3*t) + 802*sin(t + 37.0/8) + 421.0/5*sin(2*t + 11.0/7) - 23264.0/9)*theta(31*PI -t)*theta(t - 27*PI) + (-71.0/4*sin(7.0/9 - 9*t) - 289.0/9*sin(6.0/7 - 8*t) - 922.0/3*sin(1.0/10 - 3*t) - 3601.0/36*sin(5.0/4 - 2*t) + 30703.0/7*sin(t + 1) + 706.0/9*sin(4*t + 5.0/6) + 265.0/14*sin(5*t + 11.0/5) + 278.0/9*sin(6*t + 1.0/8) + 341.0/10*sin(7*t + 4.0/5) - 605)*theta(27*PI -t)*theta(t - 23*PI) + (10764.0/7*sin(t + 40.0/9) + 519.0/4*sin(2*t + 28.0/11) + 707.0/4*sin(3*t + 27.0/7) + 685.0/14*sin(4*t + 21.0/10) + 355.0/7*sin(5*t + 11.0/3) + 128.0/3*sin(6*t + 7.0/5) + 96.0/5*sin(7*t + 29.0/9) + 272.0/9*sin(8*t + 18.0/17) + 71.0/8*sin(9*t + 16.0/5) + 127.0/7*sin(10*t + 4.0/7) + 71.0/9*sin(11*t + 30.0/7) + 46.0/3*sin(12*t + 2.0/7) - 3661.0/6)*theta(23*PI -t)*theta(t - 19*PI) + (-115.0/7*sin(1.0/7 - 13*t) - 462.0/13*sin(1.0/6 - 9*t) - 353.0/3*sin(6.0/5 - 7*t) - 6463.0/6*sin(5.0/6 - 2*t) + 340.0/3*sin(8*t) + 22885.0/12*sin(t + 6.0/5) + 443.0/7*sin(3*t + 19.0/5) + 295.0/14*sin(4*t + 5.0/2) + 1466.0/7*sin(5*t + 27.0/10) + 288.0/5*sin(6*t + 13.0/4) + 265.0/8*sin(10*t + 16.0/7) + 60.0/7*sin(11*t + 21.0/5) + 930.0/19*sin(12*t + 16.0/7) - 5475.0/8)*theta(19*PI -t)*theta(t - 15*PI) + (3299.0/2*sin(t + 7.0/6) + 377.0/5*sin(2*t + 7.0/6) + 139.0/6*sin(3*t + 2.0/7) + 10166.0/7)*theta(15*PI -t)*theta(t - 11*PI) + (-30228.0/19*sin(16.0/15 -t) + 200.0/7*sin(2*t + 35.0/12) + 316.0/9*sin(3*t + 7.0/3) + 178.0/5*sin(4*t + 12.0/7) + 365.0/9*sin(5*t + 21.0/5) + 18.0/7*sin(6*t + 11.0/9) - 20196.0/7)*theta(11*PI -t)*theta(t - 7*PI) + (-257.0/4*sin(23.0/24 - 15*t) - 2071.0/4*sin(1.0/3 - 3*t) - 99793.0/36*sin(10.0/9 - 2*t) + 51290.0/7*sin(t + 1) + 6064.0/9*sin(4*t + 3.0/4) + 2497.0/5*sin(5*t + 16.0/9) + 2413.0/8*sin(6*t + 11.0/4) + 5585.0/21*sin(7*t + 1) + 493.0/3*sin(8*t + 5.0/3) + 859.0/11*sin(9*t + 3.0/2) + 462.0/5*sin(10*t + 26.0/7) + 421.0/4*sin(11*t + 2) + 735.0/8*sin(12*t + 5.0/2) + 63*sin(13*t + 8.0/3) + 425.0/7*sin(14*t + 71.0/18) - 4853.0/8)*theta(7*PI -t)*theta(t - 3*PI) + (-4027.0/7*sin(4.0/3 - 5*t) + 55361.0/7*sin(t + 1) + 2324.0/3*sin(2*t + 31.0/16) + 705.0/7*sin(3*t + 11.0/9) + 2194.0/11*sin(4*t + 26.0/25) + 977.0/9*sin(6*t + 13.0/4) + 284*sin(7*t + 27.0/7) + 1026.0/7*sin(8*t + 7.0/5) + 677.0/8*sin(9*t + 19.0/7) + 1023.0/8*sin(10*t + 5.0/9) - 4475.0/8)*theta(3*PI -t)*theta(t +PI))*theta(sqrt(sgn(sin(t/2))));
}

float y(float t)
{
  return ((-59*sin(14.0/9 - 16*t) - 5.0/2*sin(4.0/3 - 15*t) - 466.0/7*sin(17.0/11 - 14*t) - 14.0/5*sin(14.0/9 - 13*t) - 265.0/12*sin(11.0/7 - 12*t) - 185.0/2*sin(11.0/7 - 8*t) - 38.0/3*sin(11.0/7 - 7*t) - 2523.0/8*sin(11.0/7 - 6*t) - 7094.0/7*sin(11.0/7 - 4*t) - 451.0/5*sin(14.0/9 - 3*t) + 581.0/5*sin(t + 11.0/7) + 707.0/6*sin(2*t + 8.0/5) + 289.0/36*sin(5*t + 4.0/3) + 93.0/7*sin(9*t + 12.0/7) + 592.0/9*sin(10*t + 13.0/8) + 137.0/9*sin(11*t + 14.0/3) - 63797.0/8)*theta(75*PI -t)*theta(t - 71*PI) + (-311.0/8*sin(11.0/7 - 4*t) - 1619.0/5*sin(11.0/7 - 2*t) - 471.0/4*sin(11.0/7 -t) + 107.0/3*sin(3*t + 11.0/7) + 4487.0/3)*theta(71*PI -t)*theta(t - 67*PI) + (-143.0/6*sin(11.0/7 - 6*t) - 709.0/10*sin(11.0/7 - 4*t) - 3736.0/15*sin(11.0/7 - 2*t) + 3961.0/30*sin(t + 11.0/7) + 27.0/7*sin(3*t + 33.0/7) + 145.0/6*sin(5*t + 33.0/7) + 52.0/7*sin(7*t + 33.0/7) + 37.0/6*sin(8*t + 33.0/7) + 19529.0/14)*theta(67*PI -t)*theta(t - 63*PI) + (-11.0/5*sin(14.0/9 - 17*t) - 161.0/20*sin(14.0/9 - 16*t) - 52.0/7*sin(11.0/7 - 12*t) - 3.0/2*sin(3.0/2 - 11*t) - 67.0/10*sin(14.0/9 - 10*t) - 13.0/6*sin(14.0/9 - 4*t) + 573*sin(t + 11.0/7) + 172.0/19*sin(2*t + 33.0/7) + 185.0/6*sin(3*t + 11.0/7) + 179.0/7*sin(5*t + 11.0/7) + 37.0/9*sin(6*t + 11.0/7) + 79.0/5*sin(7*t + 11.0/7) + 14.0/3*sin(8*t + 11.0/7) + 107.0/7*sin(9*t + 8.0/5) + 7.0/4*sin(13*t + 8.0/5) + 11.0/12*sin(14*t + 32.0/7) + 27.0/10*sin(15*t + 8.0/5) - 4217.0/3)*theta(63*PI -t)*theta(t - 59*PI) + (35.0/3*sin(t + 33.0/7) + 550.0/9*sin(2*t + 47.0/10) + 255.0/4*sin(3*t + 17.0/11) + 979.0/6*sin(4*t + 14.0/9) + 245.0/9*sin(5*t + 3.0/2) + 101.0/4*sin(6*t + 17.0/11) + 820.0/11*sin(7*t + 3.0/2) + 437.0/7*sin(8*t + 3.0/2) + 339.0/7*sin(9*t + 14.0/3) + 75.0/4*sin(10*t + 3.0/2) - 17567.0/5)*theta(59*PI -t)*theta(t - 55*PI) + (-25.0/4*sin(11.0/7 - 19*t) - 621.0/5*sin(11.0/7 - 5*t) + 498.0/5*sin(t + 11.0/7) + 11.0/8*sin(2*t + 22.0/5) + 2609.0/15*sin(3*t + 11.0/7) + 149.0/3*sin(4*t + 8.0/5) + 52.0/5*sin(6*t + 14.0/3) + 271.0/10*sin(7*t + 14.0/9) + 1112.0/7*sin(8*t + 11.0/7) + 557.0/6*sin(9*t + 33.0/7) + 109.0/8*sin(10*t + 14.0/3) + 403.0/6*sin(11*t + 33.0/7) + 113.0/3*sin(12*t + 8.0/5) + 609.0/8*sin(13*t + 11.0/7) + 11.0/8*sin(14*t + 9.0/2) + 193.0/7*sin(15*t + 11.0/7) + 117.0/10*sin(16*t + 11.0/7) + 204.0/5*sin(17*t + 33.0/7) + 77.0/10*sin(18*t + 33.0/7) + 401.0/20*sin(20*t + 33.0/7) + 56.0/3*sin(21*t + 33.0/7) - 56953.0/7)*theta(55*PI -t)*theta(t - 51*PI) + (-459.0/7*sin(1.0/8 - 13*t) - 459.0/5*sin(7.0/5 - 11*t) + 89.0/5*sin(t + 31.0/15) + 4109.0/11*sin(2*t + 14.0/3) + 23*sin(3*t + 23.0/8) + 2692.0/23*sin(4*t + 40.0/9) + 968.0/13*sin(5*t + 9.0/4) + 1201.0/6*sin(6*t + 11.0/6) + 1017.0/5*sin(7*t + 9.0/5) + 5035.0/8*sin(8*t + 14.0/3) + 1697.0/9*sin(9*t + 23.0/5) + 996.0/7*sin(10*t + 13.0/8) + 166*sin(12*t + 4.0/3) + 736.0/5*sin(14*t + 28.0/27) - 29201.0/5)*theta(51*PI -t)*theta(t - 47*PI) + (7611.0/8*sin(t + 11.0/7) + 2098.0/3*sin(2*t + 11.0/7) + 4549.0/5*sin(3*t + 11.0/7) + 3369.0/5*sin(4*t + 33.0/7) + 484.0/5*sin(5*t + 14.0/3) + 125.0/9*sin(6*t + 13.0/8) + 402.0/5*sin(7*t + 23.0/5) + 267.0/2*sin(8*t + 14.0/3) + 730.0/7*sin(9*t + 37.0/8) + 2056.0/17*sin(10*t + 14.0/3) + 35*sin(11*t + 12.0/7) - 5032)*theta(47*PI -t)*theta(t - 43*PI) + (-1233.0/22*sin(7.0/5 - 9*t) - 566.0/5*sin(16.0/11 - 8*t) - 733.0/12*sin(14.0/9 - 7*t) - 919.0/7*sin(11.0/7 - 5*t) - 3557.0/3*sin(14.0/9 - 3*t) - 2939.0/4*sin(14.0/9 - 2*t) + 6148.0/11*sin(t + 11.0/7) + 1185.0/7*sin(4*t + 3.0/2) + 1600.0/13*sin(6*t + 8.0/5) + 59.0/5*sin(10*t + 9.0/7) + 71.0/9*sin(11*t + 13.0/3) + 164.0/5*sin(12*t + 13.0/8) - 41799.0/8)*theta(43*PI -t)*theta(t - 39*PI) + (-117.0/5*sin(4.0/5 - 6*t) - 145.0/4*sin(5.0/4 - 4*t) - 1311.0/7*sin(7.0/5 - 2*t) + 15551.0/10*sin(t + 1.0/9) + 518*sin(3*t + 1.0/5) + 679.0/17*sin(5*t + 2.0/5) + 259.0/6*sin(7*t + 5.0/6) - 9484.0/7)*theta(39*PI -t)*theta(t - 35*PI) + (-130.0/7*sin(9.0/8 - 4*t) - 427.0/4*sin(24.0/25 - 3*t) - 3332.0/3*sin(9.0/7 -t) + 932.0/19*sin(2*t + 30.0/7) - 32269.0/6)*theta(35*PI -t)*theta(t - 31*PI) + (-1119.0/13*sin(10.0/9 - 3*t) - 1386.0/17*sin(4.0/3 - 2*t) - 4103.0/4*sin(9.0/7 -t) - 46877.0/9)*theta(31*PI -t)*theta(t - 27*PI) + (-7485.0/4*sin(5.0/9 -t) + 1909.0/9*sin(2*t + 34.0/9) + 2861.0/4*sin(3*t + 23.0/5) + 11.0/2*sin(4*t + 7.0/2) + 111.0/8*sin(5*t + 12.0/7) + 511.0/8*sin(6*t + 16.0/15) + 180.0/7*sin(7*t + 11.0/4) + 279.0/4*sin(8*t + 17.0/5) + 76.0/5*sin(9*t + 81.0/20) - 16919.0/11)*theta(27*PI -t)*theta(t - 23*PI) + (-71.0/13*sin(1.0/2 - 11*t) - 119.0/6*sin(17.0/16 - 6*t) - 292.0/7*sin(10.0/7 - 5*t) - 64.0/13*sin(3.0/5 - 3*t) - 1493.0/3*sin(2.0/7 -t) + 1883.0/8*sin(2*t + 7.0/6) + 171.0/7*sin(4*t + 32.0/9) + 251.0/25*sin(7*t + 1) + 35.0/2*sin(8*t + 16.0/7) + 117.0/10*sin(9*t + 15.0/4) + 43.0/9*sin(10*t + 29.0/8) + 43.0/9*sin(12*t + 20.0/13) - 65269.0/8)*theta(23*PI -t)*theta(t - 19*PI) + (-174.0/5*sin(4.0/7 - 8*t) - 4532.0/23*sin(5.0/6 - 6*t) + 36005.0/17*sin(t + 25.0/9) + 2164.0/5*sin(2*t + 35.0/9) + 1376.0/5*sin(3*t + 13.0/7) + 1164.0/5*sin(4*t + 28.0/9) + 277.0/3*sin(5*t + 19.0/5) + 539.0/4*sin(7*t + 3.0/10) + 839.0/12*sin(9*t + 26.0/9) + 23.0/5*sin(10*t + 8.0/3) + 901.0/22*sin(11*t + 11.0/5) + 163.0/5*sin(12*t + 5.0/9) + 135.0/7*sin(13*t + 9.0/2) - 11569.0/2)*theta(19*PI -t)*theta(t - 15*PI) + (-5801.0/5*sin(5.0/11 -t) + 171.0/7*sin(2*t + 21.0/5) + 782.0/9*sin(3*t + 17.0/4) - 7576.0/5)*theta(15*PI -t)*theta(t - 11*PI) + (-34.0/3*sin(1 - 4*t) - 838.0/7*sin(1.0/2 - 2*t) + 7788.0/7*sin(t + 2.0/5) + 1055.0/7*sin(3*t + 11.0/7) + 219.0/10*sin(5*t + 19.0/5) + 194.0/7*sin(6*t + 49.0/11) - 7441.0/5)*theta(11*PI -t)*theta(t - 7*PI) + (-209.0/2*sin(5.0/6 - 8*t) + 58085.0/14*sin(t + 21.0/8) + 5813.0/3*sin(2*t + 26.0/7) + 25709.0/7*sin(3*t + 10.0/7) + 6831.0/8*sin(4*t + 9.0/4) + 3693.0/10*sin(5*t + 38.0/13) + 6453.0/7*sin(6*t + 30.0/7) + 1996.0/11*sin(7*t + 16.0/5) + 3541.0/22*sin(9*t + 5.0/4) + 2263.0/29*sin(10*t + 35.0/18) + 4279.0/46*sin(11*t + 1.0/5) + 523.0/4*sin(12*t + 21.0/5) + 326.0/7*sin(13*t + 21.0/8) + 396.0/7*sin(14*t + 21.0/5) + 1446.0/17*sin(15*t + 2.0/3) + 1971.0/5)*theta(7*PI -t)*theta(t - 3*PI) + (-938.0/5*sin(8.0/9 - 7*t) + 26701.0/4*sin(t + 18.0/7) + 8911.0/33*sin(2*t + 7.0/2) + 4615.0/6*sin(3*t + 32.0/7) + 18102.0/23*sin(4*t + 12.0/5) + 1129.0/7*sin(5*t + 13.0/4) + 473.0/7*sin(6*t + 10.0/7) + 671.0/7*sin(8*t + 1.0/14) + 7.0/4*sin(9*t + 9.0/2) + 491.0/9*sin(10*t + 29.0/14) - 19490.0/3)*theta(3*PI -t)*theta(t +PI))*theta(sqrt(sgn(sin(t/2))));
}
