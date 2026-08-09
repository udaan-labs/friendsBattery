import 'package:test/test.dart';
import 'package:friends_battery_api/friends_battery_api.dart';


/// tests for ProductsApi
void main() {
  final instance = FriendsBatteryApi().getProductsApi();

  group(ProductsApi, () {
    // Get products in the authenticated user's inventory
    //
    //Future<InventoryProductsResponse> apiProductsInventoryProductsGet() async
    test('test apiProductsInventoryProductsGet', () async {
      // TODO
    });

    // Return all products matching filters
    //
    //Future apiProductsListPost(ApiProductsListPostRequest apiProductsListPostRequest) async
    test('test apiProductsListPost', () async {
      // TODO
    });

    // Create a new product
    //
    //Future<CreateProductResponse> apiProductsPost(CreateProductRequest createProductRequest) async
    test('test apiProductsPost', () async {
      // TODO
    });

    // Return all models belonging to a product name
    //
    //Future<ProductModelsResponse> apiProductsProductModelsListPost(ListProductModelsRequest listProductModelsRequest) async
    test('test apiProductsProductModelsListPost', () async {
      // TODO
    });

    // Create a product model
    //
    //Future<ProductModelResponse> apiProductsProductModelsPost(CreateProductModelRequest createProductModelRequest) async
    test('test apiProductsProductModelsPost', () async {
      // TODO
    });

    // Return all product names
    //
    //Future<ProductNamesResponse> apiProductsProductNamesGet() async
    test('test apiProductsProductNamesGet', () async {
      // TODO
    });

    // Create a product name
    //
    //Future<ProductNameResponse> apiProductsProductNamesPost(CreateProductNameRequest createProductNameRequest) async
    test('test apiProductsProductNamesPost', () async {
      // TODO
    });

  });
}
