import React, { Fragment } from "react";
import { DashboardHeader } from "./DashbboardHeader";
import DashboardContainer from "./DashboardContainer";

const DashboardPage = props => {
  return (
    <>
      <DashboardHeader user={props.user} />
      <DashboardContainer />
    </>
  );
};

export default props => <DashboardPage {...props} />;
