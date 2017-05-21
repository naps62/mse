import * as React from 'react';
import { ListItem } from "material-ui/List";
import Keyrune from '../keyrune';
import ContentSend from 'material-ui/svg-icons/content/send';

import ISet from '../../helpers/interfaces';

import { Link } from 'react-router-dom';

interface ItemProps {
  set: ISet,
};

export default class Item extends React.Component<ItemProps, any> {
  render() {
    const set = this.props.set;
    const url = `/sets/${set.id}`;

    return <Link to={url}>
      <ListItem
        primaryText={set && set.name}
        leftIcon={<Keyrune id={set.id} className="ss-absolute-left" />}
      />
    </Link>;
  }
}
