/*
Description: The player character
 Authors: Ryan and Casper
 Comments:
 */

class Player
{
  private float xSpeed;
  private float ySpeed;
  private float xPos;
  private float yPos;
  private float playerHeight;
  private float playerWidth;
  private int shieldCharges;
  private int gunType;
  private boolean shieldActive;
  private int hitPoints;
  private PImage playerPic = playerSprite;
  private float fireRate;//Delay between shots in milliseconds
  private float shieldCooldown;//Delay between uses of sheild ability
  private float lastProjectileFiredAt; //indicates when the last shot was fire in milliseconds
  private float lastShieldFiredAt;//indicates when last shield charge was used
  private float shieldEffectLength;//number of milliseconds shield effect lasts when triggered
  private int ticksLastUpdate = millis(); //time fix used to make movement the same across different hardware
  private boolean isDead;

  // Constructor, provides starting values for all player variables
  Player(float newXPos, float newYPos)
  {
    xPos = newXPos;
    yPos = newYPos;
    playerHeight = playerPic.height;
    playerWidth = playerPic.width;
    xSpeed = 300;
    ySpeed = 300;
    shieldCharges = 3;
    gunType = 1;
    shieldActive = false;
    hitPoints = 1;
    //TO DO: PImage = something later but for now it's a square
    shieldEffectLength = 3000;//Value in milliseconds
    shieldCooldown = 1000;//Value in milliseconds
    fireRate = 200;//Value in milliseconds
    shieldActive = false;
    isDead = false;
  }

  public void update()
  {
    display();//Displays player instance every frame in Main
    move(); //Updates position of player every frame in Main
    borderCollision();//Checks if player is on screen border every frame in Main
    enemyCollision();//Checks if player has collided with enemy every frame in Main
    bossCollision();//Checks if player has collided with boss every frame in Main
    pickupCollision();//Checks if player has collided with pickup every frame in Main
    obstacleCollision();
    
     if (keys[5] == true)//if space bar is pressed
    {
      shoot();
    }
  }

  //Draws player on screen
  public void display()
  {
    strokeWeight(0);
    //fill(144, 11, 30);//Red
    //rect(xPos, yPos, playerWidth, playerHeight);
    image(playerPic, xPos, yPos);
  }

  //Updates position of player
  public void move()
  {
    if (keys[0] == true)//Moves player up when 'w' is pressed
    {
      yPos -= ySpeed * float(millis() - ticksLastUpdate) * 0.001;
    }
    if (keys[1] == true)//Moves player down when 'a' is pressed
    {
      xPos -= xSpeed * float(millis() - ticksLastUpdate) * 0.001;
    }
    if (keys[2] == true)//Moves player down when 's' is pressed
    {
      yPos += ySpeed * float(millis() - ticksLastUpdate) * 0.001;
    }
    if (keys[3] == true)//Moves player down when 'd' is pressed
    {
      xPos += xSpeed * float(millis() - ticksLastUpdate) * 0.001;
    }
    ticksLastUpdate = millis();
  }

  //Player collides with screen borders and stops moving
  public void borderCollision()
  {
    if (yPos + playerHeight >= height)//Bottom border
    {
      yPos = height - playerHeight;
    }
    if (yPos <= 0)//Top border
    {
      yPos = 0;
    }
    if (xPos + playerWidth >= width)//Right border
    {
      xPos = width - playerWidth;
    }
    if (xPos <= 0)//Left border
    {
      xPos = 0;
    }
  }

  //Player shoots by pressing space bar
  public void shoot()
  {
    //Sets projectile patterns for different gun types
    if (gunType == 0)
    {
      if (millis() > lastProjectileFiredAt)
      {
        lastProjectileFiredAt = millis() + fireRate;
        curLevel.getProjectiles().add(new Projectile(xPos + playerWidth/2, yPos, 0.0, -400.0, "Player", color(255, 0, 0), 15));
      }
    } else if (gunType == 1)
    {
      if (millis() > lastProjectileFiredAt)
      {
        lastProjectileFiredAt = millis() + fireRate/2;
        curLevel.getProjectiles().add(new Projectile(xPos + playerWidth/4, yPos, 0.0, -400.0, "Player", color(255, 0, 0), 7));
        curLevel.getProjectiles().add(new Projectile(xPos + (playerWidth/4 * 3), yPos, 0.0, -400.0, "Player", color(255, 0, 0), 7));
      }
    } else if (gunType == 2)
    {
      if (millis() > lastProjectileFiredAt)
      {
        lastProjectileFiredAt = millis() + fireRate*1.5;
        curLevel.getProjectiles().add(new Projectile(xPos + playerWidth/2, yPos, 0.0, -400.0, "Player", color(255, 0, 0), 20));
      }
    }
  }

  //Sets conditions to activate shield, and keeps player from taking damage when shield is active
  public void shield()
  {
    if (shieldActive == false && shieldCharges < 0 && keys[4] == true) //if the player has shield charges && presses 'e' key
    {
      if (millis() > lastShieldFiredAt)
      {
        shieldActive = true;
        shieldCharges--;
        lastShieldFiredAt = millis() + shieldCooldown;
      }
    }
    if (shieldCharges <= 0)
    {
      shieldCharges = 0;
    }
    if (millis() > lastShieldFiredAt + shieldEffectLength)//turns shield effect off after set number of seconds
    {
      shieldActive = false;
    }
  }

  public void isHit()
  {
    hitPoints--;

    if (hitPoints <= 0 && isDead == false)
    {
      hitPoints = 0;
      isDead = true;
      destroy();
    }
  }

  public void pickupCollision()
  {
    //A for each loop which checks collision for every instance of Enemy in enemies array list.
    for (Pickup pu : curLevel.getPickups())
    {
      //Player top border collision check
      if (yPos >= pu.getYPos() && yPos <= pu.getYPos() + pu.getPickupHeight() && xPos >= pu.getXPos() && xPos <= pu.getXPos() + pu.getPickupWidth())
      {
        pu.triggerPickup();
      }

      //Player bottom border collision check
      if (yPos + playerHeight >= pu.getYPos() && yPos + playerHeight <= pu.getYPos() + pu.getPickupHeight() && xPos >= pu.getXPos() && xPos <= pu.getXPos() + pu.getPickupWidth())
      {
        pu.triggerPickup();
      }
      //Player left border collision check
      if (xPos >= pu.getXPos() && xPos <= pu.getXPos() + pu.getPickupWidth() && yPos + playerHeight >= pu.getYPos() && yPos <= pu.getYPos() + pu.getPickupHeight())
      {
        pu.triggerPickup();
      }

      //Player right border collision check
      if (xPos + playerWidth >= pu.getXPos() && xPos + playerWidth <= pu.getXPos() + pu.getPickupWidth() && yPos >= pu.getYPos() && yPos <= pu.getYPos() + pu.getPickupHeight())
      {
        pu.triggerPickup();
      }
    }
  }

  //Player checks itself for colliding with Enemies, takes damage
  public void enemyCollision()
  {
    //A for each loop which checks collision for every instance of Enemy in enemies array list.
    for (Enemy e : curLevel.getEnemies())
    {
      //Player top border collision check
      if (yPos >= e.getYPos() && yPos <= e.getYPos() + e.getEnemyHeight() && xPos >= e.getXPos() && xPos <= e.getXPos() + e.getEnemyWidth())
      {
        isHit();
        e.isHit();
      }

      //Player bottom border collision check
      if (yPos + playerHeight >= e.getYPos() && yPos + playerHeight <= e.getYPos() + e.getEnemyHeight() && xPos >= e.getXPos() && xPos <= e.getXPos() + e.getEnemyWidth())
      {
        isHit();
        e.isHit();
      }
      //Player left border collision check
      if (xPos >= e.getXPos() && xPos <= e.getXPos() + e.getEnemyWidth() && yPos + playerHeight >= e.getYPos() && yPos <= e.getYPos() + e.getEnemyHeight())
      {
        isHit();
        e.isHit();
      }

      //Player right border collision check
      if (xPos + playerWidth >= e.getXPos() && xPos + playerWidth <= e.getXPos() + e.getEnemyWidth() && yPos >= e.getYPos() && yPos <= e.getYPos() + e.getEnemyHeight())
      {
        isHit();
        e.isHit();
      }
    }
  }

  public float getXPos()
  {
    return xPos;
  }

  public float getYPos()
  {
    return yPos;
  }

  public float getPlayerHeight()
  {
    return playerHeight;
  }

  public float getPlayerWidth()
  {
    return playerWidth;
  }

  public boolean getShieldActive()
  {
    return shieldActive;
  }
  
  public void setShieldActive(boolean newShieldActive)
  {
    shieldActive = newShieldActive;
  }

  public void setShieldCharge()
  {
    shieldCharges++;
  }

  public void bossCollision()
  {
    //A for each loop which checks collision for every instance of Boss in bosses array list.
    for (Boss b : curLevel.getBosses())
    {
      //Player top border collision check
      if (yPos >= b.getYPos() && yPos <= b.getYPos() + b.getBossHeight() && xPos >= b.getXPos() && xPos <= b.getXPos() + b.getBossWidth())
      {
        isHit();
        b.isHit();
      }

      //Player bottom border collision check
      if (yPos + playerHeight >= b.getYPos() && yPos + playerHeight <= b.getYPos() + b.getBossHeight() && xPos >= b.getXPos() && xPos <= b.getXPos() + b.getBossWidth())
      {
        isHit();
        b.isHit();
      }

      //Player left border collision check
      if (xPos >= b.getXPos() && xPos <= b.getXPos() + b.getBossWidth() && yPos + playerHeight >= b.getYPos() && yPos <= b.getYPos() + b.getBossHeight())
      {
        isHit();
        b.isHit();
      }

      //Player right border collision check
      if (xPos + playerWidth >= b.getXPos() && xPos + playerWidth <= b.getXPos() + b.getBossWidth() && yPos >= b.getYPos() && yPos <= b.getYPos() + b.getBossHeight())
      {
        isHit();
        b.isHit();
      }
    }
  }
  
  //Player checks itself for colliding with Obstacles
  public void obstacleCollision()
  {
    setSpeed(300, 300);
    //A for each loop which checks collision for every instance of Obstacle in obstacles array list.
    for (Obstacle o : curLevel.getObstacles())
    {
      //Player top border collision check
      if (yPos >= o.getYPos() && yPos <= o.getYPos() + o.getObstacleHeight() && xPos >= o.getXPos() && xPos <= o.getXPos() + o.getObstacleWidth())
      {
        if(o.getObstacleType() == 0)
        {
          isHit();
        }

        setSpeed(50,50);
      }

      //Player bottom border collision check
      if (yPos + playerHeight >= o.getYPos() && yPos + playerHeight <= o.getYPos() + o.getObstacleHeight() && xPos >= o.getXPos() && xPos <= o.getXPos() + o.getObstacleWidth())
      {
        if(o.getObstacleType() == 0)
        {
          isHit();
        }
        
        else if (o.getObstacleType() == 1)
        {
          setSpeed(50,50);
        }
      }
      //Player left border collision check
      if (xPos >= o.getXPos() && xPos <= o.getXPos() + o.getObstacleWidth() && yPos + playerHeight >= o.getYPos() && yPos <= o.getYPos() + o.getObstacleHeight())
      {
        if(o.getObstacleType() == 0)
        {
          isHit();
        }
        
        else if (o.getObstacleType() == 1)
        {
          setSpeed(50,50);
        }
      }

      //Player right border collision check
      if (xPos + playerWidth >= o.getXPos() && xPos + playerWidth <= o.getXPos() + o.getObstacleWidth() && yPos >= o.getYPos() && yPos <= o.getYPos() + o.getObstacleHeight())
      {
        if(o.getObstacleType() == 0)
        {
          isHit();
        }
        
        else if (o.getObstacleType() == 1)
        {
          setSpeed(50,50);
        }
      }
    }
  }

  public void destroy()
  {
    gameOver();
  }
  
  public void setSpeed(float newXSpeed, float newYSpeed)
  {
    xSpeed = newXSpeed;
    ySpeed = newYSpeed;
  }

  public void setGunType(int gun)
  {
    gunType = gun;
  }
  
  public void resetPlayer()
  {
    isDead = false;
  }
}
