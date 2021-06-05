import React from "react";
import PropTypes from "prop-types";
import TextField from "../TextField/TextField";

const FormInput = ({
  formInput,
  inputChangeHandler,
  addFormInput,
  removeFormInput,
  addDisabled,
  index,
}) => (
  <>
    <div className="col-4 my-2">
      <TextField
        type="text"
        name="activity"
        value={formInput.activity || ""}
        className="form-control"
        placeholder="What did you do?"
        inputChangeHandler={inputChangeHandler}
      />
    </div>
    <div className="col-4 my-2">
      <TextField
        type="text"
        name="answer"
        value={formInput.answer || ""}
        className="form-control"
        placeholder="How much?"
        inputChangeHandler={inputChangeHandler}
      />
    </div>
    <div className="col-4 my-2">
      <div className="row">
        <div className="col-6">
          <button
            type="button"
            click={addFormInput}
            className="btn btn-success"
            disabled={addDisabled}
          >
            Add
          </button>
        </div>
        <div className="col-6">
          <button
            type="button"
            click={() => removeFormInput(index)}
            className="btn btn-danger"
          >
            Remove
          </button>
        </div>
      </div>
    </div>
  </>
);

FormInput.propTypes = {
  formInput: PropTypes.func.isRequired,
  inputChangeHandler: PropTypes.func.isRequired,
  addFormInput: PropTypes.func.isRequired,
  removeFormInput: PropTypes.func.isRequired,
  addDisabled: PropTypes.bool.isRequired,
  index: PropTypes.number.isRequired,
};

export default FormInput;
