/*
Description: Level structure
 Comments:
 */

class Level
{
  private ArrayList<Obstacle> obstacles; //ArrayList containing all instances of Obstacle
  private ArrayList<Boss> bosses; //ArrayList containing all instances of Boss
  private ArrayList<Enemy> enemies; //ArrayList containing all active instances of Enemy
  private ArrayList<Projectile> projectiles; //ArrayList containing all active Instances of Projectile
  private ArrayList<Pickup> pickups;//ArrayList containing all active instances of Pickup
  private ArrayList<Explosion> explosions; //ArrayList containing all active instances of Explosion
  private ArrayList<Spawner> spawners; //ArrayList containing all active instances of Spawner
  private Roadstripe[] roadstripes;
  private String[] levelTiling; //array of strings containing the level structure from a .txt file
  private Confetti[] particles;

  //Constructor
  Level(int curGameState)
  {
    //Level 1
    if (curGameState == 1)
    {
      levelTiling = loadStrings("level1.txt");
    }

    //Level 2
    else if (curGameState == 2)
    {
      levelTiling = loadStrings("level2.txt");
    }

    //Level 3
    else if (curGameState == 3)
    {
      levelTiling = loadStrings("level3.txt");
    }

    //Level 4
    else if (curGameState == 4)
    {
      levelTiling = loadStrings("level4.txt");
    }

    //Level 5
    else if (curGameState == 5)
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
    pickups = new ArrayList<Pickup>();
    //Instantiate arrays
    roadstripes = new Roadstripe[4];
    particles = new Confetti[100];
    
    //Fill roadstripes with instances of Roadstripe
    for (int i = 0; i < roadstripes.length; i++)
    {
      roadstripes[i] = new Roadstripe(height - 250*i);
    }

    readTextFile();
  }

  //updates every instance of enemy, boss, projectile, explosion, obstacle, roadstripe, spawner, pickup, and confetti in the level
  public void update()
  {
    println(spawners.size());
    updateRoadstripes();
    updateObstacles();
    updateEnemies();
    updateBosses();
    updateProjectiles();
    updateExplosions();
    updateSpawner();
    updatePickups();
    updateParticles();
  }
  
  //Reads .txt file from disc containing level structure and instantiates appropriate classes
  public void readTextFile()
  {
    //Instantiate class at correct position
    //Every loop goes through one row in .txt file
    for (int i = 0; i < levelTiling.length; i++)
    {
      //Every nested loop goes through each char in the String
      for (int j = 0; j < levelTiling[i].length(); j++)
      {
        //If char=0, it's a Obstacle of type boulder
        if (levelTiling[i].charAt(j) == '0')
        {
          //constructor(starting/default x + Wall width * column number + 1 to avoid multiplication by zero, starting/default y + wall height * row number + 1 to avoid multiplication by zero, xspeed, yspeed)
          obstacles.add(new Obstacle(0+140*j, -140*levelTiling.length+140*i, 0));
        }

        //if char=/ it's an Obstacle of type mud
        if (levelTiling[i].charAt(j) == '/')
        {
          obstacles.add(new Obstacle(0+140*j, -140*levelTiling.length+140*i, 1));
        }

        //Instantiates Spawner containing EnemyType 1
        else if (levelTiling[i].charAt(j) == '1')
        {
          spawners.add(new Spawner(0+140*j, -140*levelTiling.length+140*i, 1));
        }

        //Instantiates Spawner containing EnemyType 2
        else if (levelTiling[i].charAt(j) == '2')
        {
          spawners.add(new Spawner(0+140*j, -140*levelTiling.length+140*i, 2));
        }

        //IInstantiates Spawner containing EnemyType 1
        else if (levelTiling[i].charAt(j) == '3')
        {
          spawners.add(new Spawner(0+140*j, -140*levelTiling.length+140*i, 3));
        }

        //Instantiates Spawner containing Boss
        else if (levelTiling[i].charAt(j) == '4')
        {
          spawners.add(new Spawner(0+140*j, -140*levelTiling.length+140*i, 4));
        }
      }
    }
  }

  public void updateEnemies()
  {
    //Update every Enemy in the ArrayList enemies
    for (Enemy e : enemies)
    {
      e.update();
    }

    //Iterator used to remove Enemy from the ArrayList enemies if they are dead.
    Iterator<Enemy> itrE = enemies.iterator();
    //As long as there is another entry in enemies
    while (itrE.hasNext()) 
    { 
      Enemy elementE = itrE.next(); 
      //if enemy is destroyed
      if (elementE.getDestroyed() == true) 
      { 
        itrE.remove(); //remove it from the ArrayList
      }
    }
  }

  public void updateBosses()
  {
    //Updates every instance of Boss in the ArrayList
    for (Boss b : bosses)
    {
      b.update();
    }
  }

  public void updateProjectiles()
  {
    //update every Projectile in the ArrayList
    for (Projectile p : projectiles)
    {
      p.update();
    }

    //Iterator used to remove Projectiles from the ArrayList if they are destroyed.
    Iterator<Projectile> itr = projectiles.iterator();
    //As long as there is another entry in projectiles
    while (itr.hasNext()) 
    { 
      Projectile element = itr.next(); 
      //if projectile is destroyed
      if (element.getDestroyed() == true) 
      { 
        itr.remove(); //remove it from the ArrayList
      }
    }
  }

  public void updatePickups()
  {
    //update every Pickup in the ArrayList
    for (Pickup pu : pickups)
    {
      pu.update();
    }

    //Iterator used to remove Pickups from the ArrayList if they are destroyed/picked up.
    Iterator<Pickup> itr = pickups.iterator();
    //As long as there is another entry in pickups
    while (itr.hasNext()) 
    { 
      Pickup element = itr.next(); 
      //if projectile is destroyed
      if (element.getDestroyed() == true) 
      { 
        itr.remove(); //remove from ArrayList
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

    //Iterator used to remove Explosion from the ArrayList explosions if they are done animating
    Iterator<Explosion> itrEx = explosions.iterator();
    while (itrEx.hasNext()) 
    { 
      Explosion elementEx = itrEx.next(); 
      //if explosion animation has ended
      if (elementEx.getAnimationEnded() == true) 
      { 
        itrEx.remove(); //remove it from the ArrayList
      }
    }
  }

  public void updateObstacles()
  {
    //Update every Obstacle in the ArrayList obstacles
    for (Obstacle o : obstacles)
    {
      o.update();
    }

    //Iterator used to remove Obstacle from the ArrayList obstacles if they have moved beyond the bottom border of the screen
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
    //Update every Spawner in the ArrayList spawners
    for (Spawner s : spawners)
    {
      s.move();
    }
    
    //Iterator used to remove Spawner from the ArrayList spawners if they have spawned their entity.
     Iterator<Spawner> itrS = spawners.iterator();
     while (itrS.hasNext()) 
     { 
       Spawner elementS = itrS.next(); 
       if (elementS.getSpawned() == true) 
       { 
         itrS.remove();
       }
     }
     
  }
  
  //Updates array of roadstripes.
  public void updateRoadstripes()
  {
    for (int i = 0; i < roadstripes.length; i++)
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

  public ArrayList<Pickup> getPickups()
  {
    return pickups;
  }

  public Confetti[] getParticles()
  {
    return particles;
  }

  //Updates array of Confetti
  public void updateParticles()
  {

    for (int i = 0; i < particles.length; i++)
    {
      //Only update instances of Confetti if particles is not empty
      if(particles[i] != null)
      {
        particles[i].display();
        particles[i].move();
      }
    }
  }
}
