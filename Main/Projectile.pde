/*
Description: Projectiles that the Player, boss and enemies fire. It detects collision with obstacles, the player, bosses, and enemies.
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
  private color c; //Color of projectile
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
  //Call every method in Projectile required to update Projectile
  public void update()
  {
    bossCollision();
    enemyCollision();
    playerCollision();
    obstacleCollision();
    display();
    move();
  }

  //Detects collision with instances of Boss in the arraylist bosses
  public void bossCollision()
  {
    //A for-each loop which checks collision for every instance of Boss in bosses list.
    for (Boss b : curLevel.getBosses()) 
    {
      //If the projectile collides with boss, and it was shot by the player
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
    //Moves the Projectile off screen
    xPos = -1000;
    yPos = 0;
    //Stops its velocity
    xSpeed = 0;
    ySpeed = 0;

    destroyed = true;
  }

  //Detects collision with instances of Enemy in the arraylist enemies
  public void enemyCollision()
  {
    //A for-each loop which checks collision for every instance of Enemy in enemies list.
    for (Enemy e : curLevel.getEnemies()) 
    {
      //If the projectile collides with e and it was shot by the player
      if (drawColPoint(e.getXPos(), e.getYPos(), e.getEnemyHeight(), e.getEnemyWidth()) == true && shotBy == "Player")
      {
        curLevel.getExplosions().add(new Explosion(xPos, yPos)); //Instantiates an explosion animation at current position
        e.isHit();
        destroy();
      }
    }
  }

  //Detects collision with instances of Player
  public void playerCollision()
  {
    //If the projectile collides with the player and it was shot by either an enemy or boss
    if (drawColPoint(player.getXPos(), player.getYPos(), player.getPlayerHeight(), player.getPlayerWidth()) == true && shotBy == "Enemy" || shotBy == "Boss")
    {
      if (player.getShieldActive() == false)//if shield is not active, hit player
      {
        player.isHit();
        destroy();
      } else if (player.getShieldActive() == true)//if shield is active, no damage to player, destroy projectile
      {
        destroy();
      }
    }
  }

  //Detects collision with instances of Obstacle in the arraylist obstacles
  public void obstacleCollision()
  {
    //A for-each loop which checks collision for every instance of Enemy in enemies list.
    for (Obstacle o : curLevel.getObstacles()) 
    {
      //If projectile collides with obstacle, the obstacle is a boulder (and not mud)
      if (drawColPoint(o.getXPos(), o.getYPos(), o.getObstacleHeight(), o.getObstacleWidth()) == true && o.getObstacleType() == 0)
      {
        curLevel.getExplosions().add(new Explosion(xPos, yPos)); //Instantiates an explosion animation at current position
        destroy();
      }
    }
  }


  //moves the location of the Projectile based on its speed along the x and y axes
  public void move()
  {
    xPos += xSpeed * float(millis() - ticksLastUpdate) * 0.001;
    yPos += ySpeed * float(millis() - ticksLastUpdate) * 0.001;
    ticksLastUpdate = millis(); 

    //If the Projectile is above the screen, destroy it
    if (yPos + diameter/2 < 0)
    {
      destroy();
    }

    //If the Projectile is below the screen, destroy it
    if (yPos - diameter/2 > height)
    {
      destroy();
    }
  }

  //Displays the projectile at its current location
  public void display()
  {
    fill(c);
    ellipse(xPos, yPos, diameter, diameter);//This represents the projectile
    noStroke();
  }

  //Checks collision between a projectile and a rectangle. The parameters it takes are that of the Enemy/Player/Boss picture. Returns true if they collide
  public boolean drawColPoint(float picX, float picY, float picHeight, float picWidth)
  {
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
