const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

console.log('📦 1. Running changeset version (generating changelog & removing changesets)...');
execSync('npx changeset version', { stdio: 'inherit' });

// 1. Read the newly bumped version from root package.json
const rootPkgPath = path.join(__dirname, '../package.json');
const rootPkg = JSON.parse(fs.readFileSync(rootPkgPath, 'utf8'));
const newVersion = rootPkg.version;
console.log(`\n✨ New workspace version: ${newVersion}`);

// 2. Sync version to backend/package.json
const backendPkgPath = path.join(__dirname, '../backend/package.json');
if (fs.existsSync(backendPkgPath)) {
  const backendPkg = JSON.parse(fs.readFileSync(backendPkgPath, 'utf8'));
  backendPkg.version = newVersion;
  fs.writeFileSync(backendPkgPath, JSON.stringify(backendPkg, null, 2) + '\n', 'utf8');
  console.log(`✅ Updated backend/package.json version to ${newVersion}`);

  // Keep backend/package-lock.json in sync
  try {
    execSync('npm install --package-lock-only', { cwd: path.join(__dirname, '../backend'), stdio: 'ignore' });
    console.log(`✅ Synced backend/package-lock.json to version ${newVersion}`);
  } catch (_) {}
}

// 3. Sync version to frontend/pubspec.yaml
const pubspecPath = path.join(__dirname, '../frontend/pubspec.yaml');
if (fs.existsSync(pubspecPath)) {
  let pubspec = fs.readFileSync(pubspecPath, 'utf8');
  const match = pubspec.match(/^version:\s*([0-9]+\.[0-9]+\.[0-9]+)\+?([0-9]+)?/m);
  let buildNumber = 1;
  if (match && match[2]) {
    buildNumber = parseInt(match[2], 10) + 1;
  }
  const newPubspecVersion = `${newVersion}+${buildNumber}`;
  pubspec = pubspec.replace(/^version:.*$/m, `version: ${newPubspecVersion}`);
  fs.writeFileSync(pubspecPath, pubspec, 'utf8');
  console.log(`✅ Updated frontend/pubspec.yaml version to ${newPubspecVersion}`);
}

// Keep root package-lock.json in sync
try {
  execSync('npm install --package-lock-only', { cwd: path.join(__dirname, '..'), stdio: 'ignore' });
} catch (_) {}

console.log('\n🎉 All changesets consumed, changelog updated, and app versions synced across root, backend & Flutter pubspec!\n');
