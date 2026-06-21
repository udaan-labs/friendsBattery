const checkHealth = async () => {
  return {
    status: 'ok',
    message: 'API is up and running via Cloudflare Tunnel',
    timestamp: new Date().toISOString()
  };
};

module.exports = {
  checkHealth
};
