"use client";

import React from "react";
import { motion } from "framer-motion";

type SkillPillProps = {
  skillName: string;
  icon?: React.ReactNode;
};

const SkillPill = ({ skillName, icon }: SkillPillProps) => {
  return (
    <motion.div
      className="flex w-fit cursor-pointer items-center gap-2 overflow-hidden border-4 border-black bg-white px-2 py-1 text-sm text-black md:px-4 md:py-2"
      initial="rest"
      whileHover="hover"
      animate="rest"
    >
      <div className="w-4 h-4 md:w-6 md:h-6 relative flex-shrink-0 overflow-hidden">
        <motion.span
          className="absolute inset-0 flex items-center justify-center"
          variants={{
            rest: { y: 0, opacity: 1 },
            hover: { y: "-100%", opacity: 0 },
          }}
          transition={{ duration: 0.25, ease: "easeInOut" }}
        >
          {icon}
        </motion.span>

        <motion.span
          className="absolute inset-0 flex items-center justify-center"
          variants={{
            rest: { y: "100%", opacity: 0 },
            hover: { y: 0, opacity: 1 },
          }}
          transition={{ duration: 0.35, ease: "easeInOut" }}
        >
          {icon}
        </motion.span>
      </div>

      <span className="font-medium whitespace-nowrap">{skillName}</span>
    </motion.div>
  );
};

export default SkillPill;