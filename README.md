# MemoryGame
A MemoryGame embedded in a Share Extension for Soundcloud

The ShareExtension is divided in two parts, the extension itself that has all the View stuff and a Framework 
that has all the game logic.

To test the Extension, clone the repo and execute `carthage update` and you are ready to go

## View

The view part is has 4 classes:

- **ShareViewController:** Has a 4x4 Collection view formed of `TrackCells`. This class initializes the Presenter and 
is in charge of diplaying the Collection view, but is not the delegate nor the dataSource. It is in charge of executing
the cell flipping to discover the track covers or not.
Can also show Error/loading/info messages to indicate the state of the game.

- **ShareViewPresenter** Has a `GameController` entity that is initialized with a permalink received from the `extensionContext`.
This class is the delegate of the GameController and will receive the events of the game (match, finish, etc...)
It also initializes the CollectionDataSource with the list of tracks provided by the `GameController`

- **TrackCell** The `Cell` used in the `CollectionView`, it has two `UIImageViews` and can be flipped to show one or the oher
d. One of the images is the cover of the track, the other is a generic one.

- **ShareViewCollectionViewDataSource** It's the dataSource for the `CollectionView` in the ShareViewController. 
Also communicates with the `GameController` when the user taps in a Cell


## Framework

The Core part hast 3 classes:

- **Game** Game is collection of Track objects, limited to 8 objects duplicated (for form the pairs) and that canbe shuffled.

- **GameController** Has all the game logic, you should ask it for the elements to show and when the user select one of them.
You must conform the `GameControllerDelegate` protocol to receive the events of the game like `didFindMatch` or `didFinish`
It communicates with the APIClient to download the necessary information to start the game and creates the `Game` object

- **APIClient** Communicates with the Soundcloud API to resolve permalinks and get the last 8 tracks from a user.
Is implemented using ReactiveCocoa.


## Testing

I used `expecta` and `specta` to test the application. Only part of the Framework is testes, more exactly the `GameController`
class with the game logic.


## Playing the game

- When the extension receives the `NSExtensionItem`, it will extract the permalink, download the track or tracklist for that 
permalink, extract the user, and then download the tracks for that user.

- If the user has less than 8 tracks then a valid game can't be created and the user will be alerted. If the user has more than 
8 tracks, they need to have a valid `artwork_url` to be considered valid tracks.

- Once we have a valid game, you can start playing like a normal Memory game. There shouldn't be any issues 
if you try to tap in multiple cells very fast.

- The game will end when all the pairs are found. Then the GameController will reset the game, reshuffle and start again.


