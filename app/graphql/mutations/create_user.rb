module Mutations
  class CreateUser < GraphQL::Schema::Mutation
    graphql_name 'create_user'
    null true
    description "Create new user"
     # arguments passed to the `resolved` method
    argument :name, String, required: true
    argument :email, String, required: true
    argument :password, String, required: true

    field :user, Types::UserType, null: false
    field :errors, [String], null: false

    def resolve(name:, email:,password:)
      user = User.new(name: name, email: email,password: password)
      if user.save
        # Successful creation, return the created object with no errors
        {
          user: user,
          errors: [],
        }
      else
        # Failed save, return the errors to the client
        {
          user: nil,
          errors: user.errors.full_messages
        }
      end
    end
  end
end