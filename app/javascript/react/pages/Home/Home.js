import React, { useState } from "react";
import { SingleDatePicker } from "react-dates";
import moment from "moment";

const Home = () => {
  const [nameInput, setNameInput] = useState("");
  const [valueInput, setValueInput] = useState("");
  const [date, setDate] = useState(moment());
  const [focus, setFocus] = useState(false);

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
      // send item through graphql query
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
            />
          </div>
        </div>
      </form>
    </div>
  );
};

export default Home;
