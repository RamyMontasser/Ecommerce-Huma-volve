import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/repo/auth_repo_imp.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/repo/auth_repo.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/repo/home_repo_imp.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repo/home_repo.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> getItsetup() async{

  getIt.registerLazySingleton<ApiClient>(() => ApiClient());

  getIt.registerSingleton<AuthRepo>(
    AuthRepoImp(apiClient: getIt<ApiClient>()
    ),
  );
  getIt.registerSingleton<HomeRepo>(
    HomeRepoImp(apiClient: getIt<ApiClient>()
    ),
  );

}