import React, { useState, useEffect } from "react";
import { gql, useQuery } from "@apollo/client";
import Button from "../Button/Button";
import FormInput from "../FormInput/FormInput";
import { changeObjectToArray } from "../../../utility/convertArrayAndObject";

const DAILY_STAT_BY_DATE = gql`
  query DailyStatByDate($date: String!) {
    dailyStatByDate(date: $date) {
      data
    }
  }
`;

const AddStatsForm = (props) => {
  const defaultForm = {
    activity: "",
    answer: "",
  };

  const [formInput, setFormInput] = useState([defaultForm]);
  const [emptyInputCheck, setEmptyInputCheck] = useState(true);
  const date = props.date.toISOString();
  const { loading, error, data } = useQuery(DAILY_STAT_BY_DATE, {
    variables: { date },
  });

  useEffect(() => {
    if (data && data.dailyStatByDate && data.dailyStatByDate.data) {
      const inputArr = changeObjectToArray(data.dailyStatByDate.data);
      setFormInput(inputArr);
      isDisabledHandler();
    }
  }, [data]);

  const isDisabledHandler = () => {
    // needs to fixed to disabled when input condition is not met
    if (formInput.length <= 0) return true;

    const disable = formInput
      .map((input) => {
        return Object.values(input).includes("");
      })
      .includes(true);
    setEmptyInputCheck(disable);
  };

  const addFormInput = () => {
    const formInputCopy = [...formInput, defaultForm];
    setFormInput(formInputCopy);
  };

  const onSubmitHandler = (e) => {
    e.preventDefault();
    props.onSubmit(formInput);
  };

  const removeFormInput = (index) => {
    const formInputCopy = [...formInput];
    formInputCopy.splice(index, 1);
    setFormInput(formInputCopy);
    isDisabledHandler();
  };

  const inputChangeHandler = (index, e) => {
    const formInputCopy = [...formInput];
    formInputCopy[index][e.target.name] = e.target.value;
    setFormInput(formInputCopy);
    isDisabledHandler();
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
          <Button
            type="submit"
            className="form-control btn btn-info"
            disabled={false}
          >
            Add this to my list
          </Button>
        </div>
      </div>
    </form>
  );
};

export default AddStatsForm;
