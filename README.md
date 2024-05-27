# memory_app

# Memory App

After launching the application, a menu is displayed where the user is prompted to select the difficulty level, which will determine the number of pairs to be revealed. Additionally, a button labeled "Options" is displayed. Upon clicking the "Options" button, the user has the ability to specify the number of players and set the round time. After selecting the difficulty level, the game starts. The player chooses two cards; if they are identical, the cards remain flipped. If the pair is not correct, the cards return to their initial position. If the player guesses all pairs, the gameplay time is taken into account. However, if the player fails to do so before the designated time, the number of guessed pairs is considered. The ranking during multiplayer gameplay functions in the same way.

## Gameplay Scenarios:

### 1. Start Menu
- User is prompted to select the difficulty level.
- User can access options by clicking the "Options" button.

### 2. Options
- User can specify the number of players.
- User can set the round time.

### 3. Start Game
- User selects the difficulty level.
- Gameplay begins.

### 4. Playing the Game
- User selects two cards.
- If the cards are identical, they remain flipped.
- If not, the cards return to their initial position.

### 5. End of Game
- If the player guesses all pairs, gameplay time is considered.
- If not, the number of guessed pairs is considered.
- Multiplayer ranking follows the same rules.

## Functional and Non-functional Requirements:

### Functional Requirements:
- Specify the number of players.
- Set the round time.
- Choose the difficulty level.
- Start the game.
- Display gameplay time.
- Display ranking.
- Return to the menu.

### Non-functional Requirements:
- Intuitive interface.
- Easy modification of gameplay.
- Cross-platform compatibility.
- Scalability.


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Use Case Descriptions:

### Use Case: Open Options
**Actor:** User  
**Trigger:** Desire to modify gameplay options  
**Main Scenario:**
1. The system displays the user with the start screen.
2. The user clicks the "Options" button.
3. The system displays the user with a view of available modifications.

### Use Case: Set Round Time
**Actor:** User  
**Trigger:** Actor pressed the "Options" button  
**Main Scenario:**
1. The actor modifies the gameplay time by entering the appropriate value.
   2.1. The actor entered a correct value.
   2.1.1. The system modifies the gameplay time.
   2.2. The actor entered an incorrect value.
   2.2.1. An error message is displayed.

### Use Case: Choose Number of Players
**Actor:** User  
**Trigger:** Actor pressed the "Options" button  
**Main Scenario:**
1. The actor modifies the number of players by entering the appropriate value.
   2.1. The actor entered a correct value.
   2.1.1. The system modifies the number of players.
   2.2. The actor entered an incorrect value.
   2.2.1. An error message is displayed.

### Use Case: Choose Difficulty Level
**Actor:** User  
**Trigger:** Actor wants to modify the difficulty level  
**Main Scenario:**
1. The system displays the user with the start screen.
2. The user clicks the icon with the appropriate difficulty level.
3. The system modifies the gameplay difficulty level.

### Use Case: Play
**Actor:** User  
**Trigger:** Actor selected the difficulty level  
**Main Scenario:**
1. The system displays the user with the card board.
2. The user starts the game by clicking on a chosen card.
   3.1. The user correctly chose a pair of cards.
   3.1.1. The chosen cards remain flipped.
   3.1.2. The system assigns points to the user.
   3.2. The user incorrectly chose a pair of cards.
   3.2.1. The cards return to their initial position.
   3.2.2. It's the next player's turn.

### Use Case: Play Again
**Actor:** User  
**Trigger:** User completed the game  
**Main Scenario:**
1. The system displays the user with the end screen.
2. The user clicks the "Play Again" button.
3. The system displays a new card board.

### Use Case: Return to Menu
**Actor:** User  
**Trigger:** User completed the game  
**Main Scenario:**
1. The system displays the user with the end screen.
2. The user clicks the "Menu" button.
3. The system displays the user with the start screen.

### Use Case: Display Result
**Actor:** User  
**Trigger:** User completed the game  
**Main Scenario:**
1. The system displays the user with the end screen with the result.
2. The system displays the player ranking.

## Functional and Non-functional Requirements:
### Functional Requirements:
- Determine the number of players
- Determine the gameplay time
- Choose the difficulty level
- Start the game
- Display the number of points earned
- Display ranking
- Ability to return to the "Menu"

### Non-functional Requirements:
- Intuitive interface
- Easy gameplay editing
- Cross-platform compatibility
- Scalability
