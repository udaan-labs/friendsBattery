const returnService = require('./returns.service');
const { successResponse } = require('../../shared/utils/response');

const createReturn = async (req, res, next) => {
  try {
    const returnReq = await returnService.createReturn(req.body);
    return successResponse(res, 201, 'Return request created', returnReq);
  } catch (error) { next(error); }
};

const updateReturnStatus = async (req, res, next) => {
  try {
    const returnReq = await returnService.updateReturnStatus(req.params.id, req.body.status, req.user.id);
    return successResponse(res, 200, 'Return status updated', returnReq);
  } catch (error) { next(error); }
};

const processReplacement = async (req, res, next) => {
  try {
    if (!req.user.shop_id) {
        const err = new Error('User does not belong to a shop');
        err.statusCode = 403;
        throw err;
    }
    const result = await returnService.processReplacement(
      req.params.id,
      req.body.newProductUnitId,
      req.user.id,
      req.user.shop_id
    );
    return successResponse(res, 200, 'Replacement processed successfully', result);
  } catch (error) { next(error); }
};

module.exports = {
  createReturn,
  updateReturnStatus,
  processReplacement
};
