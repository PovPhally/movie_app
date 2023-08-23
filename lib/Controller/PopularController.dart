import 'package:get/get.dart';
import 'package:movie_app/Model/PopularMovieResModel.dart';
import 'package:movie_app/Service/api_service.dart';

class PopularMovieController extends GetxController
    with StateMixin<PopularMovieResModel> {
  final api = PopularAPIService();
  var getMovies = PopularMovieResModel();
  @override
  void onInit() {
    getMovie();
    super.onInit();
  }

  void getMovie() async {
    change(null, status: RxStatus.loading());
    try {
      getMovies = await api.getPopularMovies();
      change(getMovies, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
