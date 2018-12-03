/*
Description: A boulder on the road which the player can collide with
Authors: Ryan and Casper
Comments:
*/

class Boulder
{
  private float xPos;
  private float yPos;
  private float ySpeed;
  private float boulderWidth;
  private float boulderHeight;
  private int ticksLastUpdate = millis(); //time fix used to make movement the same across different hardware
  
  Boulder(float newXPos, float newYPos)
  {
    xPos = newXPos;
    yPos = newYPos;
    ySpeed = 200;
    boulderWidth = 140;
    boulderHeight = 140;
  }
  
  void update()
  {
    move();
    display();
  }
  
  void move()
  {
    yPos += ySpeed * float(millis() - ticksLastUpdate) * 0.001;
    ticksLastUpdate = millis(); 
  }
  
  void display()
  {
    fill(210, 210, 210);
    rect(xPos, yPos, boulderWidth, boulderHeight);
    noFill();
  }
  
  public float getYPos()
  {
    return yPos;
  }
}
