const repo = require('./src/modules/dashboard/dashboard.repository');

async function test() {
  try {
    console.log('Testing getRecentActivity()...');
    const recent = await repo.getRecentActivity();
    console.log(`Recent Activity Count: ${recent.length}`);
    console.log('Top 2:', recent.slice(0, 2));

    console.log('\nTesting getActivityHistory()...');
    const history = await repo.getActivityHistory(1, 5);
    console.log(`History Page 1 Data Count: ${history.data.length}`);
    console.log(`History Total Count: ${history.total}`);
    console.log('History Top 2:', history.data.slice(0, 2));

    process.exit(0);
  } catch (err) {
    console.error('Error:', err);
    process.exit(1);
  }
}

test();
