import * as React from "react";
import Requester from '../decorators/requester';
import * as _ from 'lodash';
import { List, ListItem } from "material-ui/List";

import Item from './set_list/item';

interface SetListProps {
  data: ReadonlyArray<{ name: string, mtgio_id: string}>;
}

const SetList = (props: SetListProps) => (
  <List>
    {_.map(props.data, (set) => <Item key={set.mtgio_id} set={set} />)}
  </List>
);

export default Requester(SetList, {
  url: '/api/sets',
  initialData: [],
});
