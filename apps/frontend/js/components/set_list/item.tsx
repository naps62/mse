import * as React from 'react';
import { ListItem } from "material-ui/List";
import Keyrune from '../keyrune';
import ContentSend from 'material-ui/svg-icons/content/send';

import { Link } from 'react-router-dom';

interface ItemProps {
  set: {
    id: string,
    name: string,
    mtgio_id: string
  }
};

export default class Item extends React.Component<ItemProps, any> {
  render() {
    const set = this.props.set;
    const url = `/sets/${set.id}`;

    return <Link to={url}>
      <ListItem
        primaryText={set && set.name}
        leftIcon={<Keyrune id={set.mtgio_id} className="ss-absolute-left" />}
      />
    </Link>;
  }
}
