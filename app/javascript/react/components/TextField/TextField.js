import React from "react";
import PropTypes from "prop-types";

const TextField = ({
  type,
  name,
  value,
  className,
  placeholder,
  inputChangeHandler,
}) => (
  <input
    type={type}
    name={name}
    value={value}
    className={className}
    placeholder={placeholder}
    onChange={inputChangeHandler}
  />
);

TextField.propTypes = {
  type: PropTypes.string.isRequired,
  name: PropTypes.string.isRequired,
  value: PropTypes.oneOfType([
    PropTypes.string.isRequired,
    PropTypes.number.isRequired,
  ]).isRequired,
  className: PropTypes.string.isRequired,
  placeholder: PropTypes.string.isRequired,
  inputChangeHandler: PropTypes.func.isRequired,
};

export default TextField;
