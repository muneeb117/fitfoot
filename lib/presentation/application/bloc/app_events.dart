abstract class AppEvents{}
class AppTriggeredEvents extends AppEvents{
  final int index;
  AppTriggeredEvents(this.index):super();
}