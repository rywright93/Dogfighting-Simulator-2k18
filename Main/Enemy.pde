/*
Description:
 Authors:
 Comments:
 */

class Enemy
{
  private float xPos; //Current x-position
  private float yPos; //current y-position
  private PImage enemyPic = enemySprite; //Image used to display Enemy
  private int hitPoints; //The health of the enemy
  private float enemyWidth; //Width of enemy image
  private float enemyHeight; //height of enemy image
  private float xSpeed; //Enemy's speed along the x-axis
  private float ySpeed; //Enemy's speed along thet y-axis
  private int ticksLastUpdate = millis(); //time fix used to make movement the same across different hardware
  private int enemyType; //EnemyType 1: fly straight, don't shoot. Type 2: sin wave, and shoot. Type 3: kamikaze
  private float spawnXPos; //the x-coodinate of the Enemy's spawn position. Used for EnemyType 3
  private float fireRate = 800; //The frequency by which enemy can shoot
  private float lastProjectileFiredAt; //indicates when the last shot was fire in milliseconds
  private PVector direction; //A directional vector that enemies of type 3 use to home in on the player
  private boolean destroyed = false;
  private int maxHitPoints; //The maximum amount of hitpoints is stored to make depleting healthbars

  //Constructor
  Enemy(float newXPos, float newYPos, int newHitPoints, int newEnemyType)
  {
    xPos = newXPos;
    yPos = newYPos;
    hitPoints = newHitPoints;
    enemyWidth = enemyPic.width;
    enemyHeight = enemyPic.height;
    xSpeed = 0;
    ySpeed = 350;
    enemyType = newEnemyType;
    spawnXPos = newXPos;
    maxHitPoints = hitPoints;
  }

  //Call every method in Enemey required to update Enemy
  public void update()
  {
    display();
    move();
  }

  //Moves the position of the enemy based on its speed and time fix
  public void move()
  {
    //EnemyType 1 movement
    if (enemyType == 1)
    {
      xPos += xSpeed * float(millis() - ticksLastUpdate) * 0.001;
      yPos += ySpeed * float(millis() - ticksLastUpdate) * 0.001;
      ticksLastUpdate = millis();
    }

    //EnemyType 2 movement. Moves in sine wave and shoots
    if (enemyType == 2)
    {
      yPos += ySpeed * float(millis() - ticksLastUpdate) * 0.001;
      xPos = (sin(yPos * 0.01) * 140) + spawnXPos + enemyWidth * float(millis() - ticksLastUpdate) * 0.001;
      ticksLastUpdate = millis(); 

      if (millis() > lastProjectileFiredAt)
      {
        shoot();
        lastProjectileFiredAt = millis() + fireRate;
      }
    }

    //EnemyType 3 is a Kamikaze car. It drives towards the player position
    if (enemyType == 3)
    {
      direction = new PVector (player.getXPos(), player.getYPos());
      //calculate the direction based on the starting point and end point
      direction.sub(xPos, yPos);
      //normalize the vector so that it has a length of 1
      direction.normalize();
      //scale it to make it move at greater length each update
      direction.mult(400);

      xPos += direction.x * float(millis() - ticksLastUpdate) * 0.001; //Home in on the players x-position
      yPos += ySpeed * float(millis() - ticksLastUpdate) * 0.001; //moves down the screen every update so it won't drive back towards the player if it misses
      ticksLastUpdate = millis(); 
    }
    //Destroy the enemy if it moves past the bottom of the screen
    if (yPos > height)
    {
      destroy();
    }
  }

  //Instantiates projectiles that can only collide with an instance of Player
  public void shoot()
  {
    curLevel.getProjectiles().add(new Projectile(xPos + enemyWidth/2, yPos + enemyHeight, 0, 400, "Enemy", color(255, 0, 0), 20));
  }

  //When the enemy collides with a Projectile fired from the player, or a shielded player, it takes damage
  public void isHit()
  {
    hitPoints--;

    if (hitPoints <= 0)
    {
      if (random(0, 100) < 10)//one in 10 enemies should drop a Pickup
      {
        curLevel.getPickups().add(new Pickup(xPos, yPos, int(random(0, 4))));//Instantiates new Pickup and adds it to pickups ArrayList in Level
      }
      
      givePoints();
      destroy();
    }
  }

  //Moves Enemy off screen and halts its movement.
  public void destroy()
  {
    xPos = -1000;
    xSpeed = 0;
    ySpeed = 0;
    destroyed = true;
  }

  //yield points to the player when dying
  public void givePoints()
  {
    points = points + 100;
  }

  //Display the enemy in the window at its current location
  public void display()
  {
    fill(255, 0, 0);
    rect(xPos, yPos - 20, map(hitPoints, 0, maxHitPoints, 0, enemyWidth), 10); //displays a healthbar
    image(enemyPic, xPos, yPos);
    noFill();
  }

  public float getXPos()
  {
    return xPos;
  }

  public float getYPos()
  {
    return yPos;
  }

  public float getEnemyHeight()
  {
    return enemyHeight;
  }

  public float getEnemyWidth()
  {
    return enemyWidth;
  }

  public int getHitPoints()
  {
    return hitPoints;
  }

  public boolean getDestroyed()
  {
    return destroyed;
  }
  
  public void setHitPoints(int newHitPoints)
  {
    hitPoints = newHitPoints;
  }
}
