import 'package:equatable/equatable.dart';

abstract class AppsEvent extends Equatable {
  const AppsEvent();

  @override
  List<Object> get props => [];
}

class LoadApps extends AppsEvent {}

class SearchApps extends AppsEvent {
  final String query;

  const SearchApps(this.query);

  @override
  List<Object> get props => [query];
}
