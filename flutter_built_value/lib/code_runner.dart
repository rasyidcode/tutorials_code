import 'package:flutter_built_value/models/tmg_character.dart';

class CodeRunner {
  static void runCode() {
    final TMGCharacter takemitchi = TMGCharacter((b) => b
      ..japaneseName = '花垣武道'
      ..romanjiName = 'Hanagaki Takemichi'
      ..aliases.addAll(['Takemitchy', 'Hanagaki-kun', 'Takemichi-kun'])
      ..born = 'Japan'
      ..skinColor = SkinColor.white);
    final TMGCharacter takemitchi2 = TMGCharacter((b) => b
      ..japaneseName = '花垣武道'
      ..romanjiName = 'Hanagaki Takemichi2'
      ..aliases.addAll(['Takemitchy', 'Hanagaki-kun', 'Takemichi-kun'])
      ..skinColor = SkinColor.black);
    final TMGCharacter mikey = takemitchi.rebuild((b) => b
      ..japaneseName = '佐野 万次郎'
      ..romanjiName = 'Sano Manjirō'
      ..aliases.add('Invincible Mikey'));

    print(takemitchi);
    print(mikey);
    print(takemitchi == takemitchi2);

    final takemichiJson = takemitchi.toJson();
    print(takemichiJson);

    final takemitchi3 = TMGCharacter.fromJson(takemichiJson);
    print(takemitchi3);
  }
}
