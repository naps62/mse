import * as React from 'react';
import gql from 'graphql-tag';
import { graphql } from 'react-apollo';
import {Card, CardHeader, CardText, CardMedia, CardTitle, CardActions} from 'material-ui/Card';

import CardList from '../components/card_list';
import Search from '../components/search';
import CardInfo from '../components/card_info';

interface IProps {
  data?: {
    loading: boolean,
    card: {
      name: string,
      image_url: string,
      manacost: string,
      ability: string,
      mkm_price_trend: string,
      mkm_url: string,
      set: {
        name: string,
      }
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
      <CardTitle
        title={card.name}
        subtitle={card.set.name}
      />

      <CardText>
        <CardInfo card={card} />
      </CardText>
    </Card>;
  }
}

const query = gql`
  query($id: ID!) {
    card(id: $id) {
      name,
      image_url,
      mkm_price_trend,
      mkm_url,
      single {
        manacost,
        type,
        name,
        ability,
      },
      set {
        name,
      }
    }
  }
`;

export default graphql(query, {
  options: ({ match }) => ({
    variables: { id: match.params.id },
  })
})(CardPage);
