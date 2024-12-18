import 'package:chat_me/services/alert_service.dart';
import 'package:chat_me/services/auth_service.dart';
import 'package:chat_me/services/media_service.dart';
import 'package:chat_me/services/navigation_service.dart';
import 'package:chat_me/services/storage_service.dart';
import 'package:get_it/get_it.dart';

Future<void> registerServices() async {
  final GetIt getIt = GetIt.instance;
  getIt.registerSingleton<AuthService>(
    AuthService(),
  );
  getIt.registerSingleton<NavigationService>(
    NavigationService(),
  );
  getIt.registerSingleton<AlertService>(
    AlertService(),
  );
  getIt.registerSingleton<MediaService>(
    MediaService(),
  );
  getIt.registerSingleton<StorageService>(
    StorageService(),
  );
}
