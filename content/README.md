# Content Publishing Workflow

Paste your idea/draft to Copilot → it generates a JSON file here → you run one command → it's live.

---

## One-Time Setup

1. **Get your Firebase service account key:**
   - Go to [Firebase Console](https://console.firebase.google.com/project/bdc-website-2/settings/serviceaccounts/adminsdk)
   - Click **"Generate new private key"** → download the JSON file
   - Save it as `scripts/service-account.json` (it's gitignored — never commit it)

2. **Install dependencies:**
   ```bash
   cd scripts
   npm install
   ```

---

## Workflow

### 1. Create content with Copilot
Paste your draft, notes, or outline into the Copilot chat. It will create a file like:
```
content/blogs/my-post-title.json
content/projects/my-project-title.json
```

### 2. Review (optional)
Open the generated JSON file and tweak anything you want.

### 3. Publish
```bash
cd scripts
node publish.js ../content/blogs/my-post-title.json
```

The script prints the live URL when done.

---

## Block Types

| Type | Required fields | Optional fields |
|------|----------------|-----------------|
| `heading` | `content`, `level` (1/2/3) | `align`, `colorHex` |
| `paragraph` | `content` | `align`, `fontSize`, `fontFamily`, `colorHex` |
| `image` | `url` | `caption` |
| `video` | `url` | `caption` |
| `code` | `content` | `language` |
| `divider` | *(none)* | |

---

## Updating an Existing Post

Add `"id": "existing_doc_id"` to the JSON and re-run publish. It will update in place without changing `createdAt`.

---

## File Structure

```
content/
  blogs/          ← blog post JSON files live here
  projects/       ← project JSON files live here
  template.json   ← copy this to start a new post
scripts/
  publish.js      ← the publish script
  package.json
  service-account.json  ← gitignored, download from Firebase
```
