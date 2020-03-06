import React from "react";
import { Header } from "../../components/organisms/Header";
import { PasswordResetForm } from "../../components/organisms/PasswordResetForm";

export const PasswordResetTemplate = ({workspaceMember}) => {
  return (
    <>
      <Header />
      <PasswordResetForm />
    </>
  );
}
