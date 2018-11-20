/*
Program Title: Dogfighting Simulator 2k18
Program Description: 
Authors: 
Comments: Testing if stuff works
Ryan's also testing if stuff works
*/
import java.util.*; //imports the Iterator class

int points; //the players current score
int gameState; //indicates the current game state
String inputName;
int[] highscores;
String[] highscoreNames;
Player player;
ArrayList<Boss> bosses;
ArrayList<Enemy> enemies;

ArrayList<Projectile> pewpews;

void setup()
{
  size(700, 900);
  bosses = new ArrayList<Boss>(); //Used for testing
  bosses.add(new Boss(20)); //Used for testing
  
  enemies = new ArrayList<Enemy>(); //Used for testing
  enemies.add(new Enemy(100, 0, 3, 1)); //Used for testing
  
  pewpews = new ArrayList<Projectile>(); //Used for testing
  loadHighscore();
}

void draw()
{
  background(0);
  
  //Used for testing. Updates every instance of Boss in the ArrayList
  for(Boss b : bosses)
  {
    b.update();
  }
  
  //update every Projectile in the ArrayList. Used for testing
  for(Projectile p : pewpews)
  {
    p.update();
  }
  
  //Iterator used to remove Projectiles from the ArrayList if they are dead.
  Iterator<Projectile> itr = pewpews.iterator();
  while (itr.hasNext()) 
  { 
    Projectile element = itr.next(); 
    if (element.getDestroyed() == true) 
    { 
      itr.remove();
    }
  }
  
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

void keyReleased()
{
  //Press the "r" key to terminate the program
  if(key == 114)
  {
    saveHighscore();
    exit();
  }
}

void mousePressed()
{
  //Instantiates a Projectile at mouse position when clicking. Used for testing.
  pewpews.add(new Projectile(mouseX, mouseY, 0, -6, "Player", color(255,0,0)));
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
      return true;
    }
  }
  //If it went through the entire for-loop and didn't return true at any point, it means that the current score does not beat any of the existing ones
  return false;
}

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
