import React from "react";

const TextField = (props) => (
  <input
    type={props.type}
    name={props.name}
    value={props.value}
    className={props.className}
    placeholder={props.placeholder}
    onChange={props.inputChangeHandler}
  />
);

export default TextField;
