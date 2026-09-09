"use client";

import Image from "next/image";
import React from "react";
import StatusDot from "../BlinkingDot.tsx/BlinkingDot";
import RingButton from "../RingButton";
import { GitHubIcon } from "@/app/icons/Githubicon";
import { CircleArrowRight } from "lucide-react";

type ProjectStatus = "live" | "building" | "discontinued";

type ProjectCardProps = {
  image: string;
  title: string;
  description: string;
  status?: ProjectStatus;
  liveLink?: string;
  githubLink?: string;
  projectBg?: string;
};

const statusColorMap: Record<ProjectStatus, "green" | "yellow" | "red"> = {
  live: "green",
  building: "yellow",
  discontinued: "red",
};

const ProjectCard = ({
  image,
  title,
  description,
  status = "live",
  liveLink,
  githubLink,
}: ProjectCardProps) => {
  const color = statusColorMap[status];

  return (
    <div className="bdc-frame group flex h-full flex-col bg-white">
      <div className="relative h-52 w-full overflow-hidden border-b-8 border-black bg-white">
        <Image
          src={image}
          alt={title}
          fill
          className={`transition-transform duration-500 group-hover:scale-[1.03] ${
            image.endsWith(".svg")
              ? "object-contain p-8"
              : image.includes("tickets-thumb")
                ? "object-contain bg-black"
                : "object-cover"
          }`}
        />
      </div>

      <div className="flex flex-1 flex-col p-3">
        <div className="flex items-center justify-between px-1">
          <h3 className="font-display mb-2 text-base tracking-tight md:text-xl">
            {title}
          </h3>
          <div className="font-body flex items-center gap-2 text-sm">
            <StatusDot color={color} />
            {status}
          </div>
        </div>

        <p className="font-body mb-4 flex-1 px-1 text-sm text-neutral-600 md:text-base">
          {description}
        </p>

        {(liveLink || githubLink) && (
          <div
            className={`mt-auto grid gap-3 p-1 ${githubLink && liveLink ? "grid-cols-2" : "grid-cols-1"}`}
          >
            {liveLink && (
              <RingButton
                text="View Live"
                icon={CircleArrowRight}
                href={liveLink}
                size="md"
                target="_blank"
                rel="noopener noreferrer"
              />
            )}
            {githubLink && (
              <RingButton
                text="Github"
                icon={GitHubIcon}
                href={githubLink}
                size="sm"
                target="_blank"
                rel="noopener noreferrer"
              />
            )}
          </div>
        )}
      </div>
    </div>
  );
};

export default ProjectCard;
