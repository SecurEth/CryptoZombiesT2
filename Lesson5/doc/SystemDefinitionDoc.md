# System Description Document - CryptoZombies Lesson 5

Crypto is a Zombie Card Battle and Trading Game designed for teaching Solidity (See cryptozombies.io).  It is organized lessons.  This documentation process example follows the lessons of the cryptozombies.io in order to show how documentation grows as a project develops.  This is the last lesson; 5.

CryptoZombies is designed to be run from a java script website designed for this purpose.

## Actors

### Player
The Player plays the game via the website. Multiple player can play at the same time or sequentially.

### Game Administrator
The Game Administrator can set and change the owner of the CryptoKitties that the Zombies can feed off of.

The Game Administrator can withdraw the funds in the account  (from fees for leveling up)

### Traders
Traders can trade the zombie ERC-721 tokens without needing to play (but of course they will play)

## Tokens
The zombies in this game can be traded as ERC-721.  The traders or players can check the ownership of a zombie or get a count of number of zombies anyone owns.

It also allows transfer of zombies in two manners; the owner of a zombie can transfer it to another owner or the owner can just approve another address for a transfer.  Then the approved address transfers the zombie.  These transfers can be done from any website, not just the game site.

## Currency
Players can Level up a zombie by paying a fee

## Game Rules
Each player can only create one random zombie.  The Player enters a name for a zombie and asks to create a zombie.  

The name must be between 2 and 14 letters.

The zombie is created on the blockchain with attributes.  The player receives an index to the zombie, the name written on the blockchain (which is the same as he sent) and a dna number.

Zombies can feed on cryptokitties and create a new zombie with a mix of the dna of the kitty and the feeding zombie.  The created zombie has specific kitty dna.  The created zombie has the initial name "noname".  Zombie enters a cool down period (1 day) after a feeding

The owner of a zombie can change its name, but the name length must be between 2 and 14

The dna can be used to specify the looks of the zombie but this functionality is not on chain, it is within the Java Script contracts).

Zombies can attack other zombies.  They have a 70% chance to win.  Where they win, their wincount and level is incremented.  The enemy loss count is incremented. Where the attacking zombie loses, its loss count is incremented and the enemy zombies win count is incremented.  Win or lose, the attacking zombie enters a cooldown time (1 day).  It cannot fight or feed until the cool down time is complete.
