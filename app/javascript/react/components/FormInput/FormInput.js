import React, { Fragment } from "react";
import Button from "../Button/Button";
import TextField from "../TextField/TextField";

const FormInput = (props) => (
  <>
    <div className="col-4 my-2">
      <TextField
        type="text"
        name="activity"
        value={props.formInput.activity || ""}
        className="form-control"
        placeholder="What did you do?"
        inputChangeHandler={props.inputChangeHandler}
      />
    </div>
    <div className="col-4 my-2">
      <TextField
        type="text"
        name="answer"
        value={props.formInput.answer || ""}
        className="form-control"
        placeholder="How much?"
        inputChangeHandler={props.inputChangeHandler}
      />
    </div>
    <div className="col-4 my-2">
      <div className="row">
        <div className="col-6">
          <Button
            click={props.addFormInput}
            className="btn btn-success"
            disabled={props.addDisabled}
          >
            Add
          </Button>
        </div>
        <div className="col-6">
          <Button
            click={() => props.removeFormInput(props.index)}
            className="btn btn-danger"
          >
            Remove
          </Button>
        </div>
      </div>
    </div>
  </>
);

export default FormInput;
