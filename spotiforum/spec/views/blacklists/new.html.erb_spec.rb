require 'rails_helper'

RSpec.describe "blacklists/new", type: :view do
  before(:each) do
    assign(:blacklist, Blacklist.new(
      email: "MyString"
    ))
  end

  it "renders new blacklist form" do
    render

    assert_select "form[action=?][method=?]", blacklists_path, "post" do

      assert_select "input[name=?]", "blacklist[email]"
    end
  end
end
