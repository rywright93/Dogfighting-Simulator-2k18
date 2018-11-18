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
  private float diameter; //diameter of projectile
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
    xPos = mouseX;
    yPos = mouseY;
  }
  
  public void display()
  {
    //If the rectangle and projectile the fill changes
    if(drawColPoint(400,300,200,200) == true)
    {
      fill(0, 255, 0);
    }
    else
    {
      fill(0,0,255);
    }
    //this is a boss
    rect(400,300, 200, 200);
    noFill();
    //move the projectile's position
    move();
    fill(255, 0, 0);
    //This represents the projectile
    ellipse(xPos, yPos, diameter, diameter);
    noStroke();
  }
  
  //Checks collision between a projectile and a rectangle. Returns true if they collide
  public boolean drawColPoint(float picX, float picY, float picHeight, float picWidth)
  {
    float closestX = 0;
    float closestY = 0;
    //Checks top side of rect
    if(yPos < picY && xPos > picX && xPos < picX + picWidth)
    {
      closestX = xPos;
      closestY = picY;
    }
    //Checks bottom side of rect
    else if (yPos > picY + picHeight && xPos > picX && xPos < picX + picWidth)
    {
      closestX = xPos;
      closestY = picY + picHeight;
    }
    //Checks left side of rect
    else if (xPos < picX)
    {
      //If projectile's y-position is less than the target the collision point is on the top corner
      if(yPos < picY)
      {
        closestX = picX;
        closestY = picY;
      }
      //if the projectile's y-position is higher than the target's y-position, the collision point is on the bottom corner
      else if (yPos > picY + picHeight)
      {
        closestX = picX;
        closestY = picY + picHeight;
      }
      //If none of the above, the collision point has the same y-position as the projectile
      else
      {
        closestX = picX;
        closestY = yPos;
      }
    }
    //Checks right side of rect
    else if (xPos > picX + picWidth)
    {
      //If projectile's y-position is less than the target the collision point is on the top corner
      if(yPos < picY)
      {
        closestX = picX + picWidth;
        closestY = picY;
      }
      //if the projectile's y-position is higher than the target's y-position, the collision point is on the bottom corner
      else if (yPos > picY + picHeight)
      {
        closestX = picX + picWidth;
        closestY = picY + picHeight;
      }
      //If none of the above, the collision point has the same y-position as the projectile
      else
      {
        closestX = picX + picWidth;
        closestY = yPos;
      }
    }
    //Checks if the projectile is inside of the target rectangle
    else if (xPos > picX && xPos < picX + picWidth && yPos > picY && yPos < picY + picHeight)
    {
      return true;
    }
    
    //Display the closest point to the Projectile on the rectangle
    ellipse(closestX, closestY, 10, 10);
    
    //If the distance between the closest point on the rectangle and the projectile is less than the projectile's radius, they have collided
    if(dist(xPos, yPos, closestX, closestY) < diameter/2)
    {
      return true;
    }
    //If not. They have not collided
    else
    {
      return false;
    }
  }
  
}
