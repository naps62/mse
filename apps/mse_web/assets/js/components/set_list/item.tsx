import * as React from 'react';
import { ListItem } from "material-ui/List";
import Keyrune from '../keyrune';
import ContentSend from 'material-ui/svg-icons/content/send';

interface ItemProps {
  set: {
    name: string,
    mtgio_id: string
  }
};

export default class Item extends React.Component<ItemProps, any> {
  render() {
    const set = this.props.set;

    return <ListItem
      key={set.mtgio_id}
      primaryText={set && set.name}
      leftIcon={<Keyrune id={set.mtgio_id} className="ss-absolute-left" />}
    />;
  }
}
