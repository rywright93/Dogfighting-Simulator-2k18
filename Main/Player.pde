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
  private PImage playerPic;
  private float fireRate;//Delay between shots in milliseconds
  private float shieldCooldown;//Delay between uses of sheild ability
  private float lastProjectileFiredAt; //indicates when the last shot was fire in milliseconds
  private float lastShieldFiredAt;//indicates when last shield charge was used
  private float shieldEffectLength;//number of milliseconds shield effect lasts when triggered
  private int ticksLastUpdate = millis(); //time fix used to make movement the same across different hardware

  // Constructor, provides starting values for all player variables
  Player()
  {
    xPos = width/2;
    yPos = height - 100;
    playerHeight = 30;
    playerWidth = 15;
    xSpeed = 3.5;
    ySpeed = 3.5;
    shieldCharges = 3;
    gunType = 2;
    shieldActive = false;
    hitPoints = 1;
    //TO DO: PImage = something later but for now it's a square
    shieldEffectLength = 3000;//Value in milliseconds
    shieldCooldown = 1000;//Value in milliseconds
    fireRate = 200;//Value in milliseconds
  }

  public void update()
  {
    display();//Displays player instance every frame
    move(); //Updates position of player every frame
    borderCollision();//Checks if player is on screen border every frame
    enemyCollision();//Checks if player has collided with enemy every frame
  }

  //Draws player on screen
  public void display()
  {
    strokeWeight(0);
    fill(144, 11, 30);//Red
    rect(xPos, yPos, playerWidth, playerHeight);
  }

  //Updates position of player
  public void move()
  {
    if (keyPressed == true)
    {
      if (key == 119)//Moves player up when 'w' is pressed
      {
        yPos = yPos - ySpeed;
      } else if (key == 115)//Moves player down when 's' is pressed
      {
        yPos = yPos + ySpeed;
      } else if (key == 100)//Moves player down when 'd' is pressed
      {
        xPos = xPos + xSpeed;
      } else if (key == 97)//Moves player down when 'a' is pressed
      {
        xPos = xPos - xSpeed;
      }
    }
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
    if (key == 32)//if space bar is pressed
    {
      if (gunType == 0)
      {
        if (millis() > lastProjectileFiredAt)
        {
          lastProjectileFiredAt = millis() + fireRate;
          projectiles.add(new Projectile(xPos + playerWidth/2, yPos, 0.0, -400.0, "Player", color(255, 0, 0), 15));
        }
      } else if (gunType == 1)
      {
        if (millis() > lastProjectileFiredAt)
        {
          lastProjectileFiredAt = millis() + fireRate/2;
          projectiles.add(new Projectile(xPos + playerWidth/4, yPos, 0.0, -400.0, "Player", color(255, 0, 0), 7));
          projectiles.add(new Projectile(xPos + (playerWidth/4 * 3), yPos, 0.0, -400.0, "Player", color(255, 0, 0), 7));
        }
      } else if (gunType == 2)
      {
        if (millis() > lastProjectileFiredAt)
        {
          lastProjectileFiredAt = millis() + fireRate*1.5;
          projectiles.add(new Projectile(xPos + playerWidth/2, yPos, 0.0, -400.0, "Player", color(255, 0, 0), 20));
        }
      }
    }
  }

  //Sets projectile patterns for different gun types


  //Sets conditions to activate shield, and keeps player from taking damage when shield is active
  public void shield()
  {
    if ((shieldActive == false) && (shieldCharges < 0) && (keyPressed == true) && (key == 101)) //if the player has shield charges && presses 'e' key
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

    if (hitPoints <= 0)
    {
      hitPoints = 0;
      destroy();
    }
  }

  public void pickupCollision()
  {
  }

  //Player checks itself for colliding with Enemies, takes damage
  public void enemyCollision()
  {
    //A for each loop which checks collision for every instance of Enemy in enemies array list.
    for (Enemy e : enemies)
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

  public void setShieldCharge()
  {
    shieldCharges++;
  }

  public void bossCollision()
  {
    //A for each loop which checks collision for every instance of Boss in bosses array list.
    for (Boss b : bosses)
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

  public void destroy()
  {
    gameOver();
  }

  public void setGunType(int gun)
  {
    gunType = gun;
  }
}
