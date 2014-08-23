Feature: Login
  In order to access the network
  As a student
  I want to be able to log in

  Scenario: Valid login
    Given I have signed in
    Then I should be on the dashboard

  Scenario: Invalid login
    Given I have signed in incorrectly
    Then I should see "Die E-Mail-Adresse oder das Passwort sind falsch."
