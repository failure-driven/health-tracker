import React from "react";
import { BrowserRouter, Route, Switch } from "react-router-dom";
import Home from "../../pages/Home/Home";
import Stats from "../../pages/Stats/Stats";
import Nav from "../Nav/Nav";
import style from "./layout.module.scss";

const LayoutComponent = () => (
  <BrowserRouter className="akash">
    <div className={style.container}>
      <Nav />
      <Switch>
        <Route exact path="/" component={Home} />
        <Route exact path="/stats" component={Stats} />
      </Switch>
    </div>
  </BrowserRouter>
);

export default LayoutComponent;
