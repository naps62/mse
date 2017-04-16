import * as React from "react";
import {BrowserRouter, Route} from 'react-router-dom';

import SetList from './set_list';

const Root = (props) => {
  return <BrowserRouter>
    <Route path="/" component={SetList} />
  </BrowserRouter>
};

export default Root;
