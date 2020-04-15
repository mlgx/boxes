# Boxes
Boxes helps you keep track of where your stuff is.

## Running

```bash
brew install elixir
brew install postgresql
brew install node
# https://github.com/nodejs/node-gyp#on-macos

psql -d postgres
=# CREATE USER postgres CREATEDB PASSWORD '********';

mix deps.get
mix ecto.setup
(cd assets && npm install)
npm run deploy --prefix ./assets
mix phx.digest
mix phx.server

open "http://0.0.0.0:4000/"
```

## Concept
Everything is a box.  
You can have boxes inside a box.


## Types of boxes

There's two types of boxes:
* Physical Boxes (PBs)
* Virtual Boxes (VBs)

Physical Boxes -like the name indicates- represent physical objets.  
Use them to describe where a physical object is in the real world.  
Example of PBs: bed, table, chairs, bedroom, house.

Virtual Boxes represent concepts or ideas.  
Use them to organize your PBs into logical groups.  
Example of VBs: furniture, bedding.

The main difference between them is that VBs form trees, while PBs form directed acyclic graphs
(with a major simplification: nodes with more than one parent can't have children).

## Rules for physical boxes

* Physical Boxes (PBs) are unique and identified by a unique `id`.
* To avoid confusion their `name` is also unique.

```sql
CREATE TABLE physical_boxes (
	id SERIAL PRIMARY KEY,
	name VARCHAR UNIQUE NOT NULL
)
```
```sql
-- Should succeed:
INSERT INTO physical_boxes (name) VALUES ('a');
INSERT INTO physical_boxes (name) VALUES ('b');
-- Should fail:
INSERT INTO physical_boxes (name) VALUES ('a');
INSERT INTO physical_boxes (name) VALUES ('a');
-- and
INSERT INTO physical_boxes (id, name) VALUES (1, 'a');
INSERT INTO physical_boxes (id, name) VALUES (2, 'a');
-- and
INSERT INTO physical_boxes (id, name) VALUES (1, 'a');
INSERT INTO physical_boxes (id, name) VALUES (1, 'a');
-- and
INSERT INTO physical_boxes (id, name) VALUES (1, 'a');
INSERT INTO physical_boxes (id, name) VALUES (1, 'b');
```
* PBs can be inside of other PBs.

```sql
CREATE TABLE physical_boxes_relationships (
	id INTEGER NOT NULL REFERENCES physical_boxes (id),
	parent_id INTEGER NOT NULL REFERENCES physical_boxes (id)
)
```
```sql
-- Should succeed:
--   Box 2 is inside box 1.
INSERT INTO physical_boxes_relationships (id, parent_id) VALUES (2, 1);
```
* A PB cannot be inside itself.

```sql
-- Should fail:
--   Box 1 is inside box 1.
INSERT INTO physical_boxes_relationships (id, parent_id) VALUES (1, 1);
```
* Circular references should not be permitted either.

```sql
-- Should fail:
--   Box 2 is inside box 1 which is inside box 2.
INSERT INTO physical_boxes_relationships (id, parent_id) VALUES (2, 1);
INSERT INTO physical_boxes_relationships (id, parent_id) VALUES (1, 2);
```
* When a PB is inside multiple PBs, we say there are _copies_ of it.
* You can have multiple copies inside a single PB.

```sql
-- Should succeed:
--   Keep 1 house key on my keychain and 2 copies in the key holder.
INSERT INTO physical_boxes (id, name, description) VALUES (1, 'Key chain', 'Always with me');
INSERT INTO physical_boxes (id, name, description) VALUES (2, 'Key holder', 'On the wall inside the house');
INSERT INTO physical_boxes (id, name, description) VALUES (3, 'House key', 'The key to the house');
INSERT INTO physical_boxes_relationships (id, parent_id) VALUES (3, 1);
INSERT INTO physical_boxes_relationships (id, parent_id) VALUES (3, 2);
INSERT INTO physical_boxes_relationships (id, parent_id) VALUES (3, 2);
```
* A PB of which there are copies (2+ parents) cannot have children.

```sql
-- Should fail:
INSERT INTO physical_boxes_relationships (id, parent_id) VALUES (3, 1);
INSERT INTO physical_boxes_relationships (id, parent_id) VALUES (3, 2);
INSERT INTO physical_boxes_relationships (id, parent_id) VALUES (4, 3);
```

## Rules for virtual boxes

* Virtual Boxes (VBs) are unique and identified by a unique `id`.
* To avoid confusion their `name` is also unique.

```sql
CREATE TABLE virtual_boxes (
	id SERIAL PRIMARY KEY,
	name VARCHAR UNIQUE NOT NULL
)
```
* VBs can be inside other VBs.
* Unlike PBs, a VB cannot be inside multiple VBs at once.
  * You can't have _copies_ of something virtual (i.e. of a concept).

```sql
CREATE TABLE virtual_boxes_relationships (
	id INTEGER UNIQUE NOT NULL REFERENCES virtual_boxes (id),
	parent_id INTEGER NOT NULL REFERENCES virtual_boxes (id)
)
```
```sql
-- Should succeed:
--   Box 2 is inside box 1.
INSERT INTO virtual_boxes_relationships (id, parent_id) VALUES (2, 1);
-- Should fail:
--   Box 1 is inside box 2 and 3.
INSERT INTO virtual_boxes_relationships (id, parent_id) VALUES (1, 2);
INSERT INTO virtual_boxes_relationships (id, parent_id) VALUES (1, 3);
-- and
--   Box 1 is inside box 2 twice.
INSERT INTO virtual_boxes_relationships (id, parent_id) VALUES (1, 2);
INSERT INTO virtual_boxes_relationships (id, parent_id) VALUES (1, 2);
```
* A VB cannot be inside itself.
```sql
-- Should fail:
--   Box 1 is inside box 1.
INSERT INTO virtual_boxes_relationships (id, parent_id) VALUES (1, 1);
```
* Circular references should not be permitted either.

```sql
-- Should fail:
--   Box 2 is inside box 1 which is inside box 2.
INSERT INTO virtual_boxes_relationships (id, parent_id) VALUES (2, 1);
INSERT INTO virtual_boxes_relationships (id, parent_id) VALUES (1, 2);
```

## Rules for physical and virtual boxes relationships (NOT IMPLEMENTED YET, no db table creation, nothing)

* VBs cannot be inside PBs.
* A PB can be inside a VB (but not inside multiple VBs at once).
  * TODO: consider removing this restriction.

```sql
CREATE TABLE boxes_relationships (
    physical_box_id INTEGER UNIQUE NOT NULL REFERENCES physical_boxes (id),
    virtual_box_id INTEGER NOT NULL REFERENCES virtual_boxes (id)
)
```
```sql
-- Should succeed:
INSERT INTO boxes_relationships (1, 1);
INSERT INTO boxes_relationships (2, 1);
-- Should fail:
INSERT INTO boxes_relationships (1, 1);
INSERT INTO boxes_relationships (1, 2);
```
