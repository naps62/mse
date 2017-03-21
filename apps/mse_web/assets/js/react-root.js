import React from "react";
import ReactDOM from "react-dom";
import $ from "jquery";
import _ from "lodash";

$(() => {
  const roots = document.getElementsByClassName("react-root")

  _.each(roots, (root) => {
    ReactDOM.render(<div>CHANGE ME!</div>, root);
  });
});
