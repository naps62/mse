import * as React from "react";
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';

const WithTheme = Child => props => {
  return <MuiThemeProvider>
    <Child {...props} />
  </MuiThemeProvider>
};

export default WithTheme;
