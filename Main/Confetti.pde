/*
Description: A simple particle system that adds a colorful explosion when the player picks up a pickup.
*/

class Confetti
{
 private float xPos = 0; //current x-position
 private float yPos = 0; //current y-position
 private float xSpeed = 0; //movement speed along x-axis
 private float ySpeed = 0; //movement speed along y-axis
 private color c=color(int(random(128, 256)), int(random(128, 256)),int(random(128, 256))); //assigns a somewhat random color to Confetti
 private float gravity = 8; //value which will be added to y-speed
 private int ticksLastUpdate = millis(); //time fix used to make movement the same across different hardware
 
 Confetti(float newXPos, float newYPos, float newXSpeed, float newYSpeed)
 {
   xPos = newXPos;
   yPos = newYPos;
   xSpeed = newXSpeed;
   ySpeed = newYSpeed;
 }
 
 //display the Confetti on screen
 void display()
 {
 stroke(c);
 strokeWeight(5);
 point(xPos, yPos);
 }
 
 //moves the position of the Confetti based on x and y speed
 void move()
 { 
   xPos += xSpeed * float(millis() - ticksLastUpdate) * 0.001;
   yPos += ySpeed * float(millis() - ticksLastUpdate) * 0.001;
   ticksLastUpdate = millis();
   ySpeed += gravity;
 }
}
