/*
Description:
Authors:
Comments:
*/
class Explosion
{
  private float xPos;
  private float yPos;
  private int durationOneFrame = 500; //in milliseconds
  private int frame = 0;
  private int frameMax = 8;
  private int ticksLast = millis();
  private PImage spriteSheet = explosionSpriteSheet;
  private boolean animationEnded;
  
  Explosion(float x, float y)
  {
    xPos = x;
    yPos = y;
    animationEnded = false;
  }
  
  public void display()
  {
    imageMode(CENTER);
    //display frame from sprite sheet with Magic Numbers (frame 0 starts at (10, 168) with a size of 16x36 pixels):
    PImage f = spriteSheet.get(0 + (frame * 66), 0, 66, 66); //6
    image(f, 200, 100);
    int delta = millis() - ticksLast;
    if (delta >= durationOneFrame)
    {
      frame++;
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
