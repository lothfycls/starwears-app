import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starwears/services/banners_service.dart';

import '../models/banner.dart';

part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  BannersService bannersService = BannersService();
  List<Banner> banners = [];
  BannerBloc() : super(BannerInitial()) {
    on<GetBanner>((event, emit) async {
      try {
        final List<Banner> _banners = await bannersService.getBanners();
        print('wooo');
        banners = _banners;
        print(banners.length);
        emit(BannerReady(banners: _banners));
      } catch (e) {
        emit(BannerFailed(error: e.toString()));
      }
    });
  }
}
