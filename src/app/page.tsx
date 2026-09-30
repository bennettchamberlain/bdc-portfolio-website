import About from "@/components/About";
import ContactSection from "@/components/ContactSection";
import WritingsSection from "@/components/WritingsSection";
import Container from "@/components/Container";
import HeroSection from "@/components/HeroSection";
import Navbar from "@/components/Navbar";
import ProjectsSection from "@/components/ProjectsSection";
import SectionHeading from "@/components/SectionHeading";
import ExperienceSection from "@/components/ExperienceSection/Experience";
import LoadingScreen from "@/components/InitialLoadShell";

const page = () => {
  return (
    <LoadingScreen>
      <Container>
        <div className="w-full">
          <div className="bg-white text-black">
            <Navbar />
            <section data-section-label="Hero section">
              <HeroSection />
            </section>
            <section data-section-label="Projects section">
              <SectionHeading title="Projects" />
              <ProjectsSection />
            </section>
            <section data-section-label="Experience section">
              <SectionHeading title="Experience" />
              <ExperienceSection />
            </section>
            <section data-section-label="About section">
              <SectionHeading title="About Me" />
              <About />
            </section>
            <section id="writings" data-section-label="Writings section">
              <SectionHeading title="Writings" />
              <WritingsSection />
            </section>
            <section data-section-label="Contact section">
              <ContactSection />
            </section>
          </div>
        </div>
      </Container>
    </LoadingScreen>
  );
};

export default page;
