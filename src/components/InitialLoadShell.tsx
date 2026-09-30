"use client";

import React, { createContext, useContext, useState } from "react";
import LoadingScreen from "@/components/LoadingScreen";
import Taskbar from "@/components/Taskbar/Taskbar";

type InitialLoadShellProps = {
  children: React.ReactNode;
};

const SplashReadyContext = createContext(true);

export const useSplashReady = () => useContext(SplashReadyContext);

let hasShownInitialLoader = false;

const InitialLoadShell = ({ children }: InitialLoadShellProps) => {
  const [loading, setLoading] = useState(!hasShownInitialLoader);

  const handleLoadingFinish = () => {
    hasShownInitialLoader = true;
    setLoading(false);
  };

  return (
    <SplashReadyContext.Provider value={!loading}>
      <div className="bg-white">
        {loading && <LoadingScreen onFinish={handleLoadingFinish} />}
        {children}
        {!loading && <Taskbar />}
      </div>
    </SplashReadyContext.Provider>
  );
};

export default InitialLoadShell;
