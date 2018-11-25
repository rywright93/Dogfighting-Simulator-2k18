/*
Program Title: Dogfighting Simulator 2k18
Program Description: 
Authors: 
Comments:
*/
import java.util.*; //imports the Iterator class

int points; //the players current score
int gameState; //indicates the current game state
String inputName; //should be reset everytime one exits or enters the highscore screen
int[] highscores;
String[] highscoreNames;
boolean[] keys; //Boolean array for checking if keys are being pressed, enables multiple concurrent button presses

Player player;
ArrayList<Boss> bosses;
ArrayList<Enemy> enemies;

ArrayList<Projectile> projectiles;

ArrayList<Explosion> explosions;
PImage explosionSpriteSheet;
Explosion boom;

PImage enemySprite;
PImage bossSprite;
PImage playerSprite;

void setup()
{
  size(700, 900);
  playerSprite = loadImage("player.png");
  player = new Player();// Instantiates player object
  
  keys = new boolean [6];
  keys[0] = false;// 'w' key for upward movement defined in Player class
  keys[1] = false;// 'a' key for leftward movement defined in Player class
  keys[2] = false;// 's' key for downward movement defined in Player class
  keys[3] = false;// 'd' key for rightward movement defined in Player class
  keys[4] = false;// 'e' key for shield toggling defined in Player class
  keys[5] = false;// space bar for shooting defined in Player class
  
  bossSprite = loadImage("boss.png");
  bosses = new ArrayList<Boss>(); //Used for testing
  //bosses.add(new Boss(20)); //Used for testing. Instantiates a Boss
  
  bosses.add(new Boss(80)); //Used for testing. Instantiates a Boss
  enemySprite = loadImage("enemy c.png");
  enemies = new ArrayList<Enemy>(); //Used for testing
  enemies.add(new Enemy(100, 0, 20, 3)); //Used for testing. Instantiates an Enemy

  projectiles = new ArrayList<Projectile>(); //Used for testing
  
  explosions = new ArrayList<Explosion>();
  
  loadHighscore(); //loads the highscorelist from the .txt file into the arrays
  
  explosionSpriteSheet = loadImage("explosion animation b.png");
}

void draw()
{
  background(161, 161, 161);
  textSize(30);
  text(points, 50, 50);
  
  //Updates player position and collisions every frame
  player.update();
  
  //Used for testing. Updates every instance of Boss in the ArrayList
  for(Boss b : bosses)
  {
    b.update();
  }
  
  //update every Projectile in the ArrayList. Used for testing
  for(Projectile p : projectiles)
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
  
  //Update every Enemy in the ArrayList enemies. Used for testing
  for(Enemy e : enemies)
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
  
  //Update every Explosion in the ArrayList explosions
  for(Explosion ex : explosions)
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

//Checks on each key pressed event if the player needs to fire a projectile
void keyPressed()
{
  if (key == 119)//'w' key
  {
    keys[0] = true;
  }
  if (key == 97)//'a' key
  {
    keys[1] = true;
  }
  if (key == 115)//'s' key
  {
    keys[2] = true;
  }
  if (key == 100)//'d' key
  {
    keys[3] = true;
  }
  if (key == 101)//'e' key
  {
    keys[4] = true;
  }
  if (key == 32)//space bar
  {
    keys[5] = true;
  }
}

void keyReleased()
{
  if (key == 119)//'w' key
  {
    keys[0] = false;
  }
  if (key == 97)//'a' key
  {
    keys[1] = false;
  }
  if (key == 115)//'s' key
  {
    keys[2] = false;
  }
  if (key == 100)//'d' key
  {
    keys[3] = false;
  }
  if (key == 101)//'e' key
  {
    keys[4] = false;
  }
  if (key == 32)//space bar
  {
    keys[5] = false;
  }
 /* if(key == 114) //used for testing, Press the "r" key to terminate the program
  {
    checkHighscore();
    saveHighscore();
    exit();
  }
  */
}

void mousePressed()
{
}

void spawnPlayer()
{
}

void spawnEnemy()
{
}

void spawnBoss()
{
}

void gameOver()
{
}

void gameOverScreen()
{
}

void mainMenuScreen()
{
}

void playScreen()
{
}

void reset()
{
  // start movement, change gamestate, draw playing screen, 
}

//save the two highscores array to the .txt files on disc
void saveHighscore()
{
  saveStrings("highscoreNames.txt", highscoreNames);
  saveStrings("highscoreScores.txt", str(highscores));
}

//Loads the data in the .txt files into the two highscore arrays
void loadHighscore()
{
  highscoreNames = loadStrings("highscoreNames.txt");
  highscores = int(loadStrings("highscoreScores.txt"));
  for(int i = 0; i<highscores.length;i++)
  {
    println(i +1 + " " + highscoreNames[i] + ": " + highscores[i]);
  }
}

//returns true if the current score (points) is greater than, or equals to, one of the scores in the highscorelist
boolean checkHighscore()
{
  //goes through the array highscores and compares the entries' values with current score (points)
  for(int i = 0; i < highscores.length; i++)
  {
    if(points >= highscores[i])
    {
      rearrangeHighscoreList(i);
      return true;
    }
  }
  //If it went through the entire for-loop and didn't return true at any point, it means that the current score does not beat any of the existing ones
  return false;
}

//Rearranges the highscore list if the current score beats any of them. The parameter it takes is the placement on the scoreboard of the new entry
void rearrangeHighscoreList(int i)
{
  //If the new highscore is not the bottom one on the list
  if(i < 9) 
  {
    //Re-arrange the scoreboard by moving them down one - stops when it reaches the new highscore
    for(int j = 9; j > i; j--)
    {
      highscores[j] = highscores[j-1];
      highscoreNames[j] = highscoreNames[j-1];
    }
  }
  highscores[i] = points; //set the new highscore
  highscoreNames[i] = ""; //clear the corresponding spot for a new name
}

//Resets the highscore list back to default
void resetHighscoreList()
{
  //reset the scores
  for(int i = 0; i < highscores.length; i++)
  {
    highscores[i] = 0;
  }
  
  //reset the names
  for(int i = 0; i < highscoreNames.length; i++)
  {
    highscoreNames[i] = "N/A";
  }
}

//is used to create inputName. Should only be called if inputName < 4 characters long, and if the key pressed was a letter.
void createInputName()
{
  inputName += key; //add the character to the String
}

//The argument should be the variable inputName once it is completed. The name will then be placed on the highscore list
void enterNewHighscoreName(String newName)
{
  //go through every entry in the array highscoreNames
  for(int i = 0; i < highscoreNames.length; i++)
  {
    //locates the entry that is blank (this is done in rearrangeHighscoreList())
    if(highscoreNames[i] == "")
    {
      highscoreNames[i] = newName; //replace the blank entry with the one from the parameter
    }
  }
}
