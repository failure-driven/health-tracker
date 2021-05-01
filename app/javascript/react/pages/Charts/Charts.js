import React from "react";
import Highcharts from "highcharts";
import HighchartsReact from "highcharts-react-official";
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
const Charts = () => {
  const { loading, error, data } = useQuery(TEST_QUERY, {});
  if (loading) return <p>Loading ...</p>;
  if (error) return <p>{`Error! ${error.message}`}</p>;

  const allKeys = Array.from(
    new Set(
      data.dailyStats.map((stat) => Object.keys(stat.data)).flat()
    ).values()
  );
  const valuesFor = (metric) =>
    data.dailyStats.map((stat) => [Date.parse(stat.date), stat.data[metric]]);

  return (
    <div>
      {allKeys.map((key) => (
        <HighchartsReact
          key={key}
          highcharts={Highcharts}
          options={{
            title: { text: key },
            xAxis: { type: "datetime" },
            yAxis: { min: 0 },
            series: [{ data: valuesFor(key) }],
            plotOptions: {
              series: {
                connectNulls: true,
              },
            },
          }}
        />
      ))}
    </div>
  );
};
export default Charts;
