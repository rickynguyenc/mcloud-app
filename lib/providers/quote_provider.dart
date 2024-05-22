import 'package:mcloud/services/quote_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final quoteProvider = Provider.autoDispose((_) {
  final quoteService = _.read(quoteServiceProvider);
  return quoteService.getQuotes({});
});
