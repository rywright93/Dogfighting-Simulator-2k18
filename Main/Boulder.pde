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
  private int obstacleType; //type 0 is a boulder. type 1 is a pool of mud
  
  Boulder(float newXPos, float newYPos, int newObstacleType)
  {
    xPos = newXPos;
    yPos = newYPos;
    ySpeed = 200;
    boulderWidth = 140;
    boulderHeight = 140;
    obstacleType = newObstacleType;
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
    if(obstacleType == 0)
    {
      fill(210, 210, 210);
      rect(xPos, yPos, boulderWidth, boulderHeight);
      noFill();
    }
    else if(obstacleType == 1)
    {
      fill(115, 71, 45);
      rect(xPos, yPos, boulderWidth, boulderHeight);
      noFill();
    }
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
  
  public int getObstacleType()
  {
    return obstacleType;
  }
}
