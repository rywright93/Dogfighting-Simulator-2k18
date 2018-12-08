/*
Description:
 Authors:
 Comments:
 */

class Pickup
{
  private int pickupType;// 4 possibilities: 0 = give shield, 1 = give gunType 1, 2 = give gunType 2, 3 = give gunType 3
  private int ticksLastUpdate;
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
    pickupType = newPickupType;
    pickupHeight = 10;
    pickupWidth = 10;
    isPickedUp = false;
    destroyed = false;
  }

  public void move()
  {
    yPos += ySpeed * float(millis() - ticksLastUpdate) * 0.001;
    if (yPos > height)
    {
      destroy();
    }
  }

  public void giveShield()
  {
    if (pickupType == 0)
    {
      player.setShieldActive(true);
    }
  }

  public void giveGun()
  {
    if (pickupType == 1)
    {
      player.setGunType(1);
    }
    if (pickupType == 2)
    {
      player.setGunType(2);
    }
    if (pickupType == 3)
    {
      player.setGunType(3);
    }
  }

  public void destroy()
  {
    if (isPickedUp == true)
    {
      xPos = -1000;
      destroyed = true;
    }
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
