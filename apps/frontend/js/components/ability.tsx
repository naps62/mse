import * as React from 'react';
import * as _ from 'lodash';

import Manacost from './manacost';

interface IProps {
  str: string,
}

class Ability extends React.Component<IProps, any> {
  static regex = new RegExp('\{[0-9A-Z]+\}');

  render() {
    if (!this.props.str) {
      return null;
    }

    const html = this.props.str.
      replace(/£/g, "<br />").
      replace(/#_/g, "<i>").
      replace(/_#/g, "</i>")

    return <Manacost str={html} />;
  }
}

export default Ability;
