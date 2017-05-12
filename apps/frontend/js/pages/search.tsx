import * as React from 'react';
import gql from 'graphql-tag';
import { graphql } from 'react-apollo';
import {Card, CardHeader, CardActions} from 'material-ui/Card';

import Search from '../components/search';
import SetList from '../components/set_list';
import CardList from '../components/card_list';
import Space from '../components/space';

interface ISearchResultsProps {
  search: string,
  data?: {
    sets: Array<{ id: string, name: string, mtgio_id: string }>,
  }
}

const SearchResults = (props: ISearchResultsProps) => (
  <div>
    <Card className="SearchPage-sets">
      <CardHeader title="Sets" />
      <SetList sets={props.data.sets} />
    </Card>

    <Space small />

    <Card className="SearchPage-cards">
      <CardHeader title="Cards" />
      <CardList cards={props.data.cards} />
    </Card>
  </div>
);

const query = gql`
  query Search($search: String!) {
    sets(search: $search, limit: 10) {
      name,
      mtgio_id
    },

    cards(search: $search, limit: 10) {
      name,
      mtgio_id,
      image_url,
      set { name }
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
    this.setState({ query: event.target.value });
  }

  renderBlankSlate() {
    return <Card>
      <CardHeader title="Type something to find sets or cards" />
    </Card>;
  }

  renderResults() {
    if (this.state.query.length === 0) {
      return this.renderBlankSlate();
    } else {
      return <SearchResultsWithQuery search={this.state.query} />
    }
  }

  render() {
    return <div className="SearchPage">
      <Card className="SearchPage-search">
        <CardActions>
          <Search onChange={this.onSearchChange} hint="Search anything!" />
        </CardActions>
      </Card>

      <Space large />

      {this.renderResults()}
    </div>;
  }
}

export default SearchPage;
