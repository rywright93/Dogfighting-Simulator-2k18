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
    
    enemies = new ArrayList<Enemy>(); //Used for testing
    bosses = new ArrayList<Boss>();
    projectiles = new ArrayList<Projectile>(); //Used for testing
    explosions = new ArrayList<Explosion>();
    boulders = new ArrayList<Boulder>();
  }
  
  public void update()
  {
    updateEnemies();
    updateBosses();
    updateProjectiles();
    updateExplosions();
    
  }
  
  public void updateEnemies()
  {
    //Update every Enemy in the ArrayList enemies. Used for testing
    for (Enemy e : enemies)
    {
      e.update();
    }

    //Iterator used to remove Enemy from the ArrayList enemies if they are dead.
    Iterator<Enemy> itrE = enemies.iterator();
    while (itrE.hasNext()) 
    { 
      Enemy elementE = itrE.next(); 
      if (elementE.getHitPoints() <= 0) 
      { 
        itrE.remove();
      }
    }
  }
  
  public void updateBosses()
  {
    //Used for testing. Updates every instance of Boss in the ArrayList
    for (Boss b : bosses)
    {
      b.update();
    }
    
  }
  
  public void updateProjectiles()
  {
    //update every Projectile in the ArrayList. Used for testing
    for (Projectile p : projectiles)
    {
      p.update();
    }
  
    //Iterator used to remove Projectiles from the ArrayList if they are dead.
    Iterator<Projectile> itr = projectiles.iterator();
    while (itr.hasNext()) 
    { 
      Projectile element = itr.next(); 
      if (element.getDestroyed() == true) 
      { 
        itr.remove();
      }
    }
  }
  
  public void updateExplosions()
  {
    //Update every Explosion in the ArrayList explosions
    for (Explosion ex : explosions)
    {
      ex.display();
    }
  
    //Iterator used to remove Enemy from the ArrayList enemies if they are dead.
    Iterator<Explosion> itrEx = explosions.iterator();
    while (itrEx.hasNext()) 
    { 
      Explosion elementEx = itrEx.next(); 
      if (elementEx.getAnimationEnded() == true) 
      { 
        itrEx.remove();
      }
    }
  }
  
  public ArrayList<Projectile> getProjectiles()
  {
    return projectiles;
  }
  
  public ArrayList<Boss> getBosses()
  {
    return bosses;
  }
  
  public ArrayList<Enemy> getEnemies()
  {
    return enemies;
  }
  
  public ArrayList<Explosion> getExplosions()
  {
    return explosions;
  }
}
