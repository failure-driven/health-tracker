import React from "react";
import { ApolloProvider } from "@apollo/client";
import ApolloClient from "api/ApolloClient";
import LayoutComponent from "./LayoutComponent/LayoutComponent";

const App = () => (
  <ApolloProvider client={ApolloClient}>
    <LayoutComponent />
  </ApolloProvider>
);
export default App;
