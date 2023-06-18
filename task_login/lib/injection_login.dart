import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection_login.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
GetIt configureLoginDependencies() => getIt.init();