import 'package:dartz/dartz.dart';
import 'package:paynow_e_wallet_app/core/network/error/failures.dart';
import 'package:paynow_e_wallet_app/core/utils/usecases/usecase.dart';
import 'package:paynow_e_wallet_app/features/articles/domain/models/article_model.dart';
import 'package:paynow_e_wallet_app/features/articles/domain/models/articles_params.dart';
import 'package:paynow_e_wallet_app/features/articles/domain/repositories/abstract_articles_repository.dart';

class ArticlesUseCase extends UseCase<List<ArticleModel>, ArticlesParams> {
  final AbstractArticlesRepository repository;

  ArticlesUseCase(this.repository);

  @override
  Future<Either<Failure, List<ArticleModel>>> call(
      ArticlesParams params) async {
    final result = await repository.getArticles(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
