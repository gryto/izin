import '../../model/dashboardAtk.dart';
import '../../model/menuIzin.dart';
import '../../model/user.dart';

class AtkState {
  final User user;
  final bool isLoading;
  final bool isSuccess;
  final String errorMessage;
  DashboardAtkRequest? dashboardAtkRequest;
  final List<MenuIzin> listMenu;
  final String currentScreen;
  final int indexMenu;

  AtkState({
    User? user,
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage = '',
    DashboardAtkRequest? dashboardAtkRequest,
    this.listMenu = const <MenuIzin>[],
    this.currentScreen = '',
    this.indexMenu = 0
  })  : user = user ?? User(),
        dashboardAtkRequest = dashboardAtkRequest ?? DashboardAtkRequest();

  AtkState copyWith({
    User? user,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    DashboardAtkRequest? dashboardAtkRequest,
    List<MenuIzin>? listMenu,
    String? currentScreen,
    int? indexMenu
  }) {
    return AtkState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      dashboardAtkRequest: dashboardAtkRequest ?? this.dashboardAtkRequest,
      listMenu: listMenu ?? this.listMenu,
      currentScreen: currentScreen ?? this.currentScreen,
      indexMenu: indexMenu ?? this.indexMenu,
    );
  }

  List<Object> get props => [
        user,
        isLoading,
        isSuccess,
        errorMessage,
        listMenu,
        currentScreen,
        indexMenu
      ];
}
