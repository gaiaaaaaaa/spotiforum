Feature: User Registration

	Scenario: Successful registration
		Given I am on the registration page
		When I fill in "Name" with "example"
		And I fill in "Email" with "test@example.com"
		And I fill in "Password" with "123456"
		And I fill in "Password confirmation" with "123456"
		And I click the "Sign up" button
		Then I should see "Benvenuto/a su Spotiforum, example!"
		
		
