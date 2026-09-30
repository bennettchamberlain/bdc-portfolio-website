import React, { ReactNode } from "react";
// import RulerLines from "./RulerLines";

interface ContainerProps {
  children: ReactNode;
  className?: string;
}

const Container: React.FC<ContainerProps> = ({ children, className }) => {
  return (
    <div
      className={`relative mx-auto flex w-full flex-row overflow-x-hidden bg-white ${className ?? ""}`}
    >
      {/* <RulerLines variant="left" /> */}
      {children}
      {/* <RulerLines variant="right" /> */}
    </div>
  );
};

export default Container;
