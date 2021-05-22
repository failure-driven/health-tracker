const changeArrayToObject = (array) => {
  const obj = {};
  array.forEach(({ activity, answer }) => {
    obj[activity] = answer;
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
