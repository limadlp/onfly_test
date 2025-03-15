abstract class AuthRepository {
  Future<void> signin(String email, String password);
  Future<void> signout();
}
