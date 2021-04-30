import React from 'react';
import { ApolloProvider } from '@apollo/client';
import ApolloClient from 'api/ApolloClient';
import LayoutComponent from './LayoutComponent/LayoutComponent';
import 'react-dates/initialize';

const App = () => (
  <ApolloProvider client={ApolloClient}>
    <LayoutComponent />
  </ApolloProvider>
);
export default App;
