const shipmentsService = require('./shipments.service');
const { successResponse, errorResponse } = require('../../shared/utils/response');

class ShipmentsController {
  async createShipment(req, res) {
    try {
      const adminId = Number(req.user.id);
      const result = await shipmentsService.createShipment(req.body, adminId);
      return successResponse(res, 201, 'Shipment created successfully', result);
    } catch (error) {
      if (error.statusCode) {
        return errorResponse(res, error.statusCode, error.message);
      }
      console.error('Create Shipment Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }

  async getPendingShipmentsCount(req, res) {
    try {
      const sellerId = Number(req.user.id);
      const result = await shipmentsService.getPendingShipmentsCount(sellerId);
      return successResponse(res, 200, 'Pending shipments count retrieved successfully', result);
    } catch (error) {
      console.error('Get Pending Shipments Count Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }

  async getShipments(req, res) {
    try {
      const sellerId = Number(req.user.id);
      const result = await shipmentsService.getShipments(sellerId);
      return successResponse(res, 200, 'Seller shipments retrieved successfully', result);
    } catch (error) {
      console.error('Get Shipments Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }

  async acceptShipment(req, res) {
    try {
      const sellerId = Number(req.user.id);
      const shipmentId = Number(req.params.shipmentId);
      const result = await shipmentsService.acceptShipment(shipmentId, sellerId);
      return successResponse(res, 200, 'Shipment accepted successfully', result);
    } catch (error) {
      if (error.statusCode) {
        return errorResponse(res, error.statusCode, error.message);
      }
      console.error('Accept Shipment Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }
}

module.exports = new ShipmentsController();
