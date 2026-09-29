import { storageImage } from "@/lib/firebase";

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
    name: "Lita Hotels",
    description:
      "A robot hotel stood up in 90 days. Several robot types, an elevator on a reverse-engineered protocol, and guest requests over SMS.",
    image: storageImage("/images/projects/lita-hotels.jpg"),
    links: [
      { label: "Watch", href: "https://www.youtube.com/watch?v=bzdVsxfPiUs" },
      { label: "Essay", href: "https://hook.org/anselm/essays/medium/elevator-pitch" },
      { label: "Website", href: "https://litahotel.com" },
    ],
    status: "live",
    projectBg: storageImage("/images/projects/lita-hotels.jpg"),
  },
  {
    id: 11,
    name: "Webbed Feet",
    description:
      "Website for a Montreal radio show, drawn as a map of artists, collaborators, and the people who shaped them.",
    image: storageImage("/images/projects/webbed-feet.png"),
    link: "https://webbedfeetradio.ca",
    status: "live",
    projectBg: storageImage("/images/projects/webbed-feet.png"),
  },
  {
    id: 14,
    name: "Companion Intelligence",
    description:
      "Private server for local models and agents, with an app store and Companion Memory on hardware you own. A 3D avatar talks in the room over WebXR, on those same models.",
    image: "/images/ci-logo.svg",
    link: "https://ci.computer",
    status: "building",
    projectBg: "/images/ci-logo.svg",
  },
  {
    id: 1,
    name: "StudioTimes",
    description:
      "Studio booking and ops. The product is live, and so is the community next door.",
    image: storageImage("/images/studiotimes-logo.png"),
    links: [
      { label: "studiotimes.io", href: "https://studiotimes.io" },
      { label: "Community", href: "https://community.studiotimes.io" },
    ],
    status: "live",
    projectBg: storageImage("/images/studiotimes-logo.png"),
  },
  {
    id: 13,
    name: "Transcend Collective",
    description:
      "Storefront for a Los Angeles streetwear label, sitting on Shopify.",
    image: storageImage("/images/projects/transcend-select.jpg"),
    link: "https://www.transcendcollective.la/",
    status: "live",
    projectBg: storageImage("/images/projects/transcend-select.jpg"),
  },
  {
    id: 3,
    name: "Ciel Ouvert",
    description:
      "Festival site for Ciel Ouvert, including a catalog of 127 Belgian films about the prison system.",
    image: storageImage("/images/projects/ciel-ouvert.png"),
    links: [
      { label: "Site", href: "https://www.ciel-ouvert.be/en" },
      { label: "Catalog", href: "https://www.ciel-ouvert.be/en/catalog" },
    ],
    status: "live",
    projectBg: storageImage("/images/projects/ciel-ouvert.png"),
  },
  {
    id: 4,
    name: "genreless",
    description:
      "Site and archive for genreless Media. Creative direction, release rollouts, photography, and commercial production.",
    image: storageImage("/images/projects/genreless.png"),
    link: "https://www.genreless.media/",
    status: "live",
    projectBg: storageImage("/images/projects/genreless.png"),
  },
  {
    id: 5,
    name: "miniCEO",
    description:
      "A sales CRM that keeps the pipeline simple and does the busywork underneath. The product and the site.",
    image: storageImage("/images/projects/miniceo-site.png"),
    links: [
      { label: "Site", href: "https://miniceocrm.com/" },
      { label: "App", href: "https://app.miniceocrm.com/" },
    ],
    status: "live",
    projectBg: storageImage("/images/projects/miniceo-site.png"),
  },
  {
    id: 6,
    name: "Rent Fiesta",
    description:
      "Booking for party vendors. Planners find a service, vendors run the business, on the web and in the app.",
    image: storageImage("/images/projects/rentfiesta.png"),
    link: "https://rentfiestausa.com/",
    status: "live",
    projectBg: storageImage("/images/projects/rentfiesta.png"),
  },
  // {
  //   id: 7,
  //   name: "Sadie Scott",
  //   description:
  //     "Photography portfolio for Sadie Scott, rebuilt on Next.js and Sanity.",
  //   image: storageImage("/images/projects/sadie-scott.jpg"),
  //   link: "https://sadiescott.com/",
  //   status: "building",
  //   projectBg: storageImage("/images/projects/sadie-scott.jpg"),
  // },
  {
    id: 8,
    name: "Steady Fence & Railing",
    description:
      "Quote builder for a San Francisco railing company. Draw the rail, see the price, email the diagram.",
    image: storageImage("/images/projects/steadyfnr.png"),
    link: "https://www.steadyfnr.com/",
    status: "live",
    projectBg: storageImage("/images/projects/steadyfnr.png"),
  },
  {
    id: 9,
    name: "Superhot Fabrication",
    description:
      "Site for a metal shop. Process, gallery, and shop, with the shop's actual energy.",
    image: storageImage("/images/projects/superhot.png"),
    link: "https://superhotfab.com/",
    status: "live",
    projectBg: storageImage("/images/projects/superhot.png"),
  },
  // {
  //   id: 10,
  //   name: "The 80% Bill",
  //   description:
  //     "A pledge and a voter guide for 21 bills most Americans already agree on. More than 25,000 pledges.",
  //   image: storageImage("/images/projects/eighty-percent.png"),
  //   link: "https://the80percentbill.com/",
  //   status: "live",
  //   projectBg: storageImage("/images/projects/eighty-percent.png"),
  // },
  {
    id: 12,
    name: "Baked Cravings",
    description:
      "Site and marketing for a nut-free bakery. The brand later cleared $100M+ through deals with large retailers.",
    image: storageImage("/images/projects/baked-cravings.png"),
    link: "https://www.bakedcravings.com/",
    status: "live",
    projectBg: storageImage("/images/projects/baked-cravings.png"),
  },
  {
    id: 18,
    name: "512 Counsel",
    description:
      "Criminal defense site for Laurie Drymalla in Austin. Former prosecutor, and a municipal court judge.",
    image: storageImage("/images/projects/512-counsel.png"),
    link: "https://www.512counsel.com/",
    status: "live",
    projectBg: storageImage("/images/projects/512-counsel.png"),
  },
  {
    id: 19,
    name: "Law Offices of Paul D. Scott",
    description:
      "Site for a whistleblower practice. False Claims Act, IRS, SEC, and the other reward programs.",
    image: storageImage("/images/projects/lopds.png"),
    link: "https://lopds.com",
    status: "live",
    projectBg: storageImage("/images/projects/lopds.png"),
  },
  {
    id: 15,
    name: "Event Ticketing Web App",
    description:
      "Guest, press, and hotel ticketing for the Mr. Brainwash Art Museum in Beverly Hills. Automated email with a QR code that scanned at the door.",
    image: storageImage("/images/tickets-thumb.png"),
    link: "https://www.mrbrainwashartmuseum.com/tickets/",
    status: "live",
    projectBg: storageImage("/images/tickets-thumb.png"),
  },
  {
    id: 16,
    name: "Street Art iPad App",
    description:
      "Mr. Brainwash Paints. An easy Photoshop-style toy preloaded with his assets, splatter brushes, stencils, and layers.",
    image: storageImage("/images/paintapp-still-1.png"),
    status: "live",
    projectBg: storageImage("/images/paintapp-still-1.png"),
  },
  {
    id: 2,
    name: "Black Soldier Fly",
    description:
      "Published paper on when and where the flies breed. I built the climate data behind the temporal patterns and the biogeographical hotspots.",
    image: storageImage("/images/projects/bsf.png"),
    links: [
      {
        label: "Published Research",
        href: "https://www.researchgate.net/publication/407068727_When_and_where_Data_insights_for_identifying_temporal_patterns_in_BSF_behavior_and_biogeographical_hotspots",
      },
    ],
    status: "live",
    projectBg: storageImage("/images/projects/bsf.png"),
  },
  {
    id: 17,
    name: "This Site",
    description:
      "Personal site, rebuilt. Next.js, 8px black frames, copy in the repo. No Firebase.",
    image: storageImage("/images/headshot.jpg"),
    github: "https://github.com/bennettchamberlain/bdc-portfolio-website",
    status: "building",
    projectBg: storageImage("/images/headshot.jpg"),
  },
];
