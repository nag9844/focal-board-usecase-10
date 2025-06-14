Feature: Ensure owner tag is present
  Scenario: Every resource must have an Owner tag
    Given I have resource that supports tags defined
    Then it must contain tags
    And its value must contain the key Owner
