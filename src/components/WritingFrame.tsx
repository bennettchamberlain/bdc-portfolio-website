"use client";

import { motion, useReducedMotion } from "motion/react";
import type { ReactNode } from "react";

const WritingFrame = ({
  children,
  index,
}: {
  children: ReactNode;
  index: number;
}) => {
  const reduceMotion = useReducedMotion();

  return (
    <motion.article
      className="bdc-frame justify-self-start overflow-hidden p-6 md:p-8"
      style={{ originX: 0 }}
      initial={reduceMotion ? { width: "100%" } : { width: "64%" }}
      whileInView={{ width: "100%" }}
      viewport={{ once: true, amount: 0.45 }}
      transition={{
        duration: 0.8,
        ease: [0.22, 1, 0.36, 1],
        delay: reduceMotion ? 0 : index * 0.08,
      }}
    >
      {children}
    </motion.article>
  );
};

export default WritingFrame;
