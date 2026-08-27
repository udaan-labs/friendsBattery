/**
 * Send OTP SMS via Fast2SMS Quick SMS.
 * Env: FAST2SMS_API_KEY — when empty, SMS is skipped (dev); OTP is logged + echoed by auth.
 * ponytail: DLT template route later if Quick SMS / compliance needs it.
 */
const { httpError } = require('../../shared/utils/http-error');

function normalizeIndiaMobile(raw) {
  if (raw == null) return null;
  let s = String(raw).replace(/\D/g, '');
  if (s.startsWith('91') && s.length === 12) s = s.slice(2);
  if (s.length !== 10) return null;
  return s;
}

/**
 * @returns {Promise<{ skipped: boolean }>}
 */
async function sendOtpSms({ phone, code, purpose }) {
  const apiKey = process.env.FAST2SMS_API_KEY?.trim();
  if (!apiKey) {
    // Dev bypass: no provider configured — do not block login.
    console.warn(
      `[SMS] FAST2SMS_API_KEY not set — skipping SMS. OTP=${code} purpose=${purpose || 'n/a'}`
    );
    return { skipped: true };
  }

  const mobile = normalizeIndiaMobile(phone);
  if (!mobile) {
    throw httpError(400, 'Account has no valid 10-digit mobile number for OTP');
  }

  const label = purpose === 'login' ? 'login' : purpose || 'verification';
  const message = `FriendsBattery ${label} OTP is ${code}. Valid for 5 minutes. Do not share with anyone.`;

  let res;
  try {
    res = await fetch('https://www.fast2sms.com/dev/bulkV2', {
      method: 'POST',
      headers: {
        Authorization: apiKey,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ route: 'q', message, numbers: mobile }),
    });
  } catch (err) {
    console.error('[SMS] network error', err.message);
    throw httpError(502, 'Failed to reach SMS provider');
  }

  const data = await res.json().catch(() => ({}));
  if (data.return === false || !(data.return === true || data.return === 'true' || res.ok)) {
    const msg =
      (Array.isArray(data.message) ? data.message.join(', ') : data.message) ||
      data.error ||
      `SMS provider error (${res.status})`;
    console.error('[SMS] send failed', data);
    throw httpError(502, `SMS failed: ${msg}`);
  }

  console.log(`[SMS] OTP sent ****${mobile.slice(-4)} id=${data.request_id || 'n/a'}`);
  return { skipped: false };
}

module.exports = { sendOtpSms, normalizeIndiaMobile };
