import seltar.motion.*;
Motion Pendel;
int _num = 5;    
Circle[] pArr = new Circle[_num];

void setup() {
  size(500, 300);
  Pendel = new Motion(width/2,height/2);
  Pendel.setDamping(0.99);
  smooth(); 
  frameRate(230);
  background(0);
  for (int i=0;i<_num;i++) {
    pArr[i] = new Circle(i);
    pArr[i].init(width/2, height/2);
  }
}

void clearBackground() {
  fill(0,120);
  noStroke();
  rect(0,0,width,height);
  noFill();
}

void draw() {
  if(!mousePressed) background(0);  
  stroke(255);
  fill(255);
  Pendel.springTo(mouseX,mouseY);
  Pendel.move();
  
  line(mouseX,mouseY,Pendel.getX(),Pendel.getY());
  
  for (int i=0;i<_num;i++) {
    pArr[i].update();
  }
}

void mousePressed() { 
  background(0);
  for (int i=0;i<_num;i++) {
    pArr[i].init(mouseX, mouseY);
  }
}

class Circle {
  int id;
  float angnoise, radiusnoise;
  float widnoise, heinoise;
  float angle = 0;
  float radius = 200;
  float centreX = width/2;
  float centreY = height/2;
  float strokeCol = 254;
  float g, b;
  float lastX = 9999;
  float lastY, lastAng;
  float lastOuterX, lastOuterY;
  
  Circle (int num) {
    id = num;
  }
  
  void init(float ex, float why) {
    centreX = ex;
    centreY = why;
  
    noiseSeed(int(random(1000)));
    angnoise = random(100);
    lastX = 9999;
    strokeCol = random(10) + 0.5;
    g = random(255); 
    b = random(255);
    angle = 100;
  }
  
  void update() {
    float radnoise;
    if (angle > 180) {
      radnoise = (angle+1)/180 * strokeCol;
    } else {
      radnoise = ((360-angle)+1)/180 * strokeCol;
    }
    radius = (noise(radnoise) * (width/4.5));
    
    angle += (noise(radnoise) * 4.5);
    if (angle > 360) { 
      angle -= 360;
      strokeCol++; 
      clearBackground();
    } else if (angle < 0) { 
      angle += 360; 
      strokeCol++; 
      clearBackground();
    }
    
    float wid = (noise(radnoise) * 150) - 75;
    float rad = radians(angle + 90);
    float x1 = centreX + (radius * cos(rad));
    float y1 = centreY + (radius * sin(rad));
    
    float outerRadius = radius + wid;
    float outerX = centreX + (outerRadius * cos(rad));
    float outerY = centreY + (outerRadius * sin(rad));    
    
    
    if (strokeCol > 10) {
       init(centreX, centreY); 
       if (random(5) > 1) {
         b += 40;
         if (b > 250) { b = 0; }
       } else {
         g += 40;
         if (g > 250) { g = 0; }
       }
    }
    
    if (lastX < 9999) {
      strokeWeight(0.7);
      stroke(strokeCol * 40, g, b, 250);
      line(x1, y1, lastX, lastY);
      strokeWeight(0.5);
      stroke(strokeCol * 40, g, b, 150);
      line(centreX, centreY, outerX, outerY);
    }
    
    lastX = x1;
    lastY = y1;
    lastOuterX = outerX;
    lastOuterY = outerY;
  }
  
}