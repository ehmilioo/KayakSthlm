import 'package:kayak_sthlm/test/test_classes.dart';
import 'package:kayak_sthlm/models/user.dart';
import 'package:test/test.dart';

void main() {
  //Create a object of TheUser to see if the data is sent correctly, fetched through variables and functions..
  test('Create an object of a user, check if the gender is correct', () {
    final obj = new TheUser(
      uid: 'fwieufiuew',
      email: 'test.123@hotmail.com',
      username: 'Testperson',
      experience: 'Skilled',
      age: '20',
      gender: 'Male',
    );
    expect(obj.gender, 'Male');
    expect(obj.username, 'Testperson');
    expect(obj.getUid(), 'fwieufiuew');
  });

  //Test for all the functions used to validate user inputs..
  test('Should return if input-email is correct', () {
    final obj = Test();
    expect(obj.validateEmail('test.test@hotmail.com'), true);
    expect(obj.validatePassword('Testing123'), true);
    expect(obj.confirmPassword('TEST123', 'TEST123'), true);
  });
}
