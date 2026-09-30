import { ArrowUpRight } from "lucide-react";
import { about, site, skillGroups } from "@/data/site";

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
          <p className="font-body mb-6 text-base leading-relaxed text-neutral-700 sm:text-lg md:text-xl">
            {about.philosophy}
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
              href={site.linkedin}
              target="_blank"
              rel="noopener noreferrer"
              className="font-body flex items-center gap-1 text-sm font-bold text-black hover:underline sm:text-base"
            >
              LinkedIn <ArrowUpRight size={16} />
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

        <div className="mt-8 grid grid-cols-1 gap-8 md:grid-cols-2">
          {skillGroups.map((group) => (
            <div
              key={group.title}
              className={`bdc-frame p-6 md:p-8 ${group.title === "Certification" ? "md:col-span-2" : ""}`}
            >
              <h3 className="font-display text-2xl tracking-tight md:text-3xl">{group.title}</h3>
              <p className="font-body mt-2 text-sm text-neutral-500 md:text-base">{group.note}</p>
              <ul className="mt-5 flex flex-wrap gap-2">
                {group.items.map((item) => (
                  <li
                    key={item}
                    className="font-body border-4 border-black bg-black px-3 py-1.5 text-sm text-white md:text-base"
                  >
                    {item}
                  </li>
                ))}
              </ul>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
};

export default About;
