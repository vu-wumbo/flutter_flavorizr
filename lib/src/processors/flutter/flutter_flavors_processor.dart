/*
 * Copyright (c) 2024 Angelo Cassano
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */

import 'package:flutter_flavorizr/src/parser/models/flavors/flavor.dart';
import 'package:flutter_flavorizr/src/processors/commons/string_processor.dart';

class FlutterFlavorsProcessor extends StringProcessor {
  FlutterFlavorsProcessor({
    super.input,
    required super.config,
  });

  @override
  String execute() {
    StringBuffer buffer = StringBuffer();

    _appendFlavorEnum(buffer);
    _appendFlavorClass(buffer);

    return buffer.toString();
  }

  void _appendFlavorEnum(StringBuffer buffer) {
    buffer.writeln('enum Flavor {');

    for (var flavorName in config.flavors.keys) {
      buffer.writeln('  ${flavorName.toLowerCase()},');
    }

    buffer.writeln('}');
  }

  void _appendFlavorClass(StringBuffer buffer) {
    buffer.writeln();
    buffer.writeln('class F {');
    buffer.writeln('  static Flavor? appFlavor;');
    buffer.writeln();

    buffer.writeln('  static String get name => appFlavor?.name ?? \'\';');
    buffer.writeln();

    final flavorKeys = config.flavors.keys;

    /// Append app's title
    buffer.writeln('  static String get title {');
    buffer.writeln('    switch (appFlavor) {');
    config.flavors.forEach((String name, Flavor flavor) {
      if (flavorKeys.last != name) {
        buffer.writeln('      case Flavor.${name.toLowerCase()}:');
      } else {
        buffer.writeln('      default:');
      }
      buffer.writeln('        return \'${flavor.app.name}\';');
    });
    buffer.writeln('    }');
    buffer.writeln('  }');

    /// Append custom configs
    config.flavors.values.first.configs?.forEach((String cKey, String value) {
      var isValid = true;
      for (var fKey in flavorKeys) {
        isValid =
            isValid && config.flavors[fKey]?.configs?[cKey]?.isNotEmpty == true;
      }

      if (isValid) {
        buffer.writeln();
        buffer.writeln('  static String get ${cKey.toLowerCase()} {');
        buffer.writeln('    switch (appFlavor) {');
        for (var fKey in flavorKeys) {
          if (flavorKeys.last != fKey) {
            buffer.writeln('      case Flavor.${fKey.toLowerCase()}:');
          } else {
            buffer.writeln('      default:');
          }
          buffer.writeln(
              '        return \'${config.flavors[fKey]?.configs?[cKey]}\';');
        }
        buffer.writeln('    }');
        buffer.writeln('  }');
      }
    });

    buffer.writeln();
    buffer.writeln('}');
  }

  @override
  String toString() => 'FlutterFlavorsProcessor';
}
