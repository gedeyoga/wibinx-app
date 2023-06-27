part of 'website_user_cubit.dart';

abstract class WebsiteUserState extends Equatable {
  const WebsiteUserState();

  @override
  List<Object> get props => [];
}

class WebsiteUserInitial extends WebsiteUserState {}

class WebsiteUserLoading extends WebsiteUserState {}

class WebsiteUserSuccess extends WebsiteUserState {
  final String message;
  final WebsiteUserModel websiteUser;

  const WebsiteUserSuccess(this.websiteUser , this.message);
}

class WebsiteUserFailed extends WebsiteUserState {
  final Map<String, dynamic> error;

  const WebsiteUserFailed(this.error);
}

class LinkNameTyping extends WebsiteUserState {
  final String link;

  const LinkNameTyping(this.link);
}
