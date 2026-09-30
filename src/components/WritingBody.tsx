import React from "react";

function inline(text: string) {
  const parts = text.split(/(\*\*[^*]+\*\*|\*[^*]+\*|\[[^\]]+\]\([^)]+\))/g);
  return parts.map((part, index) => {
    if (part.startsWith("**") && part.endsWith("**")) {
      return <strong key={index}>{part.slice(2, -2)}</strong>;
    }
    if (part.startsWith("*") && part.endsWith("*")) {
      return <em key={index}>{part.slice(1, -1)}</em>;
    }
    const link = part.match(/^\[([^\]]+)\]\(([^)]+)\)$/);
    if (link) {
      return (
        <a key={index} href={link[2]} className="underline" target="_blank" rel="noopener noreferrer">
          {link[1]}
        </a>
      );
    }
    return <React.Fragment key={index}>{part}</React.Fragment>;
  });
}

const WritingBody = ({ body }: { body: string }) => {
  const blocks = body.split(/\n{2,}/);
  return (
    <div className="font-body space-y-5 text-base leading-relaxed text-neutral-800 md:text-lg">
      {blocks.map((block, index) => {
        const image = block.match(/^!\[([^\]]*)\]\(([^)]+)\)$/);
        if (image) {
          return (
            <img
              key={index}
              src={image[2]}
              alt={image[1]}
              className="mx-auto max-h-[28rem] border-4 border-black"
            />
          );
        }
        if (block.startsWith("## ")) {
          return (
            <h2 key={index} className="font-display pt-4 text-2xl tracking-tight md:text-3xl">
              {block.slice(3)}
            </h2>
          );
        }
        if (block.trim() === "---") {
          return <hr key={index} className="border-0 border-t-4 border-black" />;
        }
        const lines = block.split("\n");
        if (lines.every((line) => line.startsWith("- "))) {
          return (
            <ul key={index} className="list-disc space-y-2 pl-6">
              {lines.map((line) => (
                <li key={line}>{inline(line.slice(2))}</li>
              ))}
            </ul>
          );
        }
        return <p key={index}>{inline(block.replace(/\n/g, " "))}</p>;
      })}
    </div>
  );
};

export default WritingBody;
