// Copyright (c) 2023, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

export 'src/intl_default.dart' // Stub implementation
    // Browser implementation
    if (dart.library.html) 'intl_browser.dart'
    // Native implementation
    if (dart.library.io) 'intl_standalone.dart';
