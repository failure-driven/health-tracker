import React from "react";
import { Link } from "react-router-dom";
import { useQuery } from "@apollo/client";
import gql from "graphql-tag";

const TEST_QUERY = gql`
  {
    testField
  }
`;

const Header = () => {
  const { loading, error, data } = useQuery(TEST_QUERY, {});
  if (loading) return <p>Loading ...</p>;
  if (error) return <p>{`Error! ${error.message}`}</p>;

  return (
    <nav className="navbar navbar-expand-lg navbar-light bg-light">
      <div className="container">
        <Link to="/" className="navbar-brand">
          Health Tracker
        </Link>
        <button
          className="navbar-toggler"
          type="button"
          data-toggle="collapse"
          data-target="#navbarSupportedContent"
          aria-controls="navbarSupportedContent"
          aria-expanded="false"
          aria-label="Toggle navigation"
        >
          <span className="navbar-toggler-icon"></span>
        </button>

        <div className="collapse navbar-collapse" id="navbarSupportedContent">
          <ul className="navbar-nav mr-auto">
            <li className="nav-item">
              <Link to="/stats" className="nav-link">
                stats
              </Link>
            </li>
          </ul>
          <ul className="navbar-nav ml-auto">
            <li className="nav-item dropdown">
              <a
                className="nav-link dropdown-toggle"
                href="#"
                id="navbarDropdown"
                role="button"
                data-toggle="dropdown"
                aria-haspopup="true"
                aria-expanded="false"
              >
                {data.testField}
              </a>
              <div
                className="dropdown-menu pb-0"
                aria-labelledby="navbarDropdown"
              >
                <a className="dropdown-item disabled" href="#">
                  Action
                </a>
                <a className="dropdown-item disabled" href="#">
                  Another action
                </a>
                <div className="dropdown-divider"></div>
                <Link className="dropdown-item">Sign out</Link>
              </div>
            </li>
            <li className="nav-item"></li>
          </ul>
        </div>
      </div>
    </nav>
  );
};

export default Header;
