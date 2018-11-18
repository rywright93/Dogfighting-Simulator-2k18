/*
Description:
Authors:
Comments:
*/

class Projectile
{
  private float xPos; //current x-position
  private float yPos; //current y-position
  private float xSpeed; //speed on x-axis
  private float ySpeed; //speed on y-axis
  private int diameter; //diameter of projectile
  private String shotBy; //indicates if projectile was fired by Enemy or Player
  /*
  private ArrayList<Boss> bs; //Collection of Boss instances
  private ArrayList<Enemy> es; //Collection of Enemy instances
  Player p; //Reference to Player instance
  */
  color c; //Color of projectile
  
  Projectile(float newXPos, float newYPos, float newXSpeed, float newYSpeed, String newShotBy, color newColor)
  {
    xPos = newXPos;
    yPos = newYPos;
    xSpeed = newXSpeed;
    ySpeed = newYSpeed;
    diameter = 20;
    shotBy = newShotBy;
    c = newColor;
    
  }
  
  public void bossCollision()
  {
  }
  
  public void enemyCollision()
  {
  }
  
  public void playerCollision()
  {
  }
  
  public void move()
  {
    
  }
  
  public void display()
  {
    fill(255, 0, 0);
    noStroke();
    ellipse(xPos, yPos, diameter, diameter);
  }
  
}
