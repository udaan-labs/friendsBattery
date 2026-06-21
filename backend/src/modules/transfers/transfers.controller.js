const transfersService = require('./transfers.service');
const { successResponse, errorResponse } = require('../../shared/utils/response');

/**
 * Transfers Controller
 *
 * Handles HTTP requests for the transfers (shipments) module.
 * Thin layer — delegates all business logic to the service.
 */
class TransfersController {
  /**
   * Create a new shipment from Admin to Seller
   *
   * Controller responsibility:
   * - Read request body
   * - Pass admin ID from req.user (never trust frontend)
   * - Delegate to service
   * - Return standardized response
   */
  async createTransfer(req, res) {
    try {
      const adminId = req.user.id;
      const result = await transfersService.createTransfer(req.body, adminId);
      return successResponse(res, 201, 'Shipment created successfully', result);
    } catch (error) {
      if (error.statusCode) {
        return errorResponse(res, error.statusCode, error.message);
      }
      console.error('Create Transfer Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }

  /**
   * Get all shipments
   *
   * Controller responsibility:
   * - Pass authenticated user to service (role-based filtering happens in service)
   * - Return standardized response
   */
  async getTransfers(req, res) {
    try {
      const transfers = await transfersService.getTransfers(req.user);
      return successResponse(res, 200, 'Shipments fetched successfully', transfers);
    } catch (error) {
      console.error('Get Transfers Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }

  /**
   * Get complete shipment details by ID
   *
   * Controller responsibility:
   * - Read shipmentId from params
   * - Pass user for authorization check in service
   * - Return standardized response
   */
  async getTransferById(req, res) {
    try {
      const { shipmentId } = req.params;
      const transfer = await transfersService.getTransferById(Number(shipmentId), req.user);
      return successResponse(res, 200, 'Shipment details fetched successfully', transfer);
    } catch (error) {
      if (error.statusCode) {
        return errorResponse(res, error.statusCode, error.message);
      }
      console.error('Get Transfer By ID Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }

  /**
   * Receive a shipment (Seller confirms delivery)
   *
   * Controller responsibility:
   * - Read shipmentId from params
   * - Pass authenticated seller ID from req.user (never trust frontend)
   * - Return standardized response
   */
  async receiveTransfer(req, res) {
    try {
      const { shipmentId } = req.params;
      const sellerId = req.user.id;
      const result = await transfersService.receiveTransfer(Number(shipmentId), sellerId);
      return successResponse(res, 200, 'Shipment received successfully', result);
    } catch (error) {
      if (error.statusCode) {
        return errorResponse(res, error.statusCode, error.message);
      }
      console.error('Receive Transfer Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }

  /**
   * Cancel a shipment (Admin only)
   *
   * Controller responsibility:
   * - Read shipmentId from params
   * - Delegate to service
   * - Return standardized response
   */
  async cancelTransfer(req, res) {
    try {
      const { shipmentId } = req.params;
      const result = await transfersService.cancelTransfer(Number(shipmentId));
      return successResponse(res, 200, 'Shipment cancelled successfully', result);
    } catch (error) {
      if (error.statusCode) {
        return errorResponse(res, error.statusCode, error.message);
      }
      console.error('Cancel Transfer Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }
}

module.exports = new TransfersController();
