import * as React from 'react';
import TextField from 'material-ui/TextField/TextField';

import debouncedEventHandler from '../helpers/debounced_event_handler';

class Search extends React.Component<any, any> {
  render() {
    return <TextField
      hintText="Filter sets"
      onChange={debouncedEventHandler(this.props.onChange, 300)}
    />;
  }
}

export default Search;
