"use client";

import React, { useState } from "react";
import { useRouter } from "next/navigation";
import { site } from "@/data/site";
import { useSplashReady } from "@/components/InitialLoadShell";
import ButtonBox from "./ButtonBox";

const Navbar: React.FC = () => {
  const [isMenuOpen, setIsMenuOpen] = useState(false);
  const router = useRouter();
  const ready = useSplashReady();

  const go = (href: string) => {
    setIsMenuOpen(false);
    if (href.startsWith("#")) {
      document
        .querySelector(`[data-section-label="${href.slice(1)}"]`)
        ?.scrollIntoView({ behavior: "smooth", block: "start" });
      return;
    }
    router.push(href);
  };

  return (
    <div className="relative">
      <div
        className={`fixed top-0 left-0 z-50 w-full border-b-8 border-black bg-white transition-transform duration-700 ease-[cubic-bezier(0.16,1,0.3,1)] ${
          ready ? "translate-y-0" : "-translate-y-full"
        }`}
      >
        <div className="flex items-center justify-between gap-3 px-2 py-1.5 sm:px-3">
          <button
            onClick={() => go("/")}
            className="font-wordmark min-w-0 max-w-[calc(100%-3.25rem)] py-0 text-left tracking-[-0.05em] text-black lg:max-w-none"
          >
            <span className="block text-[clamp(1.15rem,6.2vw,1.55rem)] leading-[0.8] lg:hidden">
              BENNETT
              <br />
              CHAMBERLAIN
            </span>
            <span className="hidden text-[clamp(1.45rem,2.4vw,2.1rem)] leading-none whitespace-nowrap lg:block">
              {site.handle}
            </span>
          </button>

          <div className="flex shrink-0 items-center gap-2 sm:gap-3">
            <div className="hidden items-center gap-2 md:flex">
              <ButtonBox
                className="font-body h-10 min-w-[88px] px-3 text-sm lg:h-[46px] lg:min-w-[110px] lg:px-4 lg:text-base"
                onClick={() => go("/projectspage")}
              >
                Projects
              </ButtonBox>
              <ButtonBox
                className="font-body h-10 min-w-[88px] px-3 text-sm lg:h-[46px] lg:min-w-[110px] lg:px-4 lg:text-base"
                onClick={() => go("#About section")}
              >
                About
              </ButtonBox>
              <ButtonBox
                className="font-body h-10 min-w-[88px] px-3 text-sm lg:h-[46px] lg:min-w-[110px] lg:px-4 lg:text-base"
                onClick={() => go("#Contact section")}
              >
                Contact
              </ButtonBox>
            </div>

            <button
              onClick={() => setIsMenuOpen(!isMenuOpen)}
              className="flex h-11 w-11 shrink-0 flex-col items-center justify-center gap-[5px] border-[6px] border-black bg-white md:hidden"
              aria-label="Toggle menu"
            >
              <span
                className={`h-[3px] w-5 bg-black transition-all duration-300 ${
                  isMenuOpen ? "translate-y-2 rotate-45" : ""
                }`}
              />
              <span
                className={`h-[3px] w-5 bg-black transition-all duration-300 ${
                  isMenuOpen ? "opacity-0" : ""
                }`}
              />
              <span
                className={`h-[3px] w-5 bg-black transition-all duration-300 ${
                  isMenuOpen ? "-translate-y-2 -rotate-45" : ""
                }`}
              />
            </button>
          </div>
        </div>

        <div
          className={`overflow-hidden transition-all duration-300 ease-in-out md:hidden ${
            isMenuOpen ? "max-h-64 opacity-100" : "max-h-0 opacity-0"
          }`}
        >
          <div className="border-t-8 border-black px-4 pb-4">
            <div className="space-y-1 pt-3">
              {[
                ["Projects", "/projectspage"],
                ["About", "#About section"],
                ["Contact", "#Contact section"],
              ].map(([label, href]) => (
                <ButtonBox
                  key={label}
                  className="font-body w-full justify-start px-3 py-3 text-left"
                  onClick={() => go(href)}
                >
                  {label}
                </ButtonBox>
              ))}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Navbar;
