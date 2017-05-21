import * as React from 'react';
import * as _ from 'lodash';
import { List, ListItem } from 'material-ui/List';

import ICard from '../helpers/interfaces';

import Item from './card_list/item';

interface IProps {
  cards: Array<ICard>,
}

class CardList extends React.Component<IProps, any> {
  render() {
    return <List style={{ paddingTop: 0 }}>
      {_.map(this.props.cards, (card) => <Item key={card.id} card={card} />)}
    </List>;
  }
}

export default CardList;
