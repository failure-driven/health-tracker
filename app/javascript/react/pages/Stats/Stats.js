import React from "react";
import gql from "graphql-tag";
import moment from "moment";
import { useQuery } from "@apollo/client";

const TEST_QUERY = gql`
  {
    dailyStats {
      id
      data
      date
    }
  }
`;

const Stats = () => {
  const { loading, error, data } = useQuery(TEST_QUERY, {});
  if (loading) return <p>Loading ...</p>;
  if (error) return <p>{`Error! ${error.message}`}</p>;

  return (
    <ul className="list-group daily-stats-list">
      <li className="list-group-item">
        <div className="row">
          <div className="col-md-2">
            <strong>Date</strong>
          </div>
          <div className="col-md-10">
            <strong>Data</strong>
          </div>
        </div>
      </li>
      {data.dailyStats.map((stat) => (
        <li key={stat.id} className="list-group-item daily-stats-item">
          <div className="row">
            <div className="col-md-2">{moment(stat.date).format("L")}</div>
            <div className="col-md-10">
              {Object.keys(stat.data).map((key) => (
                <dl className="row" key={key}>
                  <dt className="col-4 text-right">{key}</dt>
                  <dd className="col-8">{stat.data[key]}</dd>
                </dl>
              ))}
            </div>
          </div>
        </li>
      ))}
    </ul>
  );
};

export default Stats;
