import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:frontend/Models/SubscriptionModel.dart';
import 'package:frontend/Repository/subscriptionRepository.dart';
import 'package:meta/meta.dart';

part 'subscription_event.dart';
part 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  SubscriptionBloc() : super(SubscribeInitial());

  @override
  Stream<SubscriptionState> mapEventToState(
    SubscriptionEvent event,
  ) async* {
    if (event is Subscribe) {
      yield SubscriptionInProgress();
      await Future.delayed(Duration(seconds: 2));
      print("message");
      var message =
          await SubscriptionRepository.subscribe(event.subscriptionModel);
      if (message.runtimeType != String) {
        yield Subscribed(message: message['message']);
      } else
        yield SubscribeUnsbscribeFaild(message: "Failed");
    }
    if (event is UnSubscribe) {
      yield SubscriptionInProgress();
      await Future.delayed(Duration(seconds: 2));
      var message =
          await SubscriptionRepository.unSubscribe(event.subscriptionModel);
      print('message $message');
      if (message.runtimeType != String) {
        print("unsubscribed");
        yield UnSubscribed(message: message['message']);
      } else
        yield SubscribeUnsbscribeFaild(message: message);
    }
    if (event is GetlAllSubscriptions) {
      yield SubscriptionInProgress();
      var response = await SubscriptionRepository.getAllSubscriptions(event.id);
      print("response $response runtime ${response.runtimeType}");
      if (response.runtimeType != String) {
        print("good job");
        yield AllSubscriptionsFetched(allSubscriptions: response);
      } else {
        yield SubscribeUnsbscribeFaild(message: response.toString());
      }
    }
  }
}
