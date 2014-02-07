//Jackie trying to add stuff in joint sketch

import spacebrew.*;

// Spacebrew stuff
String server = "sandbox.spacebrew.cc";
String name   = "ExquisiteCorpse_YOUR_NAME_HERE!";
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

//JN stuff
int rate = 60; 
int slide = 1280;

float angle;
float jitter;

float x = 100;
float y = 100;
float xspeed = 1;
float yspeed = 3.3;

PImage myImage;

void setup(){
  size( appWidth, appHeight );
  smooth();
  
  sb = new Spacebrew(this);
  sb.addPublish("doneExquisite", "boolean", false);
  sb.addPublish("slide", "range"); //jn slider 
  sb.addSubscribe("startExquisite", "boolean");
  
  myImage = loadImage("excorpse.png");//j loading image

 
  
  // add any of your own subscribers here!
    sb.addSubscribe("rate", "range"); //jn slider

  
  sb.connect( server, name, desc );
}

void draw(){
  // this will make it only render to screen when in EC draw mode
  if (!bDrawing) return;
  
  // blank out your background once
  if ( bNeedToClear ){
    bNeedToClear = false;
    background(0); // feel free to change the background color!
  }
  
  // ---- start person 1 ---- //
  if ( millis() - corpseStarted < 10000 ){
    noFill();
    stroke(255);
    rect(0,0, width / 3.0, height );
    fill(255);
  
  // ---- start person 2 ---- //
  } else if ( millis() - corpseStarted < 20000 ){
    noFill();
    stroke(255);
    rect(width / 3.0,0, width / 3.0, height );
    fill(255);
    
  // ---- start person 3 ---- JN// 
  } else if ( millis() - corpseStarted < 30000 ){
    noFill();
    stroke(255);    
    rect(width * 2.0/ 3.0,0, width / 3.0, height );
    noFill();
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

   if (second() % 2 == 0) {  
    jitter = random(-0.1, 0.1); //to be controled by mouse or slider
  }
  angle = angle + jitter;
  //float c = cos(angle);
  //translate(width, height);
  // rotate(c);
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
   image(myImage, x, mouseY); 
    
  
  //make stuff happen here:
  
  // ---- we're done! ---- //
  } else {
    sb.send( "doneExquisite", true );
    bDrawing = false;
  }
}

void mousePressed(){
  // for debugging, comment this out!
  sb.send( "doneExquisite", true );
}

void onBooleanMessage( String name, boolean value ){
  if ( name.equals("startExquisite") ){
    // start the exquisite corpse process!
    bDrawing = true;
    corpseStarted = millis();
    bNeedToClear = true;
  }
}

void onRangeMessage( String name, int value ){
}

void onStringMessage( String name, String value ){
}


