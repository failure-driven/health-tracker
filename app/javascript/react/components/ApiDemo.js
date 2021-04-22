import React from "react";
import { useQuery } from "@apollo/client";
import gql from "graphql-tag";

const TEST_QUERY = gql`
  {
    testField
  }
`;

const ApiDemo = () => {
  const { loading, error, data } = useQuery(TEST_QUERY, {});
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
