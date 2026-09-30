"use client";
import { useState } from "react";
import { taskbarData } from "./constants";

const Taskbar = () => {
  const [hovered, setHovered] = useState(false);
  return (
    <div className="fixed bottom-8 left-1/2 z-50 flex -translate-x-1/2 items-center gap-3 border-8 border-black bg-white p-3">
      {taskbarData.map((item) => (
        <a
          key={item.name}
          href={item.href}
          target="_blank"
          rel="noopener noreferrer"
          className="border-4 border-black bg-white p-2 transition-transform duration-300 hover:-translate-y-1"
        >
          {item.icon}
        </a>
      ))}

      <div
        onMouseEnter={() => setHovered(true)}
        onMouseLeave={() => setHovered(false)}
        className="mr-1 ml-1 flex items-center gap-2"
      >
        <div className="relative flex items-center justify-center">
          <span className="absolute inline-flex h-3 w-3 animate-ping bg-black opacity-40" />
          <span className="relative inline-flex h-3 w-3 bg-black" />
        </div>
        <span
          className={`font-body overflow-hidden text-sm font-bold whitespace-nowrap text-black transition-all duration-500 ${
            hovered ? "max-w-xs opacity-100" : "max-w-0 opacity-0"
          }`}
        >
          Open to work
        </span>
      </div>
    </div>
  );
};

export default Taskbar;
