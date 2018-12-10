/*
Description: Spawner is basically an x-y coordinate which moves. Once it reaches the top border of the screen it will instantiate the boss or enemy which it represents
 Authors:
 Comments:
 */

class Spawner
{
  private float xPos; //current xPosition
  private float yPos; //current yPosition
  private float ySpeed; //speed by which it moves along the y-axis
  private int spawnType; //the type of enemy or boss that will be spawned. 1 = EnemyType1. 2 = EnemyType2: 3 = EnemyType3. 4 = Boss.
  private boolean spawned = false; //indicates whether the Spawner has spawned its entity yet
  private int ticksLastUpdate = millis(); //time fix used to make movement the same across different hardware
  
  //Constructor
  Spawner(int newXPos, int newYPos, int newSpawnType)
  {
    xPos = newXPos;
    yPos = newYPos;
    spawnType = newSpawnType;
    ySpeed = 200;
  }
  
  //Moves the Spawner
  public void move()
  {    
    yPos += ySpeed * float(millis() - ticksLastUpdate) * 0.001;
    ticksLastUpdate = millis(); 
    //If Spawner has reached the top of the screen (adding 140 to not use the top border of the tile but the bottom border
    if(yPos+140 >= 0 && spawned == false)
    {
      spawn();
    }
  }
  //Instantiate entity
  public void spawn()
  {
    if(spawnType == 1)
    {
      //Instantiates a new Enemy with EnemyType1 in enemies ArrayList
      curLevel.getEnemies().add(new Enemy(xPos, 0-enemySprite.height, 6, 1));
    }
    else if(spawnType == 2)
    {
      //Instantiates a new Enemy with EnemyType2 in enemies ArrayList
      curLevel.getEnemies().add(new Enemy(xPos, 0-enemySprite.height, 6, 2));
    }
      
    else if(spawnType == 3)
    {
      //Instantiates a new Enemy with EnemyType3 in enemies ArrayList
      curLevel.getEnemies().add(new Enemy(xPos, 0-enemySprite.height, 6, 3));
    }
      
    else if(spawnType == 4)
    {
      //Instantiates a new Boss in bosses ArrayList
      curLevel.getBosses().add(new Boss(100));
    }
 
    spawned = true;
  }
  
  public boolean getSpawned()
  {
    return spawned;
  }
  
}
