part of 'subscription_bloc.dart';

@immutable
abstract class SubscriptionState {}

class SubscribeInitial extends SubscriptionState {}

class Subscribed extends SubscriptionState {
  final String message;

  Subscribed({required this.message});
}

class SubscribeUnsbscribeFaild extends SubscriptionState {
  final String message;
  SubscribeUnsbscribeFaild({required this.message});
}

class UnSubscribed extends SubscriptionState {
  final String message;

  UnSubscribed({required this.message});
}

class SubscriptionInProgress extends SubscriptionState {}

class AllSubscriptionsFetched extends SubscriptionState {
  final List<dynamic> allSubscriptions;

  AllSubscriptionsFetched({required this.allSubscriptions});
}
