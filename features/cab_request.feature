#@javascript

Feature: Requesting a cab
  In order to book a cab
  A requester
  Should submit a cab request form

  Background:
    Given  User is logged in
    And    Current User is not an Admin
    And    User is on the home page


@pending
    Scenario: Sends a Cab Request
    And    User fills in traveler_name as cat
    And    User fills in contact_no as 1234567890
    And    User fills in pick_up_date as 07/02/9999
    And    User fills in pick_up_time as 11:59
    And    User selects ThoughtWorks from drop down list source
    And    User selects other from drop down list destination
    And    User fills in other_destination as India Gate
    And    User fills in no_of_passengers as 1
    And    Users have some previous requests
    When   User creates cab_request
    Then   User should be able to view all his CabRequests including this one
    And    User should be able to view 'Download XLS Sheet' link

