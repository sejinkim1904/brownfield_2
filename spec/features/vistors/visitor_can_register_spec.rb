require 'rails_helper'

describe 'vister can create an account', :js do
  it ' visits the home page' do
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

    email = 'jimbob@aol.com'
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'
    password_confirmation = 'password'

    visit '/'

    click_on 'Sign In'

    expect(current_path).to eq(login_path)

    click_on 'Sign up now.'

    expect(current_path).to eq(new_user_path)

    fill_in 'user[email]', with: email
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password

    click_on'Create Account'

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content(email)
    expect(page).to have_content(first_name)
    expect(page).to have_content(last_name)
    expect(page).to_not have_content('Sign In')
  end
end
