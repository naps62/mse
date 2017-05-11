import * as React from 'react';
import gql from 'graphql-tag';
import { graphql } from 'react-apollo';
import {Card, CardActions} from 'material-ui/Card';

import Search from '../components/search';
import SetList from '../components/set_list';
import CardList from '../components/card_list';

interface ISearchResultsProps {
  search: string,
  data?: {
    sets: Array<{ id: string, name: string, mtgio_id: string }>,
  }
}

const SearchResults = (props: ISearchResultsProps) => (
  <div>
    <SetList sets={props.data.sets} />
    <CardList cards={props.data.cards} />
  </div>
);

const query = gql`
  query($search: String!) {
    sets(search: $search) {
      name,
      mtgio_id
    },

    cards(search: $search) {
      name,
      mtgio_id,
      image_url
    }
  }
`;

const SearchResultsWithQuery = graphql(query, {
  options: ({ search }) => ({
    variables: { search },
  })
})(SearchResults);

class SearchPage extends React.Component<any, any> {
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
        <Search onChange={this.onSearchChange} hint="Search anything!" />
      </CardActions>
      <SearchResultsWithQuery search={this.state.search} />
    </Card>;
  }
}

export default SearchPage;
