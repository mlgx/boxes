# Boxes
Boxes helps you keep track of where your stuff is.

## Concept
Everything is a box.  
You can have boxes inside a box.

#### Copies
A box can be inside multiple boxes and multiple times inside a box.  
Example: your car keys.

#### Pieces
A box can be broken down into pieces. Each piece is itself a box.  
Example: your desktop computer (tower, screen, keyboard, etc).

## Why
I wanted to create a flexible model of the physical world using a very simple
database schema:  
`CREATE TABLE boxes (id, parent, name);`

This schema is not suited for our use case and adds a lot of complexity to the implementation.
This is just part of an exercise and an excuse to play with Ecto.
