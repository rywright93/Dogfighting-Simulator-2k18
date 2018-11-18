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

Projectile pewpew = new Projectile(100.0, 100.0, 2.0, 2.0, "Name", color(255,0,0)); //Used for testing

void setup()
{
  size(1600, 900);
}

void draw()
{
  background(0);
  fill(0, 255, 0);
  rect(500,500, 200, 200);
  noFill();
  pewpew.display(); //used for testing
}

void keyReleased()
{
  //Press the "r" key to terminate the program
  if(key == 114)
  {
    exit();
  }
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
