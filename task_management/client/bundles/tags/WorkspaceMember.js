import gql from "graphql-tag";

export const INVITATION_WORKSPACE_MEMBER = gql`
  mutation(
    $name: String!
    $email: String!
    $role: Int!
  ) {
    invitationWorkspaceMember(
      input: {
        name: $name
        email: $email
        role: $role
      }
    ) {
      workspaceMember {
        role
        user {
          name
        }
      }
    }
  }
`;

export const WORKSPACE_MEMBERS = gql`
  query {
    workspaceMembers {
      id
      role
      createdAt
      user {
        name
        email
      }
    }
  }
`;

export const WORKSPACE_MEMBER_ID_NAMES = gql`
  query {
    workspaceMembers {
      id
      user {
        name
      }
    }
  }
`;

export const DESTROY_WORKSPACE_MEMBER = gql`
  mutation(
    $workspaceMemberId: Int!
  ) {
    destroyWorkspaceMember(
      input: {
        workspaceMemberId: $workspaceMemberId
      }
    ) {
      workspaceMember {
        role
        user {
          name
          email
        }
      }
    }
  }
`;

export const WORKSPACE_MEMBERS_PROJECTS  = gql`
  query(
    $workspaceMemberId: Int
  ) {
    projects(workspaceMemberId: $workspaceMemberId) {
      title
      description
      workspaceMemberId
    }
  }
`
