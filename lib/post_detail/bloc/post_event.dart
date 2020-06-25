part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
}

class GetAllPosts extends PostEvent {
  const GetAllPosts();
  @override
  List<Object> get props => [];
}
