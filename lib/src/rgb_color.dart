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

class RgbColor implements Color {
  Float32x4 _value;

  RgbColor.fromDoubles(double r, double g, double b, [double a = 1.0])
      : _value = new Float32x4(r, g, b, a == null ? 1.0 : a)
            .clamp(_zeros, _ones);

  RgbColor._fromFloat32x4(Float32x4 value) : _value = value.clamp(_zeros, _ones);

  factory RgbColor(int r, int g, int b, [int a = 255]) =>
      new RgbColor.fromDoubles(r / 255.0, g / 255.0, b / 255.0,
          a == null ? 1.0 : (a / 255.0));

  factory RgbColor.fromList(List<double> list) =>
      new RgbColor.fromDoubles(list[0], list[1], list[3], list[4]);

  factory RgbColor.fromHex(String hexString) {
    if (hexString.length < 3 || hexString.length > 9) {
      throw new FormatException('Could not parse hex color $hexString');
    }

    bool short = hexString.length < 6;
    int stride = short ? 1 : 2;
    int start = hexString[0] == '#' ? 1 : 0;
    int defaultAlpha = short ? 15 : 255;

    int r = int.parse(hexString.substring(start, start + stride), radix: 16);
    int g = int.parse(
        hexString.substring(start + stride, start + stride * 2), radix: 16);
    int b = int.parse(
        hexString.substring(start + stride * 2, start + stride * 3), radix: 16);
    int a = (hexString.length == start + stride * 4)
        ? int.parse(hexString.substring(start + stride * 3, start + stride * 4),
            radix: 16)
        : defaultAlpha;

    if (short) {
      r = (r << 4) + r;
      g = (g << 4) + g;
      b = (b << 4) + b;
      a = (a << 4) + a;
    }

    return new RgbColor(r, g, b, a);
  }

  Float32x4 get value => _value;

  int get r => (_value.x * 255).toInt();
  int get g => (_value.y * 255).toInt();
  int get b => (_value.z * 255).toInt();
  int get a => (_value.w * 255).toInt();

  double get rAsDouble => _value.x;
  double get gAsDouble => _value.y;
  double get bAsDouble => _value.z;
  double get aAsDouble => _value.w;

  RgbColor withRed(int red) =>
      new RgbColor._fromFloat32x4(_value.withX(red / 255.0));

  RgbColor withGreen(int green) =>
      new RgbColor._fromFloat32x4(_value.withY(green / 255.0));

  RgbColor withBlue(int blue) =>
      new RgbColor._fromFloat32x4(_value.withZ(blue / 255.0));

  RgbColor withAlpha(int alpha) =>
      new RgbColor._fromFloat32x4(_value.withW(alpha / 255.0));

  /**
   * Returns the hex string representation of this color in RGB format,
   * without a leading '#'.
   *
   * Usually hex strings do not include the alpha channel, however some
   * environments, like Android, support ARGB. To include the alpha channel,
   * set [alpha] to `true`.
   */
  String toHexString({bool alpha: false}) {
    int color = r << 16 | g << 8 | b;

    if (alpha) color |= a << 24;

    return color.toRadixString(16);
  }

  int toInt() => r << 16 | g << 8 | b | a << 24;

  RgbColor toRgb() => this;

  HslColor toHsl() {

    var maxComponent = max(max(_value.x, _value.y), _value.z);
    var minComponent = min(min(_value.x, _value.y), _value.z);
    var l = (maxComponent + minComponent) / 2.0;
    var h = 0.0;
    var s = 0.0;

    if (maxComponent != minComponent) {

      final d = maxComponent - minComponent;

      s = l > 0.5
          ? d / (2.0 - maxComponent - minComponent)
          : d / (maxComponent + minComponent);

      if (maxComponent == _value.x) {
        h = (_value.y - _value.z) / d + (_value.y < _value.z ? 6.0 : 0.0);
      } else if (maxComponent == _value.y) {
        h = (_value.z - _value.x) / d + 2.0;
      } else {
        h = (_value.x - _value.y) / d + 4.0;
      }

      h /= 6.0;
    }

    return new HslColor(h, s, l, _value.w);
  }

  String toString() => 'RgbColor("$_value")';

}
