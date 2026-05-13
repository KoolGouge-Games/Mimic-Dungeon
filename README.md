
# Mimic-Dungeon

A Reverse Stealth game where you play as a mimic in a dungeon eating adventurers

## Alex TODO

- [x] get all the object sprites to show up
- [x] Implement Adventurer queueing
- [x] add a restock timer (like 30sec?) for looted POIs
  -[x] take the POI out of "objects" when the adventurer starts looting
        (minimize looting conflicts)
- [x] Impelement logic for eating adventurers
  - [x] have the mimic un-transform after the eating minigame
- [x] Implement score/level clear mechanics
- [x] Add a "level complete" screen
- [x] Add a Pause menu
- [x] Add a Start menu
- [x] Implement Adventurer animation logic
- [x] Implement Mimic animation logic
- [ ] set up export settings for submission
- [ ] implement object type indicators
- [ ] Implement an options menu
  - [ ] volume controls
- [ ] tie all the audio to their relative objects
  - [ ] mimic footsteps
  - [ ] "you won" music
  - [ ] "menu open" for options
  - [ ] UI hovers?
- [ ] add "running away" logic for when an adventurer spots a mimic
  - [ ] set up marekers at each point on the nav mesh, then have the adventurer navigate to the one furthest from the player
  - [ ] also have player lose a point
- [ ] Add a "how to play" screen
- [ ] Implement a timer and display clear times

### Stretch Goals

- [ ] Add a level selector screen?
- [ ] Get FMOD to work in the web
- [ ] Add controller support
- [ ] Add key rebinding
  - https://youtu.be/of9O44xr0Go?si=_GeiP1xN2aA3hFv1

### Post Jam Stretch Goals

- [ ] Add Multiplayer
- [ ] Procedurally generated levels
