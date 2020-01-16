# Multipane Clock

A flutter clock engine based on the concept of overlapping panes rotated relative to the current instantaneous time, as per a physical wristwatch. With three example clock faces.

> Note that this engine is pretty processor intensive without a GPU: as such, it performs badly on an emulator, and should be viewed on a physical device.

## Example Clocks

The basic clock engine allows for many different clock faces and behaviours to be modelled. Three examples are provided.

> In proper use the clock face shown would be selected by the device owner. Since the rules of the Flutter Clock competition state that no user interaction with the clock is allowed, this build simply cycles through the available faces, allowing about 15 seconds on each.

### Paper Cogs

A simple demonstration of multiple superimposed rotating panes in a fairly traditional analogue clock face.

Features:
- satisfyingly clunky movement on the second hand

### The Unobservant Astronaut

A child's bedroom clock.

Features:
- the wobble on the flying saucer, which makes use of a `Pane`'s `pendulumArc` to limit rotation to part of a circle (see below)
- the various things in the sky, all of which use `Vector`s to offset themselves from their origin according to the current time.

### Flutsky Orloj

A simulation of the [Pražský Orloj, or Prague Astronomical Clock](http://www.orloj.eu/en/home1.htm). Assuming my calculations are working (which is a bit of a leap, but go with me) it should look like the simulation [here](http://www.orloj.eu/en/orloj_simulator1.php).

Features:
- siderial time and lunar time exposed on the zodiac dial and moon respectively
- a more obvious use of the possibity of pendulum panes

> Note that this is very much a work in progress, and there are a number of improvements to be made: the phase of the moon is currently static; the placement of the sun doesn't match well enough with the real clock (I need to improve my maths); and the outer dial is oscillating far too fast. In real life, this dial moves 60° back and forth across the year; but in all honesty that makes for a tectonically slow clock face which appears entirely static: speeding it up gives you something to look at.

## Components

### `AngularClockTime`

A wrapper for a `DateTime` instance which exposes its entities - `millisecond`, `second`, `minute` etc. - as values in the range 0 <= x < 1, representing how many of the entities have passed since the start of the next higher entity, as a fraction. For example, 32 seconds would be expressed as 32 / 60, since 32 60ths of the current minute have passed.

In other words, for any given entity it answers the question: what angle would my hand be pointing at, if shown on a clock face?

>Note that throughout this project angles are represented in a somewhat unorthodox manner, as fractions of a full circle: 0 <= angle < 1 (they are only converted to radians in widgets at the point of rendering). This allows angles and `AngularClockTime` entities to be used roughly interchangeably.

`AngularClockTime` exposes a few extra fields too, notably a `bouncySecond` which provides a delayed, damped bounce to its second value, enabling the nice, clunky motion of the second hand on the Paper Cogs clock.

## Licenses

### Source Code

Source code is originated by [Nic Ford](https://github.com/shinyford/), and licensed under the [Apache 2.0 License](https://www.apache.org/licenses/LICENSE-2.0).

### Images

All images are licensed for reuse with modification. Where not listed below, images are cackhandedly created by [Nic Ford](https://github.com/shinyford/), and also licensed under the [Apache 2.0 License](https://www.apache.org/licenses/LICENSE-2.0).

- Flutsky Orloj
  - Dials, hands, sun, moon: https://publicdomainvectors.org/en/free-clipart/Prague-astronomical-clock/72025.html
  - Time hand: https://www.publicdomainpictures.net/en/view-image.php?image=174632&picture=hand-pointing-out
  - Night sky: https://www.pxfuel.com/en/free-photo-qllfa
- Moon Clock
  - Astronaut standing on moon: https://www.pxfuel.com/en/free-photo-qllfm
  - Rocket and night sky: https://www.pxfuel.com/en/free-photo-qllfa
  - Flying saucer: https://www.needpix.com/photo/171539/ufo-alien-extraterrestrial-green-flying-saucer-spaceship
  - Floating Astronaut: https://www.pxfuel.com/en/free-photo-qllfx
  - Moon: https://pixabay.com/vectors/moon-craters-lunar-surface-sphere-36858/
  - Sun: [Brian Jordan](https://commons.wikimedia.org/wiki/User:Bcjordan), https://commons.wikimedia.org/wiki/File:Sun.svg
- Paper Cog Clock
  - Clock face and hands: https://freesvg.org/roman-clock-new
  - Cogs: Ian L, https://www.needpix.com/photo/1331454/cogs-cog-wheel-drawing-clipart-illustration-gear-gears-mechanism
  - Hourglass: https://publicdomainvectors.org/en/free-clipart/Hourglass-vector-image/10505.html



