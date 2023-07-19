require 'rails_helper'

RSpec.describe "blacklists/edit", type: :view do
  let(:blacklist) {
    Blacklist.create!(
      email: "MyString"
    )
  }

  before(:each) do
    assign(:blacklist, blacklist)
  end

  it "renders the edit blacklist form" do
    render

    assert_select "form[action=?][method=?]", blacklist_path(blacklist), "post" do

      assert_select "input[name=?]", "blacklist[email]"
    end
  end
end
