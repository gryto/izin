import '../../model/dashboardAtk.dart';
import '../../model/etalaseAtk.dart';
import '../../model/menuIzin.dart';
import '../../model/user.dart';

class AtkState {
  final User user;
  final bool isLoading;
  final bool isSuccess;
  final String errorMessage;
  DashboardAtkRequest? dashboardAtkRequest;
  final List<Data2> etalaseAtkRequest;
  final List<MenuIzin> listMenu;
  final String currentScreen;
  final int indexMenu;
  final bool isUpdateSuccess;
  final String warningMessage;
  final List<Data2?> filteredEtalase;
  final String searchQuery;

  AtkState({
    User? user,
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage = '',
    DashboardAtkRequest? dashboardAtkRequest,
    this.etalaseAtkRequest = const <Data2>[],
    this.listMenu = const <MenuIzin>[],
    this.currentScreen = '',
    this.indexMenu = 0,
    this.isUpdateSuccess = false,
    this.warningMessage = '',
    this.filteredEtalase = const <Data2>[],
    this.searchQuery = '',
  })  : user = user ?? User(),
        dashboardAtkRequest = dashboardAtkRequest ?? DashboardAtkRequest();

  AtkState copyWith({
    User? user,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    DashboardAtkRequest? dashboardAtkRequest,
    List<Data2>? etalaseAtkRequest,
    List<MenuIzin>? listMenu,
    String? currentScreen,
    int? indexMenu,
    bool? isUpdateSuccess,
    String? warningMessage,
    List<Data2>? filteredEtalase,
    String? searchQuery,
  }) {
    return AtkState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      dashboardAtkRequest: dashboardAtkRequest ?? this.dashboardAtkRequest,
      etalaseAtkRequest: etalaseAtkRequest ?? this.etalaseAtkRequest,
      listMenu: listMenu ?? this.listMenu,
      currentScreen: currentScreen ?? this.currentScreen,
      indexMenu: indexMenu ?? this.indexMenu,
      isUpdateSuccess: isUpdateSuccess ?? this.isUpdateSuccess,
      warningMessage: warningMessage ?? this.warningMessage,
      filteredEtalase: filteredEtalase ?? this.filteredEtalase,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  List<Object> get props => [
        user,
        isLoading,
        isSuccess,
        errorMessage,
        listMenu,
        currentScreen,
        indexMenu,
        etalaseAtkRequest,
        isUpdateSuccess,
        warningMessage,
        filteredEtalase,
        searchQuery,
      ];
}
