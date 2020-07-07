require 'rails_helper'

describe 'visitor visits video show page' do
  it 'sees that the bookmark button is disabled' do
    tutorial = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)

    visit tutorial_path(tutorial)

    expect(page).to have_button('Bookmark', disabled: true)
  end
end
