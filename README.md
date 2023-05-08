# flutter_spinkit_szw

A collection of loading indicators animated with flutter. Heavily inspired by [ybq's Android-SpinKit](https://github.com/ybq/Android-SpinKit).

## Showcase
<img src="https://raw.githubusercontent.com/songzhw/flutter_spinkit_szw/master/art/loadings.gif">

## Getting start

```dart
LoadingWidget(
    size: 200,
    bgColor: Colors.purple,
    animStyle: AnimStyle.CUBE_3D
)
```

There are multiple animation style, which are from an enum:
```dart
enum AnimStyle {
  PULSE, DOUBLE_BOUNCE, TRIPLE_BOUNCE, CHASING_DOTS,
  SOUND_WAVE, CUBE_GRID, BEADS_SCALE, BEADS_FADING,
  CIRCLE_3D, CUBE_3D, FOLDING_CUBES
}
```