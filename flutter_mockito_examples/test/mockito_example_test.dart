import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mockito_example_test.mocks.dart';

class Cat {
  String? sound() => 'Meow';
  bool? eatFood(String? food, {bool? hungry}) => true;
  Future<void> chew() async => print('Chewing...');
  int? walk(List<String>? places) => 7;
  void sleep() {}
  void hunt(String? place, String? prey) {}
  int lives = 9;
}

@GenerateMocks([
  Cat
], customMocks: [
  MockSpec<Cat>(as: #MockCatRelaxed, returnNullOnMissingStub: true)
])
void main() {
  late Cat cat;
  late Cat cat2;

  setUp(() {
    cat = MockCat();
    cat2 = MockCatRelaxed();
  });

  test('Verify some behavior', () {
    // Stub a method before interacting with it
    when(cat.sound()).thenReturn('Meow');

    // Interacting with the mock object.
    cat.sound();

    // Verify the interaction
    verify(cat.sound());
  });

  test('More stubbing', () {
    try {
      cat2.sound();
    } on MissingStubError catch (_) {
      // Unstubbed methods throw MissingStubError.
      print('stub error');
    }

    // Unstubbed methods returns null
    expect(cat2.sound(), null);

    // Stub a method before interacting with it.
    when(cat.sound()).thenReturn('Purr');
    expect(cat.sound(), 'Purr');

    // Call it again
    expect(cat.sound(), 'Purr');

    // Change the stu
    when(cat.sound()).thenReturn('Meow');
    expect(cat.sound(), 'Meow');

    // Stub getters
    when(cat.lives).thenReturn(9);
    expect(cat.lives, 9);

    // Stub a method to throw
    when(cat.lives).thenThrow(RangeError('Boo'));
    expect(() => cat.lives, throwsRangeError);

    // Calculate a response at call time
    var response = ['Purr', 'Meow'];
    when(cat.sound()).thenAnswer((_) => response.removeAt(0));

    expect(cat.sound(), 'Purr');
    expect(cat.sound(), 'Meow');
  });

  test('Argument matchers', () {
    // Use plain arguments
    when(cat.eatFood('fish')).thenReturn(true);

    // Or collections
    when(cat.walk(['roof', 'tree'])).thenReturn(2);

    // Or matchers
    when(cat.eatFood(argThat(startsWith('dry')))).thenReturn(false);

    // Or mixed arguments with matchers
    when(cat.eatFood(argThat(startsWith('dry')), hungry: true))
        .thenReturn(true);

    expect(cat.eatFood('fish'), isTrue);
    expect(cat.walk(['roof', 'tree']), equals(2));
    expect(cat.eatFood('dry food'), isFalse);
    expect(cat.eatFood('dry food', hungry: true), isTrue);

    // Verify using an argument matchers
    verify(cat.eatFood('fish'));
    verify(cat.walk(['roof', 'tree']));
    verify(cat.eatFood(argThat(contains('food'))));

    // Verify setters
    cat.lives = 10;
    verify(cat.lives = 10);

    cat.hunt('backyard', null);
    verify(cat.hunt('backyard', null));

    cat.hunt('backyard', null);
    verify(cat.hunt(argThat(contains('yard')), argThat(isNull)));
  });
}
