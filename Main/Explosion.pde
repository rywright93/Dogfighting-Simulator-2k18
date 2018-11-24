/*
Description:
Authors:
Comments:
*/
float xPos;
float yPos;
int durationOneFrame = 200; //in milliseconds
int frame = 0;
int frameMax = 8;
int ticksLast = millis();
PImage spriteSheet = explosionSpriteSheet;

void Explosion(float x, float y)
{
  xPos = x;
  yPos = y;
}

void display()
{
 imageMode(CENTER);
 //display frame from sprite sheet
 PImage f = spriteSheet.get(0 + (frame * 66), 0, 66, 66);
 image(f, xPos, yPos);
 int delta = millis() - ticksLast;
 if (delta >= durationOneFrame)
 {
   frame++;
   if (frame >= frameMax) { frame = 0; } 
   ticksLast += delta; //avoids adding up error
 }
}
