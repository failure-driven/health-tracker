import React from "react";
import { ApolloProvider } from "@apollo/client";
import ApolloClient from "../../api/ApolloClient";
import LayoutComponent from "./LayoutComponent/LayoutComponent";
import "react-dates/initialize";

const App = () => (
  <div className="container">
    <ApolloProvider client={ApolloClient}>
      <LayoutComponent />
    </ApolloProvider>
  </div>
);
export default App;
