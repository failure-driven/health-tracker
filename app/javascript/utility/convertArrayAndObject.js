const changeArrayToObject = (array) => {
  const obj = {};
  array.forEach(({ activity, answer }) => {
    console.log(activity, answer);
    obj = {
      ...obj,
      [activity]: answer,
    };
  });
  return obj;
};

const changeObjectToArray = (obj) => {
  const array = [];
  Object.keys(obj).forEach((element) => {
    const newObj = {
      activity: element,
      answer: obj[element],
    };
    array.push(newObj);
  });
  return array;
};

export { changeArrayToObject, changeObjectToArray };
