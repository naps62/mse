import * as React from 'react';
import gql from 'graphql-tag';
import { graphql } from 'react-apollo';

import TextField from 'material-ui/TextField/TextField';

import CardList from './card_list';


class CardSearchResults extends React.Component<IProps, any> {
  render() {
    return <CardList
      cards={this.props.data.cards}
    />;
  }
}

const query = gql`
  query($setId: String!, $search: String!) {
    cards(setId: $setId, search: $search) {
      mtgio_id,
      name,
      image_url
    }
  }
`;

export default graphql(query, {
  options: ({ search, setId }) => ({
    variables: { setId, search },
  })
})(CardSearchResults);
