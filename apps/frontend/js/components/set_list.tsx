import * as React from "react";
import WithQuery from '../decorators/with_query';
import * as _ from 'lodash';
import { List, ListItem } from "material-ui/List";

import Item from './set_list/item';

interface SetListProps {
  data: {
    sets: ReadonlyArray<{ name: string, mtgio_id: string}>,
  },
}

const SetList = (props: SetListProps) => (
  <List>
    {_.map(props.data.sets, (set) => <Item key={set.mtgio_id} set={set} />)}
  </List>
);

export default WithQuery(SetList, {
  query: `
    { sets { id, name, mtgio_id } }
  `,
  initialData: [],
});
