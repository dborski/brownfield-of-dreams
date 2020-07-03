require 'rails_helper'

describe 'GithubUser' do
  it 'exists' do
    ghuser = GithubUser.new({login: "alex-latham"})

    expect(ghuser).to be_a(GithubUser)
  end

  it 'attributes' do
    ghuser = GithubUser.new({login: "alex-latham"})

    expect(ghuser.name).to eq("alex-latham")
  end
end
