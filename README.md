colors.dart
===========

A library for representing and maniuplating colors

The colors package contains and abstract class `Color` and basic
representations `RgbColor` and `HslColor`. Color values are stored as
`Float32x4` to allow SIMD processing.

## Future Features & Contributing

I'd like to add color manipulation functionality over time, such as:

 * Saturation / Brightness
 * Gamma correction
 * Blending, with various modes: alpha, multiply, screen, overlay, etc.
 * Colorization: general remapping of hues
 * Color theory / harmonies: complementary, triadic, analgous, etc.
 * Gradients

 If you'd like to, please contribute! If it's something very simple, a PR will
 do, but if it's more complex open an issue so we can be on the same page before
 work begins.
 