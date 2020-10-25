import 'package:animated_sidebar/pages/homepage.dart';
import 'package:animated_sidebar/pages/myaccountpage.dart';
import 'package:animated_sidebar/pages/myorderpage.dart';
import 'package:bloc/bloc.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  MyAccountClickedEvent,
  MyOrdersClickedEvent
}

abstract class NavigationStates {}
class NavigationBlock extends Bloc<NavigationEvents, NavigationStates> {

  @override
  NavigationStates get initialState => HomePage();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async*{
    switch(event) {
      case NavigationEvents.HomePageClickedEvent: 
        yield HomePage();
        break;

      case NavigationEvents.MyAccountClickedEvent: 
        yield MyAccountPage();
        break;

      case NavigationEvents.MyOrdersClickedEvent: 
        yield MyOrderPage();
        break;
    }
  }}