import * as React from "react";
import AppBar from 'material-ui/AppBar';

interface LayoutProps {
  children?: any
};

const Layout = ({ children }: LayoutProps) => (
  <div className="Layout">
    <AppBar title="MTG Search Engine" />

    <div className="Layout-content">
      {children}
    </div>
  </div>
);

export default Layout;
