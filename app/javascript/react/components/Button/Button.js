import React from "react";

const Button = (props) => (
  <button
    onClick={props.click}
    className={props.className}
    type={props.type || "button"}
    disabled={props.disabled}
  >
    {props.children}
  </button>
);

export default Button;
