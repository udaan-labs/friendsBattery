const {
  APP_LATEST_VERSION,
  APP_MAINTENANCE,
  APP_STATUS_MESSAGE,
  APP_ANDROID_UPDATE_URL,
} = require('../../config/env');

class AppService {
  getStatus() {
    return {
      latest_version: APP_LATEST_VERSION,
      maintenance: APP_MAINTENANCE,
      message: APP_STATUS_MESSAGE || null,
      android_update_url: APP_ANDROID_UPDATE_URL || null,
    };
  }
}

module.exports = new AppService();
