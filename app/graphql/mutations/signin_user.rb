module Mutations
  class SigninUser < GraphQL::Schema::Mutation
    null true

    graphql_name 'sign_in_user'
    null true
    description "Sign In User "
     # arguments passed to the `resolved` method
    argument :email, String, required: true
    argument :password, String, required: true

    field :token, String, null: true
    field :user, Types::UserType, null: true

    def resolve(email: nil,password: nil)
      # basic validation
      return unless email

      user = User.find_by email: email

      # ensures we have the correct user
      return unless user
      return unless user.authenticate(password)

      token = user.set_authentication_token(:token)

      { user: user, token: token }
    end
  end
end