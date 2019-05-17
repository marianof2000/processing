import controlP5.*;

//------------------- Los números originales
//float a = 3.085;
//float b = -1.504;
//float c = 0.111;
//float d = -4.393;
// http://ptahi.ru/2016/03/25/processing-sketch-based-on-histograms-of-iterated-chaotic-functions/
//https://github.com/PaulOrlov/processing-1

ControlP5[] cp5 = new ControlP5[4];
ControlP5[] colorcp5 = new ControlP5[3];// Four scrollbars
float parametro0, parametro1, parametro2, parametro3;
float h, s, b;
int vez;
boolean cambiar;
String[] gama = { "h", "s", "b" };

ArrayList<MyE> myEs = new ArrayList<MyE>();

void setup() {
  size(600, 600);
  for (int i=0; i<cp5.length; i++) {
    cp5[i] = new ControlP5(this);
    cp5[i].addSlider("parametro"+i)
      .setPosition(10, 10+i*15)
      .setRange(-10, 10)
      .setColorValueLabel(0)
      .setColorCaptionLabel(0);
  }
  for (int i=0; i<colorcp5.length; i++) {
    colorcp5[i] = new ControlP5(this);
    colorcp5[i].addSlider(gama[i])
      .setPosition(300, 10+i*15)
      .setRange(0, 100)
      .setColorValueLabel(0)
      .setColorCaptionLabel(0)
      .setValue(80);
  }
  smooth();
  noStroke();
  ellipseMode(CENTER);
  colorMode(HSB, 100);
  background(0, 0, 95);
  float step = 1.0f / 500.0f;
  for (float x = 0; x < 1; x+=step) {
    for (float y = 0; y < 1; y+=step) {
      MyE tmpE = new MyE(x, y);
      myEs.add(tmpE);
    }
  }
  cambiar = false;
}

void draw() {
  fill(h, s, b, 5);
  rect(500, 10, 50, 50);
  //fill(0, 100, 50, 5);  
  if (vez!=0) {
    for (MyE tmpE : myEs) {
      float nx = sin(parametro0 * tmpE.y) - cos(parametro1 * tmpE.x);
      float ny = sin(parametro2 * tmpE.x) - cos(parametro3 * tmpE.y);      
      ellipse(nx*100 + width/2, ny*100 + height/2, 1, 1);
      tmpE.x = nx;
      tmpE.y = ny;
    }
  }
  if (vez==7) {
    cambiar = false;
    vez = 0;
  }
  //println(vez);
  if (cambiar) {
    vez ++;
  }
}

void keyPressed() {
  if (key=='s') {
    saveFrame("fyre-######.png");
  }
  if (key=='c') { //calcular
    cambiar = true;
  }
  if (key=='r') { //reset
    println(myEs.size());
    myEs.clear();
    float step = 1.0f / 500.0f;
    for (float x = 0; x < 1; x+=step) {
      for (float y = 0; y < 1; y+=step) {
        MyE tmpE = new MyE(x, y);
        myEs.add(tmpE);
      }
    }
    background(0, 5, 95);
    //cambiar = true;
  }
  if (key==' ') {
    noLoop();
  }
}
