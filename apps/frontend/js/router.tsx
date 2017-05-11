import * as React from "react";
import {BrowserRouter, Route, Switch} from 'react-router-dom';

import SearchPage from './pages/search';
import SetsPage from './pages/sets';
import SetPage from './pages/set';
import CardPage from './pages/card';
import RouteNotFound from './pages/route_not_found';

import Layout from './components/layout';

const Router = (props: any) => {
  return <BrowserRouter>
    <Layout>
      <Switch>
        <Route exact path="/" component={SearchPage} />
        <Route exact path="/sets" component={SetsPage} />
        <Route exact path="/sets/:id" component={SetPage} />
        <Route exact path="/cards/:id" component={CardPage} />
        <Route component={RouteNotFound} />
      </Switch>
    </Layout>
  </BrowserRouter>
};

export default Router;
