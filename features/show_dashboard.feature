Feature: Show the dashboard
  In order to access the network
  As a student
  I want to see the dashboard after logging in

  Scenario: No profile exists
    Given I have an account without a profile
    When I visit the dashboard
    Then I should see "Profil erstellen"

  Scenario: A profile exists
    Given I have an account with a profile
    When I visit the dashboard
    Then I should see "Mein Profil"

  Scenario: A comment needs approval
    Given I have signed in
    And I haved 1 associated profile
    And 1 comment requires my approval
    When I visit the dashboard
    Then I should see "1 Kommentar erfordert deine Überprüfung."
