require "rails_helper"

describe "As an admin user" do
  it "I can navigate to 'admin/tutorials/new' and create a new tutorial using the form" do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit 'admin/tutorials/new'

    fill_in 'Title', with: "New Tutorial"
    fill_in 'Description', with: "This is a new tutorial"
    fill_in 'Thumbnail', with: "https://www.tubics.com/wp-content/uploads/2018/10/Choose-the-Right-Video-Thumbnail-Size-1-1-1024x576.png"

    click_on 'Save'

    expect(current_path).to eq("/tutorials/#{Tutorial.last.id}")
  end
end
