# System Description Document - CryptoZombies Lesson 2

Crypto is a Zombie Card Battle and Trading Game designed for teaching Solidity (See cryptozombies.io).  It is organized lessons.  This documentation process example follows the lessons of the cryptozombies.io in order to show how documentation grows as a project develops.

CryptoZombies is designed to be run from a java script website designed for this purpose.

## Actors

### Player
The Player plays the game via the website.

## Tokens
This game has no tokens (yet).

## Currency
This games has no payable transactions (yet).

## Game Rules
Each player can only create one random zombie.  The Player enters a name for a zombie and asks to create a zombie.  

The name must be between 2 and 14 letters.

The zombie is created on the blockchain with attributes.  The player receives an index to the zombie, the name written on the blockchain (which is the same as he sent) and a dna number.

Zombies can feed on cryptokitties and create a new zombie with a mix of the dna of the kitty and the feeding zombie.  Only one fixed kitty can be used for now.  The created zombie has specific kitty dna when the species kitty is specified.  The created zombie has the name "noname" for now.

The dna can be used to specify the looks of the zombie but this functionality is not on chain, it is within the Java Script contracts).

