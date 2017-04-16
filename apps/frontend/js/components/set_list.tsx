import * as React from "react";
import * as _ from 'lodash';
import { List, ListItem } from "material-ui/List";

import WithQuery from '../decorators/with_query';
import Item from './set_list/item';

interface SetListProps {
  data: {
    sets: ReadonlyArray<{ id: string, name: string, mtgio_id: string}>,
  },
}

const SetList = (props: SetListProps) => (
  <List>
    {_.map(props.data.sets, (set) => <Item key={set.id} set={set} />)}
  </List>
);

export default WithQuery(SetList, {
  query: `
    { sets { id, name, mtgio_id } }
  `,
  initialData: [],
});
