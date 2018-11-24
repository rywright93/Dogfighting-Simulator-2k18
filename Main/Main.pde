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
Player player;
ArrayList<Boss> bosses;
ArrayList<Enemy> enemies;

ArrayList<Projectile> projectiles;

PImage explosionSpriteSheet;
Explosion boom;

void setup()
{
  size(700, 900);
  player = new Player();// Instantiates player object
  bosses = new ArrayList<Boss>(); //Used for testing
  //bosses.add(new Boss(20)); //Used for testing. Instantiates a Boss
  
  enemies = new ArrayList<Enemy>(); //Used for testing
  enemies.add(new Enemy(100, 0, 3, 3)); //Used for testing. Instantiates an Enemy
  
  projectiles = new ArrayList<Projectile>(); //Used for testing
  
  loadHighscore(); //loads the highscorelist from the .txt file into the arrays
  
  explosionSpriteSheet = loadImage("explosion animation b.png");
  Explosion boom = new Explosion(100, 100);
}

void draw()
{
  background(0);
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
}

//Checks on each key pressed event if the player needs to fire a projectile
void keyPressed()
{
  if (keyPressed == true)
  {
    player.shoot();
  }
}

void keyReleased()
{
  //Press the "r" key to terminate the program
  if(key == 114)
  {
    checkHighscore();
    saveHighscore();
    exit();
  }
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
