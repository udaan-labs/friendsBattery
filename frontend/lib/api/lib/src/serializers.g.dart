// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializers.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers =
    (Serializers().toBuilder()
          ..add(AccountUser.serializer)
          ..add(AccountUserLocation.serializer)
          ..add(AccountUserRoleEnum.serializer)
          ..add(AccountUsersResponse.serializer)
          ..add(ActivityHistoryPagination.serializer)
          ..add(ActivityHistoryResponse.serializer)
          ..add(ActivityItem.serializer)
          ..add(AdjustInventoryRequest.serializer)
          ..add(AdjustInventoryResponse.serializer)
          ..add(AdjustInventoryResult.serializer)
          ..add(AdminDashboardStats.serializer)
          ..add(AdminDashboardStatsResponse.serializer)
          ..add(AdminEmployeeDetailData.serializer)
          ..add(AdminEmployeeDetailDataCurrentAttendance.serializer)
          ..add(AdminEmployeeDetailResponse.serializer)
          ..add(AdminSaleHistoryPage.serializer)
          ..add(AdminSaleHistoryResponse.serializer)
          ..add(AdminSaleRecord.serializer)
          ..add(AdminSaleShipment.serializer)
          ..add(ApiAuthActivatePutRequest.serializer)
          ..add(ApiAuthLoginPostRequest.serializer)
          ..add(ApiAuthRegisterPostRequest.serializer)
          ..add(ApiAuthVerifyOtpPostRequest.serializer)
          ..add(ApiDashboardStatsGet200Response.serializer)
          ..add(ApiEmployeeAttendanceCheckInPost201Response.serializer)
          ..add(ApiEmployeeAttendanceCheckedInGet200Response.serializer)
          ..add(
            ApiEmployeeAttendanceCheckedInGet200ResponseDataInner.serializer,
          )
          ..add(ApiEmployeeAttendanceStatusGet200Response.serializer)
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
          ..add(ApiInventoryTransferPostRequest.serializer)
          ..add(ApiInventoryTransferPostRequestProductsInner.serializer)
          ..add(ApiSellerDashboardPendingShipmentsGet200Response.serializer)
          ..add(ApiSellerDashboardPendingShipmentsGet200ResponseData.serializer)
          ..add(ApiSellerDashboardStatsGet200Response.serializer)
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
          ..add(ApiTransfersPostRequest.serializer)
          ..add(ApiTransfersPostRequestItemsInner.serializer)
          ..add(AppStatus.serializer)
          ..add(AppStatusResponse.serializer)
          ..add(AssignedLocation.serializer)
          ..add(AttendanceGeoBody.serializer)
          ..add(AttendanceRecord.serializer)
          ..add(AttendanceRecordStatusEnum.serializer)
          ..add(AttendanceStatusData.serializer)
          ..add(AvailableSerialsResponse.serializer)
          ..add(CreateEmployeeRequest.serializer)
          ..add(CreateEmployeeResponse.serializer)
          ..add(CreateLocationRequest.serializer)
          ..add(CreateLocationRequestTypeEnum.serializer)
          ..add(CreateLocationResponse.serializer)
          ..add(CreateProductModelRequest.serializer)
          ..add(CreateProductNameRequest.serializer)
          ..add(CreateProductRequest.serializer)
          ..add(CreateProductResponse.serializer)
          ..add(CreateRentRequest.serializer)
          ..add(CreateRentResponse.serializer)
          ..add(CreateRentResult.serializer)
          ..add(CreateReturnRequest.serializer)
          ..add(CreateReturnResponse.serializer)
          ..add(CreateReturnResult.serializer)
          ..add(CreateSaleRequest.serializer)
          ..add(CreateSaleRequestSaleTypeEnum.serializer)
          ..add(CreateSaleResponse.serializer)
          ..add(CreateSaleResult.serializer)
          ..add(CreateServiceBillRequest.serializer)
          ..add(CreateServiceBillRequestServiceTypeEnum.serializer)
          ..add(CreateServiceBillResponse.serializer)
          ..add(CreateServiceBillResult.serializer)
          ..add(CreateShipmentItem.serializer)
          ..add(CreateShipmentRequest.serializer)
          ..add(CreateShipmentResponse.serializer)
          ..add(CreateShipmentResult.serializer)
          ..add(CreateShipmentResultStatusEnum.serializer)
          ..add(CreatedEmployee.serializer)
          ..add(CreatedEmployeeLocation.serializer)
          ..add(CreatedEmployeeLocationTypeEnum.serializer)
          ..add(CreatedEmployeeRoleEnum.serializer)
          ..add(EmployeeAction.serializer)
          ..add(EmployeeActionActionEnum.serializer)
          ..add(EmployeeActionLocation.serializer)
          ..add(EmployeeRoleItem.serializer)
          ..add(EmployeeRolesResponse.serializer)
          ..add(Error.serializer)
          ..add(HealthStatus.serializer)
          ..add(InventoryItemDetail.serializer)
          ..add(InventoryItemDetailResponse.serializer)
          ..add(InventoryListItem.serializer)
          ..add(InventoryListPayload.serializer)
          ..add(InventoryListResponse.serializer)
          ..add(InventoryPagination.serializer)
          ..add(InventoryProductModelOption.serializer)
          ..add(InventoryProductNameGroup.serializer)
          ..add(InventoryProductsResponse.serializer)
          ..add(InventoryTransaction.serializer)
          ..add(InventoryTransactionActionEnum.serializer)
          ..add(ListProductModelsRequest.serializer)
          ..add(ListProductsRequest.serializer)
          ..add(ListProductsResponse.serializer)
          ..add(LocationItem.serializer)
          ..add(LocationItemTypeEnum.serializer)
          ..add(LocationsListResponse.serializer)
          ..add(LoginData.serializer)
          ..add(LoginOtpChallengeData.serializer)
          ..add(LoginOtpChallengeResponse.serializer)
          ..add(LoginResponse.serializer)
          ..add(LoginUser.serializer)
          ..add(LoginUserEmployeeRole.serializer)
          ..add(LoginUserLocation.serializer)
          ..add(LoginUserLocationTypeEnum.serializer)
          ..add(LoginUserRoleEnum.serializer)
          ..add(NextEmployeeUserIdData.serializer)
          ..add(NextEmployeeUserIdResponse.serializer)
          ..add(Product.serializer)
          ..add(ProductConfigItem.serializer)
          ..add(ProductCreated.serializer)
          ..add(ProductModel.serializer)
          ..add(ProductModelResponse.serializer)
          ..add(ProductModelsResponse.serializer)
          ..add(ProductName.serializer)
          ..add(ProductNameResponse.serializer)
          ..add(ProductNamesResponse.serializer)
          ..add(ProductStockDetails.serializer)
          ..add(ProductStockDetailsResponse.serializer)
          ..add(ProductUnit.serializer)
          ..add(ProductUnitStatusEnum.serializer)
          ..add(RecentActivityResponse.serializer)
          ..add(RegisterData.serializer)
          ..add(RegisterResponse.serializer)
          ..add(ReturnListItem.serializer)
          ..add(ReturnListProduct.serializer)
          ..add(ReturnListProductModel.serializer)
          ..add(ReturnListProductName.serializer)
          ..add(ReturnProduct.serializer)
          ..add(ReturnRentRequest.serializer)
          ..add(ReturnRentResponse.serializer)
          ..add(ReturnRentResult.serializer)
          ..add(ReturnsListResponse.serializer)
          ..add(SaleCustomer.serializer)
          ..add(SaleDetailResponse.serializer)
          ..add(SaleHistoryPage.serializer)
          ..add(SaleHistoryResponse.serializer)
          ..add(SaleProduct.serializer)
          ..add(SaleRecord.serializer)
          ..add(SaleSeller.serializer)
          ..add(SalesTransaction.serializer)
          ..add(ScanForSaleResponse.serializer)
          ..add(ScanForSaleResult.serializer)
          ..add(SellerDashboardStats.serializer)
          ..add(SellerDashboardStatsResponse.serializer)
          ..add(SellerDetail.serializer)
          ..add(SellerDetailLocation.serializer)
          ..add(SellerDetailResponse.serializer)
          ..add(SellerRecentSale.serializer)
          ..add(SellerShipmentListItem.serializer)
          ..add(SellerShipmentListItemItemsInner.serializer)
          ..add(SellerShipmentsListResponse.serializer)
          ..add(SellerShopSummary.serializer)
          ..add(SellerStatistics.serializer)
          ..add(SellersListResponse.serializer)
          ..add(SetAccountActiveData.serializer)
          ..add(SetAccountActiveDataRoleEnum.serializer)
          ..add(SetAccountActiveRequest.serializer)
          ..add(SetAccountActiveResponse.serializer)
          ..add(Shipment.serializer)
          ..add(ShipmentItem.serializer)
          ..add(ShipmentStatusEnum.serializer)
          ..add(ShopStaffData.serializer)
          ..add(ShopStaffMember.serializer)
          ..add(ShopStaffMemberRoleEnum.serializer)
          ..add(ShopStaffResponse.serializer)
          ..add(TransferEmployeeRequest.serializer)
          ..add(TransferEmployeeResponse.serializer)
          ..add(TransferInventoryCount.serializer)
          ..add(UpdateLocationRequest.serializer)
          ..add(UpdateLocationResponse.serializer)
          ..add(UpdateStockRequest.serializer)
          ..add(UpdateStockResponse.serializer)
          ..add(UpdateStockResult.serializer)
          ..add(User.serializer)
          ..add(UserRoleEnum.serializer)
          ..add(VerifyProductInfo.serializer)
          ..add(VerifyProductPayload.serializer)
          ..add(VerifyProductRequest.serializer)
          ..add(VerifyProductResponse.serializer)
          ..add(VerifyProductUnit.serializer)
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(AccountUser)]),
            () => ListBuilder<AccountUser>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(ActivityItem)]),
            () => ListBuilder<ActivityItem>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(ActivityItem)]),
            () => ListBuilder<ActivityItem>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(AdminSaleRecord)]),
            () => ListBuilder<AdminSaleRecord>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                ApiEmployeeAttendanceCheckedInGet200ResponseDataInner,
              ),
            ]),
            () =>
                ListBuilder<
                  ApiEmployeeAttendanceCheckedInGet200ResponseDataInner
                >(),
          )
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
              const FullType(ApiTransfersPostRequestItemsInner),
            ]),
            () => ListBuilder<ApiTransfersPostRequestItemsInner>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(CreateShipmentItem),
            ]),
            () => ListBuilder<CreateShipmentItem>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(EmployeeAction)]),
            () => ListBuilder<EmployeeAction>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(EmployeeRoleItem)]),
            () => ListBuilder<EmployeeRoleItem>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(InventoryListItem),
            ]),
            () => ListBuilder<InventoryListItem>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(InventoryListItem),
            ]),
            () => ListBuilder<InventoryListItem>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(InventoryProductModelOption),
            ]),
            () => ListBuilder<InventoryProductModelOption>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(InventoryProductNameGroup),
            ]),
            () => ListBuilder<InventoryProductNameGroup>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(JsonObject)]),
            () => ListBuilder<JsonObject>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(LocationItem)]),
            () => ListBuilder<LocationItem>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(ProductConfigItem),
            ]),
            () => ListBuilder<ProductConfigItem>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(ProductModel)]),
            () => ListBuilder<ProductModel>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(ProductName)]),
            () => ListBuilder<ProductName>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(ReturnListItem)]),
            () => ListBuilder<ReturnListItem>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(SaleRecord)]),
            () => ListBuilder<SaleRecord>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(SellerRecentSale)]),
            () => ListBuilder<SellerRecentSale>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(SellerShipmentListItem),
            ]),
            () => ListBuilder<SellerShipmentListItem>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(SellerShipmentListItemItemsInner),
            ]),
            () => ListBuilder<SellerShipmentListItemItemsInner>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(SellerShopSummary),
            ]),
            () => ListBuilder<SellerShopSummary>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(ShipmentItem)]),
            () => ListBuilder<ShipmentItem>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(ShopStaffMember)]),
            () => ListBuilder<ShopStaffMember>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(ShopStaffMember)]),
            () => ListBuilder<ShopStaffMember>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(ShopStaffMember)]),
            () => ListBuilder<ShopStaffMember>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(TransferInventoryCount),
            ]),
            () => ListBuilder<TransferInventoryCount>(),
          ))
        .build();

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
