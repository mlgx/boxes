# Boxes
Boxes helps you keep track of where your physical stuff is.

## Concept
Everything is a box.
You can have boxes inside a box.
An object is a box with nothing inside (caveat: an empty box becomes an object).

*Copies*
A box or object can be inside multiple boxes, or can be multiple times inside a single box.
Example: the keys to your safe.

*Pieces*
A box or object can be broken down into pieces. Each piece is itself a box or object.
The pieces can be placed into various boxes. To keep track of all the pieces that form an object, you also put them inside of a common box.
However, since the pieces would then belong to more than one box they would also wrongly be considered "copies".
To avoid that, the "common" box must be flagged as being a "virtual" box (i.e. a
box that does not exists in the physical world anymore and simply describes the object from which the pieces come).
Example: your desktop computer (tower, screen, keyboard, etc).

## Why
I wanted to create a flexible model the physical world using a very simple database schema: `CREATE TABLE boxes (id, parent, name);`
