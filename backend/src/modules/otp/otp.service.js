/**
 * Login OTP challenges (in-memory).
 * ponytail: single-process only — DB/Redis if multi-instance.
 */
const crypto = require('crypto');
const { httpError } = require('../../shared/utils/http-error');

const TTL_MS = 5 * 60 * 1000;
const MAX_ATTEMPTS = 5;

/** @type {Map<string, { purpose: string, subject: string, code: string, meta: object, expiresAt: number, attempts: number }>} */
const store = new Map();

function purgeExpired() {
  const now = Date.now();
  for (const [id, row] of store) {
    if (row.expiresAt <= now) store.delete(id);
  }
}

function maskPhone(phone) {
  if (!phone || String(phone).length < 4) return '****';
  const s = String(phone);
  return `${'*'.repeat(Math.max(0, s.length - 4))}${s.slice(-4)}`;
}

function createChallenge({ purpose, subject, meta = {} }) {
  purgeExpired();
  if (!purpose || !subject) {
    throw httpError(400, 'OTP purpose and subject are required');
  }

  for (const [id, row] of store) {
    if (row.purpose === purpose && row.subject === subject) store.delete(id);
  }

  const challengeId = crypto.randomUUID();
  const code = String(crypto.randomInt(100000, 999999));
  store.set(challengeId, {
    purpose: String(purpose),
    subject: String(subject),
    code,
    meta: meta || {},
    expiresAt: Date.now() + TTL_MS,
    attempts: 0,
  });

  return {
    challengeId,
    code,
    expiresIn: Math.floor(TTL_MS / 1000),
  };
}

function verifyChallenge({ challengeId, code, purpose }) {
  purgeExpired();
  if (!challengeId || !code) {
    throw httpError(400, 'challenge_id and otp are required');
  }

  const row = store.get(challengeId);
  if (!row) {
    throw httpError(401, 'OTP expired or invalid. Request a new one.');
  }
  if (purpose && row.purpose !== purpose) {
    throw httpError(401, 'OTP purpose mismatch');
  }
  if (row.expiresAt <= Date.now()) {
    store.delete(challengeId);
    throw httpError(401, 'OTP expired. Request a new one.');
  }

  row.attempts += 1;
  if (row.attempts > MAX_ATTEMPTS) {
    store.delete(challengeId);
    throw httpError(403, 'Too many OTP attempts. Request a new one.');
  }

  if (String(code).trim() !== row.code) {
    throw httpError(401, 'Invalid OTP');
  }

  store.delete(challengeId);
  return {
    purpose: row.purpose,
    subject: row.subject,
    meta: row.meta,
  };
}

/** Echo OTP unless SKIP_LOGIN_OTP=0. Set SKIP_LOGIN_OTP=0 to require SMS OTP UI. */
function shouldEchoOtp() {
  const skip = process.env.SKIP_LOGIN_OTP;
  if (skip === '0' || skip === 'false') return false;
  return true;
}

module.exports = {
  createChallenge,
  verifyChallenge,
  maskPhone,
  shouldEchoOtp,
  TTL_MS,
};
