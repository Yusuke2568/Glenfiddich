class InvitationWorkspaceMemberService
  attr_reader :name, :user, :role, :workspace
  
  # @param [String] name ユーザー名
  # @param [String] email メールアドレス
  # @param [Enum] role 権限
  # @param [Workspace] workspace ワークスペースメンバーを招待するワークスペース
  def initialize(name:, email:, role:, workspace:)
    @name = name
    @user = User.find_or_initialize_by(email: email)
    @role = role
    @workspace = workspace
  end

  def invite!
    WorkspaceMember.transaction do
      # まだ user が作成されていなければ作成しておく
      if user.new_record?
        create_user!
      end
      
      create_workspace_member!
      send_invite_email
      # まだ user_status が作成されていなければ作成しておく
      create_user_status! unless user.user_status
    end
    
    # view で使いたいので作成した workspace_member を返す
    user.workspace_members.find_by(workspace: workspace)
  end

  def create_user!
    # ユーザー招待の属性(トークンとダイジェストと、招待したユーザーのid)を作成する
    user.invite_token = User.new_token
    # password はランダムな文字列を入れておく
    password = SecureRandom.hex(8)
    
    user.update!(
      name: name,
      password: password,
      password_confirmation: password,
      invite_digest: User.digest(user.invite_token),
      invite_sent_at: Time.zone.now
    )
  end
  
  # 招待メールを送信する
  def send_invite_email
    UserMailer.invitation(user, workspace).deliver_now
  end

  def create_workspace_member!
    user
      .workspace_members
      .create!(workspace: workspace, role: role)
  end

  def create_user_status!
    user.create_user_status!(workspace: workspace)
  end
end
