// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializers.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers =
    (Serializers().toBuilder()
          ..add(ApiAuthActivatePutRequest.serializer)
          ..add(ApiAuthLoginPostRequest.serializer)
          ..add(ApiAuthRegisterPostRequest.serializer)
          ..add(ApiDashboardStatsGet200Response.serializer)
          ..add(ApiDashboardStatsGet200ResponseData.serializer)
          ..add(ApiInventoryAdjustPatchRequest.serializer)
          ..add(ApiInventoryDetailsGet200Response.serializer)
          ..add(ApiInventoryDetailsGet200ResponseData.serializer)
          ..add(ApiInventoryDetailsGet200ResponseDataCategoriesInner.serializer)
          ..add(
            ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner
                .serializer,
          )
          ..add(
            ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner
                .serializer,
          )
          ..add(ApiInventoryDetailsGet200ResponseDataPagination.serializer)
          ..add(ApiInventoryProductIdGet200Response.serializer)
          ..add(ApiInventoryProductIdGet200ResponseData.serializer)
          ..add(ApiInventoryTransferPostRequest.serializer)
          ..add(ApiInventoryTransferPostRequestProductsInner.serializer)
          ..add(ApiInventoryUpdateStockPostRequest.serializer)
          ..add(ApiProductsListPostRequest.serializer)
          ..add(ApiProductsPostRequest.serializer)
          ..add(ApiProductsProductModelsListPostRequest.serializer)
          ..add(ApiProductsProductModelsPostRequest.serializer)
          ..add(ApiProductsProductNamesPostRequest.serializer)
          ..add(ApiSalesPostRequest.serializer)
          ..add(ApiSellerDashboardPendingShipmentsGet200Response.serializer)
          ..add(ApiSellerDashboardPendingShipmentsGet200ResponseData.serializer)
          ..add(ApiSellerDashboardStatsGet200Response.serializer)
          ..add(ApiSellerDashboardStatsGet200ResponseData.serializer)
          ..add(ApiSellerShipmentsGet200Response.serializer)
          ..add(ApiSellerShipmentsGet200ResponseDataInner.serializer)
          ..add(ApiSellerShipmentsGet200ResponseDataInnerItemsInner.serializer)
          ..add(ApiShipmentsGet200Response.serializer)
          ..add(ApiShipmentsGet200ResponseDataInner.serializer)
          ..add(ApiShipmentsGet200ResponseDataInnerSeller.serializer)
          ..add(ApiShipmentsIdGet200Response.serializer)
          ..add(ApiShipmentsIdGet200ResponseData.serializer)
          ..add(ApiShipmentsIdGet200ResponseDataItemsInner.serializer)
          ..add(ApiShipmentsIdGet200ResponseDataSeller.serializer)
          ..add(ApiShipmentsPostRequest.serializer)
          ..add(ApiShipmentsPostRequestItemsInner.serializer)
          ..add(ApiTransfersPostRequest.serializer)
          ..add(ApiTransfersPostRequestItemsInner.serializer)
          ..add(Category.serializer)
          ..add(Customer.serializer)
          ..add(Error.serializer)
          ..add(InventoryTransaction.serializer)
          ..add(InventoryTransactionActionEnum.serializer)
          ..add(Product.serializer)
          ..add(ProductModel.serializer)
          ..add(ProductName.serializer)
          ..add(ProductUnit.serializer)
          ..add(ProductUnitStatusEnum.serializer)
          ..add(ReturnProduct.serializer)
          ..add(SalesTransaction.serializer)
          ..add(Shipment.serializer)
          ..add(ShipmentItem.serializer)
          ..add(ShipmentStatusEnum.serializer)
          ..add(StockRequest.serializer)
          ..add(StockRequestItem.serializer)
          ..add(StockRequestStatusEnum.serializer)
          ..add(User.serializer)
          ..add(UserRoleEnum.serializer)
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                ApiInventoryDetailsGet200ResponseDataCategoriesInner,
              ),
            ]),
            () =>
                ListBuilder<
                  ApiInventoryDetailsGet200ResponseDataCategoriesInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner,
              ),
            ]),
            () =>
                ListBuilder<
                  ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner,
              ),
            ]),
            () =>
                ListBuilder<
                  ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(ApiInventoryTransferPostRequestProductsInner),
            ]),
            () => ListBuilder<ApiInventoryTransferPostRequestProductsInner>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(ApiSellerShipmentsGet200ResponseDataInner),
            ]),
            () => ListBuilder<ApiSellerShipmentsGet200ResponseDataInner>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                ApiSellerShipmentsGet200ResponseDataInnerItemsInner,
              ),
            ]),
            () =>
                ListBuilder<
                  ApiSellerShipmentsGet200ResponseDataInnerItemsInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(ApiShipmentsGet200ResponseDataInner),
            ]),
            () => ListBuilder<ApiShipmentsGet200ResponseDataInner>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(ApiShipmentsIdGet200ResponseDataItemsInner),
            ]),
            () => ListBuilder<ApiShipmentsIdGet200ResponseDataItemsInner>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(ApiShipmentsPostRequestItemsInner),
            ]),
            () => ListBuilder<ApiShipmentsPostRequestItemsInner>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(ApiTransfersPostRequestItemsInner),
            ]),
            () => ListBuilder<ApiTransfersPostRequestItemsInner>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(JsonObject)]),
            () => ListBuilder<JsonObject>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(ShipmentItem)]),
            () => ListBuilder<ShipmentItem>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(StockRequestItem)]),
            () => ListBuilder<StockRequestItem>(),
          ))
        .build();

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
