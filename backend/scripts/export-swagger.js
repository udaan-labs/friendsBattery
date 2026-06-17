const fs = require('fs');
const path = require('path');

// Ensure env variables are configured (in case script is run outside backend root)
require('dotenv').config({ path: path.join(__dirname, '../.env') });

const swaggerSpec = require('../src/config/swagger');

const outputPath = path.join(__dirname, '../openapi.json');

try {
  fs.writeFileSync(outputPath, JSON.stringify(swaggerSpec, null, 2), 'utf-8');
  console.log(`OpenAPI specification exported successfully to: ${outputPath}`);
} catch (error) {
  console.error('Failed to export OpenAPI specification:', error);
  process.exit(1);
}
