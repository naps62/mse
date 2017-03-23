import * as React from "react";

import WithTheme from '../decorators/with_theme'
import SetList from './set_list';

const mainComponents = {
  SetList,
};

interface MainProps {
  component: string,
  props: object,
}

const Main = (props: MainProps) => (
  React.createElement(
    mainComponents[props.component],
    props.props,
  )
)

export default WithTheme(Main);
