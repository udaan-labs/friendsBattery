//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:one_of_serializer/any_of_serializer.dart';
import 'package:one_of_serializer/one_of_serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:friends_battery_api/src/date_serializer.dart';
import 'package:friends_battery_api/src/model/date.dart';

import 'package:friends_battery_api/src/model/api_auth_activate_put_request.dart';
import 'package:friends_battery_api/src/model/api_auth_login_post_request.dart';
import 'package:friends_battery_api/src/model/api_auth_register_post_request.dart';
import 'package:friends_battery_api/src/model/api_dashboard_stats_get200_response.dart';
import 'package:friends_battery_api/src/model/api_dashboard_stats_get200_response_data.dart';
import 'package:friends_battery_api/src/model/api_inventory_adjust_patch_request.dart';
import 'package:friends_battery_api/src/model/api_inventory_available_serials_get200_response.dart';
import 'package:friends_battery_api/src/model/api_inventory_details_get200_response.dart';
import 'package:friends_battery_api/src/model/api_inventory_details_get200_response_data.dart';
import 'package:friends_battery_api/src/model/api_inventory_details_get200_response_data_categories_inner.dart';
import 'package:friends_battery_api/src/model/api_inventory_details_get200_response_data_categories_inner_subcategories_inner.dart';
import 'package:friends_battery_api/src/model/api_inventory_details_get200_response_data_categories_inner_subcategories_inner_products_inner.dart';
import 'package:friends_battery_api/src/model/api_inventory_details_get200_response_data_pagination.dart';
import 'package:friends_battery_api/src/model/api_inventory_product_details_get200_response.dart';
import 'package:friends_battery_api/src/model/api_inventory_product_details_get200_response_data.dart';
import 'package:friends_battery_api/src/model/api_inventory_product_id_get200_response.dart';
import 'package:friends_battery_api/src/model/api_inventory_product_id_get200_response_data.dart';
import 'package:friends_battery_api/src/model/api_inventory_transfer_post_request.dart';
import 'package:friends_battery_api/src/model/api_inventory_transfer_post_request_products_inner.dart';
import 'package:friends_battery_api/src/model/api_inventory_update_stock_post200_response.dart';
import 'package:friends_battery_api/src/model/api_inventory_update_stock_post200_response_data.dart';
import 'package:friends_battery_api/src/model/api_inventory_update_stock_post_request.dart';
import 'package:friends_battery_api/src/model/api_products_categories_list_post_request.dart';
import 'package:friends_battery_api/src/model/api_products_categories_post_request.dart';
import 'package:friends_battery_api/src/model/api_products_groups_post_request.dart';
import 'package:friends_battery_api/src/model/api_products_list_post_request.dart';
import 'package:friends_battery_api/src/model/api_products_post_request.dart';
import 'package:friends_battery_api/src/model/api_products_product_models_list_post_request.dart';
import 'package:friends_battery_api/src/model/api_products_product_models_post_request.dart';
import 'package:friends_battery_api/src/model/api_products_product_names_list_post_request.dart';
import 'package:friends_battery_api/src/model/api_products_product_names_post_request.dart';
import 'package:friends_battery_api/src/model/api_sales_post_request.dart';
import 'package:friends_battery_api/src/model/api_seller_dashboard_pending_shipments_get200_response.dart';
import 'package:friends_battery_api/src/model/api_seller_dashboard_pending_shipments_get200_response_data.dart';
import 'package:friends_battery_api/src/model/api_seller_dashboard_stats_get200_response.dart';
import 'package:friends_battery_api/src/model/api_seller_dashboard_stats_get200_response_data.dart';
import 'package:friends_battery_api/src/model/api_seller_shipments_get200_response.dart';
import 'package:friends_battery_api/src/model/api_seller_shipments_get200_response_data_inner.dart';
import 'package:friends_battery_api/src/model/api_seller_shipments_get200_response_data_inner_items_inner.dart';
import 'package:friends_battery_api/src/model/api_shipments_get200_response.dart';
import 'package:friends_battery_api/src/model/api_shipments_get200_response_data_inner.dart';
import 'package:friends_battery_api/src/model/api_shipments_get200_response_data_inner_seller.dart';
import 'package:friends_battery_api/src/model/api_shipments_id_get200_response.dart';
import 'package:friends_battery_api/src/model/api_shipments_id_get200_response_data.dart';
import 'package:friends_battery_api/src/model/api_shipments_id_get200_response_data_items_inner.dart';
import 'package:friends_battery_api/src/model/api_shipments_id_get200_response_data_seller.dart';
import 'package:friends_battery_api/src/model/api_shipments_post_request.dart';
import 'package:friends_battery_api/src/model/api_shipments_post_request_items_inner.dart';
import 'package:friends_battery_api/src/model/api_transfers_post_request.dart';
import 'package:friends_battery_api/src/model/api_transfers_post_request_items_inner.dart';
import 'package:friends_battery_api/src/model/category.dart';
import 'package:friends_battery_api/src/model/customer.dart';
import 'package:friends_battery_api/src/model/error.dart';
import 'package:friends_battery_api/src/model/inventory_transaction.dart';
import 'package:friends_battery_api/src/model/product.dart';
import 'package:friends_battery_api/src/model/product_model.dart';
import 'package:friends_battery_api/src/model/product_name.dart';
import 'package:friends_battery_api/src/model/product_unit.dart';
import 'package:friends_battery_api/src/model/return_product.dart';
import 'package:friends_battery_api/src/model/sales_transaction.dart';
import 'package:friends_battery_api/src/model/shipment.dart';
import 'package:friends_battery_api/src/model/shipment_item.dart';
import 'package:friends_battery_api/src/model/stock_request.dart';
import 'package:friends_battery_api/src/model/stock_request_item.dart';
import 'package:friends_battery_api/src/model/user.dart';

part 'serializers.g.dart';

@SerializersFor([
  ApiAuthActivatePutRequest,
  ApiAuthLoginPostRequest,
  ApiAuthRegisterPostRequest,
  ApiDashboardStatsGet200Response,
  ApiDashboardStatsGet200ResponseData,
  ApiInventoryAdjustPatchRequest,
  ApiInventoryAvailableSerialsGet200Response,
  ApiInventoryDetailsGet200Response,
  ApiInventoryDetailsGet200ResponseData,
  ApiInventoryDetailsGet200ResponseDataCategoriesInner,
  ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner,
  ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner,
  ApiInventoryDetailsGet200ResponseDataPagination,
  ApiInventoryProductDetailsGet200Response,
  ApiInventoryProductDetailsGet200ResponseData,
  ApiInventoryProductIdGet200Response,
  ApiInventoryProductIdGet200ResponseData,
  ApiInventoryTransferPostRequest,
  ApiInventoryTransferPostRequestProductsInner,
  ApiInventoryUpdateStockPost200Response,
  ApiInventoryUpdateStockPost200ResponseData,
  ApiInventoryUpdateStockPostRequest,
  ApiProductsCategoriesListPostRequest,
  ApiProductsCategoriesPostRequest,
  ApiProductsGroupsPostRequest,
  ApiProductsListPostRequest,
  ApiProductsPostRequest,
  ApiProductsProductModelsListPostRequest,
  ApiProductsProductModelsPostRequest,
  ApiProductsProductNamesListPostRequest,
  ApiProductsProductNamesPostRequest,
  ApiSalesPostRequest,
  ApiSellerDashboardPendingShipmentsGet200Response,
  ApiSellerDashboardPendingShipmentsGet200ResponseData,
  ApiSellerDashboardStatsGet200Response,
  ApiSellerDashboardStatsGet200ResponseData,
  ApiSellerShipmentsGet200Response,
  ApiSellerShipmentsGet200ResponseDataInner,
  ApiSellerShipmentsGet200ResponseDataInnerItemsInner,
  ApiShipmentsGet200Response,
  ApiShipmentsGet200ResponseDataInner,
  ApiShipmentsGet200ResponseDataInnerSeller,
  ApiShipmentsIdGet200Response,
  ApiShipmentsIdGet200ResponseData,
  ApiShipmentsIdGet200ResponseDataItemsInner,
  ApiShipmentsIdGet200ResponseDataSeller,
  ApiShipmentsPostRequest,
  ApiShipmentsPostRequestItemsInner,
  ApiTransfersPostRequest,
  ApiTransfersPostRequestItemsInner,
  Category,
  Customer,
  Error,
  InventoryTransaction,
  Product,
  ProductModel,
  ProductName,
  ProductUnit,
  ReturnProduct,
  SalesTransaction,
  Shipment,
  ShipmentItem,
  StockRequest,
  StockRequestItem,
  User,
])
Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(Customer)]),
        () => ListBuilder<Customer>(),
      )
      ..add(const OneOfSerializer())
      ..add(const AnyOfSerializer())
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer())
    ).build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
