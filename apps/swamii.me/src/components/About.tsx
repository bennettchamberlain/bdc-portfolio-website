import { ArrowUpRight } from "lucide-react";
import { about, site } from "@/data/site";

const About = () => {
  return (
    <section className="bg-white text-black">
      <div className="px-[3%] py-10 md:py-15">
        <div className="bdc-frame p-6 md:p-10">
          <p className="font-body mb-4 text-base leading-relaxed text-neutral-700 sm:text-lg md:text-xl">
            {about.intro}
          </p>
          <p className="font-body mb-4 text-base leading-relaxed text-neutral-700 sm:text-lg md:text-xl">
            {about.location}
          </p>
          <p className="font-body mb-4 text-base leading-relaxed text-neutral-700 sm:text-lg md:text-xl">
            {about.philosophy}
          </p>
          <p className="font-body mb-6 text-base leading-relaxed text-neutral-700 sm:text-lg md:text-xl">
            {about.hobbies}
          </p>

          <div className="flex flex-wrap gap-6 py-2">
            <a
              href={site.github}
              target="_blank"
              rel="noopener noreferrer"
              className="font-body flex items-center gap-1 text-sm font-bold text-black hover:underline sm:text-base"
            >
              GitHub <ArrowUpRight size={16} />
            </a>
            <a
              href={`mailto:${site.email}`}
              className="font-body flex items-center gap-1 text-sm font-bold text-black hover:underline sm:text-base"
            >
              Email <ArrowUpRight size={16} />
            </a>
            <a
              href={site.resume}
              target="_blank"
              rel="noopener noreferrer"
              className="font-body flex items-center gap-1 text-sm font-bold text-black hover:underline sm:text-base"
            >
              Resume <ArrowUpRight size={16} />
            </a>
          </div>
        </div>
      </div>
    </section>
  );
};

export default About;
