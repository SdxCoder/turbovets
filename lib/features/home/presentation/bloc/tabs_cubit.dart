import 'package:flutter_bloc/flutter_bloc.dart';

enum TabsState { chats, dashboard, settings }

class TabsCubit extends Cubit<TabsState> {
  TabsCubit() : super(TabsState.chats);

  void selectTab(TabsState tab) {
    emit(tab);
  }
}
