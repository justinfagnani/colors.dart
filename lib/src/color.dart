// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

part of colors;

abstract class Color {

  factory Color.fromHex(String hexString) => new RgbColor.fromHex(hexString);

  factory Color.rgb(int red, int green, int blue, [int alpha = 255]) =>
      new RgbColor(red, green, blue, alpha);

  factory Color.hsl(double hue, double saturation, double lightness,
      [double alpha = 1.0]) => new HslColor(hue, saturation, lightness, alpha);

  RgbColor toRgb();

  HslColor toHsl();
}

final Float32x4 _ones = new Float32x4.splat(1.0);
final Float32x4 _zeros = new Float32x4.zero();
