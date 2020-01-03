# frozen_string_literal: true

class WorkspaceMembersController < ApplicationController
  def index
    @current_workspace_member = current_user.current_workspace_member
    @workspace_members = current_workspace.workspace_members
  end
end
