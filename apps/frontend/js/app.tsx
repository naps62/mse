import * as React from 'react';
import * as ReactDOM from 'react-dom';
import * as injectTapEventPlugin from 'react-tap-event-plugin';

import Router from './router';
import WithTheme from './decorators/with_theme'
import WithApolloProvider from './decorators/with_apollo_provider'

const Main = WithTheme(WithApolloProvider(Router));

injectTapEventPlugin();
ReactDOM.render(<Main />, document.getElementById('root'));
