// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';

import '../generation_options.dart';
import '../message_with_metadata.dart';
import 'generation.dart';

class ClassGeneration extends Generation<Spec> {
  final GenerationOptions options;
  final MessageListWithMetadata messageList;

  final List<Constructor> constructors;
  final List<Field> fields;
  final List<Method> methods;

  ClassGeneration(
    this.options,
    this.messageList,
    this.constructors,
    this.fields,
    this.methods,
  );

  String getClassName(String? context) => '${context ?? ''}Messages';

  @override
  List<Spec> generate() {
    final classes = <Spec>[
      Class(
        (cb) => cb
          ..name = getClassName(messageList.context)
          ..constructors.addAll(constructors)
          ..fields.addAll(fields)
          ..methods.addAll(methods),
      ),
    ];
    if (options.findByType == IndexType.integer) {
      classes.add(Class((cb) => cb
        ..name = indicesName(messageList.context)
        ..fields.addAll(List.generate(
            messageList.messages.length,
            (index) => Field(
                  (evb) => evb
                    ..name = messageList.messages[index].name!
                    ..type = const Reference('int')
                    ..assignment = Code('$index')
                    ..static = true
                    ..modifier = FieldModifier.constant,
                )))));
    }
    if (options.findByType == IndexType.enumerate || options.messageCalls) {
      classes.add(Enum((cb) => cb
        ..name = enumName(messageList.context)
        ..values.addAll(List.generate(
            messageList.messages.length,
            (index) => EnumValue(
                  (evb) => evb..name = messageList.messages[index].name,
                )))));
    }
    return classes;
  }
}
