import * as React from 'react';
import gql from 'graphql-tag';
import { graphql } from 'react-apollo';
import {Card, CardTitle, CardActions} from 'material-ui/Card';

import Search from '../components/search';
import Keyrune from '../components/keyrune';
import CardList from '../components/card_list';

interface ISearchResultsProps {
  search: string,
  setId: string,
  data?: {
    cards: Array<{ id: number, name: string, image_url: string }>,
  }
}

const SearchResults = (props: ISearchResultsProps) => (
  <CardList cards={props.data.cards} />
);

const SearchResultsWithQuery = graphql(
  gql`
    query($setId: String!, $search: String!) {
      cards(setId: $setId, search: $search) {
        id,
        name,
        image_url,
        set { name }
      }
    }`,
  {
    options: ({ search, setId }) => ({
      variables: { setId, search },
    })
})(SearchResults);

interface IProps {
  data?: {
    loading: boolean,
    set: {
      id: number,
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
      <SearchResultsWithQuery search={this.state.search} setId={this.props.match.params.id} />
    </Card>;
  }
}

export default graphql(
  gql`
    query($id: ID!) {
      set(id: $id) {
        id,
        name,
      }
    }`,
  {
  options: ({ match }) => ({
    variables: { id: match.params.id },
  })
})(SetPage);
