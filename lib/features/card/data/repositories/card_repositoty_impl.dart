import 'package:dartz/dartz.dart';
import 'package:paynow_e_wallet_app/core/network/error/exceptions.dart';
import 'package:paynow_e_wallet_app/core/network/error/failures.dart';
import 'package:paynow_e_wallet_app/core/params/card_params.dart';
import 'package:paynow_e_wallet_app/features/card/business/entities/card_entity.dart';
import 'package:paynow_e_wallet_app/features/card/business/repositories/card_repository.dart';
import 'package:paynow_e_wallet_app/features/card/data/data_sources/card_remote_data_source.dart';
import 'package:paynow_e_wallet_app/features/card/data/models/card_model.dart';

class CardRepositoryImpl extends CardRepository {
  final CardRemoteDataSource cardRemoteDataSource;

  CardRepositoryImpl(
    this.cardRemoteDataSource,
  );

  @override
  Future<Either<Failure, CardModel>> addCard(AddCardParams params) async {
    try {
      final result = await cardRemoteDataSource.addCard(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.code));
    } catch (e) {
      return Left(ServerFailure(e.toString(), null));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCard(String id) async {
    try {
      final result = await cardRemoteDataSource.deleteCard(id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.code));
    } catch (e) {
      return Left(ServerFailure(e.toString(), null));
    }
  }

  @override
  Future<Either<Failure, List<CardEntity>>> getCard(String userId) async {
    try {
      final result = await cardRemoteDataSource.getCard(userId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.code));
    } catch (e) {
      return Left(ServerFailure(e.toString(), null));
    }
  }

  @override
  Future<Either<Failure, void>> updateCard(UpdateCardParams params) async {
    try {
      final result = await cardRemoteDataSource.updateCard(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.code));
    } catch (e) {
      return Left(ServerFailure(e.toString(), null));
    }
  }

  @override
  Future<Either<Failure, void>> setDefault(SetDefaultCardParams params) async {
    try {
      final result = await cardRemoteDataSource.setDefault(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.code));
    } catch (e) {
      return Left(ServerFailure(e.toString(), null));
    }
  }
}
