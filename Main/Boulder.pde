/*
Description: A boulder on the road which the player can collide with
Authors: Ryan and Casper
Comments:
*/

class Boulder
{
  private float xPos; //current x-position of the Boulder
  private float yPos; //current y-position of the Boulder
  private float ySpeed; //speed by which it moves along the y-axis
  private float boulderWidth; //width of the boulder
  private float boulderHeight; //height of the boulder
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
  
  public float getXPos()
  {
    return xPos;
  }
  
  public float getBoulderHeight()
  {
    return boulderHeight;
  }
  
  public float getBoulderWidth()
  {
    return boulderWidth;
  }
}
