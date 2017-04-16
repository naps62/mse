import * as React from 'react';
import * as ReactDOM from 'react-dom';
import * as injectTapEventPlugin from 'react-tap-event-plugin';

import Root from './components/root';
import WithTheme from './decorators/with_theme'

const Main = WithTheme(Root);

injectTapEventPlugin();
ReactDOM.render(<Main />, document.getElementById('root'));
