/**
 * Empty shop tree must not fall back to org-wide feed.
 * node backend/scripts/test_dashboard_activity_scope.js
 */
const assert = require('assert');
const dashboardRepository = require('../src/modules/dashboard/dashboard.repository');

async function main() {
  const empty = await dashboardRepository.getRecentActivity({
    actorIds: [],
    locationIds: [],
    adminId: 1n,
  });
  assert.deepStrictEqual(empty, []);

  const hist = await dashboardRepository.getActivityHistory({
    scopeFilter: { actorIds: [], locationIds: [], adminId: 1n },
  });
  assert.deepStrictEqual(hist.data, []);
  assert.strictEqual(hist.hasNextPage, false);

  console.log('dashboard activity scope self-check ok');
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
