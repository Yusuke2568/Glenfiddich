module Mutations
  class UpdatePassword < GraphQL::Schema::RelayClassicMutation
    argument :email, String, required: true, description: 'メールアドレス(本人確認用)'
    argument :password, String, required: true, description: 'パスワード'
    argument :password_confirmation, String, required: true, description: 'パスワード(確認)'

    field :user, Types::UserType, null: false

    def resolve(email:, password:, password_confirmation:)
      current_user = context[:current_user]
      if current_user.email == email
        GraphQL::ExecutionError.new('登録済みのメールアドレスと一致しませんでした。もう一度ご確認ください。')
      end
      
      current_user
        .update!(
          password: password,
          password_confirmation: password_confirmation
        )
      
      { user: current_user }
    end
  end
end
