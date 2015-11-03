Feature: Home

Scenario: Start on homepage
  Given I am on "/#/"
  Then I should see "Welcome to Streambacker"

Scenario: List of top streamers
  Given I am on "/#/"
  Then I should see "List of top streamers"
