import * as React from 'react';
import * as _ from 'lodash';
import { List, ListItem } from 'material-ui/List';

import Item from './set_list/item';

import debouncedEventHandler from '../helpers/debounced_event_handler';

interface SetListProps {
  sets: Array<{ id: string, name: string, mtgio_id: string}>,
}

class SetList extends React.Component<SetListProps, undefined> {
  render() {
    return <List style={{ paddingTop: 0 }}>
      {_.map(this.props.sets, (set) => <Item key={set.id} set={set} />)}
    </List>;
  }
}

export default SetList;
