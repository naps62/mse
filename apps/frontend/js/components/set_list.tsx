import * as React from 'react';
import * as _ from 'lodash';
import { List, ListItem } from 'material-ui/List';
import TextField from 'material-ui/TextField/TextField';
import {Card, CardActions} from 'material-ui/Card';

import Item from './set_list/item';

import debouncedEventHandler from '../helpers/debounced_event_handler';
import Querier from '../helpers/querier';

interface SetListState {
  autocompletion: ReadonlyArray<string>,
  query: string,
  sets: Array<{ id: string, name: string, mtgio_id: string}>,
}

class SetList extends React.Component<undefined, SetListState> {
  constructor(props) {
    super(props);
    this.state = {
      autocompletion: [],
      query: '',
      sets: [],
    };
    this.updateSearchResults('');
  }

  onSearchUpdate = debouncedEventHandler(event => {
    this.updateSearchResults(event.target.value);
  }, 300)

  updateSearchResults = (search) => {
    const query = `query($search: String!) {
      sets(search: $search) { id, name, mtgio_id }
    }`;
    const vars = { search };

    Querier.query(query, vars).then(data => this.setState({ sets: data.sets }));
  }

  render() {
    return <Card>
      <CardActions>
        <TextField
          hintText="Filter sets"
          onChange={this.onSearchUpdate}
        />
      </CardActions>

      <List style={{ paddingTop: 0 }}>
        {_.map(this.state.sets, (set) => <Item key={set.id} set={set} />)}
      </List>
    </Card>
  }
}

export default SetList;
