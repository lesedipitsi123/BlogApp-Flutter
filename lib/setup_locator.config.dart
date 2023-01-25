// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:blog_app/data/blog_app_db.dart' as _i3;
import 'package:blog_app/data/repository/author_repository.dart' as _i7;
import 'package:blog_app/data/repository/blog_repository.dart' as _i6;
import 'package:blog_app/data/service/author_service.dart' as _i5;
import 'package:blog_app/data/service/blog_service.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of main-scope dependencies inside of [GetIt]
_i1.GetIt init(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.singleton<_i3.BlogAppDb>(_i3.BlogAppDb());
  gh.lazySingleton<_i4.BlogService>(
      () => _i4.BlogServiceImpl(gh<_i3.BlogAppDb>()));
  gh.lazySingleton<_i5.AuthorService>(
      () => _i5.AuthorServiceImpl(gh<_i3.BlogAppDb>()));
  gh.lazySingleton<_i6.BlogRepository>(
      () => _i6.BlogRepositoryImpl(gh<_i4.BlogService>()));
  gh.lazySingleton<_i7.AuthorRepository>(
      () => _i7.AuthorRepositoryImpl(gh<_i5.AuthorService>()));
  return getIt;
}
