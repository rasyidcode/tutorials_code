import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mickto_test.mocks.dart';

class Cat {
  String sound() => "Meow";
  bool eatFood(String food, {bool? hungry}) => true;
  Future<void> chew() async => print('Chewing...');
  int walk(List<String> places) => 7;
  void sleep() {}
  void hunt(String place, String prey) {}
  int lives = 9;
}

@GenerateMocks([Cat])
void main() {
  var cat = MockCat();

  test('verify cat sound', () {
    cat.sound();
    verify(cat.sound());
  });

  test('test verify', () {
    when(cat.sound()).thenReturn("Purr");
    expect(cat.sound(), "Purr");
  });

  // test('returns an Album if the http call completes successfully', () async {
  //   final client = MySimpleMock();
  //   when(client.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
  //       .thenAnswer((_) async =>
  //           http.Response('{"userId": 1, "id": 2, "title": "mock"}', 200));

  //   final response = await client
  //       .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
  //   final data = jsonDecode(response.body);
  //   expect(data, {"userId": 1, "id": 2, "title": "mock"});
  // });

  // test('test mockito', () async {
  //   when(mockClient.get(Uri.parse('http://localhost:9999'))).thenAnswer(
  //       (_) async => http.Response('{"message": "hello"}', 200, headers: {}));

  //   final response = await mockClient.get(Uri.parse('http://localhost:9999'));
  //   final data = jsonDecode(response.body);
  //   expect(data, {'message': 'hello'});
  // });
}
