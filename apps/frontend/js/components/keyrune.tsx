import * as React from "react";

interface KeyruneProps {
  id: string,
  className?: string,
}

const Keyrune = ({ id, className }: KeyruneProps) => {
  const classes = `ss ss-2x ss-${id.toLowerCase()} ${className}`;

  return <i className={classes} />;
}

export default Keyrune;
