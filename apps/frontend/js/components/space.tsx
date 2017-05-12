import * as React from 'react';

interface IProps {
  small?: boolean,
  right?: boolean,
}

export default class Space extends React.Component<IProps, any> {
  get direction() {
    return this.props.right ? 'right' : 'bottom';
  }

  get size() {
    return 'base';
  }

  render() {
    return <div className={`Space ${this.direction} ${this.size}`} />;
  }
}
