abstract class HomeLayoutState {}

class HomeLayoutInitial extends HomeLayoutState {}

class NavBarChangeState extends HomeLayoutState {}

class BannerChangeState extends HomeLayoutState {}

class HomePageLoadingState extends HomeLayoutState {}

class HomePageSucState extends HomeLayoutState {
  HomePageSucState();
}

class HomePageFailedState extends HomeLayoutState {
  final String error;

  HomePageFailedState(this.error);
}

class HomeCatsSucState extends HomeLayoutState {
  HomeCatsSucState();
}

class HomeCatsFailedState extends HomeLayoutState {
  final String error;

  HomeCatsFailedState(this.error);
}

class UpdateFavSucState extends HomeLayoutState {
  UpdateFavSucState();
}

class UpdateFavFailedState extends HomeLayoutState {
  final String error;

  UpdateFavFailedState(this.error);
}

class ProfileDataLoadingState extends HomeLayoutState {
  ProfileDataLoadingState();
}

class ProfileDataSucState extends HomeLayoutState {
  ProfileDataSucState();
}

class ProfileDataFailedState extends HomeLayoutState {
  final String error;

  ProfileDataFailedState(this.error);
}

class UpdateProfileDataLoadingState extends HomeLayoutState {
  UpdateProfileDataLoadingState();
}

class UpdateProfileDataSucState extends HomeLayoutState {
  UpdateProfileDataSucState();
}

class UpdateProfileDataFailedState extends HomeLayoutState {
  final String error;

  UpdateProfileDataFailedState(this.error);
}
