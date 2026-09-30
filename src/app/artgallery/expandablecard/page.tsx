"use client";

import { Squircle } from "@squircle-js/react";
import { ChevronDown, ChevronUp } from "lucide-react";
import { motion, AnimatePresence } from "motion/react";
import { useState } from "react";
import { ArrowLeft } from "lucide-react";
import { useRouter } from "next/navigation";

const cards = [
  {
    icon: (
      <svg
        xmlns="http://www.w3.org/2000/svg"
        viewBox="0 0 24 24"
        width="24"
        height="24"
        fill="none"
        stroke="#ffffff"
        strokeWidth="1.5"
        strokeLinejoin="round"
      >
        <path d="M16 20H2L5.22457 10.7557C6.79555 6.25189 7.58104 4 9 4C10.3373 4 11.1119 6 12.5116 10" />
        <path
          d="M6 20H22L17.4066 12.6585C15.8806 10.2195 15.1176 9 14 9C12.8824 9 12.1194 10.2195 10.5934 12.6585L9.12837 15"
          strokeLinecap="round"
        />
      </svg>
    ),
    title: "Hiking",
    description: "Blue Ridge Trail",
    date: "12 August",
  },
  {
    icon: (
      <svg
        xmlns="http://www.w3.org/2000/svg"
        viewBox="0 0 24 24"
        width="24"
        height="24"
        fill="none"
        stroke="#ffffff"
        strokeWidth="1.5"
        strokeLinecap="round"
        strokeLinejoin="round"
      >
        <path d="M20.8198 3.1806C10.9252 1.49952 2.07124 11.6154 3.03263 20.9246C12.3645 21.8836 22.505 13.0512 20.8198 3.1806Z" />
        <path d="M6.95898 16.9961H6.96796" />
        <path d="M16.959 6.99612H16.968" />
        <path d="M9.4958 14.4781C8.80348 13.7875 8.80348 12.6678 9.4958 11.9772L11.9649 9.51407C12.6572 8.82344 13.7796 8.82344 14.4719 9.51407C15.1643 10.2047 15.1643 11.3244 14.4719 12.015L12.0028 14.4781C11.3105 15.1688 10.1881 15.1688 9.4958 14.4781Z" />
      </svg>
    ),
    title: "Kayaking",
    description: "Crystal Bay",
    date: "8 August",
  },
  {
    icon: (
      <svg
        xmlns="http://www.w3.org/2000/svg"
        viewBox="0 0 24 24"
        width="24"
        height="24"
        fill="none"
        stroke="#ffffff"
        strokeWidth="1.5"
        strokeLinejoin="round"
      >
        <path
          d="M17.6709 16C18.5134 14.8191 19 13.4095 19 12C19 8 17.5 7 17.5 7C16.9615 8.5 15.5 9 15.5 9C15.5 3.5 12 2 12 2C12 2 8.5 3.5 8.5 9C8.5 9 7.03846 8.5 6.5 7C6.5 7 5 8 5 12C5 13.4095 5.48656 14.8191 6.32905 16"
          strokeLinecap="round"
        />
        <path d="M19 19H5C4.44772 19 4 19.4477 4 20V21C4 21.5523 4.44772 22 5 22H19C19.5523 22 20 21.5523 20 21V20C20 19.4477 19.5523 19 19 19Z" />
        <path
          d="M14.5 16C14.5 13.5 12 11 12 11C12 11 9.5 13.5 9.5 16"
          strokeLinecap="round"
        />
      </svg>
    ),
    title: "Bonfire",
    description: "Sunset Valley",
    date: "30 July",
  },
];

export default function Home() {
  const [showAll, setShowAll] = useState(false);
  const router = useRouter();

  return (
    <div className="flex min-h-screen items-center justify-center bg-[#141414] font-sans">
         <button
        onClick={() => router.push('/artgallery')}
        className="absolute top-5 left-5 flex items-center gap-2 text-white bg-white/10 hover:bg-white/20 px-4 py-2 rounded-xl backdrop-blur-lg border border-white/15 transition-all"
      >
        <ArrowLeft size={18} />
        Back to Gallery
      </button>  
      <AnimatePresence>
        <motion.div
          layout
          transition={{
            layout: {
              type: "spring",
              stiffness: 250,
              damping: 24,
            }
          }}
          className="relative flex flex-col items-center"
          style={{
            paddingTop: showAll ? 0 : "120px",
            paddingBottom: showAll ? 0 : "20px",
            width: "380px",
          }}
        >
          {cards.map((card, index) => (
            <motion.div
              key={index}
              layout
              transition={{
                layout: {
                  type: "spring",
                  stiffness: 350,
                  damping: 24,
                },
              }}
              animate={{
                y: showAll ? 0 : index * 7,
                scale: showAll ? 1 : 1 - index * 0.03,
              }}
              style={{
                position: showAll ? "relative" : "absolute",
                top: 0,
                width: "380px",
                zIndex: cards.length - index,
              }}
              className="mb-4 "
            >
              <Squircle
                key={index}
                cornerRadius={20}
                cornerSmoothing={0.6}

                className="relative flex w-[380px] items-start gap-4 border border-neutral-950 bg-[#1D1D1D] p-3 shadow-[inset_-2px_2px_2px_#252525]"
              >
                <div className="flex h-14 w-14 items-center justify-center rounded-2xl bg-[#1D1D1D] shadow-[inset_-3px_2px_2px_#252525] border border-neutral-950">
                  {card.icon}
                </div>

                <div className="flex flex-col pr-16">
                  <h2 className="text-lg font-semibold text-white">
                    {card.title}
                  </h2>

                  <p className="text-sm text-neutral-400">
                    {card.description}
                  </p>
                </div>

                <span className="absolute bottom-4 right-4 text-sm font-semibold text-neutral-600">
                  {card.date}
                </span>
              </Squircle>
            </motion.div>
          ))}

          <motion.button
            layout
            type="button"
            onClick={() => setShowAll((current) => !current)}
            className="mt-5 h-10 w-[110px] rounded-full focus:outline-none border border-neutral-900 bg-[#1D1D1D]  shadow-[inset_-2px_2px_2px_#252525]"
            transition={{
              layout: {
                type: "spring",
                stiffness: 220,
                damping: 24,
              },
            }}
          >
            <div className="flex items-center justify-center gap-1 pl-2 text-sm font-semibold text-white">
              <AnimatePresence mode="wait" initial={false}>
                <motion.span
                  key={showAll ? "hide" : "show"}
                  initial={{ opacity: 0 }}
                  animate={{ opacity: 1 }}
                  exit={{ opacity: 0 }}
                  transition={{ duration: 0.15 }}
                  className="inline-block"
                >
                  {showAll ? "Hide" : "Show all"}
                </motion.span>
              </AnimatePresence>

              <span className="flex items-center justify-center">
                {showAll ? <ChevronUp size={16} /> : <ChevronDown size={16} />}
              </span>
            </div>
          </motion.button>
        </motion.div>
      </AnimatePresence>
    </div>
  );
}