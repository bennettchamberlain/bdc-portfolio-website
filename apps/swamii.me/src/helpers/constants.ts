export type Project = {
  id: number;
  name: string;
  description: string;
  image: string;
  link?: string;
  github?: string;
  status?: "live" | "discontinued" | "building";
  projectBg: string;
};

export const projects: Project[] = [
  {
    id: 0,
    name: "Companion Intelligence",
    description:
      "The grandest one yet. One surface for a completely local ecosystem: self-hosted server infra, digital memory, and a harness layer for agents and apps you own. Posed as research. Warming up for business sales and consumer sales alike.",
    image: "/images/ci-logo.svg",
    link: "https://ci.computer",
    status: "building",
    projectBg: "/images/ci-logo.svg",
  },
  {
    id: 1,
    name: "Event Ticketing Web App",
    description:
      "Guest, press, and hotel ticketing for the Mr. Brainwash Art Museum in Beverly Hills. Automated email with a QR code that scanned at the door.",
    image: "/images/tickets-thumb.png",
    link: "https://www.mrbrainwashartmuseum.com/tickets/",
    status: "live",
    projectBg: "/images/tickets-thumb.png",
  },
  {
    id: 2,
    name: "Street Art iPad App",
    description:
      "Mr. Brainwash Paints. An easy Photoshop-style toy preloaded with his assets, splatter brushes, stencils, and layers.",
    image: "/images/paintapp-still-1.png",
    status: "live",
    projectBg: "/images/paintapp-still-1.png",
  },
  {
    id: 3,
    name: "This Site",
    description:
      "Personal site, rebuilt. Swamii's Next.js stack and type, Bennett's 8px black frames and copy. No Firebase. Just files in the repo.",
    image: "/images/headshot.jpg",
    github: "https://github.com/bennettchamberlain/bdc-portfolio-website",
    status: "building",
    projectBg: "/images/headshot.jpg",
  },
];
