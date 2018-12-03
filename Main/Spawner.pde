/*
Description: A Spawner is an x-y coordinate which moves. Once it reaches the top border of the screen it will instantiate the boss or enemy which it represents
 Authors:
 Comments:
 */

class Spawner
{
  private float xPos;
  private float yPos;
  private float ySpeed;
  private int spawnType; //the type of enemy or boss that will be spawned. 1 = EnemyType1. 2 = EnemyType2: 3 = EnemyType3. 4 = Boss.
  private boolean spawned = false;
  private int ticksLastUpdate = millis(); //time fix used to make movement the same across different hardware
  
  Spawner(int newXPos, int newYPos, int newSpawnType)
  {
    xPos = newXPos;
    yPos = newYPos;
    spawnType = newSpawnType;
    ySpeed = 200;
    println("My type is " + spawnType);
  }
  
  public void move()
  {    
    yPos += ySpeed * float(millis() - ticksLastUpdate) * 0.001;
    ticksLastUpdate = millis(); 
    //If Spawner has reached the top of the screen
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
      curLevel.getEnemies().add(new Enemy(xPos, 0-enemySprite.height, 20, 1));
    }
    else if(spawnType == 2)
    {
      curLevel.getEnemies().add(new Enemy(xPos, 0-enemySprite.height, 20, 2));
    }
      
    else if(spawnType == 3)
    {
      curLevel.getEnemies().add(new Enemy(xPos, 0-enemySprite.height, 20, 3));
    }
      
    else if(spawnType == 4)
    {
      curLevel.getBosses().add(new Boss(30));
    }
    spawned = true;
  }
  
}
