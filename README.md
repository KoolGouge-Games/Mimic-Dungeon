
# Mimic-Dungeon

A Reverse Stealth game where you play as a mimic in a dungeon eating adventurers

## Alex TODO

- [x] get all the object sprites to show up
- [x] Implement Adventurer queueing
- [x] add a restock timer (like 30sec?) for looted POIs
  -[x] take the POI out of "objects" when the adventurer starts looting
- [x] Impelement logic for eating adventurers
  - [x] have the mimic un-transform after the eating minigame
- [x] Implement score/level clear mechanics
- [x] Add a "level complete" screen
- [x] Add a Pause menu
- [x] Add a Start menu
- [x] Implement Adventurer animation logic
- [x] Implement Mimic animation logic
- [x] Add a "how to play" screen
- [x] pull the player to display over the timers/adventurers
- [x] set up export settings for submission
- [x] implement object type indicators
- [ ] Implement an options menu
  - [ ] volume controls
    - You can use the method `var bus = FmodServer.get_bus("path")`. It should return a FmodBus, which you can use to directly control its sound `bus.set_volume(x)`
  - [ ] key rebinding
    - https://youtu.be/of9O44xr0Go?si=_GeiP1xN2aA3hFv1
- [ ] add "running away" logic for when an adventurer spots a mimic
  - [ ] set up markers on the nav mesh, then have the adventurer navigate to the one furthest from the player for like, 1 second
  - [ ] also have player lose a point
- [ ] tie all the audio to their relative objects
  - [ ] mimic footsteps
  - [ ] adventurer footsteps
  - [ ] "you won" music
  - [ ] "menu open" for options

### Stretch Goals

- [ ] Implement a timer and display clear times
- [ ] Add a level selector screen + more levels
- [ ] Get FMOD to work in the web
- [ ] Add controller support
- [ ] have the mimic turn to face the adventurer he's eating
- [ ] make the dynamic music logic smarter (only cut out dynamic tracks when ALL of an adventurer type is gone)


### Post Jam Stretch Goals

- [ ] Add Multiplayer
- [ ] Procedurally generated levels
