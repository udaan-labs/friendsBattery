const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

console.log('📦 1. Running changeset version (generating changelog & removing changesets)...');
execSync('npx changeset version', { stdio: 'inherit' });

// 1. Read the newly bumped version from backend/package.json or frontend/package.json
const backendPkgPath = path.join(__dirname, '../backend/package.json');
const backendPkg = JSON.parse(fs.readFileSync(backendPkgPath, 'utf8'));
const newVersion = backendPkg.version;
console.log(`\n✨ New version: ${newVersion}`);

// 2. Sync version to root package.json
const rootPkgPath = path.join(__dirname, '../package.json');
if (fs.existsSync(rootPkgPath)) {
  const rootPkg = JSON.parse(fs.readFileSync(rootPkgPath, 'utf8'));
  rootPkg.version = newVersion;
  fs.writeFileSync(rootPkgPath, JSON.stringify(rootPkg, null, 2) + '\n', 'utf8');
  console.log(`✅ Updated root package.json version to ${newVersion}`);
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

// 4. If root CHANGELOG.md is desired, combine or sync package changelogs
const rootChangelogPath = path.join(__dirname, '../CHANGELOG.md');
const backendChangelogPath = path.join(__dirname, '../backend/CHANGELOG.md');
const frontendChangelogPath = path.join(__dirname, '../frontend/CHANGELOG.md');

let changelogEntries = [];
if (fs.existsSync(backendChangelogPath)) {
  changelogEntries.push(fs.readFileSync(backendChangelogPath, 'utf8'));
}
if (fs.existsSync(frontendChangelogPath)) {
  changelogEntries.push(fs.readFileSync(frontendChangelogPath, 'utf8'));
}
if (changelogEntries.length > 0) {
  // Combine changelogs into root CHANGELOG.md
  fs.writeFileSync(rootChangelogPath, changelogEntries.join('\n---\n\n'), 'utf8');
  console.log(`✅ Updated root CHANGELOG.md`);
}

console.log('\n🎉 All changesets consumed, changelog updated, and app versions synced across root, backend & Flutter pubspec!\n');
