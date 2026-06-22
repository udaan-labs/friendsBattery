// check_db.js - Verify password hashes
const { PrismaClient } = require('@prisma/client');
const bcrypt = require('bcrypt');
const prisma = new PrismaClient();

async function main() {
  const users = await prisma.user.findMany();
  for (const u of users) {
    let testPassword = "";
    if (u.userId === "seller1") testPassword = "seller1";
    else if (u.userId === "seller2") testPassword = "123";
    else if (u.userId === "SELLER001") testPassword = "123";
    else if (u.userId === "kartik123") testPassword = "123";
    else if (u.userId === "admin") testPassword = "admin";
    
    let isValid = false;
    if (testPassword) {
      isValid = await bcrypt.compare(testPassword, u.passwordHash);
    }
    console.log(`ID: ${u.id}, UserID: ${u.userId}, Role: ${u.role}, Test Password: '${testPassword}', IsValid: ${isValid}`);
  }
}

main()
  .catch(e => console.error(e))
  .finally(() => prisma.$disconnect());
