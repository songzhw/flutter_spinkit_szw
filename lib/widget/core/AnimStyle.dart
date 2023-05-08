import 'package:flutter_spinkit_szw/widget/core/Sprite.dart';
import 'package:flutter_spinkit_szw/widget/sprites/ChasingDotsSprite.dart';
import 'package:flutter_spinkit_szw/widget/sprites/CubeGridSprite.dart';
import 'package:flutter_spinkit_szw/widget/sprites/DoubleBounceSprite.dart';
import 'package:flutter_spinkit_szw/widget/sprites/FadingBeadsSprite.dart';
import 'package:flutter_spinkit_szw/widget/sprites/PulseSprite.dart';
import 'package:flutter_spinkit_szw/widget/sprites/Rotating3DCircleSprite.dart';
import 'package:flutter_spinkit_szw/widget/sprites/Rotating3dCubeSprite.dart';
import 'package:flutter_spinkit_szw/widget/sprites/ScaleBeadsSprite.dart';
import 'package:flutter_spinkit_szw/widget/sprites/SoundWaveSprite.dart';
import 'package:flutter_spinkit_szw/widget/sprites/TripleBounceSprite.dart';

enum AnimStyle {
  PULSE, DOUBLE_BOUNCE, TRIPLE_BOUNCE, CHASING_DOTS,
  SOUND_WAVE, CUBE_GRID, BEADS_SCALE, BEADS_FADING,
  CIRCLE_3D, CUBE_3D, FOLDING_CUBES
}

Sprite findSpriteBy(AnimStyle style) {
  final map = <AnimStyle, Sprite> {
    AnimStyle.PULSE: PulseSprite(), AnimStyle.DOUBLE_BOUNCE : DoubleBounceSprite(),
    AnimStyle.TRIPLE_BOUNCE: TripleBounceSprite(), AnimStyle.SOUND_WAVE : SoundWaveSprite(),
    AnimStyle.CHASING_DOTS : ChasingDotsSprite(), AnimStyle.CUBE_GRID: CubeGridSprite(),
    AnimStyle.BEADS_SCALE: ScaleBeadsSprite(), AnimStyle.BEADS_FADING: FadingBeadsSprite(),
    AnimStyle.CIRCLE_3D: Rotating3dCircleSprite(0), AnimStyle.CUBE_3D: Rotating3dCubeSprite(0),

  };
  return map[style] ?? PulseSprite();
}