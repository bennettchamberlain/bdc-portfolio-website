import Link from "next/link";
import { notFound } from "next/navigation";
import WritingBody from "@/components/WritingBody";
import { getWriting, getWritings } from "@/lib/writings";

export function generateStaticParams() {
  return getWritings().map((piece) => ({ slug: piece.slug }));
}

export async function generateMetadata({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;
  const piece = getWriting(slug);
  return { title: piece ? `${piece.title} — Bennett Chamberlain` : "Writing" };
}

export default async function WritingPage({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;
  const piece = getWriting(slug);
  if (!piece) notFound();

  return (
    <main className="min-h-screen bg-white text-black">
      <header className="border-b-8 border-black px-[5%] py-5">
        <Link href="/" className="font-display text-2xl tracking-tight">
          BENNETT
        </Link>
      </header>
      <article className="px-[5%] py-12">
        <Link href="/#writings" className="font-body text-sm underline">
          Writings
        </Link>
        <p className="font-body mt-6 text-sm text-neutral-500">
          {piece.kind} · {piece.date}
        </p>
        <h1 className="font-display mt-3 max-w-3xl text-3xl tracking-tight md:text-5xl">{piece.title}</h1>
        <p className="font-body mt-4 max-w-2xl text-lg text-neutral-600">{piece.dek}</p>
        <div className="mt-10 max-w-3xl">
          <WritingBody body={piece.body} />
        </div>
      </article>
    </main>
  );
}
