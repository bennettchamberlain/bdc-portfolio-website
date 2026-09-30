"use client";

import { useEffect } from "react";

const OpenApp = ({ title, url }: { title: string; url: string }) => {
  useEffect(() => {
    window.location.replace(url);
  }, [url]);

  return (
    <p className="font-body mt-8 text-lg">
      Opening {title}.{" "}
      <a href={url} className="underline">
        Go there
      </a>{" "}
      if it stays on this page.
    </p>
  );
};

export default OpenApp;
