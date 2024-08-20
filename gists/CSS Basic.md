# CSS

## CSS Selectors

The following selectors were introduced in CSS 1:

| Type                         | Example                                    |
| ---------------------------- | ------------------------------------------ |
| Туре                         | p {...}, blockquote {...}                  |
| Descendant combinator        | blockquote p {...}                         |
| ID                           | #content {...} on `<article id="content">` |
| Class                        | hentry {...} on `<article class="hentry">` |
| Link pseudo-class            | a:link {...} or a:visited {...}            |
| User action pseudo-class     | a:active {...}                             |
| :first-line pseudo-element   | p:first-line {...}                         |
| :first-letter pseudo-element | p:first-letter {...}                       |

Another 11 selectors were added in CSS 2.1.

| Type                                   | Example                          |
| -------------------------------------- | -------------------------------- |
| Universal                              | * {...}                          |
| User action pseudo-class               | a:hover {...} and a:focus {...}  |
| The :lang() pseudo-class               | article:lang(fr) {...}           |
| Structural pseudo-class                | p:first-child {...}              |
| The :before and :after pseudo-elements | a:before {...} or a:after {...}  |
| Child combinator                       | h2 > p {...}                     |
| Adjacent sibling combinator            | h2 + р {...}                     |
| Attribute selectors                    | input[required] {..}             |
| Attribute selectors; exactly equal     | input[type="checkbox"] {...}     |
| Substring attribute selectors          | input[class~="long-field"] {...} |
| Substring attribute selectors          | input [lang="en"] {...}          |

The selectors added in CSS3 that we'll be looking at in this chapter are as
follows:

| Type                             | Example                                |
| -------------------------------- | -------------------------------------- |
| General sibling combinator       | h1 ~ pre {...}                         |
| Negation pseudo-classes          | abbr:not([title]) {...}                |
| The :target(pseudo-class)        | section: target {...}                  |
| Substring attribute selectors    |                                        |
| String starts with               | a[href~"http://"] {...}                |
| String ends with                 | a[href$=".pdf"] {...}                  |
| String contains                  | a[href*="twitter"] {...}               |
| Structural pseudo-classes        |                                        |
| :nth-child                       | tr:nth-child(even) td {...}            |
| :nth-last-child                  | tr:nth-last-child(-n+5) td {...}       |
| :last-child                      | ul li:last-child {...}                 |
| :only-child                      | ul li:only-child {...}                 |
| :first-of-type                   | p:first-of-type {...}                  |
| :last-of-type                    | p:last-of-type {...}                   |
| :nth-of-type                     | li:nth-of-type(3n) {...}               |
| :nth-last-of-type                | li:nth-last-of-type(1) {...}           |
| :only-of-type                    | article img:only-of-type {...}         |
| :empty                           | aside: empty {...}                     |
| :root                            | :root {...}                            |
| UI element states pseudo-classes |                                        |
| :disabled                        | input:disabled {...}                   |
| :enabled                         | input:enabled {...}                    |
| :checked                         | input [type="checkbox"] :checked {...} |

## CSS Flex

- `flex-direction`: This controls the direction in which flex items are laid
  out, and takes the values `row (default)`, `row-reverse`, `column`, and
  `column-reverse`, with row meaning the main axis is the same direction as
  inline, and column in the same direction as block. These are based on the
  current language's writing direction, so the default row in English means from
  left-to-right, and in the traditional Japanese row is from top-to-bottom.
- `flex-wrap`: Flex containers can have a single line of flex items (the default
  `nowrap`), or contain multiple lines by using wrap or `wrap-reverse`. Multiple
  lines stack from start to end with wrap, or in the opposite direction for
  `wrap-reverse`.
- `flex-flow` shorthand property: This takes `flex-direction` and/or `flex-wrap`
  values, using the default value if one isn't declared.
- `justify-content`: This controls how flex items align in the main axis
  direction in a line. It might remind you of `text-align` for `inline-block`
  elements. The values are the default `flex-start` plus `flex-end`, `center`,
  `space-between`, and `space-around`.
- `align-items`: This controls how flex items in a flex line align in the cross
  axis direction, and might remind you of the `vertical-align` property. The
  values are `flex-start`, `flex-end`, `center`, `baseline`, and the default
  `stretch`, which makes all flex items the same height (for a row-based
  Flexbox).
- `align-content`: This controls the alignment of lines in a multi-line flex
  container in the cross-axis direction. The values are `flex-start`,
  `flex-end`, `center`, `space-between`, `space-around`, and the default
  `stretch`.

### Properties

The properties applied to flex items are the following:

- `order`: This property allows you to reorder flex items and takes number
  values. Items are ordered from negative to positive, and items without an
  explicit order declaration use the default value of `0`. Flex items with the
  same value appear in source order. This property should only be used for
  visual (not logical) reordering, and does not change order in speech readers.
- `flex-grow` and `flex-shrink`: These properties control if and how much a flex
  item is permitted to grow if there's extra space, or shrink if there's not
  enough space, respectively. Taken together for the flex items on the same flex
  line, they determine the flex grow ratio and flex shrink ratio, which
  determine proportionally how much each flex item grows or shrinks to fit.
  These properties take `0` and positive numbers, and the initial values are
  `flex-grow: 1;` and `flex-shrink: 1;`. This means flex items will default to
  being the same width (for a horizontal flow axis), and expanding or shrinking
  if there isn't enough space equally.
- `flex-basis`: This specifies the initial size of a flex item, before
  `flex-grow` or `flex-shrink` adjust its size to fit the container. It takes
  the same values as width (such as lengths and percentages), and the default is
  `auto`, which uses the item's width or height as appropriate (the dimension in
  the main axis direction). When used with flex this gives "relative flex".
  Values other than `auto` mean the item's width or height will be ignored.
  Setting `flex-basis: 0%;` or `flex-basis: O;` sets the flex items' main axis
  dimension to `0`, meaning its size will be dependent on `flex-grow` or
  `flex-shrink`, giving "absolute flex". Make sure you set a width or height as
  appropriate if using the value `auto`, or values close to (or equal to) `0`.
- `flex`: This sets `flex-grow`, `fex-shrink`, and/or `flex-basis`. If no values
  are defined, its initial values are the individual property values. If you
  only set `flex-grow` and/or `fiex-shrink` values. `flex-basis` will be `O`,
  giving "absolute flex" If you only set `fex-basis`, you'll get relative flex
  instead, with `flex-grow` and `flex-shrink` using the default `1`. Note that
  zero values for `flex-basis` in the flex property require a unit, for example
  `Opx`, to avoid confusion with the grow and shrink values. `flex` also has
  some useful shorthand values: `flex: initial;` or `flex: 0 auto;`: The flex
  item will use its width and height properties and not expand, but will shrink
  if necessary. This is the same as the initial values of `flex: 0 1 auto;` and
  is useful when using Flexbox for its alignment properties, or in combination
  with auto margins.
- `flex: none;`: Similar to `initial`, this stops flex items from flexing, even
  if their width or height cause them to overflow (equivalent to
  `flex: 0 0 auto;`).
- `flex: auto;`: Starting from their declared dimensions (or content dimensions
  if using e.g. `width: auto;`), flex items will grow or shrink to fill the
  space. If all flex items in a flex line use `auto`, any extra space will be
  distributed evenly using "relative flex" (equivalent to `flex: 1 1 auto;`).
- `flex: <positive-number>`: This makes a flex item flexible and also sets the
  `flex-basis` to `Opx` (equal to `flex: positive-number 1 0px;`) This uses
  "absolute flex", so if all flex items in a line use this style of flex (or use
  `flex-basis: 0%;` or `flex-basis: 0;`). then their sizes will be proportional
  to their flex ratios, unaffected by their intrinsic dimensions.
- `align-self`: This aligns a flex item in the cross-axis direction and is the
  flex item equivalent of the flex container's `align-items` property. It takes
  the same values (`flex-start`, `flex-end`, `center`, `baseline`, and
  `stretch`) with the addition of the default `auto`, which inherits the
  `align-items` value.

## CSS Transforms

- `transform`: This property takes one or more space-separated transform
  functions (listed below) to apply to an element, for example transform:
  `translate(3em, -24px) scale(.8);`. Transform functions can take negative
  values, and the default is `none`. The transform functions include the
  following: `translate()`: Moves the element from its `transform-origin` along
  the X, Y, and/or Z-axes. This can be written as `translate(tX)`,
  `translate(tX, tY)`, and `translate3D(tX, tY, tZ)` (percentage except tZ,
  lengths). There's also the 2D `translateX(tX)` and `translateY(tY)`, and the
  3D `translateZ(tZ)`.
- `rotate()`: Rotates the element around its `transform-origin` in
  two-dimensional space, with `0` being the top of the element, and positive
  rotation being clockwise (angles). There are also the `rotateX(rX)`,
  `rotateY(rY)`, and `rotateZ(rZ)` transformation properties to rotate around an
  individual axis. Finally, there's `rotate3D(vX, vY, vZ, angle)` to rotate an
  element in three-dimensional space around the direction vector of vX, vY, and
  vZ (unitless numbers) by angle (angles).
- `scale()`: Changes the size of the element, with `scale(1)` being the default.
  It can be written as `scale(s)`, `scale(sX, sY)`, and `scale3D(sX, sY, sZ)`
  (unitless numbers). There's also the 2D transforms `scaleX(sX)` and
  `scaleY(sY)`, and the 3D transform `scaleZ(sZ)`.
- `skew()`: Skews the element along the X (and, if two numbers are specified, Y)
  axis. It can be written as `skew(tX)` and `skew(tX, tY)` (angles). There's
  also `skewX()` and `skewY()`.
- `matrix()`: This transform property takes a transformation matrix that you
  know all about if you have some algebra chops. `matrix()` takes the form of
  `matrix(a, b, c, d, e, f)` (unitless numbers). `matrix3D()` takes a 4×4
  transformation matrix in column-major order. The 2D transform `matrix()`
  `matrix3D(a, b, 0, 0, c, d, 0, 0, 0, 0, 1, 0, e, f, 0, 1)` (unitless numbers).
  If you have the required giant brain, this lets you do (pretty much) all other
  2D and 3D transforms at once.
- `perspective()`: Provides perspective to 3D transforms and controls the amount
  of fore-shadowing (lengths) — think fish-eye lenses in photography. The value
  must be greater than zero, with about `2000px` appearing normal, `1000px`
  being moderately distorted, and `500px` being heavily distorted. The
  difference with the perspective property is that the transform function
  affects the element itself, whereas the perspective property affects the
  element's children. Note that `perspective()` only affects transform functions
  after it in the transform rule.
- `perspective`: This works the same as the perspective transform function,
  giving 3D transformed elements a feeling of depth. It affects the element's
  children, keeping them in the same 3D space.
- `perspective-origin`: This sets the origin for perspective like
  `transform-origin` does for transform. It takes the same values and keywords
  as `transform-origin`: keywords, lengths, and percentages. By default this is
  `perspective-origin: 50% 50%;`. It affects the children of the element it's
  applied to, and the default is none.
- `transform-origin`: Sets the point on the X, Y, and/or Z-axes around which the
  `transform(s)` will be performed. This can be written `transform-origin: X;`,
  `transform-origin: X Y;`, and `transform-origin: X Y Z;`. We can use the
  keywords left, center, and right for the X-axis, and top, center, and bottom
  for the Y-axis. We can also use lengths and percentages for X and Y, but only
  lengths for Z. Finally, for a 2D `transform-origin` you can use offsets by
  listing three or four values, which take the form of two pairs of a keyword
  followed by a percentage or length. For three values a missing percentage or
  length is treated as `0`. By default transform-origin is the center of the
  element, which is `transform-origin: 50% 50%;` for a 2D transform and
  `transform-origin: 50% 50% 0;` for a 3D transform.
- `transform-style`: For 3D transforms this can be `flat` (the default) or
  `preserve-3d`. `flat` keeps all children of the transformed element in 2D—in
  the same plane. `preserve-3d` child elements transform in 3D, with the
  distance in front of or behind the parent element controlled by the Z-axis.
- `backface-visibility`: For 3D transforms this controls whether the backside of
  an element is `visible` (the default) or `hidden`.

Matrix specifies a 2D transformation in the form of a transformation matrix of
six values. `matrix(a,b,c,d,e,f)` is equivalent to applying the transformation
`matrix [a b c d e f]`. The values `a` to `f` define a 3x3 transformation matrix
Representing the definition of `transform: matrix();` as a matrix. The third row
`("0, 0, 1")` is the same for each transformation. It's necessary for
multiplying matrices.

Let's see how each of the 2D transformation functions can be represented using
`transform: matrix();`.

- `translate(tX, tY) = transform: matrix(1, 0, 0, 1, tX, tY);`, where tX and tY
  are the horizontal and vertical translations.
- `rotate(a) = transform: matrix(cos(a), sin(a), -sin(a), cos(a), 0, 0);`, where
  a is the value in `deg`. Swap the `sin(a)` and `-sin(a)` values to reverse the
  rotation. Note that the maximum rotation you can represent is `360°`.
- `scale(sX, sY) = transform: matrix(sX, 0, 0, sY, 0 ,0);`, where sX and sY are
  the horizontal and vertical scaling values.
- `skew(aX, aY) = transform: matrix(1, tan(aY), tan(aX), 1, 0 ,0);`, where aX
  and aY are the horizontal and vertical values in degree.

```css
.class {  
   transform: matrix3d(  
       1  + (1 - cos(angle)) * (x * x - 1),  
       -z *      sin(angle)  + (1 - cos(angle)) * x * y,  
       y  *      sin(angle)  + (1 - cos(angle)) * x * z,  
       0,
       z  *      sin(angle)  + (1 - cos(angle)) * x * y,  
       1  + (1 - cos(angle)) * (y * y - 1),  
       -x *      sin(angle)  + (1 - cos(angle)) * y * z,         
       0,  
       -y *      sin(angle)  + (1 - cos(angle)) * x * z,  
       x  *      sin(angle)  + (1 - cos(angle)) * y * z,  
       1  + (1 - cos(angle)) * (z * z - 1),  
       0, 0, 0, 0, 1  
   );  
}
```

## Transitions

We control a transition using the following properties:

- `transition-property`: A list of transitionable properties to apply the
  transition to. By default, this is `transition-property: all;`.
- `transition-duration`: The length of the transition in units of time, such as
  `seconds (.4s)` or `milliseconds (400ms)`. By default, this is the instant
  `transition-duration: 0s;` so it's the same as not using a transition.
- `transition-timing-function`: Controls the relative speed of the transition
  over the `transition-duration` to make the transition start slowly and end
  quickly, for example. Values include `linear`, `ease` (the default),
  `ease-in`, `ease-out`, `ease-in-out`, `cubic-bezier()`, `step-start`,
  `step-end`, and `steps()`.
- `transition-delay`: A delay before the transition starts (times), with the
  default of `transition-delay: 0s;`. This can also take a negative value,
  making it appear to start already part-way through the transition.
- `transition`: A shorthand property that takes `transition-property`,
  `transition-duration`, `transitiontiming-function`, and `transition-delay`, in
  that order. Missing properties use default values, giving a default of
  `transition: all 0s ease 0s;`.
- `transition-property` allows us to specify one or more comma-separated
  animatable CSS properties to transition, with a default value of all. Note
  that properties with vendor prefixes need to be written with the vendor prefix
  in `transition-property`, too. For example, here's vendor-prefixed code to
  transition the transform property (aligned for column selection):

```css
.postcard {  
   -o-transition-property: -o-transform;  
   -ms-transition-property: -ms-transform;  
   -moz-transition-property: -moz-transform;  
   -webkit-transition-property: -webkit-transform;  
   transition-property: transform;  
}
```

### Transitions Timing property

The `transition-timing-function` property is the hardest part of transitions to
get your head around. Luckily, it's all pretty simple once you've seen some
examples. The property has functions based on Bézier curves (moving on an arc)
and steps (`stop-start` movement). Cubic Bézier curves have four points: the
`start` and `end` locations are diagonally opposite each other in the corners of
a square (0,0 and 1,1), and the other two points are the control handles that
define the curve. In contrast, the stepping functions (`steps()`, etc.) divide
the transition into equally sized intervals, depending on the number of steps.

`transition-timing-function` values include `cubic-bezier()` and `steps()`, plus
several common presets. `cubic-bezier()`: This allows you to make a custom cubic
Bézier curve by setting the X,Y handle locations for the start and end points in
the pattern `cubic-bezier(X1, Y1, X2, Y2)`. There are also several common preset
values.

- `linear`: The transition has a constant speed. Equivalent to
  `cubic-bezier(0, 0, 1.0, 1.0)`.
- `ease`: The default transition, it starts quickly then tapers out, like a
  faster, smoother version of `ease-out`. Equivalent to
  `cubic-bezier(0.25, 0.1, 0.25, 1.0)` (default).
- `ease-in`: The transition starts slow and accelerates to the end. Equivalent
  to `cubic-bezier(0.42, 0, 1.0, 1.0)`.
- `ease-out`: The transition starts fast then slows down. Equivalent to
  `cubic-bezier(0, 0, 0.58, 1.0)`.
- `ease-in-out`: The transition starts and ends slowly, but transitions quickly
  in the middle. Equivalent to `cubic-bezier(0.42, 0, 0.58, 1.0)`.
- `steps()`: The transition jumps from one step to another, rather than
  transitioning smoothly like Bézier-based transitions. It has a value with the
  number of steps and can also take a second value — either start or end — that
  controls how the transition proceeds.
- `step-start`: The transition is instant and happens immediately when
  triggered. This is equivalent to `steps(1, start)`.
- `step-end`: The transition is instant but happens at the end of the transition
  duration. This is equivalent to `steps(1, end)`.

## CSS Animations

CSS animations are added in two parts, as shown in the following code.

A `@keyframes` block containing individual keyframes defining and naming an
animation.

- `animation-*` properties to add a named `@keyframes` animation to an element
  and to control the animation's behavior.
- `animation-name`: The name (or comma-separated names) of `@keyframes`-defined
  animations to apply. By default this is `none`.
- `animation-duration`: The time for the animation to occur once, in seconds (s)
  or milliseconds (ms). By default this is `0s` or the same as no animation.
- `animation-timing-function`: The timing function (just like in CSS
  transitions) to use for the animation. Values include `linear`, `ease` (the
  default), `ease-in`, `ease-out`, `ease-in-out`, `cubic-bezier()`,
  `step-start`, `step-end`, and `steps()`. This can also be added to the
  `@keyframes` declaration to override the animation's
  `animation-timing-function` per-keyframe.
- `animation-delay`: A delay before the animation starts, in seconds (s) or
  milliseconds (ms). The default is 0s and this can also take a negative value,
  appearing to start already part-way through the animation.
- `animation-iteration-count`: The number of times the animation repeats.
  Acceptable values are `0` (no animation), positive numbers (including
  non-integers), and `infinite`. The default count is `1`.
- `animation-direction`: This takes the values `normal` (the default) and
  `alternate`, and only has an effect when the `animation-iteration-count` is
  greater than `1`. normal causes the animation to play forward (from start to
  end) each time, whereas alternate causes the animation to play forward then
  reverse.
- `animation-fill-mode`: This controls if the from keyframe affects the
  animation during an `animation-delay` and/or if the ending state is kept when
  an animation ends, via the following values:
  - `animation-fill-mode: none;`: Applies from keyframe values only when a
    positive `animation-delay` ends and uses the element's intrinsic style when
    the animation ends. This is the default state.
  - `animation-fill-mode: forwards;`: This causes the element(s) to retain the
    properties defined by the final keyframe (usually the `100%` or
    `to keyframe`) after the animation finishes. The forward value (or both)
    makes an animation's end state behave the same as CSS transitions.
  - `animation-fill-mode: backwards;`: This causes the element(s) to have any
    properties defined by the first keyframe (`0%` or `from`) during an
    animation-delay with a positive value.
  - `animation-fill-mode: both;`: This is the same as both forwards and
    backwards.
- `animation-play-state`: By default this value is running, but when this is
  changed to paused the animation pauses. The animation can be resumed from the
  same place by changing back to running. This gives us an easy way to pause
  animations using JavaScript.
- `animation`: The animation shorthand property takes a space-separated list of
  these animation properties (all the above except `animation-play-state`).
  Multiple animations are separated by commas.

```css
:hover .box {  
   animation-name: moveit;  
   animation-duration: 1s;  
}

@keyframes moveit {  
   to { 
      left: 100%; 
   }  
}
```

We recommend using the following order to avoid potential browser bugs:

- `animation-name`
- `animation-duration`
- `animation-timing-function`
- `animation-delay`
- `animation-iteration-count`
- `animation-direction`
- `animation-fill-mode`

```css
:hover .box {  
   animation-name: runner;  
   animation-duration: 3s;  
   animation-timing-function: ease-in-out;  
   animation-iteration-count: infinite;  
   animation-direction: alternate;  
}
```

It's equivalent to this (much shorter) animation property – remember that we
don't have to include any properties with a default value, in this case
`animation-delay` and `animation-fill-mode`:

```css
:hover .box {  
   animation: runner 3s ease-in-out infinite alternate;  
}
```

We can also specify more than one animation, using commas to separate values,
for both individual `animation-*` properties and for the shorthand `animation`
property.

### Perspective property

```css
.card {  
   transform-style: preserve-3d;  
   perspective: 1000px;  
}

.back, .front {  
   position: absolute;  
   width: 169px;  
   height: 245px;  
   -webkit-transition: .8s all;  
}

.front {  
   transform: rotate3d(0, 1, 0, 180deg);  
}

.card:hover .back {  
   transform: rotate3d(0, 1, 0, 180deg);  
}

.card:hover .front {  
   transform: rotate3d(0, 1, 0, 0deg);  
}

.backface .back, .backface .front {  
   backface-visibility: hidden;  
}
```

```html
<div class="card backface">  
   <div class="back">Back</div>  
   <div class="front">Front</div>  
</div>
```

## CSS Comments

```css
/*------------------------------------------------
[Master sheet]

Project:  
URL:  
Version:  
Creator:  
Last changed:  
Last Updated:  
Primary use:  
-------------------------------------------------*/

/*------------------------------------------------
Table of contents  
1. Reset  
2. Typography  
3. Basic layout  
4. Widgets  
5. Media items  
6. Forms  
7. Media queries  
8. IE specific styles  
-------------------------------------------------*/

/*------------------------------------------------
Widgets  
-------------------------------------------------*/

/*------------------------------------------------
Color reference sheet

Background:  
Body text:  
Headings:  
:link  
:hover,  
:active,  
:focus  
-------------------------------------------------*/

/*------------------------------------------------
Typography reference sheet

Body copy:  
Headers:  
Input, textarea:  
Buttons:

Notes:  
-------------------------------------------------*/
```
