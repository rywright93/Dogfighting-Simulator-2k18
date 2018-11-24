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
  private int typeOfGun; //Different shooting patterns are mapped to different values in this variable
  private float enemyWidth; //Width of enemy image
  private float enemyHeight; //height of enemy image
  private float xSpeed; //Enemy's speed along the x-axis
  private float ySpeed; //Enemy's speed along thet y-axis
  private int ticksLastUpdate = millis(); //time fix used to make movement the same across different hardware
  private int enemyType; //EnemyType 1: fly straight, don't shoot. Type 2: sin wave, and shoot. Type 3: kamikaze
  private float spawnXPos; //the x-coodinate of the Enemy's spawn position
  private float fireRate = 800;
  private float lastProjectileFiredAt; //indicates when the last shot was fire in milliseconds
  private PVector direction; //A directional vector that enemies of type 3 use to home in on the player
  
  Enemy(float newXPos, float newYPos, PImage newEnemyPic, int newHitPoints, int newTypeOfGun)
  {
  }
  //Test constructor
  Enemy(float newXPos, float newYPos, int newHitPoints, int newEnemyType)
  {
    xPos = newXPos;
    yPos = newYPos;
    hitPoints = newHitPoints;
    enemyWidth = enemyPic.width;
    enemyHeight = enemyPic.height;
    xSpeed = 0;
    ySpeed = 200;
    enemyType = newEnemyType;
    spawnXPos = newXPos;
  }
  
  //Is called in Main. It updates everything that needs updating.
  public void update()
  {
    display();
    move();
  }
  
  //Moves the position of the enemy based on its speed and time fix
  public void move()
  {
    if(enemyType == 1)
    {
      xPos += xSpeed * float(millis() - ticksLastUpdate) * 0.001;
      yPos += ySpeed * float(millis() - ticksLastUpdate) * 0.001;
      ticksLastUpdate = millis(); 
    }
    
    //move in sine wave
    if(enemyType == 2)
    {
      yPos = yPos + ySpeed/100;
      //sin(yPos * frequency) * wave length) + xPos spawnPosition
      xPos = (sin(yPos * 0.02) * 150) + spawnXPos + enemyWidth;
      if(millis() > lastProjectileFiredAt)
    {
      shoot();
      lastProjectileFiredAt = millis() + fireRate;
    }
    }
    
    //Kamikaze pilot
    if(enemyType == 3)
    {
      direction = new PVector (player.getXPos(), player.getYPos());
      /*
      //coordinates for the target location
      targetLocation = new PVector (mouseX, mouseY);
      */
      //calculate the direction based on the starting point and end point
      direction.sub(xPos, yPos);
      //normalize the vector so that it has a length of 1
      direction.normalize();
      //scale it to make it move at greater length each update
      direction.mult(4);
      
      xPos = xPos + direction.x;
      yPos = yPos + direction.y;
      //location.add(velocity);
    }
    //Destroy the enemy if it moves past the bottom of the screen
    if(yPos > height)
    {
      destroy();
    }
  }
  
  public void shoot()
  {
    projectiles.add(new Projectile(xPos + enemyWidth/2, yPos + enemyHeight, 0, 400, "Enemy", color(255, 0, 0), 20));
  }
  
  //When the enemy collides with a Projectile fired from the player it takes damage
  public void isHit()
  {
    hitPoints--;
    
    if(hitPoints <= 0)
    {
      givePoints();
      destroy();
    }
  }
  
  public void destroy()
  {
    //Moves the enemy out of screen and stops it from moving
    xPos = -1000;
    xSpeed = 0;
    ySpeed = 0;
  }
  
  //yield points to the player when dying
  public void givePoints()
  {
    points = points + 100;
  }
  
  //Display the enemy in the window at its current location
  public void display()
  {
    //A rectangle is used as placeholder
    fill(0, 255, 0);
    image(enemyPic, xPos, yPos);
    //rect(xPos, yPos, enemyWidth, enemyHeight);
    noFill();
    //Display the health of the enemy
    textSize(20);
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
}
