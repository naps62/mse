import * as React from 'react';
import gql from 'graphql-tag';
import { graphql } from 'react-apollo';
import {Card, CardText, CardMedia, CardTitle, CardActions} from 'material-ui/Card';

import CardList from '../components/card_list';
import Search from '../components/search';
import Querier from '../helpers/querier';

interface IProps {
  data?: {
    loading: boolean,
    card: {
      name: string,
      image_url: string,
    }
  },
}

class CardPage extends React.Component<IProps, any> {
  render() {
    if (this.props.data.loading) {
      return <Card>
      </Card>;
    }

    const card = this.props.data.card;

    return <Card>
      <CardTitle title={card.name} />
      <CardText>
        <img src={card.image_url} />
      </CardText>
    </Card>;
  }
}

const query = gql`
  query($id: ID!) {
    card(id: $id) {
      name,
      image_url,
    }
  }
`;

export default graphql(query, {
  options: ({ match }) => ({
    variables: { id: match.params.id },
  })
})(CardPage);
