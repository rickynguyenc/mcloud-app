import 'package:dio/dio.dart';
import 'package:mcloud/core/app_dio.dart';
import 'package:mcloud/core/constants/api_constants.dart';
import 'package:mcloud/models/quote_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/http.dart';
part 'quote_service.g.dart';

final quoteServiceProvider = Provider((ref) {
  return QuoteService(ref);
});

@RestApi()
abstract class QuoteService {
  factory QuoteService(Ref ref) => _QuoteService(ref.read(dioProvider));
  @GET('/api/v1/quote')
  Future<List<BaseQuoteModel>> getQuotes(@Queries() Map<String, dynamic> param);
}
