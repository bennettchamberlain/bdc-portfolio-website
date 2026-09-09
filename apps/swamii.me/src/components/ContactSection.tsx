"use client";
import React, { useState } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { Check, Copy } from "lucide-react";
import { site } from "@/data/site";
import ButtonBox from "./ButtonBox";

type FootLink = { text: string; href?: string; copy?: boolean; underline?: boolean };
type FootColumn = { title: string; links: FootLink[] };

const columns: FootColumn[] = [
  {
    title: "Crafted by",
    links: [
      { text: site.name, underline: true },
      { text: site.email, href: `mailto:${site.email}`, copy: true },
    ],
  },
  {
    title: "Work",
    links: [
      { text: "Book a 15-minute call", href: site.calendar },
      { text: "Resume", href: site.resume },
      { text: "Projects", href: "/projectspage" },
    ],
  },
  {
    title: "Colophon",
    links: [
      { text: "Next.js", href: "https://nextjs.org" },
      { text: "TypeScript", href: "https://www.typescriptlang.org" },
      { text: "Tailwind CSS", href: "https://tailwindcss.com" },
    ],
  },
  {
    title: "Project",
    links: [
      { text: "GitHub", href: site.github },
      { text: "Flutter archive", href: "https://github.com/bennettchamberlain/bdc-portfolio-website" },
    ],
  },
];

const iconVariants = {
  initial: { y: 8, opacity: 0 },
  animate: { y: 0, opacity: 1 },
  exit: { y: -8, opacity: 0 },
};

const ContactSection = () => {
  const [copied, setCopied] = useState(false);

  const handleCopy = async () => {
    await navigator.clipboard.writeText(site.email);
    setCopied(true);
    setTimeout(() => setCopied(false), 1500);
  };

  return (
    <section className="relative overflow-hidden bg-white text-black">
      <div className="px-[3%] pt-20 pb-0 sm:pt-24">
        <div className="bdc-frame mb-10 p-6 md:p-8">
          <h3 className="font-display text-2xl leading-tight tracking-tight text-balance md:text-3xl">
            Book a 15-Minute Call
          </h3>
          <p className="font-body mt-3 max-w-xl text-neutral-600">
            Want to connect? Pick a time that works for you. It goes straight onto my calendar.
          </p>
          <div className="mt-5">
            <ButtonBox
              href={site.calendar}
              target="_blank"
              rel="noopener noreferrer"
              border
              className="font-body h-[50px] px-6 text-base"
            >
              Schedule a Call
            </ButtonBox>
          </div>
        </div>

        <div className="grid grid-cols-2 gap-x-8 gap-y-10 sm:grid-cols-4">
          {columns.map((col) => (
            <div key={col.title}>
              <h3 className="font-geist-pixel text-xs tracking-widest text-neutral-500 uppercase">
                {col.title}
              </h3>
              <ul className="font-geist-mono mt-4 flex flex-col gap-2 text-sm">
                {col.links.map((item, i) => (
                  <li key={i} className="flex items-center gap-1.5">
                    {item.href ? (
                      <a
                        href={item.href}
                        target={item.href.startsWith("http") ? "_blank" : undefined}
                        rel="noopener noreferrer"
                        className={`truncate text-black transition-colors hover:text-neutral-500 ${item.underline ? "link-underline" : ""}`}
                      >
                        {item.text}
                      </a>
                    ) : (
                      <span className="text-black">{item.text}</span>
                    )}
                    {item.copy && (
                      <button
                        onClick={handleCopy}
                        aria-label="Copy email"
                        className="relative inline-flex h-5 w-5 shrink-0 items-center justify-center overflow-hidden text-neutral-500 hover:text-black"
                      >
                        <AnimatePresence mode="wait">
                          {copied ? (
                            <motion.span
                              key="check"
                              variants={iconVariants}
                              initial="initial"
                              animate="animate"
                              exit="exit"
                              className="absolute"
                            >
                              <Check className="h-3.5 w-3.5 text-green-600" />
                            </motion.span>
                          ) : (
                            <motion.span
                              key="copy"
                              variants={iconVariants}
                              initial="initial"
                              animate="animate"
                              exit="exit"
                              className="absolute"
                            >
                              <Copy className="h-3.5 w-3.5" />
                            </motion.span>
                          )}
                        </AnimatePresence>
                      </button>
                    )}
                  </li>
                ))}
              </ul>
            </div>
          ))}
        </div>

        <div className="font-geist-mono mt-12 flex flex-wrap items-center gap-x-5 gap-y-2 border-t-8 border-black pt-6 text-xs text-neutral-500 sm:text-sm">
          <span>
            © {new Date().getFullYear()} {site.name}
          </span>
        </div>
      </div>

      <p
        aria-hidden="true"
        className="font-wordmark pointer-events-none mt-16 -mb-[0.22em] text-center text-[clamp(2.5rem,18vw,18rem)] leading-[0.7] tracking-tighter text-black/10 select-none"
      >
        {site.wordmark}
      </p>
    </section>
  );
};

export default ContactSection;
