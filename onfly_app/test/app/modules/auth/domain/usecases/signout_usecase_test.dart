import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onfly_app/app/core/errors/failures.dart';
import 'package:onfly_app/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:onfly_app/app/modules/auth/domain/usecases/signout_usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late SignoutUsecase usecase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = SignoutUsecase(mockRepository);
  });

  test("should return Right(null) when signout is successful", () async {
    when(
      () => mockRepository.signout(),
    ).thenAnswer((_) async => const Right(null));

    final result = await usecase();

    expect(result, equals(const Right(null)));
    verify(() => mockRepository.signout()).called(1);
  });

  test("should return failure when signout fails", () async {
    when(
      () => mockRepository.signout(),
    ).thenAnswer((_) async => Left(ServerFailure("Signout failed")));

    final result = await usecase();

    expect(result, equals(Left(ServerFailure("Signout failed"))));
    verify(() => mockRepository.signout()).called(1);
  });
}
