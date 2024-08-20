## CSS Flexbox

- `flex-direction`: This property determines the direction in which flex items are arranged. It can take the values `row (default)`, `row-reverse`, `column`, and `column-reverse`. The `row` value means the main axis is aligned with the inline direction, while the `column` value aligns it with the block direction. These values are based on the current language’s writing direction. For example, the default row in English means left-to-right, while the traditional Japanese row is top-to-bottom.
- `flex-wrap`: Flex containers can have either a single line of flex items (the default `nowrap`) or multiple lines by using the `wrap` or `wrap-reverse` values. When `wrap` is used, multiple lines stack from left to right, while `wrap-reverse` stacks them in the opposite direction.
- `flex-flow` shorthand property: This property combines `flex-direction` and `flex-wrap` values, using the default values if not explicitly declared.
- `justify-content`: This property controls how flex items align along the main axis direction within a line. It may remind you of the `text-align` property for `inline-block` elements. The values are `flex-start` and `flex-end`, `center`, `space-between`, and `space-around`.
- `align-items`: This property controls how flex items align along the cross axis direction within a flex line. It may remind you of the `vertical-align` property. The values are `flex-start` and `flex-end`, `center`, `baseline`, and the default `stretch`, which makes all flex items the same height (for a row-based Flexbox).
- `align-content`: This property controls the alignment of lines in a multi-line flex container along the cross axis direction. The values are `flex-start` and `flex-end`, `center`, `space-between`, `space-around`, and the default `stretch`.

## The properties applied to flex items are as follows:

- `order`: This property allows you to reorder flex items and takes numerical values. Items are ordered from negative to positive, and items without an explicit order declaration use the default value of `0`. Flex items with the same value appear in the source order. This property should only be used for visual (not logical) reordering and does not affect the order in speech readers.
- `flex-grow` and `flex-shrink`: These properties control whether and how much a flex item can grow if there’s extra space or shrink if there’s not enough space, respectively. Together for the flex items on the same flex line, they determine the flex grow ratio and flex shrink ratio, which determine proportionally how much each flex item grows or shrinks to fit. These properties take `0` and positive numbers, and the initial values are `flex-grow: 1;` and `flex-shrink: 1;`. This means flex items will default to being the same width (for a horizontal flow axis) and expanding or shrinking equally if there isn’t enough space.
- `flex-basis`: This specifies the initial size of a flex item before `flex-grow` or `flex-shrink` adjust its size to fit the container. It takes the same values as width (such as lengths and percentages), and the default is `auto`, which uses the item’s width or height as appropriate (the dimension in the main axis direction). When used with flex, this gives “relative flex”. Values other than `auto` mean the item’s width or height will be ignored. Setting `flex-basis: 0%;` or `flex-basis: O;` sets the flex items’ main axis dimension to `0`, meaning its size will depend on `flex-grow` or `flex-shrink`, giving “absolute flex”. Make sure you set a width or height as appropriate if using the value `auto`, or values close to (or equal to) `0`.
- `flex`: This sets `flex-grow`, `flex-shrink`, and/or `flex-basis`. If no values are provided, `flex` defaults to `flex-grow: 1;`, `flex-shrink: 1;`, and `flex-basis: auto`. Flexbox defines properties that determine how items are positioned and sized within a container. These properties are initialized with the values of the individual item’s properties. If you only set `flex-grow` and/or `flex-shrink` values, `flex-basis` will be set to `0`, giving “absolute flex.” If you only set `flex-basis`, you’ll get relative flex instead, with `flex-grow` and `flex-shrink` using the default `1`. Note that zero values for `flex-basis` in the flex property require a unit, such as `Opx`, to avoid confusion with the grow and shrink values. The flex property also has some useful shorthand values: `flex: initial;` or `flex: 0 auto;`. These values allow the flex item to use its width and height properties without expanding, but it will shrink if necessary. This is the same as the initial values of `flex: 0 1 auto;` and is useful when using Flexbox for its alignment properties, or in combination with auto margins.
- `flex: none;`: Similar to `initial`, this stops flex items from flexing, even if their width or height cause them to overflow (equivalent to `flex: 0 0 auto;`).
- `flex: auto;`: Starting from their declared dimensions (or content dimensions if using, for example, `width: auto;`), flex items will grow or shrink to fill the space. If all flex items in a flex line use `auto`, any extra space will be distributed evenly using “relative flex” (equivalent to `flex: 1 1 auto;`).
- `flex: <positive-number>`: This makes a flex item flexible and also sets the `flex-basis` to `Opx` (equal to `flex: positive-number 1 0px;`). This uses “absolute flex,” so if all flex items in a line use this style of flex (or use `flex-basis: 0%;` or `flex-basis: 0;`), their sizes will be proportional to their flex ratios, unaffected by their intrinsic dimensions.
- `align-self`: This aligns a flex item in the cross-axis direction and is the flex item equivalent of the flex container’s `align-items` property. It takes the same values (`flex-start`, `flex-end`, `center`, `baseline`, and `stretch`) with the addition of the default `auto`, which inherits the `align-items` value.

## CSS Transforms

- `transform`: This property allows you to apply one or more space-separated transform functions to an element. For instance, you can use `transform: translate(3em, -24px) scale(.8);` to translate the element by 3em along the X-axis and scale it by 0.8. Transform functions can accept negative values, and the default value is `none`. The supported transform functions include:
- `translate()`: This function moves the element from its `transform-origin` along the X, Y, and/or Z-axes. You can specify the translation along each axis using `translate(tX)`, `translate(tX, tY)`, or `translate3D(tX, tY, tZ)` (percentage values except for tZ, and lengths). There are also 2D versions of `translate()`: `translateX(tX)` and `translateY(tY)`, and 3D versions: `translateZ(tZ)`.
- `rotate()`: This function rotates the element around its `transform-origin` in two-dimensional space, with the top of the element being at 0 degrees. Positive rotation is clockwise. There are also `rotateX(rX)`, `rotateY(rY)`, and `rotateZ(rZ)` transformation properties to rotate around an individual axis. Finally, `rotate3D(vX, vY, vZ, angle)` rotates the element in three-dimensional space around the direction vector of vX, vY, and vZ (unitless numbers) by the specified angle.
- `scale()`: This function changes the size of the element, with `scale(1)` being the default. You can specify the scale factor using `scale(s)`, `scale(sX, sY)`, or `scale3D(sX, sY, sZ)` (unitless numbers). There are also 2D versions of `scale()`: `scaleX(sX)` and `scaleY(sY)`, and 3D versions: `scaleZ(sZ)`.
- `skew()`: This function skews the element along the X-axis (and, if two numbers are specified, along the Y-axis). Axis transforms can be written as `skew(tX)` and `skew(tX, tY)` (angles), or `skewX()` and `skewY()`.
- `matrix()`: This transform property takes a transformation matrix. If you have some algebra chops, you know all about it. It takes the form of `matrix(a, b, c, d, e, f)` (unitless numbers). `matrix3D()` takes a 4×4 transformation matrix in column-major order. The 2D transform `matrix()` `matrix3D(a, b, 0, 0, c, d, 0, 0, 0, 0, 1, 0, e, f, 0, 1)` (unitless numbers). If you have the required giant brain, this lets you do (pretty much) all other 2D and 3D transforms at once.
- `perspective()`: Provides perspective to 3D transforms and controls the amount of foreshading (lengths) — think fish-eye lenses in photography. The value must be greater than zero. For example, `2000px` appears normal, `1000px` is moderately distorted, and `500px` is heavily distorted. The difference with the perspective property is that the transform function affects the element itself, whereas the perspective property affects the element’s children. Note that `perspective()` only affects transform functions after it in the transform rule.
- `perspective`: This works the same as the perspective transform function, giving 3D transformed elements a feeling of depth. It affects the element’s children, keeping them in the same 3D space.
- `perspective-origin`: This sets the origin for perspective like `transform-origin` does for transform. It takes the same values and keywords as `transform-origin`: keywords, lengths, and percentages. By default, this is `perspective-origin: 50% 50%;`. It affects the children of the element it’s applied to, and the default is none.
- `transform-origin`: Sets the point on the X, Y, and/or Z-axes around which the `transform(s)` will be performed. It can be written `transform-origin: X;`, `transform-origin: X Y;`, and `transform-origin: X Y Z;`. We can use the keywords left, center, and right for the X-axis, and top, center, and bottom for the Y-axis. For the Y-axis, we can use lengths and percentages for X and Y, but only lengths for Z. For a 2D `transform-origin`, we can use offsets by listing three or four values, which take the form of two pairs of a keyword followed by a percentage or length. For three values, a missing percentage or length is treated as `0`. By default, `transform-origin` is the center of the element, which is `transform-origin: 50% 50%;` for a 2D transform and `transform-origin: 50% 50% 0;` for a 3D transform.
- `transform-style`: For 3D transforms, this can be `flat` (the default) or `preserve-3d`. `flat` keeps all children of the transformed element in 2D—in the same plane. `preserve-3d` child elements transform in 3D, with the distance in front of or behind the parent element controlled by the Z-axis.
- `backface-visibility`: For 3D transforms, this controls whether the backside of an element is `visible` (the default) or `hidden`.

Matrix specifies a 2D transformation in the form of a transformation matrix of six values. `matrix(a,b,c,d,e,f)` is equivalent to applying the transformation `matrix [a b c d e f]`. The values `a` to `f` define a 3x3 transformation matrix representing the definition of `transform: matrix();` as a matrix. The third row `(“0, 0, 1”)` is the same for each transformation and is necessary for matrix multiplication. Let’s see how each of the 2D transformation functions can be represented using `transform: matrix();`.

- Translate the text by tX units. tY) =Transform the matrix: matrix(1, 0, 0, 1, tX, tY);, where tX and tY are the horizontal and vertical translations.
- `rotate(a) =Transform a matrix using the following formula:`matrix(cos(a), sin(a), -sin(a), cos(a), 0, 0)`, where`a`represents the rotation angle in degrees. To reverse the rotation, simply swap the`sin(a)`and`-sin(a)`values. However, it’s important to note that the maximum rotation angle that this matrix can represent is`360°`.
- Scale the image by `sX`. sY) =Transform the matrix with the given scaling values: matrix(sX, 0, 0, sY, 0, 0);
- `skew(aX, aY) =Transform the matrix: matrix(1, tan(aY), tan(aX), 1, 0, 0); where aX and aY are the horizontal and vertical values in degrees.

```css
.class {
   transform: matrix3d(
       1 + (1 - cos(angle)) * (x * x - 1),
       -z * sin(angle) + (1 - cos(angle)) * x * y,
       y * sin(angle) + (1 - cos(angle)) * x * z,
       0,
       z * sin(angle) + (1 - cos(angle)) * x * y,
       1 + (1 - cos(angle)) * (y * y - 1),
       -x * sin(angle) + (1 - cos(angle)) * y * z,
       0,
       -y * sin(angle) + (1 - cos(angle)) * x * z,
       x * sin(angle) + (1 - cos(angle)) * y * z,
       1 + (1 - cos(angle)) * (z * z - 1),
       0, 0, 0, 0, 1
   );
}
```

## Transitions

We control transitions using the following properties:

- `transition-property`: A list of transitionable properties to apply the transition to. By default, this is `transition-property: all;`.
- `transition-duration`: The length of the transition in units of time, such as `seconds (.4s)` or `milliseconds (400ms)`. By default, this is the instant `transition-duration: 0s;`, so it’s the same as not using a transition.
- `transition-timing-function`: Controls the relative speed of the transition over the `transition-duration` to make the transition start slowly and end quickly, for example. Values include `linear`, `ease` (the default), `ease-in`, `ease-out`, `ease-in-out`, `cubic-bezier()`, `step-start`, `step-end`, and `steps()`.
- `transition-delay`: A delay before the transition starts (in seconds), with the default of `transition-delay: 0s;`. This can also take a negative value, making it appear to start already part-way through the transition.
- `transition`: A shorthand property that takes `transition-property`, `transition-duration`, `transitiontiming-function`, and `transition-delay`, in that order. Missing properties use default values, giving a default of `transition: all 0s ease 0s;`.
- `transition-property` allows us to specify one or more comma-separated animatable CSS properties to transition, with a default value of all. Note that properties with vendor prefixes need to be written with the vendor prefix in `transition-property`, too. For example, here’s vendor-prefixed code to transition the transform property (aligned for column selection):

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

The `transition-timing-function` property is the most challenging aspect of transitions. Fortunately, it’s all quite straightforward once you’ve seen some examples. The property has functions based on Bézier curves (moving on an arc) and steps (`stop-start` movement). Cubic Bézier curves have four points: the `start` and `end` locations are diagonally opposite each other in the corners of a square (0,0 and 1,1), and the other two points are the control handles that define the curve. In contrast, the stepping functions (`steps()`, etc.) divide the transition into equally sized intervals, depending on the number of steps.

The `transition-timing-function` values include `cubic-bezier()` and `steps()`, plus several common presets. `cubic-bezier()`: This allows you to create a custom cubic Bézier curve by specifying the X,Y handle locations for the start and end points in the pattern `cubic-bezier(X1, Y1, X2, Y2)`. There are also several common preset values.

- `linear`: The transition has a constant speed. Equivalent to `cubic-bezier(0, 0, 1.0, 1.0)`.
- `ease`: The default transition, it starts quickly then tapers out, similar to a faster, smoother version of `ease-out`. Equivalent to `cubic-bezier(0.25, 0.1, 0.25, 1.0)` (default).
- `ease-in`: The transition starts slowly and accelerates to the end. Equivalent to `cubic-bezier(0.42, 0, 1.0, 1.0)`.
- `ease-out`: The transition starts fast then slows down. Equivalent to `cubic-bezier(0, 0, 0.58, 1.0)`.
- `ease-in-out`: The transition starts and ends slowly, but transitions quickly in the middle. Equivalent to `cubic-bezier(0.42, 0, 0.58, 1.0)`.
- `steps()`: The transition jumps from one step to another, rather than transitioning smoothly like Bézier-based transitions. It has a value with the number of steps and can also take a second value — either start or end — that controls how the transition proceeds.
- `step-start`: The transition is instantaneous and happens immediately when triggered. This is equivalent to `steps(1, start)`.
- `step-end`: The transition is instantaneous but happens at the end of the transition. This is equivalent to `steps(1, end)`.

## CSS animations

- The first part consists of a `@keyframes` block, which contains individual keyframes that define and name the animation.
- The second part includes the `animation-*` properties, which are used to add a named `@keyframes` animation to an element and control its behavior.
- The `animation-name` property specifies the name (or comma-separated names) of the `@keyframes`-defined animations that should be applied. By default, this value is `none`, meaning no animation is applied.
- The `animation-duration` property determines the time for the animation to occur once, expressed in seconds (s) or milliseconds (ms). By default, this value is `0s`, which means no animation is played.
- The `animation-timing-function` property specifies the timing function (similar to CSS transitions) that should be used for the animation. The available values include `linear`, `ease` (the default), `ease-in`, `ease-out`, `ease-in-out`, `cubic-bezier()`, `step-start`, `step-end`, and `steps()`. This property can also be added to the `@keyframes` declaration to override the animation’s `animation-timing-function` per-keyframe.
- The `animation-delay` property introduces a delay before the animation starts, expressed in seconds (s) or milliseconds (ms). The default value is `0s`, which means the animation starts immediately. However, it’s important to note that the `animation-delay` property can also take a negative value, which may make the animation appear to start already part-way through.
- The `animation-iteration-count` property determines the number of times the animation repeats. Acceptable values include `0` (no animation), positive numbers (including non-integers), and `infinite`. The default value is `1`, which means the animation repeats once.
- The `animation-direction` property specifies the direction in which the animation plays. The available values are `normal` (the default) and `alternate`. The `animation-direction` property only has an effect when the `animation-iteration-count` is greater than `1`. In the `normal` direction, the animation plays forward (from start to end) each time. In the `alternate` direction, the animation plays forward first, then reverses.
- The `animation-fill-mode` property controls whether the from keyframe affects the animation during an `animation-delay` and/or whether the ending state is retained when the animation ends. The available values are `animation-fill-mode: none;`, `animation-fill-mode: forwards;`, `animation-fill-mode: backwards;`, and `animation-fill-mode: forwards-backwards;`.
  - `animation-fill-mode: none;`: Applies from keyframe values only when a `animation-delay` is present.
  - `animation-fill-mode: forwards;`: Applies from keyframe values only when an `animation-delay` is present and the animation is playing forward.
  - `animation-fill-mode: backwards;`: Applies from keyframe values only when an `animation-delay` is present and the animation is playing backward.
  - `animation-fill-mode: forwards-backwards;`: Applies from keyframe values only when an `animation-delay` is present and the animation is playing forward and backward. Positive `animation-delay` ends and uses the element’s intrinsic style when the animation concludes. This is the default state.
- `animation-fill-mode: forwards;`: This causes the element(s) to retain the properties defined by the final keyframe (usually the `100%` or `to keyframe`) after the animation finishes. The forward value (or both) makes an animation’s end state behave similarly to CSS transitions.
- `animation-fill-mode: backwards;`: This causes the element(s) to have any properties defined by the first keyframe (`0%` or `from`) during an animation-delay with a positive value.
- `animation-fill-mode: both;`: This is equivalent to both forwards and backwards.
- `animation-play-state`: By default, this value is set to running. However, when it is changed to paused, the animation pauses. The animation can be resumed from the same point by changing back to running. This provides a convenient way to pause animations using JavaScript.
- `animation`: The animation shorthand property accepts a space-separated list of these animation properties (excluding `animation-play-state`). Multiple animations are separated by commas.

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

Alternatively, we can specify more than one animation using commas to separate values, for both individual `animation-*` properties and for the shorthand `animation` property.

```css
:hover .box {
  animation: runner, runner2 3s ease-in-out infinite alternate;
}
```

Remember, we don’t have to include any properties with a default value, such as `animation-delay` and `animation-fill-mode`, in this case.

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
  -webkit-transition: 0.8s all;
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
