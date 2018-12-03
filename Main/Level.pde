/*
Description: The player character
Authors: Ryan and Casper
Comments:
*/

class Level
{
  ArrayList<Boulder> boulders;
  ArrayList<Boss> bosses;
  ArrayList<Enemy> enemies;
  ArrayList<Projectile> projectiles;
  ArrayList<Explosion> explosions;
  String[] levelTiling;
  
  Level(int curGameState)
  {
    if(curGameState == 1)
    {
      levelTiling = loadStrings("level1.txt");
    }
    
    else if(curGameState == 2)
    {
      levelTiling = loadStrings("level2.txt");
    }
    
    else if(curGameState == 3)
    {
      levelTiling = loadStrings("level3.txt");
    }
    
    else if(curGameState == 4)
    {
      levelTiling = loadStrings("level4.txt");
    }
    
    else if(curGameState == 5)
    {
      levelTiling = loadStrings("level5.txt");
    }
  }
  
  public void update()
  {
    
  }
}
