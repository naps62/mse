import * as React from 'react';
import {Card, CardActions} from 'material-ui/Card';

import Search from '../components/search';
import SetList from '../components/set_list';
import Querier from '../helpers/querier';

class SetsPage extends React.Component<any, any> {
  constructor(props) {
    super(props);
    this.state = {
      query: '',
      sets: [],
    };
    this.updateSearchResults('');
  }

  onSearchChange = (event) => {
    this.updateSearchResults(event.target.value);
  }

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
        <Search onChange={this.onSearchChange} />
      </CardActions>
      <SetList sets={this.state.sets} />
    </Card>;
  }
}

export default SetsPage;
