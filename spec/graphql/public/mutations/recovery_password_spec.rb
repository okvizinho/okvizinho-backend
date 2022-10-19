require "rails_helper"

RSpec.describe "User recovering its password" do
  let(:query) do
    "
      mutation TesteRecoveryPassword($input: RecoveryPasswordInput!) {
        recoveryPassword(input: $input) {
          success
        }
      }
    "
  end

  it "is always success" do
    user = FactoryBot.create(:user)

    params = { email: user.email }

    result = PublicSchema.execute(
      query,
      context: {},
      variables: { input: params },
    )

    expect(result["errors"]).to(be_blank, result["errors"])
    expect(result["data"]).to be_present
    expect(result["data"]["recoveryPassword"]["success"]).to be true
  end
end

