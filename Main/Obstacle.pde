/*
Description: An obstacle on the road which the player can collide with.
Authors: Ryan and Casper
Comments:
*/

class Obstacle
{
  private float xPos; //current x-position of the Obstacle
  private float yPos; //current y-position of the Obstacle
  private float ySpeed; //speed by which it moves along the y-axis
  private float obstacleWidth; //width of the obstacle
  private float obstacleHeight; //height of the obstacle
  private int ticksLastUpdate = millis(); //time fix used to make movement the same across different hardware
  private int obstacleType; //type 0 is a boulder. type 1 is a pool of mud
  
  Obstacle(float newXPos, float newYPos, int newObstacleType)
  {
    xPos = newXPos;
    yPos = newYPos;
    ySpeed = 200;
    obstacleWidth = 140;
    obstacleHeight = 140;
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
      fill(30, 30, 30);
      rect(xPos, yPos, obstacleWidth, obstacleHeight);
      noFill();
    }
    else if(obstacleType == 1)
    {
      fill(115, 71, 45);
      rect(xPos, yPos, obstacleWidth, obstacleHeight);
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
  
  public float getObstacleHeight()
  {
    return obstacleHeight;
  }
  
  public float getObstacleWidth()
  {
    return obstacleWidth;
  }
  
  public int getObstacleType()
  {
    return obstacleType;
  }
}
