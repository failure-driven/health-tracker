<<<<<<< HEAD
import { ApolloClient, createHttpLink, InMemoryCache } from "@apollo/client";
import { setContext } from "@apollo/client/link/context";

const httpLink = createHttpLink({
  uri: "/graphql",
=======
import {
  ApolloClient,
  createHttpLink,
  InMemoryCache,
} from '@apollo/client';
import { setContext } from '@apollo/client/link/context';

// const xCsrfToken = () => {
//   const match = /<meta name="csrf-token" content="(.*)">/.exec(
//     document.head.innerHTML,
//   );
//   return match && match[1];
// };

const httpLink = createHttpLink({
  uri: '/graphql',
>>>>>>> code refactored to fix linting
});

const authLink = setContext((_, { headers }) => ({
  headers: {
<<<<<<< HEAD
    AUTHORIZATION: `Token ${process.env.GRAPHQL_API_KEY}`,
=======
    // 'X-CSRF-Token': xCsrfToken(),
    // AUTHORIZATION: `Token ${process.env.GRAPHQL_API_KEY}`,
>>>>>>> code refactored to fix linting
    ...headers,
  },
}));

const client = new ApolloClient({
  link: authLink.concat(httpLink),
  cache: new InMemoryCache(),
});

export default client;
