import React, { useState, useEffect } from "react";
import Button from "../Button/Button";
import FormInput from "../FormInput/FormInput";

const AddStatsForm = (props) => {
  const defaultForm = {
    activity: "",
    answer: "",
  };

  const [formInput, setFormInput] = useState([defaultForm]);
  const [emptyInputCheck, setEmptyInputCheck] = useState(true);

  useEffect(() => {
    const formInputLoaded = props.formInput;
    if (formInputLoaded.length > 0) {
      setFormInput(() => formInputLoaded);
    }
  }, []);

  const isDisabledHandler = () => {
    if (formInput.length < 0) return true;

    const disable = formInput
      .map((input) => {
        return Object.values(input).includes("");
      })
      .includes(true);
    setEmptyInputCheck(() => disable);
  };

  const addFormInput = () => {
    const formInputCopy = [...formInput, defaultForm];
    setFormInput(() => formInputCopy);
  };

  const onSubmitHandler = (e) => {
    e.preventDefault();
    console.log(formInput);
    props.onSubmit(formInput);
  };

  const removeFormInput = (index) => {
    const formInputCopy = [...formInput];
    formInputCopy.splice(index, 1);
    setFormInput(() => formInputCopy);
    isDisabledHandler();
  };

  const inputChangeHandler = (index, e) => {
    const formInputCopy = [...formInput];
    formInputCopy[index][e.target.name] = e.target.value;
    setFormInput(() => formInputCopy);
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
            addDisabled={emptyInputCheck}
            removeFormInput={removeFormInput}
          />
        ))}
      </div>
      <div className="row my-4">
        <div className="col-6">
          <Button
            type="submit"
            className="form-control btn btn-info"
            disabled={emptyInputCheck}
          >
            Add this to my list
          </Button>
        </div>
      </div>
    </form>
  );
};

export default AddStatsForm;
