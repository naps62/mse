import * as React from 'react';
import gql from 'graphql-tag';
import { graphql } from 'react-apollo';
import {Card, CardTitle, CardActions} from 'material-ui/Card';

import CardSearchResults from '../components/card_search_results';
import Search from '../components/search';
import Querier from '../helpers/querier';

interface IProps {
  data?: {
    loading: boolean,
    set: {
      name: string,
    },
  },
  match: {
    params: {
      id: string
    }
  },
}

class SetPage extends React.Component<IProps, any> {
  constructor(props) {
    super(props);
    this.state = { query: '' };
  }

  onSearchChange = (event) => {
    this.setState({ search: event.target.value })
  }

  render() {
    if (this.props.data.loading) {
      return <Card>
      </Card>;
    }

    return <Card>
      <CardTitle title={this.props.data.set.name} />
      <CardActions>
        <Search onChange={this.onSearchChange} hint="Filter cards" />
      </CardActions>
      <CardSearchResults search={this.state.search} setId={this.props.match.params.id} />
    </Card>;
  }
}

const query = gql`
  query($id: ID!) {
    set(id: $id) {
      mtgio_id,
      name,
      mtgio_id,
    }
  }
`;

export default graphql(query, {
  options: ({ match }) => ({
    variables: { id: match.params.id },
  })
})(SetPage);
