require('dotenv').config();
const { PrismaClient } = require('@prisma/client');
const p = new PrismaClient();

(async () => {
  const n = await p.productUnit.count();
  const by = await p.productUnit.groupBy({ by: ['status'], _count: true });
  const u = await p.user.findMany({
    select: { id: true, userId: true, role: true, locationId: true },
  });
  const loc = await p.location.findMany();
  const atShop = await p.productUnit.count({
    where: { currentLocationId: 2n, status: 'AVAILABLE' },
  });
  console.log('units', n, by);
  console.log(
    'users',
    u.map((x) => ({
      id: String(x.id),
      userId: x.userId,
      role: x.role,
      loc: x.locationId ? String(x.locationId) : null,
    }))
  );
  console.log(
    'locations',
    loc.map((l) => ({ id: String(l.id), code: l.code }))
  );
  console.log('available at loc 2', atShop);
  await p.$disconnect();
})().catch(async (e) => {
  console.error(e);
  await p.$disconnect();
  process.exit(1);
});
