/*
Description:
 Authors:
 Comments:
 */

class Pickup
{
  private int pickupType;// 4 possibilities: 0 = give shield, 1 = give gunType 1, 2 = give gunType 2, 3 = give gunType 3
  private int ticksLastUpdate;
  private float xPos; //current x-position
  private float yPos; //current y-position
  private float ySpeed; //speed by which it moves along the y-axis
  private int pickupWidth; //width of pickup
  private int pickupHeight; //height of pickup
  private boolean isPickedUp; //indicates if player has collided with it
  private boolean destroyed;

  //Constructor
  Pickup(float newXPos, float newYPos, int newPickupType)
  {
    xPos = newXPos;
    yPos = newYPos;
    ySpeed = 200;
    ticksLastUpdate = millis();
    pickupType = newPickupType;
    pickupHeight = 50;
    pickupWidth = 50;
    isPickedUp = false;
    destroyed = false;
  }

  //Call every method in Pickup required to update Pickup
  public void update()
  {
    move();
    display();
  }

  //Change the position of Pickup depending on its movement speed
  public void move()
  {
    yPos += ySpeed * float(millis() - ticksLastUpdate) * 0.001;
    ticksLastUpdate = millis();
    //If it crosses the bottom border of the screen, destroy it
    if (yPos > height)
    {
      destroy();
    }
  }

  //Display the pickup at its current position
  public void display()
  {
    noStroke();
    fill(random(0,255), random(0,255), random(0, 255));
    rect(xPos, yPos, pickupHeight, pickupWidth);
    
  }

  //Gives the player an extra shield charge
  public void giveShield()
  {
    player.setShieldCharge();
  }
  
  //Changes the players gunType
  public void giveGun()
  {
    if(pickupType > 0 && pickupType < 4)
    {
      player.setGunType(pickupType);
    }
  }
  
  //Calls the appropriate method depending on which pickupType it is
  public void triggerPickup()
  {
    //Instantiate an array of Confetti, to make a confetti explosion when picked up by player
    for (int i = 0; i < curLevel.getParticles().length; i++)
    {
      curLevel.getParticles()[i] = new Confetti(xPos + pickupWidth, yPos + pickupHeight, random(-200, 200),random(-400, 0));
    }
  
    if (pickupType == 0)
    {
      giveShield();
    } 
    if (pickupType >= 1);
    {
      giveGun();
    }
    destroy();
    isPickedUp = true;
  }
  
  //moves pickup off-screen
  public void destroy()
  {
    xPos = -1000;
    destroyed = true;
  }

  public int getPickupType()
  {
    return pickupType;
  }

  public float getXPos()
  {
    return xPos;
  }

  public float getYPos()
  {
    return yPos;
  }

  public int getPickupWidth()
  {
    return pickupWidth;
  }

  public int getPickupHeight()
  {
    return pickupHeight;
  }

  public boolean getIsPickedUp()
  {
    return isPickedUp;
  }

  public boolean getDestroyed()
  {
    return destroyed;
  }
}
