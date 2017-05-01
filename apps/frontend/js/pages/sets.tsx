import * as React from 'react';
import {Card, CardActions} from 'material-ui/Card';

import Search from '../components/search';
import SetSearchResults from '../components/set_search_results';

class SetsPage extends React.Component<any, any> {
  constructor(props) {
    super(props);
    this.state = { query: '' };
  }

  onSearchChange = (event) => {
    this.setState({ search: event.target.value })
  }

  render() {
    return <Card>
      <CardActions>
        <Search onChange={this.onSearchChange} hint="Filter sets" />
      </CardActions>
      <SetSearchResults search={this.state.search} />
    </Card>;
  }
}

export default SetsPage;
