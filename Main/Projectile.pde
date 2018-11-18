/*
Description:
Authors:
Comments:
*/

class Projectile
{
  private float xPos; //current x-position
  private float yPos; //current y-position
  private float xSpeed; //speed on x-axis
  private float ySpeed; //speed on y-axis
  private int diameter; //diameter of projectile
  private String shotBy; //indicates if projectile was fired by Enemy or Player
  /*
  private ArrayList<Boss> bs; //Collection of Boss instances
  private ArrayList<Enemy> es; //Collection of Enemy instances
  Player p; //Reference to Player instance
  */
  color c; //Color of projectile
  
  Projectile(float newXPos, float newYPos, float newXSpeed, float newYSpeed, String newShotBy, color newColor)
  {
    xPos = newXPos;
    yPos = newYPos;
    xSpeed = newXSpeed;
    ySpeed = newYSpeed;
    diameter = 20;
    shotBy = newShotBy;
    c = newColor;
    
  }
  
  public void bossCollision()
  {
  }
  
  public void enemyCollision()
  {
  }
  
  public void playerCollision()
  {
  }
  
  public void move()
  {
    
  }
  
  public void display()
  {
    //this is a boss
    fill(0, 255, 0);
  rect(400,300, 200, 200);
  noFill();
  
    fill(255, 0, 0);
    ellipse(mouseX, mouseY, diameter, diameter);
    drawColPoint(400,300,200,200);
    noStroke();
  }
  
  public void drawColPoint(float picX, float picY, float picHeight, float picWidth)
  {
    //Checks top side of rect
    if(mouseY < picY && mouseX > picX && mouseX < picX + picWidth)
    {
      ellipse(mouseX, picY,10,10);
    }
    //Checks bottom side of rect
    else if (mouseY > picY + picHeight && mouseX > picX && mouseX < picX + picWidth)
    {
      ellipse(mouseX, picY + picHeight, 10, 10);
    }
    //Checks left side of rect
    else if (mouseX < picX)
    {
      //If projectile's y-position is less than the target the collision point is on the top corner
      if(mouseY < picY)
      {
        ellipse(picX, picY, 10, 10);
      }
      //if the projectile's y-position is higher than the target's y-position, the collision point is on the bottom corner
      else if (mouseY > picY + picHeight)
      {
        ellipse(picX, picY + picHeight, 10, 10);
      }
      //If none of the above, the collision point has the same y-position as the projectile
      else
      {
        ellipse(picX, mouseY, 10, 10);
      }
    }
    //Checks right side of rect
    else if (mouseX > picX + picWidth)
    {
      //If projectile's y-position is less than the target the collision point is on the top corner
      if(mouseY < picY)
      {
        ellipse(picX + picWidth, picY, 10, 10);
      }
      //if the projectile's y-position is higher than the target's y-position, the collision point is on the bottom corner
      else if (mouseY > picY + picHeight)
      {
        ellipse(picX + picWidth, picY + picHeight, 10, 10);
      }
      //If none of the above, the collision point has the same y-position as the projectile
      else
      {
        ellipse(picX + picWidth, mouseY, 10, 10);
      }
    }
  }
  
}
