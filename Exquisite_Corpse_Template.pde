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


float d;
float xPos;
float yPos;
float xVel;
float yVel;

PImage myImage;

void setup(){
  size( appWidth, appHeight );
  
  sb = new Spacebrew(this);
  sb.addPublish("doneExquisite", "boolean", false);
  sb.addPublish("slide", "range"); //jn slider 
  sb.addSubscribe("startExquisite", "boolean");
  
  myImage = loadImage("excorpse.png");//j loading image

  d = random(100,100); //jn
  xPos = random(d/2, width - (d/2)); //jn
  yPos = random(d/2, height - (d/2)); //jn
  xVel = random(-3,3);    //jn
  yVel = random(-3,3);    //jn
  
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
    noStroke();    
    rect(width * 2.0/ 3.0,0, width / 3.0, height );
    noFill();
  
  //make stuff happen here:
  frameRate (int("frame")); // trying to adjust frame rate?
  ellipse(xPos,yPos,d,d); //test ellipse 
     

   image(myImage,xPos, yPos); //
    xPos = xPos + xVel;
    yPos = yPos + yVel;
  if(xPos < (d/2)) {
    xVel = xVel*(-1);
     fill(255);
}
  else if(yPos < (d/2)){   
  yVel = yVel*(-1);
   fill(255);
}
  else if(xPos > width -(d/2)){
  xVel = xVel*(-1);
  fill(225);
}
  else if (yPos > height- (d/2)){
  yVel = yVel*(-1);
  fill(255);
}
  
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


