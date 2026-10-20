import 'package:flutter_riverpod/flutter_riverpod.dart';

class SerachQueryNotifier extends Notifier<String> {
  @override
  String build()=>'';

  void updateQuery(String query){
    state = query;
  }
}
final searchQueryProvider = NotifierProvider<SerachQueryNotifier,String>(() => SerachQueryNotifier());