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
            cpf
          }
          errors
        }
      }
    '
  end


  it "updates creator data" do

    user = FactoryBot.create(:user, :creator)

    params = {
      name: "Carlos da Silva",
      phone: "42999999999",
      province: "Paraná",
      miniResume: "Meu currículo"
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
