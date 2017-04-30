import * as React from 'react';
import {Card, CardTitle, CardActions} from 'material-ui/Card';
import FlatButton from 'material-ui/FlatButton';

export default class RouteNotFound extends React.Component<any, any> {
  render() {
    return <Card>
      <CardTitle title="This page does not exist" />
      <CardActions>
        <FlatButton
          label="Go back"
          href="/"
        />
      </CardActions>
    </Card>;
  }
}
