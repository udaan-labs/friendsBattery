const inventoryService = require('./src/modules/inventory/inventory.service');

async function testGetInventory() {
  try {
    const userId = 2; // seller 1
    const role = 'SELLER';
    const inventory = await inventoryService.getInventory(userId, role, { search: '', page: 1, limit: 10 });
    console.log(JSON.stringify(inventory, null, 2));
  } catch (error) {
    console.error(error);
  }
}

testGetInventory();
