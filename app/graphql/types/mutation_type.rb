module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUser
    field :signin_user, mutation: Mutations::SigninUser
    field :change_password, mutation: Mutations::ChangePassword
    field :forgot_password, mutation: Mutations::ForgotPassword
    field :send_verification, mutation: Mutations::SendVerification
  end
end
