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

class HslColor implements Color {
  final Float32x4 _value;

  /// all values are 0.0 - 1.0
  HslColor(double hue, double saturation, double lightness, [double alpha = 1.0])
    : _value = new Float32x4(hue, saturation, lightness, alpha) {
    assert(_value.x >= 0.0);
    assert(_value.y >= 0.0);
    assert(_value.z >= 0.0);
    assert(_value.w >= 0.0);
    assert(_value.x <= 1.0);
    assert(_value.y <= 1.0);
    assert(_value.z <= 1.0);
    assert(_value.w <= 1.0);
  }

  HslColor._fromFloat32x4(this._value) {
    assert(_value.x >= 0.0);
    assert(_value.y >= 0.0);
    assert(_value.z >= 0.0);
    assert(_value.w >= 0.0);
    assert(_value.x <= 1.0);
    assert(_value.y <= 1.0);
    assert(_value.z <= 1.0);
    assert(_value.w <= 1.0);
  }

  HslColor toHsl() => this;

  RgbColor toRgb() {
    print("toRgb: $_value");

    if (_value.y == 0.0) {
      return new RgbColor.fromDoubles(_value.w, _value.w, _value.w, _value.w);
    }

    double hueToRgb(double p, double q, double t) {
      if (t < 0.0) t += 1.0;
      else if (t > 1.0) t -= 1.0;

      if (t < 1.0 / 6.0) return p + (q - p) * 6.0 * t;
      if (t < 1.0 / 2.0) return q;
      if (t < 2.0 / 3.0) return p + (q - p) * (2.0 / 3.0 - t) * 6.0;
      return p;
    }

    var q = _value.z < 0.5
        ? _value.z * (1.0 + _value.y)
        : _value.z + _value.y - _value.z * _value.y;
    var p = 2.0 * _value.z - q;

    var r = hueToRgb(p, q, _value.x + 1.0 / 3.0);
    var g = hueToRgb(p, q, _value.x);
    var b = hueToRgb(p, q, _value.x - 1.0 / 3.0);

    return new RgbColor.fromDoubles(r, g, b, _value.w);
  }

  double get h => _value.x;
  double get s => _value.y;
  double get l => _value.z;
  double get a => _value.w;

  double get hue => _value.x;
  double get saturation => _value.y;
  double get lightness => _value.z;
  double get alpha => _value.w;

  HslColor withHue(double hue) =>
      new HslColor._fromFloat32x4(_value.withX(hue));

  HslColor withSaturation(double saturation) =>
      new HslColor._fromFloat32x4(_value.withY(saturation));

  HslColor withLightness(double lightness) =>
      new HslColor._fromFloat32x4(_value.withZ(lightness));

  HslColor withAlpha(double alpha) =>
      new HslColor._fromFloat32x4(_value.withW(alpha));

  Float32x4 get value => _value;

  String toString() => 'HslColor("$_value")';
}
