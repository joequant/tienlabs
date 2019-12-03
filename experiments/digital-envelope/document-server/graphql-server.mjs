// nodejs does not have named exports
import apolloServer from 'apollo-server';
const { ApolloServer, gql } = apolloServer;

// Construct a schema, using GraphQL schema language
const typeDefs = gql`
  type Query {
    hello: String
  }
`;

// The root provides a resolver function for each API endpoint
const resolvers = {
Query: {
  hello: () => 'Hello world!',
  }
};

const server = new ApolloServer({typeDefs, resolvers});
server.listen(4000, '0.0.0.0').then(({ url }) => {
  console.log(`🚀  Server ready at ${url}`);
});
