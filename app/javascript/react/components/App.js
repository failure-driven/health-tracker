import React from 'react';
import { ApolloProvider } from '@apollo/client';
import ApolloClient from 'api/ApolloClient';
import LayoutComponent from './LayoutComponent/LayoutComponent';
import ApiDemo from './ApiDemo/ApiDemo';

const App = () => (
  <ApolloProvider client={ApolloClient}>
    <LayoutComponent />
    <ApiDemo />
  </ApolloProvider>
);
export default App;
