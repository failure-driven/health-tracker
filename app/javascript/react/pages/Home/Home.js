import React, { Fragment, useState } from "react";
import { SingleDatePicker } from "react-dates";
import moment from "moment";
import { useMutation, gql } from "@apollo/client";
import { useNavigate } from "react-router-dom";
import AddStatsForm from "../../components/AddStatsForm/AddStatsForm";
import { changeArrayToObject } from "../../../utility/convertArrayAndObject";

const UPSERT_STAT_QUERY = gql`
  mutation UpsertStat($date: String!, $data: JSON!) {
    upsertStat(input: { date: $date, data: $data }) {
      dailyStat {
        id
        date
        data
      }
      errors
    }
  }
`;

const Home = (props) => {
  let navigate = useNavigate();
  const [formInput, setFormInput] = useState([]);
  const [date, setDate] = useState(moment());
  const [focus, setFocus] = useState(false);
  const [display, setDisplay] = useState(false);

  const [upsertStat, { data }] = useMutation(UPSERT_STAT_QUERY);

  const submitHandler = (input) => {
    const data = changeArrayToObject(input);
    const variables = {
      date: date.toISOString(),
      data,
    };

    upsertStat({
      variables,
    });

    navigate("/app/stats");
  };
  return (
    <div>
      <h1 className="my-4">Are you sweating enough?</h1>
      <button
        type="button"
        className={`btn btn-${display ? "danger" : "success"}`}
        onClick={() => setDisplay((prev) => !prev)}
      >
        {display ? "hide stats" : "add stats for today"}
      </button>
      {display && (
        <Fragment>
          <div className="my-4">
            <SingleDatePicker
              date={date}
              onDateChange={(newDate) => setDate(newDate)}
              focused={focus}
              onFocusChange={({ focused }) => setFocus(focused)}
              id="date"
            />
          </div>
          <AddStatsForm
            date={date}
            className="my-4"
            onSubmit={submitHandler}
            formInput={formInput}
          />
        </Fragment>
      )}
    </div>
  );
};

export default Home;
