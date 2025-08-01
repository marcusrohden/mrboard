import 'package:flutter_modular/flutter_modular.dart';
import 'package:mrpostsboard/features/auth/login_page.dart';
import 'package:mrpostsboard/features/auth/repository/auth_firebase_repository.dart';
import 'package:mrpostsboard/features/auth/repository/auth_interface.dart';
import 'package:mrpostsboard/features/auth/store/auth_store.dart';
import 'package:mrpostsboard/features/board/board_page.dart';
import 'package:mrpostsboard/features/board/repository/board_firebase_repository.dart';
import 'package:mrpostsboard/features/board/repository/board_interface.dart';
import 'package:mrpostsboard/features/board/store/board_store.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<AuthInterface>(AuthFirebaseRepository.new);
    i.addSingleton<AuthStore>(
      AuthStore.new,
      config: BindConfig(onDispose: (store) => store.dispose()),
    );
    i.addLazySingleton<BoardInterface>(BoardFirebaseRepository.new);
    i.addSingleton<BoardStore>(
      BoardStore.new,
      config: BindConfig(onDispose: (store) => store.dispose()),
    );
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => LoginPage());
    r.child('/board', child: (context) => BoardPage());
  }
}
