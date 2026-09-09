import type { Metadata } from "next";
import localFont from "next/font/local";
import { Geist, Geist_Mono, Space_Grotesk } from "next/font/google";
import { GeistPixelSquare } from "geist/font/pixel";
import { TooltipProvider } from "@/components/ui/tooltip";
import { site } from "@/data/site";
import "./globals.css";

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

const spaceGrotesk = Space_Grotesk({
  variable: "--font-space-grotesk",
  subsets: ["latin"],
  weight: ["400", "500", "600", "700"],
});

const primetime = localFont({
  src: "../../public/fonts/PRIMETIME.ttf",
  variable: "--font-primetime",
  display: "swap",
});

const helvetica = localFont({
  src: [
    { path: "../../public/fonts/helvetica-light-1.ttf", weight: "300" },
    { path: "../../public/fonts/Helvetica.ttf", weight: "400" },
    { path: "../../public/fonts/Helvetica-Bold.ttf", weight: "700" },
    { path: "../../public/fonts/Helvetica-Bold.ttf", weight: "800" },
    { path: "../../public/fonts/Helvetica-Bold.ttf", weight: "900" },
  ],
  variable: "--font-helvetica",
  display: "swap",
});

export const metadata: Metadata = {
  title: site.title,
  description: site.description,
  icons: {
    icon: "/images/headshot.jpg",
  },
  keywords: [
    "Bennett Chamberlain",
    "Software Engineer",
    "Project Manager",
    "Flutter",
    "Next.js",
    "Portfolio",
  ],
  openGraph: {
    title: site.title,
    description: site.description,
    siteName: site.name,
    images: [
      {
        url: "/images/headshot.jpg",
        width: 1200,
        height: 630,
        alt: site.name,
      },
    ],
    locale: "en_US",
    type: "website",
  },
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en" suppressHydrationWarning>
      <body
        className={`${geistSans.variable} ${geistMono.variable} ${GeistPixelSquare.variable} ${spaceGrotesk.variable} ${primetime.variable} ${helvetica.variable} antialiased`}
      >
        <TooltipProvider>{children}</TooltipProvider>
      </body>
    </html>
  );
}
