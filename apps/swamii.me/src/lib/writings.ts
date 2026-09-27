import fs from "fs";
import path from "path";

export type Writing = {
  slug: string;
  title: string;
  dek: string;
  date: string;
  kind: string;
  body: string;
};

const dir = path.join(process.cwd(), "src/content/writings");

function parse(slug: string, raw: string): Writing {
  const match = raw.match(/^---\n([\s\S]*?)\n---\n([\s\S]*)$/);
  const meta: Record<string, string> = {};
  const front = match?.[1] ?? "";
  for (const line of front.split("\n")) {
    const cut = line.indexOf(":");
    if (cut === -1) continue;
    meta[line.slice(0, cut).trim()] = line.slice(cut + 1).trim();
  }
  return {
    slug,
    title: meta.title ?? slug,
    dek: meta.dek ?? "",
    date: meta.date ?? "",
    kind: meta.kind ?? "Essay",
    body: (match?.[2] ?? raw).trim(),
  };
}

export function getWritings(): Writing[] {
  return fs
    .readdirSync(dir)
    .filter((file) => file.endsWith(".md"))
    .map((file) => parse(file.replace(/\.md$/, ""), fs.readFileSync(path.join(dir, file), "utf8")))
    .sort((a, b) => a.title.localeCompare(b.title));
}

export function getWriting(slug: string): Writing | undefined {
  const file = path.join(dir, `${slug}.md`);
  if (!fs.existsSync(file)) return undefined;
  return parse(slug, fs.readFileSync(file, "utf8"));
}
