import 'package:paynow_e_wallet_app/features/articles/domain/models/articles_params.dart';
import 'package:paynow_e_wallet_app/features/articles/domain/models/article_response_model.dart';
import 'package:paynow_e_wallet_app/features/articles/domain/models/article_model.dart';
import 'package:paynow_e_wallet_app/features/articles/domain/usecases/articles_usecase.dart';

abstract class AbstractArticleApi {
  // Get all article
  Future<ApiResponse<List<ArticleModel>>> getArticles(ArticlesParams params);
}
