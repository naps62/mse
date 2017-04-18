import Lokka from 'lokka';
import Transport from 'lokka-transport-http';

const client = new Lokka({
  transport: new Transport('/graphql'),
});

class Querier {
  static query(q, vars = {}) {
    return client.query(q, vars)
  }
}

export default Querier;
