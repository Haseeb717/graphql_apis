module Mutations
  class ChangePassword < GraphQL::Schema::Mutation
    graphql_name 'change_password'
    null true
    description "Change Password"
     # arguments passed to the `resolved` method
    
    argument :old_password, String, required: true
    argument :new_password, String, required: true

    field :user, Types::UserType, null: false
    field :errors, [String], null: false

    def resolve(old_password:,new_password:)
      if context[:current_user].blank?
        raise GraphQL::ExecutionError.new("Authentication required")
      end

      user = current_user

      if !user.has_role? :admin && !user.has_role? :user
        raise GraphQL::ExecutionError.new("Not Allowed")
      end


      valid_old_pwd = current_user.valid_current_password(old_password)
      unless valid_old_pwd
        {
          user: user,
          errors: "Current Password not Valid"
        }    
      else
        user = user.update_attributes(:password=>new_password)
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
end