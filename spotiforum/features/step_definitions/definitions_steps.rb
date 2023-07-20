require 'devise'
require_relative '../../app/models/user'
World(Devise::Test::ControllerHelpers)

#
#
#
# Background:
Given('I have no user') do
	User.delete_all
end

#
#
#
# Scenario: successful registration
Given("I am on the registration page") do
	visit new_user_registration_path
end

When("I fill in {string} with {string}") do |field, value|
	fill_in field, with: value
end

When("I fill in {string} with {int}") do |field, int|
	fill_in field, with: int
end

When("I click the {string} button") do |button_text|
	click_button button_text
end

Then("I should see {string}") do |content|
	expect(page).to have_content(content)
end

#
#
#
# Scenario: create post
Given('I have no post') do
	Post.delete_all
end

When('I press {string}') do |button|
	click_button button
end

When('I click the link with ID my-link') do
    find('#my-link').click
end

Then ('I should be on the new post page') do
	expect(page).to have_current_path(new_post_path)
end

Then('I should have {int} post') do |count|
	expect(Post.count).to eq(count)
end

#
#
#
# Scenario: visiting the community page and liking posts
When ('I click the link with name {string}') do |link_name|
	click_link(link_name)
end

Then ('I should be on the posts page') do
	expect(page).to have_current_path('/pages/community')
end

When('I click on the button with ID AddLike') do
	click_button("AddLike")
end

Then('I should see the number of likes increased by one') do
	expect(Like.count).to eq(1)
end

Then('I should see a button with text {string}') do |user_name|
	page.should have_button(user_name)
end

#
#
#
# Scenario:	registration with spotify and choosing favourite song
When('I click on the button with class spotifyLogin') do
	puts current_url
	find(".spotifyLogin").click
end

Then ('I should be on the Spotify authentication page') do
	expect(current_url).to include('https://accounts.spotify.com')
end

When('I log in with my Spotify credentials') do
	click_button 'Allow'
end

Then('I should be redirected back to the app') do
	# Implement appropriate assertions to ensure the user is redirected back to your app
	expect(current_path).to eq('/')
end
  
When('I deny authorization for the app') do
	click_button 'Deny'
end
  
Then('I should see an error message') do
	# Implement appropriate assertions to ensure the user sees an error message
	expect(page).to have_content('Authorization denied')
end

When ('I click on the button with value {string}') do |val|
	click_button(val)
end