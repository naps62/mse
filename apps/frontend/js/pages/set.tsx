import * as React from 'react';
import gql from 'graphql-tag';
import { graphql } from 'react-apollo';
import {Card, CardTitle, CardActions} from 'material-ui/Card';

import CardSearchResults from '../components/card_search_results';
import Search from '../components/search';
import Keyrune from '../components/keyrune';

interface IProps {
  data?: {
    loading: boolean,
    set: {
      mtgio_id: string,
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

  renderTitle() {
    const set = this.props.data.set;

    return <div>
      <Keyrune id={set.mtgio_id} />
      {set.name}
    </div>;
  }

  render() {
    if (this.props.data.loading) {
      return <Card>
      </Card>;
    }

    return <Card>
      <CardTitle title={this.renderTitle()} />
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
