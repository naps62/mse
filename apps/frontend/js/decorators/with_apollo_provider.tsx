import * as React from "react";

import ApolloClient, { createNetworkInterface } from 'apollo-client';
import { ApolloProvider } from 'react-apollo';

const client = new ApolloClient({
  connectToDevTools: true,
  networkInterface: createNetworkInterface({ uri: '/graphql' })
});

const WithApolloProvider = Child => props => {
  return <ApolloProvider client={client}>
    <Child {...props} />
  </ApolloProvider>
};

export default WithApolloProvider;
