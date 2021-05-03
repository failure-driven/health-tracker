import React, { useState } from "react";
import { SingleDatePicker } from "react-dates";
import moment from "moment";
import { useMutation, gql } from "@apollo/client";

const ADD_DAILY_STATS_ALL_QUERY = gql`
  mutation AddDailyStat($date: String!, $data: JSON!) {
    addDailyStat(input: { date: $date, data: $data }) {
      dailyStat {
        id
        date
        data
      }
      errors
    }
  }
`;

const Home = () => {
  const [nameInput, setNameInput] = useState("");
  const [valueInput, setValueInput] = useState("");
  const [date, setDate] = useState(moment());
  const [focus, setFocus] = useState(false);

  const [addDailyStat, { data }] = useMutation(ADD_DAILY_STATS_ALL_QUERY);

  const inputChangeHandler = (e) => {
    if (e.target.name === "question") {
      setNameInput(e.target.value);
    } else if (e.target.name === "answer") {
      setValueInput(e.target.value);
    }
  };

  const addInputElementHandler = (e) => {
    e.preventDefault();
    if (nameInput || valueInput) {
      const data = {
        [nameInput]: valueInput,
      };
      const selectedDate = date.toISOString();
      console.log(selectedDate);
      addDailyStat({
        variables: { date: selectedDate, data: data },
      });
      setNameInput("");
      setValueInput("");
    }
  };
  return (
    <div>
      <h1 className="my-4">Are you sweating enough?</h1>
      <button type="button" className="btn btn-success">
        add stats for today
      </button>
      <div className="my-4">
        <SingleDatePicker
          date={date}
          onDateChange={(newDate) => setDate(newDate)}
          focused={focus}
          onFocusChange={({ focused }) => setFocus(focused)}
          id="date"
        />
      </div>
      <form className="my-4" onSubmit={addInputElementHandler}>
        <div className="row">
          <div className="col">
            <input
              type="text"
              name="question"
              value={nameInput}
              className="form-control"
              placeholder="What did you do?"
              onChange={inputChangeHandler}
            />
          </div>
          <div className="col">
            <input
              type="text"
              name="answer"
              value={valueInput}
              className="form-control"
              placeholder="How much?"
              onChange={inputChangeHandler}
            />
          </div>
        </div>
        <div className="row my-4">
          <div className="col-6">
            <input
              type="submit"
              className="form-control btn btn-info"
              value="Add this to my list"
              disabled={!valueInput || !nameInput}
            />
          </div>
        </div>
      </form>
    </div>
  );
};

export default Home;
