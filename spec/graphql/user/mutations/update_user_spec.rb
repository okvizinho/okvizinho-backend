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
            phone
          }
          errors
        }
      }
    '
  end


  it "updates data" do   

    user = FactoryBot.create(:user)

    params = {
      email: "davy@msn.com",
      name: "Maria Fulana",
      phone: "41-1234-1234"
    }

    expect(user.name).to_not eql params[:name]
    expect(user.phone).to_not eql params[:phone]

    result = UserSchema.execute(query, context: { current_user: user }, variables: { input: params })

    expect(result["errors"]).to(be_blank, result["errors"])
    expect(result["data"]).to be_present
    expect(result.dig("data", "updateUser", "errors")).to_not be_present

    data = result.dig("data", "updateUser", "user")

    expect(data["name"]).to eql params[:name]
    expect(data["phone"]).to eql params[:phone]
  end
end
