import Link from "next/link";
import { getWritings } from "@/lib/writings";

const order = [
  // "what-it-means-to-be-an-artist",
  "flutters-underlying-mechanisms",
  "historical-spelunking",
];

const WritingsSection = () => {
  const writings = getWritings()
    .filter((piece) => order.includes(piece.slug))
    .sort((a, b) => order.indexOf(a.slug) - order.indexOf(b.slug));

  return (
    <div className="grid grid-cols-1 gap-8 px-[3%] py-10">
      {writings.map((piece) => (
        <article key={piece.slug} className="bdc-frame p-6 md:p-8">
          <div className="font-body flex items-center gap-3 text-sm text-neutral-500">
            <span>{piece.kind}</span>
            <span aria-hidden="true">·</span>
            <span>{piece.date}</span>
          </div>
          <h3 className="font-display mt-3 text-2xl tracking-tight md:text-4xl">
            <Link href={`/writings/${piece.slug}`} className="hover:underline">
              {piece.title}
            </Link>
          </h3>
          <p className="font-body mt-3 max-w-2xl text-base text-neutral-600 md:text-lg">
            {piece.dek}
          </p>
        </article>
      ))}
    </div>
  );
};

export default WritingsSection;
