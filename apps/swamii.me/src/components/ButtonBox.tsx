"use client";

import Link from "next/link";
import { cn } from "@/lib/utils";

type ButtonBoxProps = {
  children: React.ReactNode;
  href?: string;
  onClick?: () => void;
  border?: boolean;
  className?: string;
  target?: string;
  rel?: string;
  type?: "button" | "submit";
};

const fillClass =
  "pointer-events-none absolute inset-x-0 top-0 z-0 h-0 bg-black transition-[height] duration-300 ease-in-out group-hover:h-full group-focus-visible:h-full group-active:h-full";

const labelClass =
  "relative z-10 font-bold text-black transition-none group-hover:text-white group-focus-visible:text-white group-active:text-white [&_svg]:text-current";

export default function ButtonBox({
  children,
  href,
  onClick,
  border = false,
  className,
  target,
  rel,
  type = "button",
}: ButtonBoxProps) {
  const classes = cn(
    "group relative inline-flex items-center justify-center overflow-hidden bg-white",
    border && "border-8 border-black",
    className,
  );

  const inner = (
    <>
      <span aria-hidden className={fillClass} />
      <span className={labelClass}>{children}</span>
    </>
  );

  if (href) {
    const external = href.startsWith("http") || href.startsWith("mailto:");
    if (external) {
      return (
        <a href={href} target={target} rel={rel} className={classes}>
          {inner}
        </a>
      );
    }
    return (
      <Link href={href} target={target} rel={rel} className={classes}>
        {inner}
      </Link>
    );
  }

  return (
    <button type={type} onClick={onClick} className={classes}>
      {inner}
    </button>
  );
}
