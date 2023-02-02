part of 'banner_bloc.dart';

@immutable
abstract class BannerState {}

class BannerInitial extends BannerState {}

class BannerReady extends BannerState {
  final List<Banner> banners;
  BannerReady({
    required this.banners,
  });
}

class BannerFailed extends BannerState {
  final String error;
  BannerFailed({
    required this.error,
  });
}
