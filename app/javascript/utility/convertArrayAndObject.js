const changeArrayToObject = (array) => {
  const obj = {};
  array
    .filter((item) => item.activity !== "" || item.answer !== "")
    .forEach(({ activity, answer }) => {
      obj[activity] = parseFloat(answer, 10);
    });
  return obj;
};

const changeObjectToArray = (obj) => {
  const array = [];
  Object.keys(obj).forEach((input) => {
    const newObj = {
      activity: input,
      answer: obj[input],
    };
    array.push(newObj);
  });
  return array;
};

export { changeArrayToObject, changeObjectToArray };
