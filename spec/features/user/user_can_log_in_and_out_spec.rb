require 'rails_helper'

describe 'User' do
  it 'user can sign in' do
    user = create(:user)

    visit '/'

    click_on "Sign In"

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password

    click_on 'Log In'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content(user.email)
    expect(page).to have_content(user.first_name)
    expect(page).to have_content(user.last_name)
  end

  it 'can log out', :js do
    user = create(:user)
    stub_request(:get, "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_83.0.4103").
      with(
        headers: {
     	    'Accept'=>'*/*',
     	    'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
     	    'Host'=>'chromedriver.storage.googleapis.com',
     	    'User-Agent'=>'Ruby'
        }
      ).
        to_return(status: 200, body: "", headers: {})

    visit login_path

    fill_in'session[email]', with: user.email
    fill_in'session[password]', with: user.password

    click_on 'Log In'

    click_on 'Profile'

    expect(current_path).to eq(dashboard_path)

    click_on 'Log Out'

    expect(current_path).to eq(root_path)
    expect(page).to_not have_content(user.first_name)
    expect(page).to have_content('SIGN IN')
  end

  it 'is shown an error when incorrect info is entered' do
    user = create(:user)
    fake_email = "email@email.com"
    fake_password = "123"

    visit login_path

    fill_in'session[email]', with: fake_email
    fill_in'session[password]', with: fake_password

    click_on 'Log In'

    expect(page).to have_content("Looks like your email or password is invalid")
  end
end
