import 'package:equatable/equatable.dart';
import '../../model/menuDar.dart';
import '../../model/task.dart';
import '../../model/user.dart';

class DarState extends Equatable {
  final User user;
  final Task task;
  final bool isLoading;
  final bool isSuccess;
  final String errorMessage;
  final List<Task> tasks;
  final String warningMessage;
  final List<MenuDar> listMenu;
  final String currentScreen;
  final int indexMenu;

  DarState(
      {User? user,
      Task? task,
      this.isLoading = false,
      this.isSuccess = false,
      this.errorMessage = '',
      this.warningMessage = '',
      this.tasks = const <Task>[],
      this.listMenu = const <MenuDar>[],
      this.currentScreen = '',
      this.indexMenu = 0})
      : user = user ?? User(),
        task = task ?? Task();

  DarState copyWith({
    User? user,
    Task? task,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    List<Task>? tasks,
    String? warningMessage,
    List<MenuDar>? listMenu,
    String? currentScreen,
    int? indexMenu,
  }) {
    return DarState(
      user: user ?? this.user,
      task: task ?? this.task,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      tasks: tasks ?? this.tasks, // Update field tasks di sini
      warningMessage: warningMessage ?? this.warningMessage,
      listMenu: listMenu ?? this.listMenu,
      currentScreen: currentScreen ?? this.currentScreen,
      indexMenu: indexMenu ?? this.indexMenu,
    );
  }

  @override
  List<Object> get props => [
        user,
        task,
        isLoading,
        isSuccess,
        errorMessage,
        tasks,
        warningMessage,
        listMenu,
        currentScreen,
        indexMenu,
      ];
}
