export type ProjectLink = {
  label: string;
  href: string;
};

export type Project = {
  id: number;
  name: string;
  description: string;
  image: string;
  link?: string;
  links?: ProjectLink[];
  github?: string;
  status?: "live" | "discontinued" | "building";
  projectBg: string;
};

export const projects: Project[] = [
  {
    id: 0,
    name: "StudioTimes",
    description:
      "Studio booking and ops. The product is live, and so is the community next door.",
    image: "/images/studiotimes-logo.png",
    links: [
      { label: "studiotimes.io", href: "https://studiotimes.io" },
      { label: "community.studiotimes.io", href: "https://community.studiotimes.io" },
    ],
    status: "live",
    projectBg: "/images/studiotimes-logo.png",
  },
  {
    id: 1,
    name: "Companion Intelligence",
    description:
      "The grandest one yet. One surface for a completely local ecosystem: self-hosted server infra, digital memory, and a harness layer for agents and apps you own. Posed as research. Warming up for business sales and consumer sales alike.",
    image: "/images/ci-logo.svg",
    link: "https://ci.computer",
    status: "building",
    projectBg: "/images/ci-logo.svg",
  },
  {
    id: 2,
    name: "Event Ticketing Web App",
    description:
      "Guest, press, and hotel ticketing for the Mr. Brainwash Art Museum in Beverly Hills. Automated email with a QR code that scanned at the door.",
    image: "/images/tickets-thumb.png",
    link: "https://www.mrbrainwashartmuseum.com/tickets/",
    status: "live",
    projectBg: "/images/tickets-thumb.png",
  },
  {
    id: 3,
    name: "Street Art iPad App",
    description:
      "Mr. Brainwash Paints. An easy Photoshop-style toy preloaded with his assets, splatter brushes, stencils, and layers.",
    image: "/images/paintapp-still-1.png",
    status: "live",
    projectBg: "/images/paintapp-still-1.png",
  },
  {
    id: 4,
    name: "This Site",
    description:
      "Personal site, rebuilt. Next.js, 8px black frames, copy in the repo. No Firebase.",
    image: "/images/headshot.jpg",
    github: "https://github.com/bennettchamberlain/bdc-portfolio-website",
    status: "building",
    projectBg: "/images/headshot.jpg",
  },
];
