//------------------- Los números originales
//float a = 3.085;
//float b = -1.504;
//float c = 0.111;
//float d = -4.393;
// http://ptahi.ru/2016/03/25/processing-sketch-based-on-histograms-of-iterated-chaotic-functions/
//https://github.com/PaulOrlov/processing-1

import controlP5.*;
ControlP5[] cp5 = new ControlP5[4];
ControlP5[] colorcp5 = new ControlP5[3];// Four scrollbars
ControlP5 pasoscp5;
float parametro0, parametro1, parametro2, parametro3, h, s, b, pasos;
int vez;
boolean cambiar;
String[] gama = { "h", "s", "b" };

ArrayList<MyE> myEs = new ArrayList<MyE>();

void setup() {
  size(600, 600);
  setSliders();
  smooth();
  noStroke();
  //ellipseMode(CENTER);
  colorMode(HSB, 100);
  background(0, 0, 95);
  setupArrayList();
  cambiar = false;
}

void draw() {
  fill(h, s, b);
  rect(500, 10, 50, 50);
  //fill(h, s, b, 5);
  stroke(h, s, b, 5);
  if (vez!=0) {
    for (MyE tmpE : myEs) {
      float nx = sin(parametro0 * tmpE.y) - cos(parametro1 * tmpE.x);
      float ny = sin(parametro2 * tmpE.x) - cos(parametro3 * tmpE.y);      
      //ellipse(nx*100 + width/2, ny*100 + height/2, 1, 1);
      point(nx*100 + width/2, ny*100 + height/2);
      tmpE.x = nx;
      tmpE.y = ny;
    }
  }
  if (cambiar) {
    println(vez);
    vez ++;
    if (vez > pasos) {
      cambiar = false;
      vez = 0;
    }
  }
}

void keyPressed() {
  if (key=='s') {
    saveFrame("fyre-######.png");
  }
  if (key=='r') { //reset
    //println(myEs.size());
    setupArrayList();
    background(0, 0, 95);
    cambiar = true;
  }
  if (key==' ') {
    noLoop();
  }
}

void setSliders() {
  for (int i=0; i<cp5.length; i++) { //parameters sliders
    cp5[i] = new ControlP5(this);
    cp5[i].addSlider("parametro"+i)
      .setPosition(10, 10+i*15)
      .setRange(-10, 10)
      .setColorValueLabel(0)
      .setColorCaptionLabel(0)
      .setValue(random(-5, 5));
  }
  for (int i=0; i<colorcp5.length; i++) { //color sliders
    colorcp5[i] = new ControlP5(this);
    colorcp5[i].addSlider(gama[i])
      .setPosition(300, 10+i*15)
      .setRange(0, 100)
      .setColorValueLabel(255)
      .setColorCaptionLabel(0)
      .setValue(80);
  }
  pasoscp5 = new ControlP5(this); // times slider
  pasoscp5.addSlider("pasos")
    .setPosition(300, 55)
    .setRange(1, 10)
    .setColorValueLabel(0)
    .setColorCaptionLabel(0)
    .setValue(5);
}

void setupArrayList() {
  myEs.clear();
  float step = 1.0f / 500.0f;
  for (float x = 0; x < 1; x+=step) {
    for (float y = 0; y < 1; y+=step) {
      MyE tmpE = new MyE(x, y);
      myEs.add(tmpE);
    }
  }
}
