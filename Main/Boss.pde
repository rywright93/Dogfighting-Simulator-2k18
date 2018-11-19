/*
Description:
Authors:
Comments:
*/

class Boss
{
  private float xPos;
  private float yPos;
  private float bossWidth;
  private float bossHeight;
  private PImage bossPic;
  private int hitPoints;
  
  public int colorTest = 0;
  
  Boss(int newHitPoints)
  {
    hitPoints = newHitPoints;
    bossWidth = 300;
    bossHeight = 200;
    xPos = 400;
    yPos = 300;
  }
  
  public void update()
  {
    display();
  }
  
  public void move()
  {
  }
  
  public void shoot()
  {
  }
  
  public void isHit()
  {
    hitPoints--;
  }

  public void destroy()
  {
  }
  
  public void display()
  {
    fill(colorTest, 0, 255);
    rect(xPos, yPos, bossWidth, bossHeight);
    noFill();
    textSize(25);
    text(hitPoints + " HP", xPos, yPos);
  }
  
  public float getXPos()
  {
    return xPos;
  }
  
  public float getYPos()
  {
    return yPos;
  }
  
  public float getBossHeight()
  {
    return bossHeight;
  }
  
  public float getBossWidth()
  {
    return bossWidth;
  }
  
  public void givePoints()
  {
  }
}
