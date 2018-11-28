# Boxes
Boxes helps you keep track of where your stuff is.

## Concept
Everything is a box.  
You can have boxes inside a box.

#### Copies
A box can be inside multiple boxes or can be multiple times inside a box.  
Example: your car keys.

#### Pieces
A box can be broken down into pieces.  
Pieces can be placed into various boxes.  
Each piece is itself a box.  
Example: your desktop computer (tower, screen, keyboard, etc).

## Why
I wanted to create a flexible model of the physical world using a very simple
database schema:  
`CREATE TABLE boxes (id, parent, name);`
