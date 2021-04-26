import React from "react";
import { BrowserRouter, Route, Switch } from "react-router-dom";
import Header from "../Header/Header";
import Home from "../../pages/Home/Home";
import Footer from "../Footer/Footer";
import style from "./layout.module.scss";

const LayoutComponent = () => {
  return (
    <BrowserRouter className="akash">
      <div className={style.container}>
        <Header />
        <Switch>
          <Route exact path="/" component={Home} />
        </Switch>
        <Footer />
      </div>
    </BrowserRouter>
  );
};

export default LayoutComponent;
