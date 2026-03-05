import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

final injector = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => injector.init();