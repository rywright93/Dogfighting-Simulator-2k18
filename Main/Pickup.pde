/*
Description:
Authors:
Comments:
*/

class Pickup
{
  private int pickupType;
  private float xPos;
  private float yPos;
  private PImage pickupPic;
  private int pickupWidth;
  private int pickupHeight;
  private boolean isPickedUp;
  
  Pickup(float newXPos, float newYPos, int newPickupType)
  {
  }
  
  public void move()
  {
  }
  
  public void giveShield()
  {
  }
  
  public void giveGun()
  {
  }
  
  public void destroy()
  {
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
}
