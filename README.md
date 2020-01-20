# Multipane Clock

A flutter clock engine based on the concept of overlapping panes rotated relative to the current instantaneous time, as per a physical wristwatch. With three example clock faces.

> Note that this engine is pretty processor intensive without a GPU: as such, it performs badly on an emulator, and should be viewed on a physical device.

## Example Clocks

The basic clock engine allows for many different clock faces and behaviours to be modelled. Three examples are provided.

> In proper use the clock face shown would be selected by the device owner. Since the rules of the Flutter Clock competition rules state that no user interaction with the clock is allowed, this build simply cycles through the available faces, allowing about 15 seconds on each.

### Paper Cogs

A simple demonstration of multiple superimposed rotating panes in a fairly traditional analogue clock face, highlighting:
- use of `ClockAngle.bouncySecond` to provide the (hopefully) realistic clunky movement of the second hand
- the right hand cog under the dial oscillating rather than making full turns, via the `pendulumArc` parameter to its `Pane`.

### The Unobservant Astronaut

A child's bedroom clock, highlighting:
- the `pendulumArc` feature of a `Pane` which is used to provide the wobble of the flying saucer
- the various things in the sky, all of which use `Vector`s to offset themselves from their origin according to the current time.

### Flutsky Orloj

A simulation of the [Pražský Orloj, or Prague Astronomical Clock](http://www.orloj.eu/en/home1.htm). Assuming my calculations are working (which is a bit of a leap, but go with me) it should look like the simulation [here](http://www.orloj.eu/en/orloj_simulator1.php), highlighting:
- siderial time and lunar time exposed on the zodiac dial and moon respectively

> Note that this is very much a work in progress, and there are a number of improvements to be made: the phase of the moon is currently static; the placement of the sun doesn't match well enough with the real clock (I need to improve my maths); and the outer dial is oscillating far too fast. In real life, this dial moves 60° back and forth across the year; but in all honesty that makes for a tectonically slow clock face which appears entirely static: speeding it up gives you something to look at.

## Components

### `ClockAngle`

 A container for a function that will return an angle for a given `DateTime` instant
 to answer the question: what proportion of a given period of time has passed at a particular `DateTime` point in time? More simply: if I were a hand on a clock, how much of the clock face would I have traversed? What would I be pointing at?

 Static instances are provided for commonly needed angles: `second`, `minute`, `hour` etc. More esoteric `ClockAngle`s for siderial day, lunar day and day of year are also available.

 Some 'bouncy' instances are also provided, giving a delayed change in angle to mimic the movement of watch hands and e.g. am/pm discs.

 > The naming of these instances is a bit anti-intuitive, since hands for a given time unit take the next higher unit's worth of time to go round a clock: a second hand takes a minute; a minute hand takes an hour; an hour hand takes a meridien; and so on (at least conceptually).

 Most `ClockAngle`s will simply wrap an `AngleCalculator`. Some, notably the bouncy and `dayOfYear` timings, have more specialised methods.

>Note that throughout this project angles are represented in a somewhat unorthodox manner, as fractions of a full circle: 0 <= angle < 1 (they are only converted to radians in widgets at the point of rendering). This allows proportions of time periods and calculated angles to be used interchangeably.

### `AngleCalculator`

A calculator for the proportion of a `period` that has passed at a given `DateTime` instant using what is effectively floating point clock arithmetic (no pun intended).

### `Pane`

A container for an image which can be rotated and offset from its start position when rendered. Offsets are defined as lists of `Vector`s.

### `Vector`

A representation of an offset from a current position, comprising a distance and an angle calculated from a `DateTime` instance.

`Vector`s by default rotate continually in a circle; but by specifying an arc, the proportion of a circle to cover, a `Vector` can be made to oscillate back and forth across that segment of the full circle as per a pendulum.

### `Rotation`

A specialisation of a `Vector`, with zero offset, used to specify the rotation of a pane's image during rendering.

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



