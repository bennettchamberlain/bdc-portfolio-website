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
  "btn-fill pointer-events-none absolute inset-x-0 top-0 z-0 h-0 bg-black transition-[height] duration-300 ease-in-out group-hover/btn:h-full group-hover/card:h-full group-focus-visible/btn:h-full group-active/btn:h-full";

const labelClass =
  "btn-label relative z-10 inline-flex items-center gap-2 font-bold text-black transition-none group-hover/btn:text-white group-hover/card:text-white group-focus-visible/btn:text-white group-active/btn:text-white [&_svg]:shrink-0 [&_svg]:text-current";

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
    "button-box group/btn relative inline-flex items-center justify-center overflow-hidden bg-white",
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
