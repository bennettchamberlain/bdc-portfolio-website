# Bennett Chamberlain

The site at [bennettchamberlain.com](https://bennettchamberlain.com). Next.js, exported to `out/` and hosted on Firebase (`bdc-website-2`).

```bash
npm install
npm run dev
npm run build
firebase deploy --only hosting
```

Copy and projects live in `src/data/site.ts`. Writings live in `src/content/writings`. A writing with an `app:` URL is a separate app, usually on its own subdomain, and the writings list opens that URL.
