"use client";

import React from "react";
import ButtonBox from "./ButtonBox";
import { cn } from "@/lib/utils";

type RingButtonSize = "sm" | "md" | "lg";

type RingButtonProps = {
  text: string;
  href?: string;
  icon?: React.ElementType | React.ReactNode;
  size?: RingButtonSize;
  className?: string;
  target?: string;
  rel?: string;
};

const ringButtonSizeStyles: Record<
  RingButtonSize,
  { padding: string; textSize: string; iconSize: string }
> = {
  sm: {
    padding: "px-3 py-1.5 md:py-2",
    textSize: "text-xs md:text-sm",
    iconSize: "h-3.5 w-3.5 sm:h-4 sm:w-4",
  },
  md: {
    padding: "px-4 py-2 md:py-3",
    textSize: "text-xs md:text-base",
    iconSize: "h-4 w-4 sm:h-5 sm:w-5",
  },
  lg: {
    padding: "px-6 py-2 md:py-4",
    textSize: "text-xs md:text-lg",
    iconSize: "h-4 w-4 sm:h-5 sm:w-5",
  },
};

const RingButton = ({
  text,
  href,
  icon: Icon,
  size = "lg",
  className,
  target,
  rel,
}: RingButtonProps) => {
  const sizeStyles = ringButtonSizeStyles[size];

  let iconNode = null;
  if (Icon) {
    if (typeof Icon === "function") {
      iconNode = <Icon className={sizeStyles.iconSize} />;
    } else {
      iconNode = React.isValidElement(Icon)
        ? React.cloneElement(Icon as React.ReactElement<{ className?: string }>, {
            className: cn(
              (Icon.props as { className?: string })?.className,
              sizeStyles.iconSize,
            ),
          })
        : null;
    }
  }

  return (
    <ButtonBox
      href={href}
      target={target}
      rel={rel}
      border
      className={cn("gap-2", sizeStyles.padding, className)}
    >
      {iconNode}
      <span className={cn("font-extrabold", sizeStyles.textSize)}>{text}</span>
    </ButtonBox>
  );
};

export default RingButton;
