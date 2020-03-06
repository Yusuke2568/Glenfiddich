import React from "react";
import { ApolloProvider } from "@apollo/react-hooks";
import { client } from "../../../lib/ApolloClient/client";
import { PasswordResetTemplate }  from "../templates/PasswordResetTemplate";

function PasswordResetPage({workspaceMember}) {
  return (
    <PasswordResetTemplate />
  );
}

export default props => (
  <ApolloProvider client={client}>
    <PasswordResetPage {...props} />
  </ApolloProvider>
);
