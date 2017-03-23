import React from "react";
import ReactDOM from "react-dom";
import $ from "jquery";
import _ from "lodash";

import Main from './components/main';

$(() => {
  const roots = document.getElementsByClassName("react-root")

  _.each(roots, (root) => {
    const component = root.dataset.component;
    const props = JSON.parse(root.dataset.props || "{}");

    const mainProps = { component, props };

    const elem = React.createElement(Main, mainProps);
    ReactDOM.render(elem, root);
  });
});
