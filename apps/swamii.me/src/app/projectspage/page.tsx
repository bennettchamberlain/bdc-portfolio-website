import Container from "@/components/Container";
import Navbar from "@/components/Navbar";
import ProjectCard from "@/components/ProjectCard.tsx/ProjectCard";
import { Button } from "@/components/ui/button";
import { projects } from "@/helpers/constants";
import { Undo2 } from "lucide-react";
import Link from "next/link";

const page = () => {
  return (
    <div className="min-h-screen bg-white">
      <Container>
        <div className="w-full">
          <Navbar />
          <div className="px-4 pt-24 text-black sm:px-6 md:pt-28">
            <div className="mt-8 mb-4 text-lg font-semibold">
              <Link href="/" className="flex items-center gap-2">
                <Button
                  variant="primary"
                  size="lg"
                  className="rounded-none border-4 border-black"
                >
                  <Undo2 /> Back
                </Button>
              </Link>
            </div>
            <div className="mb-8 flex flex-col gap-4">
              <div className="font-display pt-6 text-5xl tracking-tight md:text-6xl">
                Projects
              </div>
              <div className="font-body text-xl text-neutral-600">
                Proof of work in one place.
              </div>
            </div>
            <hr className="border-0 border-t-8 border-black" />
            <div className="grid grid-cols-1 gap-8 py-8 md:grid-cols-2 lg:grid-cols-3">
              {projects.map((project) => (
                <ProjectCard
                  key={project.id}
                  image={project.image}
                  title={project.name}
                  description={project.description}
                  liveLink={project.link}
                  githubLink={project.github}
                  status={project.status}
                  projectBg={project.projectBg}
                />
              ))}
            </div>
          </div>
        </div>
      </Container>
    </div>
  );
};

export default page;
