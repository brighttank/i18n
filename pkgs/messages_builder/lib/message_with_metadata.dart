// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:messages/messages.dart';

class MessageWithMetadata {
  final Message message;
  final String? name;
  List<Placeholder> placeholders;

  MessageWithMetadata(this.message, List<String> arguments, this.name)
      : placeholders = arguments.map(Placeholder.new).toList();
}

class MessageListWithMetadata {
  final List<MessageWithMetadata> messages;
  final String? locale;
  final String? context;
  final bool isReference;

  MessageListWithMetadata(
    this.messages,
    this.locale,
    this.context,
    this.isReference,
  );
}

class Placeholder {
  final String name;
  final String type;

  Placeholder(this.name, [this.type = 'String']);

  @override
  String toString() {
    return '$name: $type';
  }
}
