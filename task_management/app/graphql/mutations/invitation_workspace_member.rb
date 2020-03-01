module Mutations
  class InvitationWorkspaceMember < GraphQL::Schema::RelayClassicMutation
    argument :name, String, required: true
    argument :email, String, required: true
    argument :role, Integer, required: true

    field :workspace_member, Types::WorkspaceMemberType, null: false

    def resolve(name:, email:, role:)
      workspace = context[:current_workspace]
      workspace_member = InvitationWorkspaceMemberService
                           .new(
                             name: name,
                             email: email,
                             role: role,
                             workspace: workspace
                           )
                           .invite!

      {workspace_member: workspace_member}
    end
  end
end
