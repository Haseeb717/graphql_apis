module Mutations
  class SendVerification < GraphQL::Schema::Mutation
    graphql_name 'send_verification'
    null true
    description "Send Verification"
     # arguments passed to the `resolved` method

    field :message, String, null: false

    def resolve(old_password:,new_password:)
      if context[:current_user].blank?
        raise GraphQL::ExecutionError.new("Authentication required")
      end

      user = current_user

      if user.has_role? :user
        raise GraphQL::ExecutionError.new("Not Allowed")
      end

      user.send_verification_email
      {message: "Email Send to user"}    
    end
  end
end