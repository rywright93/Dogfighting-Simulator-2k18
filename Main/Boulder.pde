/*
Description: A boulder on the road which the player can collide with
Authors: Ryan and Casper
Comments:
*/

class Boulder
{
  float xPos;
  float yPos;
  float ySpeed;
  float boulderWidth;
  float boulderHeight;
  
  Boulder(float newXPos, float newYPos)
  {
    xPos = newXPos;
    yPos = newYPos;
    ySpeed = 5;
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
    yPos += ySpeed;
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
