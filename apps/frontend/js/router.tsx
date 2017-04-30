import * as React from "react";
import {BrowserRouter, Route, Switch} from 'react-router-dom';

import SetsPage from './pages/sets';
import SetPage from './pages/set';
import RouteNotFound from './pages/route_not_found';

import Layout from './components/layout';

const Router = (props: any) => {
  return <BrowserRouter>
    <Layout>
      <Switch>
        <Route exact path="/" component={SetsPage} />
        <Route exact path="/sets/:id" component={SetPage} />
        <Route component={RouteNotFound} />
      </Switch>
    </Layout>
  </BrowserRouter>
};

export default Router;
