/*
Program Title: Dogfighting Simulator 2k18
Program Description: 
Authors: 
Comments: Testing if stuff works
Ryan's also testing if stuff works
*/

int points;
int gameState;
String inputName;
int[] highscore;
String[] highscoreNames;
Player player;
ArrayList<Boss> bosses;
ArrayList<Enemy> enemies;

ArrayList<Projectile> pewpews;

void setup()
{
  size(1600, 900);
  bosses = new ArrayList<Boss>(); //Used for testing
  bosses.add(new Boss(20)); //Used for testing
  
  pewpews = new ArrayList<Projectile>(); //Used for testing
}

void draw()
{
  background(0);
  
  //Used for testing
  for(Boss b : bosses)
  {
    b.update();
  }
  
  //update every Projectile in the array. Used for testing
  for(Projectile p : pewpews)
  {
    p.update();
  }
}

void keyReleased()
{
  //Press the "r" key to terminate the program
  if(key == 114)
  {
    exit();
  }
}

void mousePressed()
{
  //Instantiates a Projectile at mouse position when clicking. Used for testing.
  pewpews.add(new Projectile(mouseX, mouseY, 0, -6, "Name", color(255,0,0)));
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

void saveHighscore()
{
}

void loadHighscore()
{
}

boolean checkHighscore()
{
  return false;
}

void rearrangeHighscoreList()
{
}
