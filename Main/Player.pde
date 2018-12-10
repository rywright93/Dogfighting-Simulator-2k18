/*
Description: The player character
 Comments:
 */

class Player
{
  private float xSpeed; //speed by which it moves along the x-axis
  private float ySpeed; //speed by which it moves along the y-axis
  private float xPos; //current x-position
  private float yPos; //current y-position
  private float playerHeight; //height of the player
  private float playerWidth; //width of the player
  private int shieldCharges; //number of times the player can use shield
  private int gunType; //indicates the type of gun currently active
  private boolean shieldActive; //indicates whether the shield is currently active
  private int hitPoints; //the health of the player
  private PImage playerPic = playerSprite;
  private float fireRate;//Delay between shots in milliseconds
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
    shieldEffectLength = 3000;//Value in milliseconds
    fireRate = 200;//Value in milliseconds
    shieldActive = false;
    isDead = false;
  }

  //Call every method in Player required to update Player
  public void update()
  {
    display();
    move(); 
    borderCollision();
    enemyCollision();
    bossCollision();
    pickupCollision();
    obstacleCollision();
    shield();
    
     if (keys[5] == true)//if space bar is pressed
    {
      shoot();
    }
  }

  //Displays player instance every frame on screen
  public void display()
  {
    strokeWeight(0);
    image(playerPic, xPos, yPos);
    
    if (shieldActive == true)
    {
      //Draws a rectangular shield around the player
      noFill();
      stroke(0, 255, 0);
      strokeWeight(3);
      rect(xPos, yPos, playerWidth + 1, playerHeight + 1);
      fill(0, 255, 0);
      //Depleting bar indicating how long the shield lasts
      rect(xPos, yPos + playerHeight + 10, -map((float)millis(), (float)lastShieldFiredAt, (float)lastShieldFiredAt + (float)shieldEffectLength, 0, playerWidth), 10);
      noStroke();
      noFill();
    }
  }

  //Updates position of player
  public void move()
  {
    if (keys[0] == true)//Moves player up when up arrow is pressed
    {
      yPos -= ySpeed * float(millis() - ticksLastUpdate) * 0.001;
    }
    if (keys[1] == true)//Moves player left when left arrow is pressed
    {
      xPos -= xSpeed * float(millis() - ticksLastUpdate) * 0.001;
    }
    if (keys[2] == true)//Moves player down when down arrow is pressed
    {
      yPos += ySpeed * float(millis() - ticksLastUpdate) * 0.001;
    }
    if (keys[3] == true)//Moves player right when right arrow is pressed
    {
      xPos += xSpeed * float(millis() - ticksLastUpdate) * 0.001;
    }
    ticksLastUpdate = millis();
  }

  //Checks if Player collides with screen borders and stops movement if that's the case
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

  //Player instantiates Projectile by pressing space bar
  public void shoot()
  {
    //Depending on gunType, the player shoots in different patterns
    if (gunType == 1)
    {
      if (millis() > lastProjectileFiredAt)
      {
        lastProjectileFiredAt = millis() + fireRate;
        curLevel.getProjectiles().add(new Projectile(xPos + playerWidth/2, yPos, 0.0, -400.0, "Player", color(0, 255, 0), 15));
      }
    } else if (gunType == 2)
    {
      if (millis() > lastProjectileFiredAt)
      {
        lastProjectileFiredAt = millis() + fireRate/2;
        curLevel.getProjectiles().add(new Projectile(xPos + playerWidth/4, yPos, 0.0, -400.0, "Player", color(0, 255, 0), 7));
        curLevel.getProjectiles().add(new Projectile(xPos + (playerWidth/4 * 3), yPos, 0.0, -400.0, "Player", color(0, 255, 0), 7));
      }
    } else if (gunType == 3)
    {
      if (millis() > lastProjectileFiredAt)
      {
        lastProjectileFiredAt = millis() + fireRate*1.5;
        curLevel.getProjectiles().add(new Projectile(xPos + playerWidth/2, yPos, -50.0, -400.0, "Player", color(0, 255, 0), 18));
        curLevel.getProjectiles().add(new Projectile(xPos + playerWidth/2, yPos, 0.0, -400.0, "Player", color(0, 255, 0), 18));
        curLevel.getProjectiles().add(new Projectile(xPos + playerWidth/2, yPos, 50, -400.0, "Player", color(0, 255, 0), 18));
      }
    }
  }

  //Sets conditions to activate shield, and keeps player from taking damage when colliding with Projectile and Enemy
  public void shield()
  {
    if (shieldActive == false && shieldCharges > 0 && keys[4] == true) //if the player has shield charges && presses 'e' key
    {
      if (millis() > lastShieldFiredAt)//sets shield active to true
      {
        shieldActive = true;
        shieldCharges--;
        lastShieldFiredAt = millis() + shieldEffectLength;
      }
    }
    //Makes sure that the UI won't display negative numbers if player presses 'e' when having no shield 
    if (shieldCharges <= 0)
    {
      shieldCharges = 0;
    }
    if (millis() > lastShieldFiredAt)//turns shield effect off after set number of miliseconds
    {
      shieldActive = false;
    }
  }
  
  //Player takes damage
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

  //Checks if player has collided with pickup
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

  //Checks if player has collided with enemy
  public void enemyCollision()
  {
    //A for each loop which checks collision for every instance of Enemy in enemies array list.
    for (Enemy e : curLevel.getEnemies())
    {
      //Player top border collision check
      if (yPos >= e.getYPos() && yPos <= e.getYPos() + e.getEnemyHeight() && xPos >= e.getXPos() && xPos <= e.getXPos() + e.getEnemyWidth())
      {
        //If shield is not active, both enemy and player gets hit
        if(shieldActive == false)
        {
          isHit();
          e.isHit();
        }
        //If shield is active, only enemy takes damage, and gets destroyed
        else if(shieldActive == true)
        {
          e.setHitPoints(0);
          e.isHit();
        }
      }

      //Player bottom border collision check
      if (yPos + playerHeight >= e.getYPos() && yPos + playerHeight <= e.getYPos() + e.getEnemyHeight() && xPos >= e.getXPos() && xPos <= e.getXPos() + e.getEnemyWidth())
      {
        if(shieldActive == false)
        {
          isHit();
        e.isHit();
        }
        else if(shieldActive == true)
        {
          e.setHitPoints(0);
          e.isHit();
        }
      }
      //Player left border collision check
      if (xPos >= e.getXPos() && xPos <= e.getXPos() + e.getEnemyWidth() && yPos + playerHeight >= e.getYPos() && yPos <= e.getYPos() + e.getEnemyHeight())
      {
        if(shieldActive == false)
        {
          isHit();
          e.isHit();
        }
        else if(shieldActive == true)
        {
          e.setHitPoints(0);
          e.isHit();
        }
      }

      //Player right border collision check
      if (xPos + playerWidth >= e.getXPos() && xPos + playerWidth <= e.getXPos() + e.getEnemyWidth() && yPos >= e.getYPos() && yPos <= e.getYPos() + e.getEnemyHeight())
      {
        if(shieldActive == false)
        {
          isHit();
          e.isHit();
        }
        else if(shieldActive == true)
        {
          e.setHitPoints(0);
          e.isHit();
        }
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
  
  public int getshieldCharge()
  {
    return shieldCharges;
  }
  
  //Checks if player has collided with boss
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
    setSpeed(300, 300); //reset the player movement speed to account for instances where the player has gotten out of mud
    
    //A for each loop which checks collision for every instance of Obstacle in obstacles array list.
    for (Obstacle o : curLevel.getObstacles())
    {
      //Player top border collision check
      if (yPos >= o.getYPos() && yPos <= o.getYPos() + o.getObstacleHeight() && xPos >= o.getXPos() && xPos <= o.getXPos() + o.getObstacleWidth())
      {
        //If the obstacle is a boulder, the player gets hit
        if(o.getObstacleType() == 0)
        {
          isHit();
        }
        //if the obstacle is a pool of mud, the player's speed gets slowed down
        else if (o.getObstacleType() == 1)
        {
          setSpeed(100,100);
        }
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
          setSpeed(100,100);
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
          setSpeed(100,100);
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
          setSpeed(100,100);
        }
      }
    }
  }

  public void destroy()
  {
    gameOver();
  }
  
  //Change the movement speed of the player
  public void setSpeed(float newXSpeed, float newYSpeed)
  {
    xSpeed = newXSpeed;
    ySpeed = newYSpeed;
  }
  
  //Change the gun type of the player
  public void setGunType(int gun)
  {
    gunType = gun;
  }
  
  //Reset variables back to default. Used when resetting the game
  public void resetPlayer()
  {
    isDead = false;
    gunType = 1;
    xPos = width/2-20;
    yPos = height - 100;
    shieldCharges = 3;
  }
}
