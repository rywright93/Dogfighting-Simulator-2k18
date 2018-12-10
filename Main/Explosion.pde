/*
Description:
Authors:
Comments:
*/

class Explosion
{
  private float xPos; //curent x position
  private float yPos; //current y position
  private int durationOneFrame = 100; //in milliseconds
  private int frame = 0; //keeps track of each frame in the animation should be displayed
  private int frameMax = 8; //number of frames in animation
  private int ticksLast = millis();
  private PImage spriteSheet = explosionSpriteSheet;
  private boolean animationEnded = false;
  
  //Constructor
  Explosion(float x, float y)
  {
    xPos = x;
    yPos = y;
  }
  
  //Display explosion in window at current position
  public void display()
  {
    imageMode(CENTER);
    PImage f = spriteSheet.get(0 + (frame * 66), 0, 66, 66); //displays part of the spritesheet
    image(f, xPos, yPos);
    imageMode(CORNER);
    int delta = millis() - ticksLast;
    //If more time has passed than the length of one frame
    if (delta >= durationOneFrame)
    {
      frame++; //switch frame
      if (frame >= frameMax) 
      { 
        animationEnded = true;
      } 
      //ticksLast = millis(); //adds up time overshooting error
      ticksLast += delta; //avoids adding up error
    }
  }
  
  public boolean getAnimationEnded()
  {
    return animationEnded;
  }
}
