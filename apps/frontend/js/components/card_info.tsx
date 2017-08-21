import * as React from 'react';
import Paper from 'material-ui/Paper';
import Divider from 'material-ui/Divider';
import {Card, CardHeader, CardText, CardMedia, CardTitle, CardActions} from 'material-ui/Card';

import Manacost from '../components/manacost';
import Ability from '../components/ability';
import Space from '../components/space';

interface IPros {
  card: {
    name: string,
    image_url: string,
    manacost: string,
    mkm_url: string,
    mkm_price_trend: string,
  }
}

const CardInfo = ({ card }: IProps) => (
  <div className="CardInfo">
    <div className="CardInfo-img">
      <img src={card.image_url} />
    </div>
    <Paper zDepth={2} className="CardInfo-data">
      <Divider />
      <div className="Info small">{card.single.type}</div>
      <Divider />
      <div className="Info small">
        // <Ability str={card.single.ability} />
      </div>
      <Divider />
      <div className="Info small">
        // <Manacost str={card.single.manacost} />
      </div>
      <Divider />
      <div className="Info small">
        {card.mkm_price_trend} on <a href={card.url}>Magic Card Market</a>
      </div>
    </Paper>
  </div>
);

export default CardInfo;
