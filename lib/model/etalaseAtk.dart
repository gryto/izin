class EtalaseAtkRequest {
  bool? success;
  Data? data;

  EtalaseAtkRequest({this.success, this.data});

  EtalaseAtkRequest.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Barang? barang;
  int? cartCount;

  Data({this.barang, this.cartCount});

  Data.fromJson(Map<String, dynamic> json) {
    barang =
        json['barang'] != null ? new Barang.fromJson(json['barang']) : null;
    cartCount = json['cart_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.barang != null) {
      data['barang'] = this.barang!.toJson();
    }
    data['cart_count'] = this.cartCount;
    return data;
  }
}

class Barang {
  int? currentPage;
  List<Data2>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  int? prevPageUrl;
  int? to;
  int? total;

  Barang(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  Barang.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data2>[];
      json['data'].forEach((v) {
        data!.add(new Data2.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Data2 {
  int? id;
  int? masterAssetId;
  String? typeBarang;
  String? kodeBarang;
  String? serialNumber;
  String? namaBarang;
  String? jumlah;
  String? satuan;
  String? keterangan;
  int? lastUpdatedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  Image? image;
  String? url;

  Data2(
      {this.id,
      this.masterAssetId,
      this.typeBarang,
      this.kodeBarang,
      this.serialNumber,
      this.namaBarang,
      this.jumlah,
      this.satuan,
      this.keterangan,
      this.lastUpdatedBy,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.image,
      this.url});

  Data2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    masterAssetId = json['master_asset_id'];
    typeBarang = json['type_barang'];
    kodeBarang = json['kode_barang'];
    serialNumber = json['serial_number'];
    namaBarang = json['nama_barang'];
    jumlah = json['jumlah'];
    satuan = json['satuan'];
    keterangan = json['keterangan'];
    lastUpdatedBy = json['last_updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['master_asset_id'] = this.masterAssetId;
    data['type_barang'] = this.typeBarang;
    data['kode_barang'] = this.kodeBarang;
    data['serial_number'] = this.serialNumber;
    data['nama_barang'] = this.namaBarang;
    data['jumlah'] = this.jumlah;
    data['satuan'] = this.satuan;
    data['keterangan'] = this.keterangan;
    data['last_updated_by'] = this.lastUpdatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['url'] = this.url;
    return data;
  }

  @override
  String toString() {
    return 'Data2('
        'id: $id, '
        'masterAssetId: $masterAssetId, '
        'typeBarang: $typeBarang, '
        'kodeBarang: $kodeBarang, '
        'serialNumber: $serialNumber, '
        'namaBarang: $namaBarang, '
        'jumlah: $jumlah, '
        'satuan: $satuan, '
        'keterangan: $keterangan, '
        'lastUpdatedBy: $lastUpdatedBy, '
        'createdAt: $createdAt, '
        'updatedAt: $updatedAt, '
        'deletedAt: $deletedAt, '
        'image: $image, '
        'url: $url'
        ')';
  }
}

class Image {
  int? id;
  int? barangId;
  String? image;
  String? sort;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Image(
      {this.id,
      this.barangId,
      this.image,
      this.sort,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Image.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    barangId = json['barang_id'];
    image = json['image'];
    sort = json['sort'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['barang_id'] = this.barangId;
    data['image'] = this.image;
    data['sort'] = this.sort;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
