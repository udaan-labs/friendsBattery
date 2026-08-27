require('dotenv').config();

const requiredEnvVars = ['PORT', 'DATABASE_URL', 'JWT_SECRET', 'JWT_EXPIRES_IN'];

for (const envVar of requiredEnvVars) {
  if (!process.env[envVar]) {
    throw new Error(`Missing required environment variable: ${envVar}`);
  }
}

function parseBool(value, defaultValue = false) {
  if (value === undefined || value === null || value === '') return defaultValue;
  return ['1', 'true', 'yes', 'on'].includes(String(value).trim().toLowerCase());
}

module.exports = {
  PORT: process.env.PORT,
  DATABASE_URL: process.env.DATABASE_URL,
  JWT_SECRET: process.env.JWT_SECRET,
  JWT_EXPIRES_IN: process.env.JWT_EXPIRES_IN,
  BASE_URL: process.env.BASE_URL || `http://localhost:${process.env.PORT || 3000}`,
  // App gate (version + maintenance) — optional; safe defaults for local dev
  APP_LATEST_VERSION: process.env.APP_LATEST_VERSION || '1.1.3',
  APP_MAINTENANCE: parseBool(process.env.APP_MAINTENANCE, false),
  APP_STATUS_MESSAGE: process.env.APP_STATUS_MESSAGE || null,
  APP_ANDROID_UPDATE_URL: process.env.APP_ANDROID_UPDATE_URL || null,
};
