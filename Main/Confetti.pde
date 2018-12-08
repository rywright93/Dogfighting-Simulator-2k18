class Confetti
{
 float xPos = 0;
 float yPos = 0;
 float xSpeed = 0;
 float ySpeed = 0;
 color c=color(int(random(128, 256)), int(random(128, 256)),int(random(128, 256)));
 float gravity = 8;
 private int ticksLastUpdate = millis(); //time fix used to make movement the same across different hardware
 //constructor gets position in pixels and x and y velocities, and sets the class variables accordingly
 Confetti(float newXPos, float newYPos, float newXSpeed, float newYSpeed)
 {
 xPos = newXPos;
 yPos = newYPos;
 xSpeed = newXSpeed;
 ySpeed = newYSpeed;
 }
 void display()
 {
 stroke(c);
 strokeWeight(5);
 point(xPos, yPos);
 } 
 void move()
 { 
   xPos += xSpeed * float(millis() - ticksLastUpdate) * 0.001;
   yPos += ySpeed * float(millis() - ticksLastUpdate) * 0.001;
   ticksLastUpdate = millis();
   ySpeed += gravity;
 }
}
