#!/usr/bin/env node
/**
 * publish.js — Push a content JSON file to Firestore.
 *
 * Usage:
 *   node publish.js ../content/blogs/my-post.json
 *   node publish.js ../content/projects/my-project.json
 *
 * Requires service-account.json in the scripts/ directory.
 * See README in content/ for setup instructions.
 */

const admin = require('firebase-admin');
const fs = require('fs');
const path = require('path');

// ── Load service account ────────────────────────────────────────────────────
const serviceAccountPath = path.join(__dirname, 'service-account.json');
if (!fs.existsSync(serviceAccountPath)) {
  console.error('\n❌  Missing service-account.json in scripts/');
  console.error('   Download it from Firebase Console → Project Settings → Service Accounts');
  console.error('   Save it as: scripts/service-account.json\n');
  process.exit(1);
}

const serviceAccount = require(serviceAccountPath);

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const db = admin.firestore();

// ── Helpers ──────────────────────────────────────────────────────────────────

function slugify(title) {
  return title.trim().toLowerCase().replace(/\s+/g, '_').replace(/[^a-z0-9_]/g, '');
}

function autoId() {
  return Date.now().toString() + Math.random().toString(36).slice(2, 6);
}

function normalizeBlocks(blocks) {
  return (blocks || []).map((b) => ({
    id: b.id || autoId(),
    type: b.type,
    ...(b.content !== undefined && { content: b.content }),
    ...(b.level !== undefined && { level: b.level }),
    ...(b.align !== undefined && { align: b.align }),
    ...(b.fontSize !== undefined && { fontSize: b.fontSize }),
    ...(b.fontWeight !== undefined && { fontWeight: b.fontWeight }),
    ...(b.fontFamily !== undefined && { fontFamily: b.fontFamily }),
    ...(b.colorHex !== undefined && { colorHex: b.colorHex }),
    ...(b.url !== undefined && { url: b.url }),
    ...(b.caption !== undefined && { caption: b.caption }),
    ...(b.language !== undefined && { language: b.language }),
  }));
}

// ── Main ─────────────────────────────────────────────────────────────────────

async function publish(filePath) {
  const resolved = path.resolve(filePath);
  if (!fs.existsSync(resolved)) {
    console.error(`\n❌  File not found: ${resolved}\n`);
    process.exit(1);
  }

  const raw = JSON.parse(fs.readFileSync(resolved, 'utf8'));

  const { type, title, author, desc, thumbnailUrl, blocks } = raw;

  if (!type || !['blogs', 'projects'].includes(type)) {
    console.error('\n❌  "type" must be "blogs" or "projects"\n');
    process.exit(1);
  }
  if (!title || !title.trim()) {
    console.error('\n❌  "title" is required\n');
    process.exit(1);
  }

  const docId = raw.id || slugify(title);
  const isUpdate = raw.id ? true : false;

  const data = {
    id: docId,
    title: title.trim(),
    author: author || 'Bennett Chamberlain',
    authorName: author || 'Bennett Chamberlain',
    desc: desc || '',
    imgUrl: thumbnailUrl || '',
    thumbnailUrl: thumbnailUrl || '',
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    blocks: normalizeBlocks(blocks),
  };

  // Only set createdAt for new posts
  const docRef = db.collection(type).doc(docId);
  const existing = await docRef.get();
  if (!existing.exists) {
    data.createdAt = admin.firestore.FieldValue.serverTimestamp();
  }

  await docRef.set(data, { merge: true });

  const action = existing.exists ? 'Updated' : 'Published';
  console.log(`\n✅  ${action} "${title}"`);
  console.log(`   Collection : ${type}`);
  console.log(`   Document   : ${docId}`);
  console.log(`   Live at    : https://bdc-website-2.web.app/content/${type}/${docId}\n`);
}

const file = process.argv[2];
if (!file) {
  console.error('\nUsage: node publish.js <path-to-content-file.json>\n');
  console.error('Examples:');
  console.error('  node publish.js ../content/blogs/my-post.json');
  console.error('  node publish.js ../content/projects/my-project.json\n');
  process.exit(1);
}

publish(file).catch((err) => {
  console.error('\n❌  Error:', err.message, '\n');
  process.exit(1);
});
