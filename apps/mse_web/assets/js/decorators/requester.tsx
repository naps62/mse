import * as React from "react";
import * as superagent from 'superagent';

interface RequesterState {
  data: object,
};

const Requester = (Child, options) => class extends React.Component<undefined, RequesterState> {
  constructor(props) {
    super(props);
    this.state = { data: options.initialData };
  }

  componentDidMount() {
    superagent.
      get(options.url).
      end(this.onResult);
  }

  onResult = (error, result) => {
    if (error) {
      console.error(error)
      return;
    }

    this.setState({ data: result.body });
  }

  render() {
    return <Child {...this.props} {...this.state} />;
  }
}

export default Requester;
