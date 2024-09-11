import 'package:flutter_test/flutter_test.dart';
import '../../lib/models/user.dart';
import '../../lib/services/user_service.dart';

void main() {
  test('Should add and retrieve a user', () async {
    final userService = UserService();
    
    final user = User(
      idUtilisateurs: 1,
      email: 'test@event.com',
    );
    
    await userService.addUser(user);
    
    final retrievedUser = await userService.getUser(1);
    
    expect(retrievedUser?.email, 'test@event.com');
  });
}
