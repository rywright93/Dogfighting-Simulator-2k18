/*
Description: An obstacle on the road which the player can collide with.
Authors: 
Comments: Can both be a boulder which destroys the player, and a pool of mud which slows them down.
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
  
  //Constructor
  Obstacle(float newXPos, float newYPos, int newObstacleType)
  {
    xPos = newXPos;
    yPos = newYPos;
    ySpeed = 200;
    obstacleWidth = 140;
    obstacleHeight = 140;
    obstacleType = newObstacleType;
  }
  
  //Updates everything that needs updating in Obstacle.
  void update()
  {
    move();
    display();
  }
  
  //Change the position of Obstacle based on its movement speed
  void move()
  {
    yPos += ySpeed * float(millis() - ticksLastUpdate) * 0.001;
    ticksLastUpdate = millis(); 
  }
  
  //Display Obstacle at its current location
  void display()
  {
    //If type is 0, it's a boulder
    if(obstacleType == 0)
    {
      fill(30, 30, 30);
      rect(xPos, yPos, obstacleWidth, obstacleHeight);
      noFill();
    }
    //if type is 1, it's a pool of mud
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
