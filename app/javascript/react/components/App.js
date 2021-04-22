import React from "react";
import { ApolloProvider } from "@apollo/client";
import ApolloClient from "../../api/ApolloClient";
import ApiDemo from "./ApiDemo";

const App = () => (
  <ApolloProvider client={ApolloClient}>
    <div>
      React App - test
      <ApiDemo />
    </div>
  </ApolloProvider>
);

export default App;
