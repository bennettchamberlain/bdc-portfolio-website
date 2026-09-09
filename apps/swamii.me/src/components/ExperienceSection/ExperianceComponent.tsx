"use client";

import React, { useEffect, useRef, useState } from "react";

type ExperienceProps = {
  company: string;
  role: string;
  duration: string;
  points: string[];
  logo: string;
  initials?: string;
  skills?: string[];
  rounded?: "all" | "top" | "bottom" | "none";
  first?: boolean;
};

const Experience = ({
  company,
  role,
  duration,
  points,
  logo,
  initials,
  skills = [],
  first = false,
}: ExperienceProps) => {
  const [open, setOpen] = useState(false);
  const contentRef = useRef<HTMLDivElement>(null);
  const [height, setHeight] = useState(0);

  useEffect(() => {
    if (contentRef.current) {
      setHeight(contentRef.current.scrollHeight);
    }
  }, [points, skills]);

  return (
    <div className="px-4 md:px-[3%]">
      <div
        onClick={() => setOpen((prev) => !prev)}
        className={`cursor-pointer border-x-8 border-b-8 border-black bg-white ${first ? "border-t-8" : ""}`}
      >
        <div className="flex items-start justify-between gap-3 p-4 md:items-center md:p-5">
          <div className="flex min-w-0 items-start gap-3 md:items-center md:gap-4">
            <div className="flex h-12 w-12 shrink-0 items-center justify-center border-4 border-black bg-black font-display text-sm text-white">
              {logo ? (
                <img src={logo} alt={company} className="h-full w-full object-cover" />
              ) : (
                initials
              )}
            </div>
            <div className="flex min-w-0 flex-col justify-center">
              <h2 className="font-display flex flex-wrap items-center gap-2 text-lg leading-snug tracking-tight md:text-2xl">
                <span>{company}</span>
                <span className="font-body border-2 border-black px-2 py-0.5 text-[10px] font-normal whitespace-nowrap md:text-sm">
                  {role}
                </span>
              </h2>
              <div className="font-body text-xs text-neutral-600 md:text-sm">
                {duration}
              </div>
            </div>
          </div>
          <span
            aria-hidden
            className={`relative h-8 w-8 shrink-0 transition-transform duration-500 md:h-10 md:w-10 ${open ? "rotate-180" : ""}`}
          >
            <span className="absolute top-[38%] left-0 h-2 w-[62%] origin-right rotate-45 bg-black" />
            <span className="absolute top-[38%] right-0 h-2 w-[62%] origin-left -rotate-45 bg-black" />
          </span>
        </div>

        <div
          style={{ height: open ? height : 0 }}
          className="overflow-hidden transition-all duration-500"
        >
          <div
            ref={contentRef}
            className="font-body px-4 pb-4 text-sm leading-relaxed text-neutral-700 md:px-5 md:pb-5 md:text-base"
          >
            <div className="space-y-2">
              {points.map((point) => (
                <p key={point} className="relative pl-4">
                  <span className="absolute top-[8px] left-0 h-2 w-2 bg-black" />
                  {point}
                </p>
              ))}
            </div>
            {skills.length > 0 && (
              <div className="mt-5 flex flex-wrap gap-2">
                {skills.map((skill) => (
                  <span
                    key={skill}
                    className="border-2 border-black px-2.5 py-1 text-[10px] md:text-xs"
                  >
                    {skill}
                  </span>
                ))}
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  );
};

export default Experience;
