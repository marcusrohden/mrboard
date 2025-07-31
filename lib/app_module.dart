import 'package:flutter_modular/flutter_modular.dart';
import 'package:mrpostsboard/home_page.dart';

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child('/', child: (context) => HomePage());
  }
}
