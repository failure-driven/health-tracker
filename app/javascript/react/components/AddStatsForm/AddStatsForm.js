import React, { useState, useEffect } from "react";
import PropTypes from "prop-types";
import { gql, useQuery } from "@apollo/client";
import uuid from "react-uuid";
import FormInput from "../FormInput/FormInput";
import { changeObjectToArray } from "../../../utility/convertArrayAndObject";

const DAILY_STAT_BY_DATE = gql`
  query DailyStatByDate($date: String!) {
    dailyStatByDate(date: $date) {
      data
    }
  }
`;

const AddStatsForm = ({ date, onSubmit }) => {
  const defaultForm = {
    activity: "",
    answer: "",
  };

  const [formInput, setFormInput] = useState([defaultForm]);
  const { data } = useQuery(DAILY_STAT_BY_DATE, {
    variables: { date },
  });

  useEffect(() => {
    if (data && data.dailyStatByDate && data.dailyStatByDate.data) {
      const inputArr = changeObjectToArray(data.dailyStatByDate.data);
      setFormInput(inputArr);
    }
  }, [data]);

  const addFormInput = () => {
    const formInputCopy = [...formInput, defaultForm];
    return setFormInput(formInputCopy);
  };

  const onSubmitHandler = (e) => {
    e.preventDefault();
    onSubmit(formInput);
  };

  const removeFormInput = (index) => {
    const formInputCopy = [...formInput];
    formInputCopy.splice(index, 1);
    setFormInput(formInputCopy);
  };

  const inputChangeHandler = (index, e) => {
    const formInputCopy = [...formInput];
    formInputCopy[index][e.target.name] = e.target.value;
    setFormInput(formInputCopy);
  };

  return (
    <form onSubmit={onSubmitHandler}>
      <div className="row">
        {formInput.map((input, index) => (
          <FormInput
            key={index}
            index={index}
            inputChangeHandler={(event) => inputChangeHandler(index, event)}
            formInput={input}
            addFormInput={addFormInput}
            addDisabled={false}
            removeFormInput={removeFormInput}
          />
        ))}
      </div>
      <div className="row my-4">
        <div className="col-6">
          <button
            type="submit"
            className="form-control btn btn-info"
            disabled={false}
          >
            Add this to my list
          </button>
        </div>
      </div>
    </form>
  );
};

AddStatsForm.propTypes = {
  date: PropTypes.string.isRequired,
  onSubmit: PropTypes.func.isRequired,
};

export default AddStatsForm;
