// previous imports
import React, { useState, useEffect } from "react";

import { initializeLogger } from "common/logger";

import { setAuthHeaders } from "./apis/axios";

const App = () => {
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    /*eslint no-undef: "off"*/
    initializeLogger();
    setAuthHeaders(setLoading);
    // logger.info("Never use console.log");
    // logger.error("Never use console.error");
  }, []);

  if (loading) {
    return <h1>Loading...</h1>;
  }

  return <>Home</>;
};

export default App;
