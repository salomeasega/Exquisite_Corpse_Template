//Jackie trying to add stuff in joint sketch

import spacebrew.*;

// Spacebrew stuff
String server = "sandbox.spacebrew.cc";
String name   = "Thirty_Second_The_Illfigure!";
String desc   = "Some stuff";

Spacebrew sb;

// App Size: you should decide on a width and height
// for your group
int appWidth  = 1280;
int appHeight = 720;

// EC stuff
int corpseStarted   = 0;
boolean bDrawing    = false;
boolean bNeedToClear = false;

//----JN stuff start
int rate = 60; 
int slide = 1280;

float angle;
float jitter;

float xj = 855;
float yj = 100;
float xjspeed = 1;
float yjspeed = 3.3;

PImage myImagej;
PImage myImagej2;
PImage myImagej3;

int slide_it_x = 955;
int slide_it_y = 350;

int jr = 60;
int jg = 40;
int jb = 200;
//----JN stuff end

void setup() {
  size( appWidth, appHeight );
  smooth();

  sb = new Spacebrew(this);
  sb.addPublish("doneExquisite", "boolean", false);
  sb.addPublish("slide", "range"); //jn slider 
  sb.addSubscribe("startExquisite", "boolean");

  // add any of your own subscribers here!
  sb.addSubscribe("slide_it_x", "range"); //jn slider
  sb.addSubscribe("slide_it_y", "range"); //jn slider
  sb.addSubscribe("jr", "range");
  sb.addSubscribe("jg", "range");
  sb.addSubscribe("jb", "range");

  sb.connect( server, name, desc );
  
//-----JN loading image start 
  myImagej = loadImage("excorpse.png");
  myImagej2 = loadImage ("shapeimage_1.png");
  myImagej3 = loadImage ("man-ray-yves-tanguy-joan-miro-max-morise-2-192x300.png");
//-----JN loading image end 


}

void draw() {
  // this will make it only render to screen when in EC draw mode


  if (!bDrawing) return;
  
//  if (!bDrawing) bDrawing = true; //uncomment to use with out slider

  // blank out your background once
  if ( bNeedToClear ) {
    bNeedToClear = false;
    background(0); // feel free to change the background color!
  }

  // ---- start person 1 ---- //
  if ( millis() - corpseStarted < 10000 ) {
    noFill();
    stroke(255);
    rect(0, 0, width / 3.0, height );
    fill(255);

    // ---- start person 2 ---- //
  } 
  else if ( millis() - corpseStarted < 20000 ) {
    noFill();
    stroke(255);
    rect(width / 3.0, 0, width / 3.0, height );
    fill(255);

    // ---- start person 3 ---- JN//
  } 
  else if ( millis() - corpseStarted < 30000 ) {
    noFill();
    stroke(255);    
    rect(width * 2.0/ 3.0, 0, width / 3.0, height );
    noFill();
    // Add the current speed to the location.
    xj = xj + xjspeed;
    yj = yj + yjspeed;
    // Check for bouncing
    if ((xj > width) || (xj < 855)) {
      xjspeed = xjspeed * -1;
    }
    if ((yj > height) || (yj < 0)) {
      yjspeed = yjspeed * -1;
    }
    // Display at x,y location
    stroke(0);
    fill(175);
    int jnx = constrain(slide_it_x, 855, 1280);
    int jny = constrain(slide_it_y, 20, 700);
//    ellipse(slide_it_x, slide_it_y, 16, 16);
    tint(jr, jg, jb);
    image(myImagej, xj, slide_it_y); 
    image(myImagej3, jnx, jny);
    image(myImagej2, jnx, yj);



    //make stuff happen here:

    // ---- we're done! ---- //
  } 
  else {
    sb.send( "doneExquisite", true );
    bDrawing = false;
  }
}

void mousePressed() {
  // for debugging, comment this out!
  sb.send( "doneExquisite", true );
}

void onBooleanMessage( String name, boolean value ) {
  if ( name.equals("startExquisite") ) {
    // start the exquisite corpse process!
    bDrawing = true;
    corpseStarted = millis();
    bNeedToClear = true;
  }
}

void onRangeMessage( String name, int value ) {

//------JN Slider stuff start
  if(name.equals("slide_it_x")){
    slide_it_x = value;
}else if(name.equals("slide_it_y")){
    slide_it_y = value;
}else if(name.equals("jr")){
  jr=int(random(map(value, 0, 1230, 10, 255)));
}else if(name.equals("jg")){
  jg=int(random(map(value, 0, 1230, 10, 255)));
}else if(name.equals("jb")){
  jb=int(random(map(value, 0, 1230, 100, 255)));
}

//-----JN Slider stuff end
}
void onStringMessage( String name, String value ) {
}

