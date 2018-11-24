/*
Description:
Authors:
Comments:
*/
class Explosion
{
  float xPos;
  float yPos;
  int durationOneFrame = 150; //in milliseconds
  int frame = 0;
  int frameMax = 8;
  int ticksLast = millis();
  PImage spriteSheet = explosionSpriteSheet;
  
  Explosion(float x, float y)
  {
    xPos = x;
    yPos = y;
  }
  
  public void display()
  {
   imageMode(CENTER);
   //display frame from sprite sheet
   PImage f = explosionSpriteSheet.get(0 + (frame * 66), 0, 66, 66);
   image(f, xPos, yPos);
   int delta = millis() - ticksLast;
   if (delta >= durationOneFrame)
   {
     frame++;
     if (frame >= frameMax) { frame = 0; } 
     ticksLast += delta; //avoids adding up error
   }
  }
}
