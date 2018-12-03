/*
Description: A Spawner is an x-y coordinate which moves. Once it reaches the top border of the screen it will instantiate the boss or enemy which it represents
 Authors:
 Comments:
 */

class Spawner
{
  private int xPos;
  private int yPos;
  private int ySpeed;
  private int spawnType; //the type of enemy or boss that will be spawned. 1 = EnemyType1. 2 = EnemyType2: 3 = EnemyType3. 4 = Boss.
  private boolean spawned = false;
  
  Spawner(int newXPos, int newYPos, int newSpawnType)
  {
    xPos = newXPos;
    yPos = newYPos;
    spawnType = newSpawnType;
    ySpeed = 5;
  }
  
  public void move()
  {
    yPos += ySpeed; //moves the Spawner down the screen
    //If Spawner has reached the top of the screen
    if(yPos >= 0)
    {
      spawn();
    }
  }
  //Instantiate entity
  public void spawn()
  {
    if(spawnType == 1)
    {
      curLevel.getEnemies().add(new Enemy(xPos, yPos - enemySprite.height, 20, 1));
    }
    
    else if(spawnType == 2)
    {
      curLevel.getEnemies().add(new Enemy(xPos, yPos - enemySprite.height, 20, 2));
    }
    
    else if(spawnType == 3)
    {
      curLevel.getEnemies().add(new Enemy(xPos, yPos - enemySprite.height, 20, 3));
    }
    
    else if(spawnType == 4)
    {
      curLevel.getBosses().add(new Boss(30));
    }
  }
  
}
