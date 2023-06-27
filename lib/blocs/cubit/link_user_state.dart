part of 'link_user_cubit.dart';

abstract class LinkUserState extends Equatable {
  const LinkUserState();

  @override
  List<Object> get props => [];
}

class LinkUserInitial extends LinkUserState {}

class LinkUserLoading extends LinkUserState {}

class LinkUserSuccess extends LinkUserState {
  final String message;

  const LinkUserSuccess(this.message);
}

class LinkUserDeleted extends LinkUserState {
  final String message;

  const LinkUserDeleted(this.message);
}

class LinkUserFailed extends LinkUserState {
  final Map<String, dynamic> error;

  const LinkUserFailed(this.error);
}
