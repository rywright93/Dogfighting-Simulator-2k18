/*
Description:
 Authors:
 Comments:
 */

class Pickup
{
  private int pickupType;// 4 possibilities: 0 = give shield, 1 = give gunType 1, 2 = give gunType 2, 3 = give gunType 3
  private int ticksLastUpdate;
  private int colorUpdate;
  private int colorTimer;
  private float xPos;
  private float yPos;
  private float ySpeed;
  private int pickupWidth;
  private int pickupHeight;
  private boolean isPickedUp;
  private boolean destroyed;

  Pickup(float newXPos, float newYPos, int newPickupType)
  {
    xPos = newXPos;
    yPos = newYPos;
    ySpeed = 200;
    ticksLastUpdate = millis();
    colorUpdate = millis();
    pickupType = newPickupType;
    pickupHeight = 50;
    pickupWidth = 50;
    isPickedUp = false;
    destroyed = false;
  }

  public void update()
  {
    move();
    display();
  }

  public void move()
  {
    yPos += ySpeed * float(millis() - ticksLastUpdate) * 0.001;
    ticksLastUpdate = millis();
    if (yPos > height)
    {
      destroy();
    }
  }

  public void display()
  {
    noStroke();
    fill(random(0,255), random(0,255), random(0, 255));
    rect(xPos, yPos, pickupHeight, pickupWidth);
    
  }

  public void giveShield()
  {
    player.setShieldCharge();
  }

  public void giveGun()
  {
    if(pickupType > 0 && pickupType < 4)
    {
      player.setGunType(pickupType);
    }
  }

  public void triggerPickup()
  {
    println("type is: " + pickupType);
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
