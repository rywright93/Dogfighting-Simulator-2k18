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
  private float fireRate = 200;//Delay between shots
  private float shieldCooldown = 1000;//Delay between uses of sheild ability
  private float lastProjectileFiredAt; //indicates when the last shot was fire in milliseconds
  private float lastShieldFiredAt;//indicates when last shield charge was used
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
    hitPoints = 3;
    //TO DO: PImage = something later but for now it's a square
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
      if (millis() > lastProjectileFiredAt)
      {
        lastProjectileFiredAt = millis() + fireRate;
        projectiles.add(new Projectile(xPos + playerWidth/2, yPos, 0.0, -400.0, "Player", color(255, 0, 0), 15));
      }
    }
  }

  //Sets conditions to activate shield, and keeps player from taking damage when shield is active
  public void shield()
  {
    //TODO: have condition for setting sheild to active, sheildCharges--, time passes, sheild set to inactive again
    if ((shieldActive == false) && (shieldCharges < 0) && (keyPressed == true) && (key == 101)) //if the player has shield charges && presses 'e' key
    {
      if (millis() > lastShieldFiredAt)
      {
        shieldActive = true;
        shieldCharges--;
        lastShieldFiredAt = millis() + shieldCooldown;
      }
    }
    if (shieldActive == true)
    {
      
    }
  }
    //TODO: when sheild is active => no damage, reset shieldActive to false

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
