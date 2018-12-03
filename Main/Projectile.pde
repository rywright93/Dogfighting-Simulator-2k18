/*
Description: Projectiles that the Player and enemies fire.
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
  private boolean destroyed;
  color c; //Color of projectile
  private int ticksLastUpdate = millis(); //time fix used to make movement the same across different hardware

  //Constructor
  Projectile(float newXPos, float newYPos, float newXSpeed, float newYSpeed, String newShotBy, color newColor, int newDiameter)
  {
    xPos = newXPos;
    yPos = newYPos;
    xSpeed = newXSpeed;
    ySpeed = newYSpeed;
    diameter = newDiameter;
    shotBy = newShotBy;
    c = newColor;
    destroyed = false;
  }

  public void update()
  {
    bossCollision();
    enemyCollision();
    display();
    move();
  }

  //Detects collision with instances of Boss in the arraylist bosses
  public void bossCollision()
  {
    //A for each loop which checks collision for every instance of Boss in bosses list.
    for (Boss b : curLevel.getBosses()) 
    {
      if (drawColPoint(b.getXPos(), b.getYPos(), b.getBossHeight(), b.getBossWidth()) == true && shotBy == "Player")
      {
        curLevel.getExplosions().add(new Explosion(xPos, yPos)); //Instantiates an explosion animation at current position
        b.isHit();
        destroy();
      }
    }
  }

  //Used to move the projectile off-screen and stop it when it hits something (or misses entirely)
  public void destroy()
  {
    //Moves the Projectile to the corner of the screen
    xPos = 0;
    yPos = 0;
    //Stops its velocity
    xSpeed = 0;
    ySpeed = 0;

    destroyed = true;
  }

  //Detects collision with instances of Enemy in the arraylist enemies
  public void enemyCollision()
  {
    //A for each loop which checks collision for every instance of Enemy in enemies list.
    for (Enemy e : curLevel.getEnemies()) 
    {
      if (drawColPoint(e.getXPos(), e.getYPos(), e.getEnemyHeight(), e.getEnemyWidth()) == true && shotBy == "Player")
      {
        curLevel.getExplosions().add(new Explosion(xPos, yPos)); //Instantiates an explosion animation at current position
        e.isHit();
        destroy();
      }
    }
  }

  public void playerCollision()
  {
    if (drawColPoint(player.getXPos(), player.getYPos(), player.getPlayerHeight(), player.getPlayerWidth()) == true && shotBy == "Enemy" || shotBy == "Boss" && player.getShieldActive() == false)
    {
      player.isHit();
      destroy();
    }
    if (player.shieldActive == true)
    {
      destroy();
    }
  }


  //moves the location of the Projectile based on its speed along the x and y axes
  public void move()
  {
    xPos += xSpeed * float(millis() - ticksLastUpdate) * 0.001;
    yPos += ySpeed * float(millis() - ticksLastUpdate) * 0.001;
    ticksLastUpdate = millis(); 
    /*
    xPos += xSpeed;
     yPos += ySpeed;
     */

    //If the Projectile is above the screen, destroy it
    if (yPos + diameter/2 < 0)
    {
      destroy();
    }

    //If the Projectile is above the screen, destroy it
    if (yPos + diameter/2 > height)
    {
      destroy();
    }
  }

  //Displays the projectile in the window
  public void display()
  {
    /* 
     //If the rectangle and projectile the fill changes
     if(drawColPoint(400,300,200,200) == true)
     {
     fill(0, 255, 0);
     }
     else
     {
     fill(0,0,255);
     }
     //this represents is a boss
     rect(400,300, 200, 200);
     noFill();
     */
    fill(c);
    //This represents the projectile
    ellipse(xPos, yPos, diameter, diameter);
    noStroke();
  }

  //Checks collision between a projectile and a rectangle. The parameters it takes are that of the Enemy/Player picture. Returns true if they collide
  public boolean drawColPoint(float picX, float picY, float picHeight, float picWidth)
  {
    fill(255, 0, 0);
    float closestX = 0; //the x coordinate of the closest point to the projectile on the target rect
    float closestY = 0;//the y coordinate of the closest point to the projectile on the target rect

    //Checks top side of target rect
    if (yPos < picY && xPos >= picX && xPos <= picX + picWidth)
    {
      closestX = xPos;
      closestY = picY;
    }
    //Checks bottom side of rect
    else if (yPos > picY + picHeight && xPos >= picX && xPos <= picX + picWidth)
    {
      closestX = xPos;
      closestY = picY + picHeight;
    }
    //Checks left side of rect
    else if (xPos <= picX)
    {
      //If projectile's y-position is less than the target the collision point is on the top corner
      if (yPos < picY)
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
    else if (xPos >= picX + picWidth)
    {
      //If projectile's y-position is less than the target the collision point is on the top corner
      if (yPos < picY)
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
    //ellipse(closestX, closestY, 10, 10);
    noFill();

    //If the distance between the closest point on the rectangle and the projectile is less than the projectile's radius, they have collided
    if (dist(xPos, yPos, closestX, closestY) < diameter/2)
    {
      return true;
    }
    //If not, they have not collided
    else
    {
      return false;
    }
  }

  public boolean getDestroyed()
  {
    return destroyed;
  }

  public String getShotBy()
  {
    return shotBy;
  }
}
