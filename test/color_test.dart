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

import 'package:unittest/unittest.dart';
import 'package:colors/colors.dart';
import 'dart:typed_data';

main() {

  group('RgbColor', () {

    group('constructor', () {

      test('hex', () {
        for (var s in ['fff', 'ffffff', '#fff', '#ffffff']) {
          expect(hex(s), f32x4(1.0, 1.0, 1.0, 1.0));
        }
        for (var s in ['000', '000000', '#000', '#000000']) {
          expect(hex(s), f32x4(0.0, 0.0, 0.0, 1.0));
        }
        for (var s in ['08f', '0088ff', '#08f', '#0088ff']) {
          expect(hex(s), f32x4(0.0, hex88, 1.0, 1.0));
        }
      });

      test('rgb', () {
        expect(
            rgb(11, 22, 33),
            f32x4(11 / 255, 22 / 255, 33 / 255, 1.0));
        expect(
            rgb(11, 22, 33, 44),
            f32x4(11 / 255, 22 / 255, 33 / 255, 44 / 255));
      });

      test('fromDoubles', () {
        var c = new RgbColor.fromDoubles(1.0, 1.0, 1.0, 1.0);
        expect(c.value, f32x4(1.0, 1.0, 1.0, 1.0));
      });

    });

    group('getters', () {
      test('rgba', () {
        var c = new RgbColor.fromDoubles(1.0, 1.0, 1.0, 1.0);
        expect(c.r, 255);
        expect(c.g, 255);
        expect(c.b, 255);
        expect(c.a, 255);
      });

      test('rgba as doubles', () {
        var c = new RgbColor.fromDoubles(1.0, 1.0, 1.0, 1.0);
        expect(c.rAsDouble, 1.0);
        expect(c.gAsDouble, 1.0);
        expect(c.bAsDouble, 1.0);
        expect(c.aAsDouble, 1.0);
      });

    });

    group('conversion', () {
      test('toHsl', () {
        var redRgb = new RgbColor(255, 0, 0);
        print(redRgb);
        var redHsl = redRgb.toHsl();
        print(redHsl);
        expect(redHsl.h, 0.0);
        expect(redHsl.s, 1.0);
        expect(redHsl.l, 0.5);
      });
    });

  });

}

var hex88 = int.parse('88', radix: 16) / 255.0;

hex(String s) => new RgbColor.fromHex(s).value;

rgb(int r, int g, int b, [int a = 255]) =>
    new RgbColor(r, g, b, a).value;

f32x4(x, y, z, w) => (Float32x4 f) {
  var eq = f.equal(new Float32x4(x, y, z, w));
  return eq.flagX && eq.flagY && eq.flagZ && eq.flagW;
};

//expect(c.r, 255);
//expect(c.g, 255);
//expect(c.b, 255);
//expect(c.a, 1.0);
