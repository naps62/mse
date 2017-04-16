import * as React from 'react';

import WithQuery from '../decorators/with_query';

// interface SetProps {
//   set: { id: string, name: string, mtgio_id: string},
// }

class Set extends React.Component<any, any> {
  render() {
    return <div>{this.props.data.set.name}</div>;
  }
}

export default WithQuery(Set, {
  query: `
    query x($id: Int) {
      set(id: $id) { id, name, mtgio_id }
    }

  `,
  vars: (props) => ({
    id: props.match.params.id
  }),
  initialData: {set: {}},
});
