/*
Description: The player character
Authors:
Comments:
*/

class Player
{
  private float xSpeed;
  private float ySpeed;
  private float xPos;
  private float yPos;
  private int playerHeight;
  private int playerWidth;
  private int shieldCharges;
  private int gunType;
  private boolean shieldActive;
  private int hitPoints;
  private PImage playerPic;
  private ArrayList<Enemy> enemies;
  private ArrayList<Boss> bosses;
  private ArrayList<Pickup> pickups;
  
  Player()// constructor, provides starting position to player objects toward bottom of screen
  {
    xPos = width/2;
    yPos = height - 100;
  }
  
  public void display()// draws player on screen
  {
    strokeWeight(0);
    fill(255, 14, 30);
    rect(xPos, yPos, 15, 30);
  }
  
  public void move()//method to run every frame, updates position of player
  {
    xPos = xPos + xSpeed;
    yPos = yPos + ySpeed;
  }
  
  public void borderCollision()
  {
    if (yPos >= height)
    {
      yPos = height;
    }
    if (yPos <= 0)
    {
      yPos = 0;
    }
    if (xPos >= width)
    {
      xPos = width;
    }
    if (xPos <= 0)
    {
      xPos = 0;
    }
  }
  
  public void shoot()
  {
    
  }
  
  public void shield()
  {
  }
  
  public void isHit()
  {
  }
  
  public void pickupCollision()
  {
  }
  
  public void enemyCollision()
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
  
  public int getPlayerHeight()
  {
    return playerHeight;
  }
  
  public int getPlayerWidth()
  {
    return playerWidth;
  }
  
  public boolean getShieldActive()
  {
    return shieldActive;
  }
  
  public void setShieldCharge()
  {
  }
  
  public void bossCollision()
  {
  }
  
  public void destroy()
  {
  }
  
  public void setGunType(int gun)
  {
    
  }
}
