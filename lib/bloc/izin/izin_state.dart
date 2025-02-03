import 'package:flutter/material.dart';
import '../../model/dashboardIzin.dart';
import '../../model/izinAll.dart';
import '../../model/menuIzin.dart';
import '../../model/report.dart';
import '../../model/submissionAll.dart';
import '../../model/task.dart';
import '../../model/user.dart';

class IzinState {
  final User user;
  final Task task;
  final bool isLoading;
  final bool isSuccess;
  final String errorMessage;
  final List<IzinAll> izinAll;
  final IzinAll izinId;
  final DashboardIzinAll dashboardIzin;
  final User userIzin;
  final String warningMessage;
  final List<MenuIzin> listMenu;
  final String currentScreen;
  final int indexMenu;
  final List<User> userData;
  final List<MenuIzinDashboard> menu;
  final List<MenuIzinList> menuList;
  final TextEditingController ctrlName;
  final TextEditingController ctrlDivision;
  final TextEditingController ctrlStartDate;
  final TextEditingController ctrlEndDate;
  final TextEditingController ctrlStartTime;
  final TextEditingController ctrlEndTime;
  final TextEditingController ctrlReason;
  final TextEditingController ctrlDescription;
  final bool isUpdateSuccess;
  final List<String> listDataIzin;
  String selectedValue;
  final List<SubmissionAll> submissionAll;
  final List<User> userIzinList;
  final List<String> optionIzin;
  final List<String> listUser;
  final Report report;
  final List<String> listReportUser;
  final String searchKeyword; // Keyword pencarian
  final List<User> searchResults; // Hasil pencarian
  final String? selectedUsername;
  final String? selectedName;
  final List<Color> backgroundColors;
  final List<int> selectedIds;
  final bool isSelected;
  final String message;
  final String titleMessage;
  final String typeMessage;
  final String userRole;

  IzinState({
    User? user,
    Task? task,
    DashboardIzinAll? dashboardIzin,
    User? userIzin,
    IzinAll? izinId,
    TextEditingController? ctrlName,
    TextEditingController? ctrlDivision,
    TextEditingController? ctrlStartDate,
    TextEditingController? ctrlEndDate,
    TextEditingController? ctrlStartTime,
    TextEditingController? ctrlEndTime,
    TextEditingController? ctrlReason,
    TextEditingController? ctrlDescription,
    this.isLoading = false,
    this.isSuccess = false,
    this.isUpdateSuccess = false,
    this.errorMessage = '',
    this.warningMessage = '',
    this.izinAll = const [],
    // this.dashboardIzin = const <DashboardIzinAll>[],
    this.listMenu = const <MenuIzin>[],
    this.currentScreen = '',
    this.indexMenu = 0,
    List<User>? userData,
    List<MenuIzinDashboard>? menu,
    List<MenuIzinList>? menuList,
    List<String>? listDataIzin,
    List<String>? optionIzin,
    this.selectedValue = '',
    this.submissionAll = const [],
    this.userIzinList = const [],
    this.listUser = const [],
    Report? report,
    List<String>? listReportUser,
    this.searchKeyword = '',
    this.searchResults = const [],
    this.selectedUsername,
    this.selectedName,
    // required this.backgroundColors,
    this.backgroundColors = const [],
    this.selectedIds = const [],
    this.isSelected = false,
    this.message = '',
    this.titleMessage = '',
    this.typeMessage = '',
    this.userRole = '',
  })  : user = user ?? User(),
        task = task ?? Task(),
        izinId = izinId ?? IzinAll(),
        dashboardIzin = dashboardIzin ?? DashboardIzinAll(),
        userIzin = userIzin ?? User(),
        ctrlName = ctrlName ?? TextEditingController(),
        ctrlDivision = ctrlDivision ?? TextEditingController(),
        ctrlStartDate = ctrlStartDate ?? TextEditingController(),
        ctrlEndDate = ctrlEndDate ?? TextEditingController(),
        ctrlStartTime = ctrlStartTime ?? TextEditingController(),
        ctrlEndTime = ctrlEndTime ?? TextEditingController(),
        ctrlReason = ctrlReason ?? TextEditingController(),
        ctrlDescription = ctrlDescription ?? TextEditingController(),
        report = report ?? Report(),
        listReportUser = listReportUser ?? [],
        listDataIzin = listDataIzin ??
            [
              'Semua',
              'Pending',
              'Selesai',
              'Disetujui admin',
              'Disetujui superadmin',
              'Ditolak admin',
              'Ditolak superadmin',
              'Cancel'
            ],
        userData = userData ??
            [
              // Beri nilai default di sini jika userData null
              User(),
              User(),
            ],
        menu = menu ??
            [
              const MenuIzinDashboard(Icons.work_history, 'Semua Izin',
                  Colors.white70, Colors.blue, '15'),
              const MenuIzinDashboard(Icons.check_box_rounded, 'Izin Disetujui',
                  Colors.white70, Colors.green, '20'),
              const MenuIzinDashboard(Icons.inventory, 'Izin Ditolak',
                  Colors.white70, Colors.red, '23'),
            ],
        menuList = menuList ??
            const [
              MenuIzinList(Icons.work_history, 'Semua Izin', Colors.white70,
                  Colors.blue, '75'),
              MenuIzinList(Icons.check_box_rounded, 'Izin Disetujui',
                  Colors.white70, Colors.green, '20'),
              MenuIzinList(Icons.inventory, 'Izin Ditolak', Colors.white70,
                  Colors.red, '23'),
            ],
        optionIzin = optionIzin ??
            [
              'Datang Terlambat',
              'Pulang lebih awal',
              'Tugas luar kantor',
              'Dinas luar kota',
              'Sakit',
              'Lain-lain'
            ];

  IzinState copyWith({
    User? user,
    Task? task,
    TextEditingController? ctrlName,
    TextEditingController? ctrlDivision,
    TextEditingController? ctrlStartDate,
    TextEditingController? ctrlEndDate,
    TextEditingController? ctrlStartTime,
    TextEditingController? ctrlEndTime,
    TextEditingController? ctrlReason,
    TextEditingController? ctrlDescription,
    DashboardIzinAll? dashboardIzin,
    bool? isUpdateSuccess,
    User? userIzin,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    List<IzinAll>? izinAll,
    IzinAll? izinId,
    String? warningMessage,
    List<MenuIzin>? listMenu,
    String? currentScreen,
    int? indexMenu,
    List<MenuIzinDashboard>? menu,
    List<String>? listDataIzin,
    List<String>? optionIzin,
    List<String>? listUser,
    String? selectedValue,
    List<SubmissionAll>? submissionAll,
    List<User>? userIzinList,
    Report? report,
    List<String>? listReportUser,
    String? searchKeyword,
    List<User>? searchResults,
    String? selectedUsername,
    String? selectedName,
    List<int>? selectedIds,
    bool? isSelected,
    String? message,
    String? titleMessage,
    String? typeMessage,
    String? userRole,
  }) {
    return IzinState(
      user: user ?? this.user,
      task: task ?? this.task,
      izinId: izinId ?? this.izinId,
      izinAll: izinAll ?? this.izinAll,
      dashboardIzin: dashboardIzin ?? this.dashboardIzin,
      userIzin: userIzin ?? this.userIzin,
      ctrlName: ctrlName ?? this.ctrlName,
      ctrlDivision: ctrlDivision ?? this.ctrlDivision,
      ctrlStartDate: ctrlStartDate ?? this.ctrlStartDate,
      ctrlEndDate: ctrlEndDate ?? this.ctrlEndDate,
      ctrlStartTime: ctrlStartTime ?? this.ctrlStartTime,
      ctrlEndTime: ctrlEndTime ?? this.ctrlEndTime,
      ctrlReason: ctrlReason ?? this.ctrlReason,
      ctrlDescription: ctrlDescription ?? this.ctrlDescription,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      warningMessage: warningMessage ?? this.warningMessage,
      listMenu: listMenu ?? this.listMenu,
      currentScreen: currentScreen ?? this.currentScreen,
      indexMenu: indexMenu ?? this.indexMenu,
      menu: menu ?? this.menu,
      isUpdateSuccess: isUpdateSuccess ?? this.isUpdateSuccess,
      listDataIzin: listDataIzin ?? this.listDataIzin,
      selectedValue: selectedValue ?? this.selectedValue,
      submissionAll: submissionAll ?? this.submissionAll,
      userIzinList: userIzinList ?? this.userIzinList,
      optionIzin: optionIzin ?? this.optionIzin,
      listUser: listUser ?? this.listUser,
      report: report ?? this.report,
      listReportUser: listReportUser ?? this.listReportUser,
      searchKeyword: searchKeyword ?? this.searchKeyword,
      searchResults: searchResults ?? this.searchResults,
      selectedUsername: selectedUsername ?? this.selectedUsername,
      selectedName: selectedName ?? this.selectedName,
      backgroundColors: backgroundColors,
      selectedIds: selectedIds ?? this.selectedIds,
      isSelected: isSelected ?? this.isSelected,
      message: message ?? this.message,
      titleMessage: titleMessage ?? this.titleMessage,
      typeMessage: typeMessage ?? this.typeMessage,
      userRole: userRole ?? this.userRole,
    );
  }

  List<Object> get props => [
        user,
        task,
        izinId,
        izinAll,
        ctrlName,
        ctrlDivision,
        ctrlStartDate,
        ctrlEndDate,
        ctrlStartTime,
        ctrlEndTime,
        ctrlReason,
        ctrlDescription,
        isLoading,
        isSuccess,
        errorMessage,
        dashboardIzin,
        userIzin,
        warningMessage,
        listMenu,
        currentScreen,
        indexMenu,
        menu,
        isUpdateSuccess,
        listDataIzin,
        selectedValue,
        submissionAll,
        userIzinList,
        optionIzin,
        listUser,
        report,
        listReportUser,
        backgroundColors,
        selectedIds,
        isSelected,
        message,
        userRole
      ];
}

class MenuIzinDashboard {
  const MenuIzinDashboard(
      this.icon, this.title, this.color, this.colorBg, this.subtitle);
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final Color colorBg;
}

class MenuIzinList {
  const MenuIzinList(
      this.icon, this.title, this.color, this.colorBg, this.subtitle);
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final Color colorBg;
}
