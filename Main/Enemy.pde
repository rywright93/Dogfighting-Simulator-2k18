/*
Description:
Authors:
Comments:
*/

class Enemy
{
  private float xPos; //Current x-position
  private float yPos; //current y-position
  private PImage enemyPic; //Image used to display Enemy
  private int hitPoints; //The health of the enemy
  private int typeOfGun; //Different shooting patterns are mapped to different values in this variable
  private float enemyWidth; //Width of enemy image
  private float enemyHeight; //height of enemy image
  private float xSpeed; //Enemy's speed along the x-axis
  private float ySpeed; //Enemy's speed along thet y-axis
  private int ticksLastUpdate = millis(); //time fix used to make movement the same across different hardware
  private int enemyType; //EnemyType 1: fly straight, don't shoot. Type 2: sin wave, and shoot. Type 3: kamikaze
  private float spawnXPos;
  
  Enemy(float newXPos, float newYPos, PImage newEnemyPic, int newHitPoints, int newTypeOfGun)
  {
  }
  //Test constructor
  Enemy(float newXPos, float newYPos, int newHitPoints, int newEnemyType)
  {
    xPos = newXPos;
    yPos = newYPos;
    hitPoints = newHitPoints;
    enemyWidth = 50;
    enemyHeight = 100;
    xSpeed = 0;
    ySpeed = 300;
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
    }
    //Destroy the enemy if it moves past the bottom of the screen
    if(yPos > height)
    {
      destroy();
    }
  }
  
  public void shoot()
  {
    
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
    rect(xPos, yPos, enemyWidth, enemyHeight);
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
