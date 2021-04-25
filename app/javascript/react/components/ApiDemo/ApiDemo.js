import React from 'react';
import { useQuery } from '@apollo/client';
import gql from 'graphql-tag';

const DAILY_STATS_ALL_QUERY = gql`
  {
    dailyStats {
      data
    }
  }
`;

const ApiDemo = () => {
  const { loading, error, data } = useQuery(DAILY_STATS_ALL_QUERY, {});
  if (loading) return <p>Loading ...</p>;
  if (error) return <p>{`Error! ${error.message}`}</p>;

  return (
    <div>
      Api Demo
      <pre>{JSON.stringify(data)}</pre>
    </div>
  );
};

export default ApiDemo;
