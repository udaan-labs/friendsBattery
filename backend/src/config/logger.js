const logInfo = (message, ...optionalParams) => {
  console.info(`[INFO] ${new Date().toISOString()} - ${message}`, ...optionalParams);
};

const logError = (message, ...optionalParams) => {
  console.error(`[ERROR] ${new Date().toISOString()} - ${message}`, ...optionalParams);
};

const logWarn = (message, ...optionalParams) => {
  console.warn(`[WARN] ${new Date().toISOString()} - ${message}`, ...optionalParams);
};

module.exports = {
  logInfo,
  logError,
  logWarn
};
