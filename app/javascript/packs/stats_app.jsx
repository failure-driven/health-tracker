import React from 'react';
import ReactDOM from 'react-dom';
import App from '../react/components/App';

const render = (node) => {
  try {
    if (node) {
      ReactDOM.render(
        <App/>,
        node.appendChild(document.createElement('div')),
      );
    }
  } catch (error) {
    // eslint-disable-next-line no-console
    console.warn(error);
  }
};

document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('[data-widget-type|="stats-app"]').forEach((node) => {
    render(node);
  });
})

