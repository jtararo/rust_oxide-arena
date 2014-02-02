rust_oxide-arena
================

Forked from this plugin http://forum.rustoxide.com/resources/arena-plugin.93/

I have asked the author to see if he can implement these options. He may or may not do so in the future.

Existing Commands:
/arenaon - Opens the Arena (Admin)
/arenaoff - Closes the Arena (Admin)
/arena - Players type this to spawn into the Arena (Roof Centre)

What I have added:
/arenat1 - Spawns on the bottom floor (Team 1)
/arenat2 - Spawns on the Roof (Team 2)


What I Want To Add:
/arena arm (toggle)
/arena t1
/arena t2

Two Game Modes:

1. Free-for-All
2. Team Based


FREE-FOR-ALL
Description:
Players type /arena and they a spawned to a random location within the arena. They are warned to clear their inventory.

How it Works:
1. Have a table containing random co-ordinates from within the arena. This can be gathered manually by going to random spots and taking its /location

2. When a player types /arena, a random spawn point is picked from the table above. This random spawn point is then marked as 1. It will continue to spawn players at spawn points which have not been marked as 1.
If players are still spawning in and all spawn points have been marked as 1, it clears all spawn points from being used and starts again - ie spawn points are no longer marked as one.


TEAM BASED
Description:
Players team up. All teams agree on who's statrting where then they swap at the end of each round. Teams type /arena t1 or /arena t2 depending on where their teams are going.

How it Works:
1. Same as FREE-FOR-ALL except limit to the number of teams
2. Members of the team all go to the same starting location ie /arena t1 or /arena t2


FEATURES
1. There will be an option for the admin to enable weapons - /arena arm
Once this is enabled. Players who type /arena will go through a 3 step process
  a) any weapons in their inventory will be removed/deleted
  b) their names will be added to a table - to track who's in the arena for later use
  c) they will be given an arena kit - decided by admins
  d) they are spawned into the arena
If the arena is not armed, they will just spawn in.

2. When a player spawns into the Arena using /arena, /arena t1 or /arena t2, their name is added to a table to keep track of who is in the Arena.

2a. When a player dies, they are marked as dead and a popup appears saying "[PlayerName] was killed in the Arena". Dead players can not spawn back into the Arena.

3. When there is only one player left, he is declared overall winner, matched announced as over and all players death status in the table, is cleared.

4. For Team Based. If a whole team is dead, the other team is declared winner and the match closed.
