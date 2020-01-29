## dart_flubber

Linear interpolation of open and closed lines for Dart.

The code for closed lines is based on the 
[flubber](https://github.com/veltman/flubber) package, hence the name.

Also a Python version can be found [here](https://github.com/maxme1/pyflubber).

## Usage

```dart
import 'package:dart_flubber/interpolate.dart';

main(){
  // `first` and `second` are lists of points
  var middle = interpolate(first, second, 0.5, closed: true);
}
```
