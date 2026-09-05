const shipmentsService = require('./shipments.service');
const { successResponse } = require('../../shared/utils/response');
const { handleRouteError } = require('../../shared/utils/handle-route-error');

class ShipmentsController {
  async createShipment(req, res) {
    try {
      const adminId = Number(req.user.id);
      const result = await shipmentsService.createShipment(req.body, adminId, req.user);
      return successResponse(
        res,
        201,
        `Shipment created with ${result.transferredUnits} unit(s)`,
        result
      );
    } catch (error) {
      return handleRouteError(res, error, 'Create Shipment Error:');
    }
  }

  async getPendingShipmentsCount(req, res) {
    try {
      const sellerId = Number(req.user.id);
      const result = await shipmentsService.getPendingShipmentsCount(sellerId);
      return successResponse(res, 200, 'Pending shipments count retrieved successfully', result);
    } catch (error) {
      return handleRouteError(res, error, 'Get Pending Shipments Count Error:');
    }
  }

  async getShipments(req, res) {
    try {
      const sellerId = Number(req.user.id);
      const result = await shipmentsService.getShipments(sellerId);
      return successResponse(res, 200, 'Seller shipments retrieved successfully', result);
    } catch (error) {
      return handleRouteError(res, error, 'Get Shipments Error:');
    }
  }

  /**
   * GET /api/employee/shipments — shop location shipments (read-only).
   */
  async getEmployeeShipments(req, res) {
    try {
      const locationId = req.user.locationId ?? null;
      const result = await shipmentsService.getShipmentsForEmployeeLocation(locationId);
      return successResponse(res, 200, 'Shop shipments retrieved successfully', result);
    } catch (error) {
      return handleRouteError(res, error, 'Get Employee Shipments Error:');
    }
  }

  /**
   * GET /api/shipments — Admin: list all shipments.
   */
  async getAllShipments(req, res) {
    try {
      const result = await shipmentsService.getAllShipments(req.user);
      return successResponse(res, 200, 'All shipments retrieved successfully', result);
    } catch (error) {
      return handleRouteError(res, error, 'Get All Shipments Error:');
    }
  }

  /**
   * GET /api/shipments/:id — Admin or Seller: get shipment detail.
   */
  async getShipmentById(req, res) {
    try {
      const userId = Number(req.user.id);
      const userRole = req.user.role; // ADMIN | SELLER | EMPLOYEE
      const shipmentId = Number(req.params.id);
      const locationId = req.user.locationId ?? null;

      const result = await shipmentsService.getShipmentById(
        shipmentId,
        userId,
        userRole,
        locationId
      );
      return successResponse(res, 200, 'Shipment retrieved successfully', result);
    } catch (error) {
      return handleRouteError(res, error, 'Get Shipment By ID Error:');
    }
  }

  async acceptShipment(req, res) {
    try {
      const sellerId = Number(req.user.id);
      const shipmentId = Number(req.params.shipmentId);
      const result = await shipmentsService.acceptShipment(shipmentId, sellerId);
      return successResponse(res, 200, 'Shipment accepted successfully', result);
    } catch (error) {
      return handleRouteError(res, error, 'Accept Shipment Error:');
    }
  }
}

module.exports = new ShipmentsController();
