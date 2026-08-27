/**
 * Run: npm test  (from backend/)
 * Pure geofence math — no DB, no GPS hardware.
 */
const { describe, it } = require('node:test');
const assert = require('node:assert/strict');
const { distanceMeters, normalizeGeoBody } = require('./geo.util');

// Seeded warehouse-style pin from product docs
const SHOP = { lat: 23.0225, lng: 72.5714 };
const NEAR = { lat: 23.0228, lng: 72.5718 }; // ~45–55m
const FAR = { lat: 23.04, lng: 72.59 }; // several km

describe('distanceMeters', () => {
  it('same point is 0', () => {
    assert.equal(distanceMeters(SHOP.lat, SHOP.lng, SHOP.lat, SHOP.lng), 0);
  });

  it('near shop is within ~100m (example ~45m)', () => {
    const m = distanceMeters(SHOP.lat, SHOP.lng, NEAR.lat, NEAR.lng);
    assert.ok(m > 30 && m < 80, `expected ~45m, got ${m}`);
    assert.ok(m <= 100, 'should pass 100m geofence');
  });

  it('far point is outside 100m', () => {
    const m = distanceMeters(SHOP.lat, SHOP.lng, FAR.lat, FAR.lng);
    assert.ok(m > 1000, `expected >1km, got ${m}`);
  });
});

describe('normalizeGeoBody', () => {
  it('prefers lat/lng when both sets present', () => {
    const g = normalizeGeoBody({
      lat: 1,
      lng: 2,
      latitude: 9,
      longitude: 8,
      accuracy: 5,
      timestamp: '2026-01-01T00:00:00.000Z',
    });
    assert.equal(g.lat, 1);
    assert.equal(g.lng, 2);
    assert.equal(g.accuracy, 5);
    assert.equal(g.timestamp, '2026-01-01T00:00:00.000Z');
  });

  it('falls back to latitude/longitude', () => {
    const g = normalizeGeoBody({ latitude: 23.0, longitude: 72.5 });
    assert.equal(g.lat, 23.0);
    assert.equal(g.lng, 72.5);
  });

  it('empty body → null coords', () => {
    const g = normalizeGeoBody({});
    assert.equal(g.lat, null);
    assert.equal(g.lng, null);
  });
});

describe('geofence gate (contract used by attendance.service)', () => {
  function within(loc, lat, lng) {
    if (lat == null || lng == null || Number.isNaN(lat) || Number.isNaN(lng)) {
      return { ok: false, reason: 'coords' };
    }
    if (loc.latitude == null || loc.longitude == null) {
      return { ok: false, reason: 'loc' };
    }
    const radius = loc.allowedRadius != null ? Number(loc.allowedRadius) : 100;
    const meters = distanceMeters(lat, lng, Number(loc.latitude), Number(loc.longitude));
    return { ok: meters <= radius, meters, radius };
  }

  const location = {
    latitude: SHOP.lat,
    longitude: SHOP.lng,
    allowedRadius: 100,
  };

  it('allows near employee', () => {
    const r = within(location, NEAR.lat, NEAR.lng);
    assert.equal(r.ok, true);
  });

  it('blocks far employee', () => {
    const r = within(location, FAR.lat, FAR.lng);
    assert.equal(r.ok, false);
  });

  it('blocks missing GPS', () => {
    assert.equal(within(location, null, null).ok, false);
  });

  it('blocks unconfigured location coords', () => {
    assert.equal(
      within({ latitude: null, longitude: null, allowedRadius: 100 }, NEAR.lat, NEAR.lng)
        .ok,
      false
    );
  });

  it('uses default radius 100 when omitted', () => {
    const r = within(
      { latitude: SHOP.lat, longitude: SHOP.lng },
      NEAR.lat,
      NEAR.lng
    );
    assert.equal(r.ok, true);
    assert.equal(r.radius, 100);
  });
});
