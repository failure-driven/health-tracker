import React from "react";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Home from "../../pages/Home/Home";
import Stats from "../../pages/Stats/Stats";
import Charts from "../../pages/Charts/Charts";
import Nav from "../Nav/Nav";
import style from "./layout.module.scss";

const LayoutComponent = () => {
  return (
  <BrowserRouter className="akash">
    <div className={style.container}>
      <Nav />
      <Routes>
        <Route path="app" element={<Home />} />
        <Route path="app/stats" element={<Stats />} />
        <Route path="app/charts" element={<Charts />} />
      </Routes>
    </div>
  </BrowserRouter>
)};

export default LayoutComponent;
