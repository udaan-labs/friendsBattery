/** Haversine distance in meters (same idea as Geolocator.distanceBetween). */
function distanceMeters(lat1, lon1, lat2, lon2) {
  const toRad = (d) => (Number(d) * Math.PI) / 180;
  const R = 6371000;
  const φ1 = toRad(lat1);
  const φ2 = toRad(lat2);
  const Δφ = toRad(Number(lat2) - Number(lat1));
  const Δλ = toRad(Number(lon2) - Number(lon1));
  const a =
    Math.sin(Δφ / 2) * Math.sin(Δφ / 2) +
    Math.cos(φ1) * Math.cos(φ2) * Math.sin(Δλ / 2) * Math.sin(Δλ / 2);
  return 2 * R * Math.asin(Math.min(1, Math.sqrt(a)));
}

/** Accept lat/lng or latitude/longitude. */
function normalizeGeoBody(body = {}) {
  const lat =
    body.lat != null
      ? Number(body.lat)
      : body.latitude != null
        ? Number(body.latitude)
        : null;
  const lng =
    body.lng != null
      ? Number(body.lng)
      : body.longitude != null
        ? Number(body.longitude)
        : null;
  const accuracy = body.accuracy != null ? Number(body.accuracy) : null;
  const timestamp = body.timestamp != null ? String(body.timestamp) : null;
  const address = body.address != null ? String(body.address) : null;
  return { lat, lng, accuracy, timestamp, address };
}

module.exports = { distanceMeters, normalizeGeoBody };
