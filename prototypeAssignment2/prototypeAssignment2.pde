//genral prototype of what I want it to do/ look like 

int appWidth  = 1280;
int appHeight = 720;

float angle;
float jitter;

float x = 100;
float y = 100;
float xspeed = 1;
float yspeed = 3.3;

PImage myImage;
PImage myImage2;// image 2
PImage myImage3;// image 3
PImage myImage4;// image 4

void setup() {
  size( appWidth, appHeight );
  smooth();
  background(255);
  rectMode(CENTER); //do i need this? 

  myImage = loadImage("man-ray-yves-tanguy-joan-miro-max-morise-2-192x300.png");//j loading image
  myImage2 = loadImage("excorpse.png");
  myImage3 = loadImage("EXQUISITE-1-articleInline.png");
  myImage4 = loadImage("Exquisite_corpse_drawing_by_Noah_Ryan_and_Erica_Parrott.png");
}

void draw() {
  stroke(255);
  //fill(255,10);
  //rect(0,0,width,height);
  // rect(width * 2.0/ 3.0,0, width / 3.0, height );
  fill(255);

  // Add the current speed to the location.
  x = x + xspeed;
  y = y + yspeed;
  // Check for bouncing
  if ((x > width) || (x < 0)) {
    xspeed = xspeed * -1;
  }
  if ((y > height) || (y < 0)) {
    yspeed = yspeed * -1;
  }
  // Display at x,y location
  stroke(0);
  fill(175);
  //translate(853, height);
  ellipse(mouseX, y, 16, 16);
//  image(myImage, mouseX, mouseY);
//    image(myImage2, 700, mouseY);
//    image(myImage3, mouseX, 875);
//    image(myImage4, 100, 100);


  if (second() % 2 == 0) {  
    jitter = random(-0.1, 0.1); //to be controled by mouse or slider
  }
  angle = angle + jitter;
  float c = cos(angle);
  //translate(width, height);
  rotate(c);
  //or use this for different effect  
  rotate(radians(0)); //could also make radians a slider
  // tint(0, 244, 20); //to be controled by slider maped to 0-255
x = x + xspeed;
  y = y + yspeed;
  // Check for bouncing
  if ((x > width) || (x < 0)) {
    xspeed = xspeed * -1;
  }
  if ((y > height) || (y < 0)) {
    yspeed = yspeed * -1;
  }
   image(myImage, x, mouseY); //to be controled by slider and maped to screen
//    image(myImage2, 700, mouseY);
//    image(myImage3, mouseX, 800);
//    image(myImage4, 800, 700);
}

