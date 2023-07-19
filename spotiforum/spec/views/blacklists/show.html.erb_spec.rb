require 'rails_helper'

RSpec.describe "blacklists/show", type: :view do
  before(:each) do
    assign(:blacklist, Blacklist.create!(
      email: "Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Email/)
  end
end
