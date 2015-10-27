# MemoryGame
A MemoryGame embedded in a Share Extension for Soundcloud


## Setup using Carthage

1. Install Carthage on your computer using `brew install carthage`
2. Update and build frameworks with `carthage update`
3. Compile and have fun!

## Playing the game

- Share your tracks to this extension and play with them!! :tada:

- The game downloads the track or tracklist for the given permalink, extracts the user, and then download the tracks for that user.

- If the user has less than 8 valid tracks then a game can't be created and the user will be alerted. A track is valid if it has an `artwork_url`

- The game will end when all the pairs are found. The game will be reseted to start playing again!


## Architecture

The ShareExtension is divided in two targets, the extension itself that has all the View stuff and a Framework 
that has all the game logic and API interactions. It also has a target for testing the framework code.

All the API interaction uses `ReactiveCocoa` while the Game has a delegate pattern to notify all game actions when a match is found or when the game finishes.

### Testing

I used `expecta` and `specta` to test the application. Only part of the Framework is covered, more exactly the `GameController` class with the game logic.




