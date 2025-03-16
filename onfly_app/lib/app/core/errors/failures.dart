abstract class Failure {
  final String message;
  Failure(this.message);

  @override
  bool operator ==(covariant Failure other) {
    if (identical(this, other)) return true;

    return other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
}

class InvalidCredentialsFailure extends Failure {
  InvalidCredentialsFailure() : super('Invalid credentials');
}
