import * as React from "react";
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';

const Theme = Child => props => (
  <MuiThemeProvider>
    <Child {...props} />
  </MuiThemeProvider>
);

export default Theme;
