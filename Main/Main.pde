/*
Program Title: Combat Racing Simulator 2k18

Program Description: A 2D top-down bullet hell game made as part of the course Programming for Designers
 at The IT University of Copenhagen. The game is started from a main menu, and contains 5 structurally
 different levels, as well as three different types of enemies and a boss at the end of each level.
 Furthermore, the game has a highscore list with 10 entries, which is saved locally in a .txt file.
 It is possible for successful players to enter a 4 character name/tag into the highscore list.
 
Authors: Casper Simon Boonen & Ryan Wright

Comments: Last updated: December 2018
 */
import java.util.*; //imports the Iterator class

int points; //the player's current score
int gameState; //indicates the current screen/level being displayed
String inputName; //used to store a new entry into the highscore
int[] highscores; //an array of the points of each highscore entry
String[] highscoreNames; //an array of the names in the highscore list
boolean[] keys; //Boolean array for checking if keys are being pressed. Enables multiple concurrent button presses

Player player;

PImage explosionSpriteSheet; //spritesheet containing several frames of an explosion animation

//2D sprites used to display instances of Enemy, Boss, and Player
PImage enemySprite;
PImage bossSprite;
PImage playerSprite;

Level curLevel; //Used to store the instance of Level which is currently active

boolean checkedHighscore = false; //Indicates if the game has checked whether the current score beats any highscore entries

void setup()
{
  size(700, 900);

  gameState = 0;//starts game on title/main screen
  
  //Loads sprites from disk
  enemySprite = loadImage("enemy c.png");
  bossSprite = loadImage("boss.png");
  playerSprite = loadImage("player.png");
  explosionSpriteSheet = loadImage("explosion animation b.png");

  spawnPlayer();

  keys = new boolean [6];
  keys[0] = false;// arrow up key for upward movement of Player
  keys[1] = false;// arrow left key for leftward movement of Player
  keys[2] = false;// arrow down key for downward movement of Player
  keys[3] = false;// arrow right key for rightward movement of Player
  keys[4] = false;// 'e' key for shield toggling - defined in Player
  keys[5] = false;// space bar for shooting - defined in Player

  loadHighscore();
  
  inputName = "N/A/";
}

void draw()
{
  background(160, 160, 160);

  //If gameState is 0, the main menu will be displayed
  if (gameState == 0)
  {
    mainMenuScreen();
  }
  
  //If gameState 1, 2, 3, 4, or 5 the current level and player will be updated
  if (gameState >= 1 && gameState <= 5)
  {
    curLevel.update();
    player.update();
    textSize(20);
    fill(30, 100, 255);
    text("My Score: "+points, 30, 50);
    text("Shield Charges: " + player.getshieldCharge(), 30, 80);
    text("Level: " + gameState, 600, 50);
    noFill();
  }
  
  //If gameState is 6 the You Win-screen will be displayed. Happens when the player beats all 5 levels
  if (gameState == 6)
  {
    youWinScreen();
  }
  
  //If gameState is 7 the Game Over-screen will be displayed. Happens when the player dies
  if (gameState == 7)
  {
    gameOverScreen();
  }
}

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

  //If gameState is 7 or 6 the player can edit the inputName (It will only be displayed and put into the highscore list if the players beats a score)
  if (gameState == 7 || gameState == 6)
  {
    //Only accepts small letters and restricts inputName from becoming longer than 4 characters
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
  //Checks whether the mouse is pressing a button on the screen
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
  //Checks if the player presses the buttons with the mouse on You Win and Game Over screen
  if (gameState == 7 || gameState == 6)
  {
    //Checks for clicks on "Play Again?" button on Game Over screen OR You Win screen
    if (mouseX >= width/2-300 && mouseX <= width/2-100)
    {
      if (mouseY >= 200 && mouseY <= 300)
      {
        //Only allows the player to click Play Again if inputName > 3. This is done by (a) a player beating a highscore enters
        //a 4 character handle, or (b) the player has not beaten a highscore and inputName is then "N/A/"
        if(inputName.length() > 3)
        {
          gameState = 1;//re-starts game on level 1
          enterNewHighscoreName();
          curLevel = new Level(gameState); //sets the curLevel variable to a new instance of Level with appropriate gameState
          reset();
        }
      }
    }
    //Checks for clicks on "Exit Game?" button on Game Over screen
    if (mouseX >= width/2+100 && mouseX <= width/2+300)
    {
      if (mouseY >= 200 && mouseY <= 300)
      {
        //Only allows the player to click Exit Game if inputName > 3. This is done by (a) a player beating a highscore enters
        //a 4 character handle, or (b) the player has not beaten a highscore and inputName is then "N/A/"
        if(inputName.length() > 3)
        {
          enterNewHighscoreName();
          exitGame();
        }
      }
    }
  }
}
//Instantiates player
void spawnPlayer()
{
  player = new Player(width/2, height - 100);
}

//Changes gameState to Game Over screen and checks if the current score beats any in the highscore list
void gameOver()
{
  gameState = 7;
  checkHighscore();
}

//Draws the Game Over screen
void gameOverScreen()
{
  textSize(20);
  fill(30, 100, 255);
  text("My Score: "+points, 30, 50);
  fill(255, 0, 0);
  textSize(70);
  text("GAME OVER", width/2-200, 150);

  displayHighscore();
}

//draws the highscore list in the window as well as a play again and exit button
void displayHighscore()
{
  //Buttons
  fill(255);
  rect(width/2-300, 200, 200, 100);
  rect (width/2+100, 200, 200, 100);
  fill(0);
  textSize(25);
  text("Play Again?", width/2 - 265, 255);
  text("Exit Game?", width/2 + 135, 255);
  
  //Highscore list
  textSize(30);
  fill(255, 200, 200);
  text("High Scores:", width/2 - 90, 350);
  textSize(25);
  
  //Goes through the array of highscore names to see if any of them are blank
  //If it's blank it means the current player beat a highscore
  for (int i = 0; i < highscoreNames.length; i++)
  {
    if (highscoreNames[i] == "")
    {
      text("Congrats! Add a 4 Letter Name to continue", width/2-250, 380);
      text(inputName, width/2-200, 420 + 50*i); //display inputName which can be edited by the player
    } 
    else
    {
      text(highscoreNames[i], width/2-200, 420 + 50*i);
    }
  }
  
  //Goes through the array highscores, and displays the values on screen
  for (int i = 0; i < highscores.length; i++)
  {
    text(highscores[i], width/2+100, 420 + 50*i);
  }
}

//draws You Win screen
void youWinScreen()
{
  if(checkedHighscore == false)
  {
    checkHighscore();
    checkedHighscore = true;
  }
  fill(255, 0, 0);
  textSize(70);
  fill(255, 255, 0);
  text("YOU WIN!", width/2-150, 150);
  displayHighscore();
}

//draw Main Menu
void mainMenuScreen()
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

//Resets necessary variable states back to defeault
void reset()
{
  checkedHighscore = false;
  player.resetPlayer();
  inputName = "N/A/";
  saveHighscore();
  points = 0;
}

//save the two highscore arrays to the .txt files on disc
void saveHighscore()
{
  saveStrings("highscoreNames.txt", highscoreNames);
  saveStrings("highscoreScores.txt", str(highscores));
}

//Loads the highscorelist from the local .txt files into the two arrays used to store highscore data in the game
void loadHighscore()
{
  highscoreNames = loadStrings("highscoreNames.txt");
  highscores = int(loadStrings("highscoreScores.txt"));
}

//returns true if the current score (points) is greater than, or equals to, one of the scores in the highscorelist
boolean checkHighscore()
{
  //Only runs if this has not been done before on the current play-through
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
  //If the new highscore is not the bottom one on in highscore list
  if (i < 9) 
  {
    //Re-arrange the scoreboard by moving from the last index in the array and up. Stops when it reaches the new highscore
    for (int j = 9; j > i; j--)
    {
      highscores[j] = highscores[j-1];
      highscoreNames[j] = highscoreNames[j-1];
    }
  }
  highscores[i] = points; //set the new highscore
  highscoreNames[i] = ""; //clear the corresponding spot for a new name
  inputName = ""; //clears inputName to match
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


//is used to create inputName, which will be the new highscore entry
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

//sets the current level to a new instance of Level
void changeLevel(int i)
{
  curLevel = new Level(i);
}
