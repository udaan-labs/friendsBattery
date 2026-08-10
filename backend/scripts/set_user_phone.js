/**
 * Set a real mobile on a user for OTP SMS testing.
 * Usage: node scripts/set_user_phone.js admin1 9649981514
 */
require('dotenv').config();
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
  const userId = process.argv[2];
  const phone = process.argv[3];
  if (!userId || !phone) {
    console.error('Usage: node scripts/set_user_phone.js <userId> <10digitPhone>');
    process.exit(1);
  }
  const digits = String(phone).replace(/\D/g, '').slice(-10);
  if (digits.length !== 10) {
    console.error('Phone must be 10 digits');
    process.exit(1);
  }
  const u = await prisma.user.update({
    where: { userId },
    data: { userNumber: digits },
  });
  console.log(`Updated ${u.userId} phone → ${u.userNumber}`);
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(() => prisma.$disconnect());
