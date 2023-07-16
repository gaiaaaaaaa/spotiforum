Feature: Community Page

	Background:
		Given I have no user
		Given I have no post

	Scenario: Successful registration
		Given I am on the registration page
		When I fill in "Name" with "example"
		And I fill in "Email" with "test@example.com"
		And I fill in "Photo" with 2
		And I fill in "Password" with "123456"
		And I fill in "Password confirmation" with "123456"
		And I click the "Sign up" button
		Then I should see "Benvenuto su Spotiforum!"
	
		When I click the link with name "Community"
		Then I should be on the posts page
		When I click the link with ID my-link
		Then I should be on the new post page
		When I fill in "Content" with "Post di test"
		And I fill in "User" with 1
		And I fill in "Tag" with "#test"
		And I press "Create Post"
		Then I should see "Post was successfully created."
		And I should see "Post di test"
		And I should see "1"
		And I should see "#test"
		And I should have 1 post
		
		When I click the link with name "Back"
		Then I should be on the posts page
		When I click on the button with ID AddLike
		Then I should see the number of likes increased by one
