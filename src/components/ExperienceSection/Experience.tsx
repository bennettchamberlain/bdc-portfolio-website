import React from "react";
import Experience from "./ExperianceComponent";
import { education, experience } from "@/data/site";

const ExperienceSection = () => {
  return (
    <div className="flex flex-col py-10">
      {experience.map((job, index) => (
        <Experience
          key={job.company}
          logo=""
          initials={job.initials}
          company={job.company}
          role={job.role}
          duration={`${job.duration} · ${job.location}`}
          points={job.points}
          rounded="none"
          skills={job.skills}
          first={index === 0}
        />
      ))}
      <div className="px-[calc(3%+2rem)] pt-8 md:px-[calc(3%+3rem)]">
        <p className="font-display text-2xl uppercase">{education.school}</p>
        <p className="font-body text-base md:text-lg">{education.degree}</p>
        <p className="font-body text-sm opacity-70 md:text-base">
          {education.duration} · {education.location}
        </p>
      </div>
    </div>
  );
};

export default ExperienceSection;
