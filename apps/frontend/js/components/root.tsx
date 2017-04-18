import * as React from "react";
import {BrowserRouter, Route, Switch} from 'react-router-dom';

import Layout from './layout';
import SetList from './set_list';
import Set from './set';
import RouteNotFound from './route_not_found';

const Root = (props) => {
  return <BrowserRouter>
    <Layout>
      <Switch>
        <Route exact path="/" component={SetList} />
        <Route exact path="/sets/:id" component={Set} />
        <Route component={RouteNotFound} />
      </Switch>
    </Layout>
  </BrowserRouter>
};

export default Root;
