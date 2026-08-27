const ngrok = require('@ngrok/ngrok');
const fs = require('fs');
const path = require('path');

// Simple .env parser if available
try {
  const envPath = path.join(__dirname, '../backend/.env');
  if (fs.existsSync(envPath)) {
    const envContent = fs.readFileSync(envPath, 'utf8');
    envContent.split('\n').forEach(line => {
      const match = line.match(/^\s*([\w_]+)\s*=\s*(.*)?\s*$/);
      if (match && !process.env[match[1]]) {
        process.env[match[1]] = match[2] ? match[2].trim().replace(/^["'](.*)["']$/, '$1') : '';
      }
    });
  }
} catch (_) {}

const PORT = process.env.PORT || 3000;
const DOMAIN = process.env.NGROK_DOMAIN || 'flannels-battering-paralyses.ngrok-free.dev';
const AUTHTOKEN = process.env.NGROK_AUTHTOKEN || '3FSUKxTw7hVLs2aBeF1wLoPGxLU_X6XiMfU7zDDSgKZNgVni';

async function startTunnel() {
  try {
    console.log(`Starting ngrok tunnel forwarding to port ${PORT}...`);
    const listener = await ngrok.forward({
      addr: PORT,
      domain: DOMAIN,
      authtoken: AUTHTOKEN
    });

    console.log(`\n======================================================`);
    console.log(` Status:       Tunnel online`);
    console.log(` Public URL:   ${listener.url()}`);
    console.log(` Forwarding:   http://localhost:${PORT}`);
    console.log(` Web UI:       http://127.0.0.1:4040`);
    console.log(` Press Ctrl+C to stop.`);
    console.log(`======================================================\n`);

    // Keep Node process running until killed
    const keepAlive = setInterval(() => {}, 1000 * 60 * 60);

    const cleanup = async () => {
      clearInterval(keepAlive);
      try {
        await listener.close();
      } catch (_) {}
      process.exit(0);
    };

    process.on('SIGINT', cleanup);
    process.on('SIGTERM', cleanup);
  } catch (error) {
    console.error('Failed to start ngrok tunnel:', error.message || error);
    process.exit(1);
  }
}

startTunnel();
