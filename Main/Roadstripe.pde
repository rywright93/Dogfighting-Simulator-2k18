/*
Description:
Authors:
Comments:
*/

class Roadstripe
{
  private float xPos;
  private float yPos;
  private float ySpeed;
  private float stripeHeight;
  private float stripeWidth;
  private int ticksLastUpdate = millis(); //time fix used to make movement the same across different hardware
  
  Roadstripe(float newYPos)
  {
    stripeWidth = 20;
    stripeHeight = 50;
    xPos = width/2 - stripeWidth/2;
    yPos = newYPos;
    ySpeed = 200;
  }
  
  public void update()
  {
    move();
    display();
  }
  
  public void move()
  {
    if(yPos > height)
    {
      yPos = 0 - stripeHeight;
    }
    yPos += ySpeed * float(millis() - ticksLastUpdate) * 0.001;
    ticksLastUpdate = millis(); 
  }
  
  public void display()
  {
    fill(255);
    rect(xPos, yPos, stripeWidth, stripeHeight);
    noFill();
  }
  
}
