require 'rails_helper'

RSpec.describe "status_updates/new", type: :view do
  before(:each) do
    assign(:status_update, create(:status_update))
  end

  it "renders new status_update form" do
    render

    assert_select "form[action=?][method=?]", status_updates_path, "post" do

      assert_select "input[name=?]", "status_update[status]"
    end
  end
end
