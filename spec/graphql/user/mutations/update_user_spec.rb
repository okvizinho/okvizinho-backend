require "rails_helper"

RSpec.describe "User Update account" do

  let(:query) do
    '
   mutation TestUpdateUser($input: UpdateUserMutationInput!) {
        updateUser(input: $input) {
          user {
            id
            name
            email
          }
          errors
        }
      }
    '
  end


  it "updates data" do   

    user = FactoryBot.create(:user)

    params = {
      name: "Maria Fulana"
    }

    expect(user.name).to_not eql params[:name]

    result = UserSchema.execute(query, context: { current_user: user }, variables: { input: params })

    expect(result["errors"]).to(be_blank, result["errors"])
    expect(result["data"]).to be_present
    expect(result.dig("data", "updateUser", "errors")).to_not be_present

    data = result.dig("data", "updateUser", "user")

    expect(data["name"]).to eql params[:name]
  end
end
