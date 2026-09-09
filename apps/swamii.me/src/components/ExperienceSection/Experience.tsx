import React from "react";
import Experience from "./ExperianceComponent";
import { experience } from "@/data/site";

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
    </div>
  );
};

export default ExperienceSection;
