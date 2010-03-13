// sinewaves
// Adrian Likins http://www.adrianlikins.com
// GPL v2 2006

int xspacing = 12;   // How far apart should each horizontal location be spaced
int w;              // Width of entire wave

int count = 1;
int ind = 0;
int m = 0;

Wave[] waves = new Wave[0];

float[] wavemag;
int ylen = 0;

void setup() {
  size(400,400);
  //framerate(30);
  colorMode(HSB,255,255,255,100);
  smooth();
  initWaves();
}

class Wave {
  float mag=50.0;
  int ylen;
  float[] yvalues;
  int xspacing;  // how far apart each horizontal location should be spaced
  int w = width+16;             // width of entire wave
  float freq;
  int hue;
  int satOrder;
  int stroketype;
  int filltype;

  
  Wave(float imag, int ispacing, float ifreq) {
      mag = imag;
      freq = ifreq;
      xspacing = ispacing;
      ylen = w/xspacing;
      yvalues = new float[ylen];
      hue = int(random(0,255));
      satOrder =int(abs(random(-2,2)));
      stroketype = int(floor(random(0,3)));
      filltype = int(floor(random(0,3)));
      //println("ylen: " + ylen + " yvalues.length: " + yvalues.length + " mag: " + mag + " hue: " + hue + " freq: " + freq + " sat: " + satOrder + " stroke/fill: " + stroketype +" " + filltype);
  }
  
  void calcWave(int count){
    for (int i = 0; i < yvalues.length; i++) {
        ind = i + count;
        yvalues[i] = sin(( (ind*freq)/(1.0*yvalues.length) )*TWO_PI)*mag;
    }
  }
  
  void renderWave(){
      for (int x = 0; x < yvalues.length; x++) {
        // all the color bits are more or less heuristic
        int s = int(x*(255/yvalues.length)%255);
       
        if (boolean(satOrder)){
          s = max(255 - s, 64);
        }
        switch (stroketype) {
            case 0:
              stroke(hue, 255,255 , 30);
              break;
            case 1:
              stroke(hue, s, 128, 100);
              break;
            case 2:
              stroke(hue, 128, 196, 60);
              break;
        }
        
        switch (filltype) {
            case 0:
              fill(hue, s, 196, 100);
              break;
            case 1:
              fill(hue, 128, 255, 25);
              break;
            case 2:
              fill(hue, 255, 128, 50);  
              break;
        }
        ellipseMode(CENTER);
        ellipse(x*xspacing,width/2+yvalues[x],16,16);
    }
  }
      
}

void draw() {
  background(0);
  if (mousePressed){
    initWaves();
  }
  calcWaves();
  renderWaves();
}

void initWaves(){


  int numwaves = int(random(4,24));
  waves = new Wave[numwaves];

  int m = 0;
  while ( m < waves.length)
    {
      waves[m] = new Wave( (random(.1, .5)*height), int(random(4, 16)), random(.2, 1.0)  );
      m++;
    }
}

void calcWaves() {
  int j = 0;
  while ( j < waves.length){
    waves[j].calcWave(count);
    j++;
  }
  count = count + 1;
  
}


void renderWaves() {
  
  for (int j = 0; j< waves.length; j++){
    //println(j);
    waves[j].renderWave();
  }  
  }

