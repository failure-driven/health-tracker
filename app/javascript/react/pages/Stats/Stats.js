import React from 'react';
import gql from "graphql-tag";
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
    <ul className="list-group">
      <li className="list-group-item">
        <div className="row">
          <div className="col-sm-3"><strong>Date</strong></div>
          <div className="col-sm-9"><strong>Data</strong></div>
        </div>
      </li>
      {data.dailyStats.map((stat) => (
        <li key="{stat.id}" className="list-group-item">
          <div className="row">
            <div className="col-sm-3">{stat.date}</div>
            <div className="col-sm-9">{Object.keys(stat.data).map((key) => (
              <dl className="row">
                <dt className="col-2">{key}</dt>
                <dd>{stat.data[key]}</dd>
              </dl>
            ))}</div>
          </div>
        </li>
      ))}
    </ul>
)};

export default Stats;
