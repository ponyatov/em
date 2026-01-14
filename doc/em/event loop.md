# Event loop
## цикл событий

- https://arobenko.github.io/bare_metal_cpp/#basic_concepts-event_loop
- https://en.wikipedia.org/wiki/Event_loop

> **event loop** is a programming construct or design pattern that *waits* for and *dispatches* [[GUI/event|events]] or messages in a program

## [[servo loop]]
@ [[em/embedded|embedded]]

## [[GameDev]]

- http://gameprogrammingpatterns.com/game-loop.html#event-loops

Modern graphic UI applications are surprisingly similar to old adventure games once you shuck their skin off. Your word processor usually just sits there doing nothing until you press a key or click something:

```Cpp
while (true)
{
  Event* event = waitForEvent();
  dispatchEvent(event);
}
```

The main difference is that instead of text commands, the program is waiting for user input events — mouse clicks and key presses. It still works basically like the old text adventures where the program blocks waiting for user input, which is a problem.

Unlike most other software, games keep moving even when the user isn’t providing input. If you sit staring at the screen, the game doesn’t freeze. Animations keep animating. Visual effects dance and sparkle. If you’re unlucky, that monster keeps chomping on your hero.

This is the first key part of a real game loop: it processes user input, but doesn’t wait for it. The loop always keeps spinning:

```Cpp
while (true)
{
  processInput();
  update();
  render();
}
```

We’ll refine this later, but the basic pieces are here. 
- `processInput()` handles any user input that has happened since the last call. Then, 
- `update()` advances the game simulation one step. It runs AI and physics (usually in that order). Finally, 
- `render()` draws the game so the player can see what happened.
