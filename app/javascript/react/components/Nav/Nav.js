import React from "react";
import { NavLink } from "react-router-dom";

const Nav = () => {
  return (
    <ul class="nav nav-tabs my-3">
      <li class="nav-item">
        <NavLink className="nav-link" activeClassName="active" to="app">Add</NavLink>
      </li>
      <li class="nav-item">
        <NavLink className="nav-link" activeClassName="active" to="app/stats">Stats</NavLink>
      </li>
      <li class="nav-item">
        <NavLink className="nav-link" activeClassName="active" to="app/charts">Charts</NavLink>
      </li>
      <li class="nav-item">
        <a class="nav-link disabled" href="#">Challenge</a>
      </li>
      <li class="nav-item">
        <a class="nav-link disabled" href="#">Ranking</a>
      </li>
    </ul>
  );
};

export default Nav;
