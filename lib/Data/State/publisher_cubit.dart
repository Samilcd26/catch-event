import 'package:flutter_bloc/flutter_bloc.dart';

class PublisherCubit extends Cubit<PublisherState> {
  PublisherCubit() : super(PublisherInitial());
}

abstract class PublisherState {}

class PublisherInitial extends PublisherState {}
