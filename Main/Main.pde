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
/*
 ArrayList<Boss> bosses;
 ArrayList<Enemy> enemies;
 
 ArrayList<Projectile> projectiles;
 
 ArrayList<Explosion> explosions;
 */
PImage explosionSpriteSheet;

PImage enemySprite;
PImage bossSprite;
PImage playerSprite;

Level curLevel;

boolean checkedHighscore = false;

void setup()
{
  size(700, 900);

  gameState = 0;//starts game at level, pick 0 for final build, set value to level for playtesting 0-7

  enemySprite = loadImage("enemy c.png");
  bossSprite = loadImage("boss.png");
  playerSprite = loadImage("player.png");

  spawnPlayer();

  keys = new boolean [6];
  keys[0] = false;// 'w' key for upward movement defined in Player class
  keys[1] = false;// 'a' key for leftward movement defined in Player class
  keys[2] = false;// 's' key for downward movement defined in Player class
  keys[3] = false;// 'd' key for rightward movement defined in Player class
  keys[4] = false;// 'e' key for shield toggling defined in Player class
  keys[5] = false;// space bar for shooting defined in Player class

  loadHighscore(); //loads the highscorelist from the .txt file into the arrays

  explosionSpriteSheet = loadImage("explosion animation b.png");

  //inputName = "";
}

void draw()
{
  println("inputname is: " + inputName);
  background(160, 160, 160);

  //Updates player position and collisions every frame
  if (gameState == 0)
  {
    mainMenuScreen();
  }
  if (gameState >= 1 && gameState <= 5)
  {
    curLevel.update();
    player.update();
  }

  if (gameState == 6)
  {
    youWinScreen();
  }
  if (gameState == 7)
  {
    gameOverScreen();
  }

  if (gameState >= 1 && gameState <= 5)
  {
    textSize(20);
    fill(30, 100, 255);
    text("My Score: "+points, 30, 50);
    text("Shield Charges: " + player.getshieldCharge(), 30, 80);
    text("Level: " + gameState, 600, 50);
    noFill();
  }
  
  //Used for testing. Updates every instance of Boss in the ArrayList
  /* for (Boss b : bosses)
   {
   b.update();
   }
   
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
   if (elementE.getHitPoints() <= 0) 
   { 
   itrE.remove();
   }
   }
   
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
   }*/
}

//Checks on each key pressed event if the player needs to fire a projectile
void keyPressed()
{
  if (keyCode == UP)//up arrow
  {
    keys[0] = true;
  }
  if (keyCode == LEFT)// left arrow
  {
    keys[1] = true;
  }
  if (keyCode == DOWN)// down arrow
  {
    keys[2] = true;
  }
  if (keyCode == RIGHT)// right arrow
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

  //If 
  if (gameState == 7 || gameState == 6)
  {
    if (key > 96 && key < 123 && inputName.length() < 4)
    {
      createInputName();
    }
  }
}

void keyReleased()
{
  if (keyCode == UP)//up arrow
  {
    keys[0] = false;
  }
  if (keyCode == LEFT)//left arrow
  {
    keys[1] = false;
  }
  if (keyCode == DOWN)//down arrow
  {
    keys[2] = false;
  }
  if (keyCode == RIGHT)//right arrow
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
}

void exitGame()
{
  saveHighscore();
  exit();
}

void mousePressed()
{
  //Looks for whether the mouse is hovering over a button
  if (gameState == 0)
  {
    //Checks for clicks on "Wanna Play?" button on Main Menu
    if (mouseX >= width/2-100 && mouseX <= width/2+100)
    {
      if (mouseY >= 400 && mouseY <= 500)
      { 
          gameState = 1;
          changeLevel(gameState);
      }
    }
    //Checks for clicks on "Exit Game?" button on Main Menu
    if (mouseX >= width/2-100 && mouseX <= width/2+100)
    {
      if (mouseY >= 600 && mouseY <= 700)
      {
        exitGame();
      }
    }
  }
  if (gameState == 7 || gameState == 6)
  {
    //Checks for clicks on "Play Again?" button on Game Over screen OR You Win screen
    if (mouseX >= width/2-300 && mouseX <= width/2-100)
    {
      if (mouseY >= 200 && mouseY <= 300)
      {
        if(inputName.length() > 3)
        {
          gameState = 1;//re-starts game
          enterNewHighscoreName();
          curLevel = new Level(gameState);
          reset();
        }
      }
    }
    //Checks for clicks on "Exit Game?" button on Game Over screen
    if (mouseX >= width/2+100 && mouseX <= width/2+300)
    {
      if (mouseY >= 200 && mouseY <= 300)
      {
        if(inputName.length() > 3)
        {
          enterNewHighscoreName();
          exitGame();
        }
      }
    }
  }
}

void spawnPlayer()
{
  player = new Player(width/2, height - 100);
}

void gameOver()
{
  gameState = 7;
  checkHighscore();
}

void gameOverScreen()//draw Game Over screen
{
  fill(255, 0, 0);
  textSize(70);
  text("GAME OVER", width/2-200, 150);

  displayHighscore();
}

//draws the highscore list in the window as well as a play again and exit button
void displayHighscore()
{
  fill(255);
  rect(width/2-300, 200, 200, 100);
  rect (width/2+100, 200, 200, 100);
  fill(0);
  textSize(25);
  text("Play Again?", width/2 - 265, 255);
  text("Exit Game?", width/2 + 135, 255);

  textSize(30);
  fill(255, 200, 200);
  text("High Scores:", width/2 - 90, 350);
  textSize(25);
  for (int i = 0; i < highscoreNames.length; i++)
  {
    if (highscoreNames[i] == "")
    {
      text("Congrats! Add a 4 Letter Name to continue", width/2-250, 380);
      text(inputName, width/2-200, 420 + 50*i);
    } else
    {
      text(highscoreNames[i], width/2-200, 420 + 50*i);
    }
  }

  for (int i = 0; i < highscores.length; i++)
  {
    text(highscores[i], width/2+100, 420 + 50*i);
  }
}

void youWinScreen()//draw You Win screen
{
  fill(255, 0, 0);
  textSize(70);
  fill(255, 255, 0);
  text("YOU WIN!", width/2-150, 150);
  displayHighscore();
  /*
    fill(255);
   rect(width/2-300, 200, 200, 100);
   rect (width/2+100, 200, 200, 100);
   fill(0);
   textSize(25);
   text("Play Again?", width/2 - 265, 255);
   text("Exit Game?", width/2 + 135, 255);
   
   textSize(30);
   fill(255, 200, 200);
   text("High Scores:", width/2 - 90, 350);
   textSize(25);
   text(highscoreNames[0], width/2-200, 400);
   text(highscores[0], width/2+100, 400);
   text(highscoreNames[1], width/2-200, 450);
   text(highscores[1], width/2+100, 450);
   text(highscoreNames[2], width/2-200, 500);
   text(highscores[2], width/2+100, 500);
   text(highscoreNames[3], width/2-200, 550);
   text(highscores[3], width/2+100, 550);
   text(highscoreNames[4], width/2-200, 600);
   text(highscores[4], width/2+100, 600);
   text(highscoreNames[5], width/2-200, 650);
   text(highscores[5], width/2+100, 650);
   text(highscoreNames[6], width/2-200, 700);
   text(highscores[6], width/2+100, 700);
   text(highscoreNames[7], width/2-200, 750);
   text(highscores[7], width/2+100, 750);
   text(highscoreNames[8], width/2-200, 800);
   text(highscores[8], width/2+100, 800);
   text(highscoreNames[9], width/2-200, 850);
   text(highscores[9], width/2+100, 850);
   */
}

void mainMenuScreen()//draw Main Menu
{
  if (gameState == 0)
  {
    background(0);
    fill(240, 50, 50);
    textSize(30);
    text("Combat Racing Simulator 2k18", width/2-200, 120);
    fill(255);
    rect(width/2-100, 400, 200, 100);
    rect(width/2-100, 600, 200, 100);
    textSize(25);
    fill(30, 100, 255);
    text("Wanna Play?", width/2-75, 455);
    text("Exit Game?", width/2-65, 655);
    fill(30, 100, 255);
    text("CONTROLS:", width/2-60, 200);
    text("Arrow Keys for up, down, left, right movement,", width/2-260, 240);
    text("Space bar to shoot,", width/2-85, 280);
    text("'E' button to use shield", width/2-100, 320);
    text("Good Luck!", width/2-50, 360);
    noFill();
  }
}

/*void playScreen()
 {
 if (gameState == 2)
 {
 draw();
 spawnPlayer();
 spawnBoss(); //testing function call
 spawnEnemy();//testing function call
 
 //projectiles = new ArrayList<Projectile>(); //Used for testing
 
 //explosions = new ArrayList<Explosion>();
 }
 }*/

void reset()
{
  checkedHighscore = false;
  player.resetPlayer();
  //inputName = "";
  saveHighscore();
  points = 0;
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
  for (int i = 0; i<highscores.length; i++)
  {
    println(i +1 + " " + highscoreNames[i] + ": " + highscores[i]);
  }
}

//returns true if the current score (points) is greater than, or equals to, one of the scores in the highscorelist
boolean checkHighscore()
{
  if (checkedHighscore == false)
  {
    //goes through the array highscores and compares the entries' values with current score (points)
    for (int i = 0; i < highscores.length; i++)
    {
      if (points >= highscores[i])
      {
        rearrangeHighscoreList(i);
        checkedHighscore = true;
        return true;
      }
    }
  }
  //If it went through the entire for-loop and didn't return true at any point, it means that the current score does not beat any of the existing ones
  return false;
}

//Rearranges the highscore list if the current score beats any of them. The parameter it takes is the placement on the scoreboard of the new entry
void rearrangeHighscoreList(int i)
{
  //If the new highscore is not the bottom one on the list
  if (i < 9) 
  {
    //Re-arrange the scoreboard by moving them down one - stops when it reaches the new highscore
    for (int j = 9; j > i; j--)
    {
      highscores[j] = highscores[j-1];
      highscoreNames[j] = highscoreNames[j-1];
    }
  }
  highscores[i] = points; //set the new highscore
  highscoreNames[i] = ""; //clear the corresponding spot for a new name
  inputName = "";
}

//Resets the highscore list back to default
void resetHighscoreList()
{
  //reset the scores
  for (int i = 0; i < highscores.length; i++)
  {
    highscores[i] = 0;
  }

  //reset the names
  for (int i = 0; i < highscoreNames.length; i++)
  {
    highscoreNames[i] = "N/A";
  }
}


//is used to create inputName, which is the new highscore entry
void createInputName()
{
  inputName += key; //add the character to the String
}


//Enters the inputName into the array highscoreNames
void enterNewHighscoreName()
{
  //go through every entry in the array highscoreNames
  for (int i = 0; i < highscoreNames.length; i++)
  {
    //locates the entry that is blank
    if (highscoreNames[i] == "")
    {
      highscoreNames[i] = inputName; //replace the blank entry with the name that has been entered by the player
    }
  }
}


void changeLevel(int i)
{
  curLevel = new Level(i);
}
