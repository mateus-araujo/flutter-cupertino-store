import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'models/app/app_state_model.dart';
import 'screens/app/app.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppStateModel()..loadProducts(),
      child: CupertinoStoreApp(),
    ),
  );
}
