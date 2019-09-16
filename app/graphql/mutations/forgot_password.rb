module Mutations
  class ForgotPassword < GraphQL::Schema::Mutation
    graphql_name 'forgot_password'
    null true
    description "Forgot Password"
     # arguments passed to the `resolved` method
    argument :email, String, required: true
    
    field :message, String, null: false

    def resolve(email:)
      
      user = User.find_by_email(email)
      if user

        if !user.has_role? :admin && !user.has_role? :agent
          raise GraphQL::ExecutionError.new("Not Allowed")
        end

        user.send_forgot_email
        {message: "Email Send to user"}    
      else
        {message: "Email not exists in our db"}
      end
    end
  end
end