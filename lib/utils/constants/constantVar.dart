class Variable {
  static const appName = 'HMA APP';
  static const harusDiisi = 'Harus Diisi';
  static const regexForValidationEmail =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
}

class Url {
  static const base = 'darbe.hanatekindo.com';
}

class PathUrl {
  //ALL
  static const task = '/task/list-task-user/';
  static const login = '/login';
  static const user = '/list-user/';

  //IZIN
  static const dashboardIzin = '/izin/dashboard/';
  static const izinAll = '/izin/izin-saya/';
  static const addIzin = '/izin/create-izin-saya';
  static const updateIzin = '/izin/update-izin-saya';
  static const submissionAll = '/izin/izin-saya-all/superadmin/semua';
  static const updateSubmission = '/izin/update-izin-saya';
  static const reportAll = '/izin/laporan/';
  static const addUser = '/izin/register';

  //ATK PERMINTAAN
  static const atkPermintaanDashboard = '/atk-permintaan/dashboard';
  static const atkPermintaanEtalase = '/atk-permintaan/etalase';
}
