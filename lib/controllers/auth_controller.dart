import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movies/controllers/genre_controller.dart';
import 'package:movies/screens/welcome_screen.dart';

class AuthController extends GetxController {
  final genreController = Get.put(GenreController());
  var isLogIn = false.obs;

  @override
  void onInit() async{
    await genreController.getAllGenres();
    redirect();
    super.onInit();
  }

  redirect() async {
    var token = await GetStorage().read('login_token');

    if (token != null) {
      isLogIn.value = true;
    }
    Future.delayed(Duration(seconds: 3), () {
      Get.off(WelcomeScreen(), preventDuplicates: false);
    });
  }
}
