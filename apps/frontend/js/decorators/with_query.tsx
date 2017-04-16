import * as React from "react";
import Lokka from 'lokka';
import Transport from 'lokka-transport-http';

const client = new Lokka({
  transport: new Transport('/graphql'),
});

interface WithQueryState {
  data: object,
};

const WithQuery = (Child, options) => class extends React.Component<undefined, WithQueryState> {
  constructor(props) {
    super(props);
    this.state = { data: options.initialData };
  }

  componentDidMount() {
    const vars = options.vars ? options.vars(this.props) : {};

    client.query(options.query, vars).then(this.onResult)
  }

  onResult = (result) => {
    this.setState({ data: result });
  }

  render() {
    return <Child {...this.props} {...this.state} />;
  }
}

export default WithQuery;
