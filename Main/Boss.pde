/*
Description:
Authors:
Comments:
*/

class Boss
{
  private float xPos; //current x position of the boss
  private float yPos; //current y position of the boss
  private float bossWidth; //width of the boss image
  private float bossHeight; //height of the boss image
  private PImage bossPic = bossSprite; //Image of the boss
  private int hitPoints; //Boss' health
  private int xSpeed = 300; //Speed by which it moves along the x-axis
  private int ySpeed = 180; //speed by which it moves along the y-axis
  private float fireRate = 500;
  private float lastProjectileFiredAt; //indicates when the last shot was fire in milliseconds
  private int ticksLastUpdate = millis(); //time fix used to make movement the same across different hardware
  private int maxHitPoints;
  
  Boss(int newHitPoints)
  {
    hitPoints = newHitPoints;
    bossWidth = bossPic.width;
    bossHeight = bossPic.height;
    xPos = width/2 - bossWidth/2;
    yPos = -200;
    maxHitPoints = hitPoints;
  }
  
  public void update()
  {
    display();
    if(yPos < 100)
    {
      enterLevel();
    }
    else{
      move();
    }
  }
  
  //Slowly ascends into the screen from the top
  public void enterLevel()
  {
    yPos += ySpeed * float(millis() - ticksLastUpdate) * 0.001;
    ticksLastUpdate = millis();
    //yPos += ySpeed;
  }

  //Moves the boss from side to side
  public void move()
  {
    
    xPos += xSpeed * float(millis() - ticksLastUpdate) * 0.001;
    ticksLastUpdate = millis();
    //xPos += xSpeed;
    //If boss moves beyond right border, reverse its speed
    if(xPos + bossWidth > width)
    {
      xSpeed = -xSpeed;
    }
    //If boss moves beyond the left screen border, reverse its speed
    if(xPos < 0)
    {
      xSpeed = -xSpeed;
    }
    //When the boss moves it shoots every fireRate
    if(millis() > lastProjectileFiredAt)
    {
      shoot();
      lastProjectileFiredAt = millis() + fireRate;
    }
  }
  
  //Instantiates projectiles that can only collide with an instance of Player
  public void shoot()
  {
    curLevel.getProjectiles().add(new Projectile(xPos, yPos + bossHeight, 0, 200, "Enemy", color(0,0,255), 40));
    curLevel.getProjectiles().add(new Projectile(xPos + bossWidth, yPos + bossHeight, 0,200, "Enemy", color(0,0,255), 40));
  }
  
  //When the boss collides with a Projectile fired from the player it takes damage
  public void isHit()
  {
    hitPoints--;
    //When the Boss reaches 0 HP it will be destroyed
    if(hitPoints <= 0)
    {
      destroy();
    }
  }

  public void destroy()
  {
    //Moves the boss off-screen and stops its speed
    xPos = -1000;
    xSpeed = 0;
    ySpeed = 0;
    
    
    givePoints();
  }
  
  public void display()
  {
    if(hitPoints > 0)
    {
      fill(0, 0, 255);
      //rect(xPos, yPos, bossWidth, bossHeight);
      rect(xPos, yPos - 20, map(hitPoints, 0, maxHitPoints, 0, bossWidth), 10); //displays a healthbar
      noFill();
      image(bossPic, xPos, yPos);
      /*
      textSize(25);
      text(hitPoints + " HP", xPos, yPos);
      */
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
  
  public float getBossHeight()
  {
    return bossHeight;
  }
  
  public float getBossWidth()
  {
    return bossWidth;
  }
  
  public int getHitPoints()
  {
    return hitPoints;
  }
  
  //Yields points to the player upon death
  public void givePoints()
  {
    points = points + 1000;
  }
}
