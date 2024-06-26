// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:messages/messages_json.dart';
import 'package:messages/package_intl_object.dart';
import 'package:test/test.dart';

void main() {
  test('JSON MessageList', () {
    final MessageList messageList = MessageListJson(
      JsonPreamble.build(
        serializationVersion: serializationVersion,
        locale: 'en_US',
        hash: 'hash',
        hasIds: false,
      ),
      [
        StringMessage('Hello World'),
        SelectMessage(
          StringMessage('Some case'),
          {
            'case1': StringMessage(
              'Case ',
              argPositions: [(stringIndex: 5, argIndex: 0)],
            ),
            'case2': StringMessage('Case 2'),
            'case3': PluralMessage(
              other: StringMessage('other nested'),
              twoNumber: StringMessage(': ', argPositions: [
                (stringIndex: 0, argIndex: 0),
                (stringIndex: 2, argIndex: 1),
              ]),
              argIndex: 1,
            ),
          },
          0,
        )
      ],
      OldIntlObject(),
      null,
    );

    expect(messageList.preamble.hasIds, false);
    expect(messageList.preamble.locale, 'en_US');
    expect(messageList.generateStringAtIndex(0, []), 'Hello World');
    expect(messageList.generateStringAtIndex(1, ['case1']), 'Case case1');
    expect(messageList.generateStringAtIndex(1, ['case2']), 'Case 2');
    expect(messageList.generateStringAtIndex(1, ['case3', 2]), 'case3: 2');
    expect(messageList.generateStringAtIndex(1, ['case4']), 'Some case');
  });
}
