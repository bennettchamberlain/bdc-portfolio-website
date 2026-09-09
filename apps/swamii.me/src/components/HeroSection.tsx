"use client";
import React from "react";
import { Calendar, FileDown } from "lucide-react";
import Image from "next/image";
import RingButton from "./RingButton";
import OpenToWorkNote from "./OpenToWorkNote";
import { site } from "@/data/site";

const HeroSection = () => {
  return (
    <div className="bg-white pt-24 md:px-[2%] md:pt-28">
      <div className="px-4 pt-4 sm:px-6 sm:pt-6 md:ml-4 md:px-0 md:pt-8">
        <div className="mb-10 flex max-w-7xl flex-col items-start justify-center pt-6 text-black sm:mt-10 md:mb-16 md:pt-0">
          <div className="flex w-full flex-col gap-8 lg:flex-row lg:items-end lg:justify-between">
            <div className="min-w-0 flex-1">
              <h1 className="font-display text-4xl leading-[0.95] tracking-tight sm:text-6xl md:text-7xl lg:text-8xl xl:text-[110px]">
                Hi I&apos;m {site.shortName}
              </h1>
              <p className="font-display mt-2 text-4xl leading-[0.95] tracking-tight sm:text-6xl md:text-7xl lg:text-8xl xl:text-[110px]">
                {site.tagline}
              </p>
              <p className="font-body mt-5 max-w-xl text-base text-neutral-600 sm:text-lg md:text-xl">
                {site.roles.join(" · ")}.
              </p>
              <div className="mt-6 flex flex-wrap items-center gap-3 md:mt-8 md:gap-6">
                <a
                  href={site.calendar}
                  target="_blank"
                  rel="noopener noreferrer"
                >
                  <RingButton text="Book a Meeting" icon={Calendar} />
                </a>
                <a href={site.resume} target="_blank" rel="noopener noreferrer">
                  <RingButton text="Resume" icon={FileDown} size="md" />
                </a>
                <OpenToWorkNote />
              </div>
            </div>

            <div className="bdc-frame relative h-64 w-full shrink-0 overflow-hidden sm:h-80 sm:w-72 lg:h-[420px] lg:w-[360px]">
              <Image
                src="/images/headshot.jpg"
                alt={site.name}
                fill
                priority
                className="object-cover"
              />
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default HeroSection;
