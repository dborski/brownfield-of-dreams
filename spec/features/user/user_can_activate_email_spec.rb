require "rails_helper"

feature "A registered user" do
  before :each do
    clear_emails
  end

  scenario "can activate their email account" do
    visit '/'

    click_on 'Register'
    expect(current_path).to eq('/register')

    fill_in 'Email', with: "johndoe@example.com"
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Doe'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'

    click_on 'Create Account'

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content("John's Dashboard")
    expect(page).to have_content('This account has not yet been activated. Please check your email.')

    open_email('johndoe@example.com')

    expect(current_email).to have_link('Visit here to activate your account.')

    current_email.click_link('Visit here to activate your account.')

    expect(current_path).to eq('/')

    within '.flash-message' do
      expect(page).to have_content('Thank you! Your account is now activated.')
    end

    visit '/dashboard'
    expect(page).to have_content('Status: Active')
  end
end
