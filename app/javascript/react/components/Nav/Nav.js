import React from "react";
import { NavLink } from "react-router-dom";

const Nav = () => (
  <ul className="nav nav-tabs my-3">
    <li className="nav-item">
      <NavLink className="nav-link" activeClassName="active" to="/app">
        Add
      </NavLink>
    </li>
    <li className="nav-item">
      <NavLink className="nav-link" activeClassName="active" to="/app/stats">
        Stats
      </NavLink>
    </li>
    <li className="nav-item">
      <NavLink className="nav-link" activeClassName="active" to="/app/charts">
        Charts
      </NavLink>
    </li>
    <li className="nav-item">
      <span className="nav-link disabled">Challenge</span>
    </li>
    <li className="nav-item">
      <span className="nav-link disabled">Ranking</span>
    </li>
  </ul>
);

export default Nav;
