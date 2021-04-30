import React from "react";

const Nav = () => {
  return (
    <ul class="nav nav-tabs mt-3">
      <li class="nav-item">
        <a class="nav-link active" href="#">Stats</a>
      </li>
      <li class="nav-item">
        <a class="nav-link disabled" href="#">Chart</a>
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
