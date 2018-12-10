/*
Description: 
Comments: A purely visual addition to the game to simulate driving on a road
*/

class Roadstripe
{
  private float xPos; //current x-position 
  private float yPos; //current y-position
  private float ySpeed; //speed by which it moves along the y-axis
  private float stripeHeight; //height of roadStripe
  private float stripeWidth; //width of roadStripe
  private int ticksLastUpdate = millis(); //time fix used to make movement the same across different hardware
  
  //Constructor
  Roadstripe(float newYPos)
  {
    stripeWidth = 20;
    stripeHeight = 50;
    xPos = width/2 - stripeWidth/2;
    yPos = newYPos;
    ySpeed = 200;
  }
  
  //Call every method in Roadstripe required to update Roadstripe
  public void update()
  {
    move();
    display();
  }
  
  //Change the position of roadstripe depending on its speed
  public void move()
  {
    //If the roadstripe crosses the bottom border of the screen it is moved to the top of the screen
    if(yPos > height)
    {
      yPos = 0 - stripeHeight;
    }
    yPos += ySpeed * float(millis() - ticksLastUpdate) * 0.001;
    ticksLastUpdate = millis(); 
  }
  
  //Display the roadstripe at its current position
  public void display()
  {
    fill(255);
    rect(xPos, yPos, stripeWidth, stripeHeight);
    noFill();
  }
  
}
