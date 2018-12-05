/*
Description: Level structure
Authors: Ryan and Casper
Comments:
*/

class Level
{
  private ArrayList<Obstacle> obstacles; //ArrayList containing all the obstacles
  private ArrayList<Boss> bosses; //ArrayList containing all living bosses
  private ArrayList<Enemy> enemies; //ArrayList containing all active enemy
  private ArrayList<Projectile> projectiles; //ArrayList containing all active projectiles
  private ArrayList<Explosion> explosions; //ArrayList containing all active explosions
  private ArrayList<Spawner> spawners;
  private Roadstripe[] roadstripes;
  private String[] levelTiling; //array of string containing the level structure from a .txt file
  
  //Constructor
  Level(int curGameState)
  {
    //Level 1
    if(curGameState == 1)
    {
      levelTiling = loadStrings("level1.txt");
    }
    
    //Level 2
    else if(curGameState == 2)
    {
      levelTiling = loadStrings("level2.txt");
    }
    
    //Level 3
    else if(curGameState == 3)
    {
      levelTiling = loadStrings("level3.txt");
    }
    
    //Level 4
    else if(curGameState == 4)
    {
      levelTiling = loadStrings("level4.txt");
    }
    
    //Level 5
    else if(curGameState == 5)
    {
      levelTiling = loadStrings("level5.txt");
    }
    
    //Instantiate all the arraylists
    enemies = new ArrayList<Enemy>(); //Used for testing
    bosses = new ArrayList<Boss>();
    projectiles = new ArrayList<Projectile>(); //Used for testing
    explosions = new ArrayList<Explosion>();
    obstacles = new ArrayList<Obstacle>();
    spawners = new ArrayList<Spawner>();
    roadstripes = new Roadstripe[4];
    for(int i = 0; i < roadstripes.length; i++)
    {
      roadstripes[i] = new Roadstripe(height - 250*i);
    }
    
    readTextFile();
  }
  
  //updates every instance of enemy, boss, projectile, explosion, and obstacles in the level
  public void update()
  {
    updateRoadstripes();
    updateObstacles();
    updateEnemies();
    updateBosses();
    updateProjectiles();
    updateExplosions();
    updateSpawner();
  }
  
  public void readTextFile()
  {
    //Instantiate class at correct position
    //Every loop goes through one row in txt file
    for(int i = 0; i < levelTiling.length; i++)
    {
      //Every nested loop goes through each char in the String
      for(int j = 0; j < levelTiling[i].length(); j++)
      {
        //0=Boulder
        if(levelTiling[i].charAt(j) == '0')
        {
          //constructor(starting/default x + Wall width * column number + 1 to avoid multiplication by zero, starting/default y + wall height * row number + 1 to avoid multiplication by zero, xspeed, yspeed)
          obstacles.add(new Obstacle(0+140*j, -140*levelTiling.length+140*i, 0));
        }
        
        //"/"= Pool of mud
        if(levelTiling[i].charAt(j) == '/')
        {
          //constructor(starting/default x + Wall width * column number + 1 to avoid multiplication by zero, starting/default y + wall height * row number + 1 to avoid multiplication by zero, xspeed, yspeed)
          obstacles.add(new Obstacle(0+140*j, -140*levelTiling.length+140*i, 1));
        }
        
        //Instantiates EnemyType1
        else if(levelTiling[i].charAt(j) == '1')
        {
          spawners.add(new Spawner(0+140*j, -140*levelTiling.length+140*i, 1));
        }
        
        //Instantiates EnemyType2
        else if(levelTiling[i].charAt(j) == '2')
        {
          spawners.add(new Spawner(0+140*j, -140*levelTiling.length+140*i, 2));
        }
        
        //Instantiates EnemyType3
        else if(levelTiling[i].charAt(j) == '3')
        {
          spawners.add(new Spawner(0+140*j, -140*levelTiling.length+140*i, 3));
        }
        
        //Instantiates Boss
        else if(levelTiling[i].charAt(j) == '4')
        {
          spawners.add(new Spawner(0+140*j, -140*levelTiling.length+140*i, 4));
        }

      }
    }
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
      if (elementE.getDestroyed() == true) 
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
  
  public void updateObstacles()
  {
    //Update every Explosion in the ArrayList explosions
    for (Obstacle o : obstacles)
    {
      o.update();
    }
  
    //Iterator used to remove Enemy from the ArrayList enemies if they are dead.
    Iterator<Obstacle> itrO = obstacles.iterator();
    while (itrO.hasNext()) 
    { 
      Obstacle elementBo = itrO.next(); 
      if (elementBo.getYPos() > height) 
      { 
        itrO.remove();
      }
    }
  }
  
  public void updateSpawner()
  {
    //Update every Enemy in the ArrayList enemies. Used for testing
    for (Spawner s : spawners)
    {
      s.move();
    }
/*
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
    */
  }
  
  public void updateRoadstripes()
  {
    for(int i = 0; i < roadstripes.length; i++)
    {
      roadstripes[i].update();
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
  
  public ArrayList<Obstacle> getObstacles()
  {
    return obstacles;
  }
  
}
