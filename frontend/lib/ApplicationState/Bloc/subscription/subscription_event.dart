part of 'subscription_bloc.dart';

@immutable
abstract class SubscriptionEvent {}

class Subscribe extends SubscriptionEvent {
  final SubscriptionModel subscriptionModel;
  Subscribe({required this.subscriptionModel});
}

class UnSubscribe extends SubscriptionEvent {
  final SubscriptionModel subscriptionModel;
  UnSubscribe({required this.subscriptionModel});
}

class GetlAllSubscriptions extends SubscriptionEvent {
  final String id;

  GetlAllSubscriptions({required this.id});
}
