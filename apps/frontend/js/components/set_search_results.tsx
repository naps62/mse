import * as React from 'react';
import gql from 'graphql-tag';
import { graphql } from 'react-apollo';

import TextField from 'material-ui/TextField/TextField';

import SetList from './set_list';

interface SetSearchResultsProps {
  search: string,
  data?: {
    sets: Array<{ id: string, name: string, mtgio_id: string }>,
  }
}

class SetSearchResults extends React.Component<SetSearchResultsProps, any> {
  render() {
    return <SetList
      sets={this.props.data.sets}
    />;
  }
}

const query = gql`
  query($search: String!) {
    sets(search: $search) {
      id,
      name,
    }
  }
`;

export default graphql(query, {
  options: ({ search }) => ({
    variables: { search },
  })
})(SetSearchResults);
