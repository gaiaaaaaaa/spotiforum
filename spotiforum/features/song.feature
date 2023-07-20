Feature: Choosing a song

	Scenario: User logs in with Spotify
		Given I am on the registration page
		And I click on the button with class spotifyLogin
		Then I should be redirected back to the app

        When I click the link with name "Area Personale"
        Then I should see "SpotifyUser"
        And I should see "spotifyuser@example.com"
        When I fill in "search_query" with "Hello"
        And I click on the button with value "Modifica"
        Then I should see "Hello by Adele"
