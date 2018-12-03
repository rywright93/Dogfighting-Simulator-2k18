/*
Description: The player character
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
    boulderWidth = 150;
    boulderHeight = 150;
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
}
