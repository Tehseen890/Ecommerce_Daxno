class Product {
  String? url;
  String? title;
  String? asin;
  String? price;
  String? brand;
  String? productDetails;
  String? breadcrumbs;
  List<String>? imagesList;
  List<Features>? features;

  Product({
    this.url,
    this.title,
    this.asin,
    this.price,
    this.brand,
    this.productDetails,
    this.breadcrumbs,
    this.imagesList,
    this.features,
  });

  Product.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    title = json['title'];
    asin = json['asin'];
    price = json['price'];
    brand = json['brand'];
    productDetails = json['product_details'];
    breadcrumbs = json['breadcrumbs'];
    imagesList = json['images_list'].cast<String>();
    if (json['features'] != null) {
      features = <Features>[];
      json['features'].forEach((v) {
        features!.add(new Features.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['title'] = this.title;
    data['asin'] = this.asin;
    data['price'] = this.price;
    data['brand'] = this.brand;
    data['product_details'] = this.productDetails;
    data['breadcrumbs'] = this.breadcrumbs;
    data['images_list'] = this.imagesList;
    if (this.features != null) {
      data['features'] = this.features!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Features {
  String? outerMaterial;
  String? innerMaterial;
  String? sole;
  String? closure;
  String? heelHeight;
  String? heelType;
  String? shoeWidth;

  Features(
      {this.outerMaterial,
      this.innerMaterial,
      this.sole,
      this.closure,
      this.heelHeight,
      this.heelType,
      this.shoeWidth});

  Features.fromJson(Map<String, dynamic> json) {
    outerMaterial = json['Outer Material'];
    innerMaterial = json['Inner Material'];
    sole = json['Sole'];
    closure = json['Closure'];
    heelHeight = json['Heel Height'];
    heelType = json['Heel Type'];
    shoeWidth = json['Shoe Width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Outer Material'] = this.outerMaterial;
    data['Inner Material'] = this.innerMaterial;
    data['Sole'] = this.sole;
    data['Closure'] = this.closure;
    data['Heel Height'] = this.heelHeight;
    data['Heel Type'] = this.heelType;
    data['Shoe Width'] = this.shoeWidth;
    return data;
  }
}
