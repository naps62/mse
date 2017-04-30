import * as React from 'react';
import {Card, CardTitle, CardActions} from 'material-ui/Card';

import Search from '../components/search';
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
      <CardTitle title="Set page" />
    </Card>;
  }
}

export default SetsPage;
