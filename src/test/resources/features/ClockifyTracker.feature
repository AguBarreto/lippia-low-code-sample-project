@TrackerClokilfy @FINAL
Feature: Consigna Final Lippia API low-code

  Background:
    Given base url $(env.base_url)
    And header x-api-key = $(env.x_api_key)
    And header Content-Type = application/json

  @GetUser
  Scenario: Get the information of the user currently logged in
    And endpoint /v1/user
    When execute method GET
    Then the status code should be 200
    And response should be name = Agustin_Barreto
    * define userId = response.id

  @GetWorkspace
  Scenario: Get all workspaces
    And endpoint /v1/workspaces
    When execute method GET
    Then the status code should be 200
    And response should be [1].name = workspace010
    * define workspaceId = response[1].id

  @GetProject
  Scenario: Get all projects on workspace
    And call Tracker.feature@GetWorkspace
    And endpoint /v1/workspaces/{{workspaceId}}/projects
    When execute method GET
    Then the status code should be 200
    And response should be [0].name = Proyecto001
    * define projectId = response[0].id

  @GetTime
  Scenario: Get the time logs of a user in the workspace
    And call Tracker.feature@GetUser
    And call Tracker.feature@GetWorkspace
    And endpoint /v1/workspaces/{{workspaceId}}/user/{{userId}}/time-entries
    When execute method GET
    Then the status code should be 200
    * define TimeEntryId = response[0].id

  @AddTime
  Scenario Outline: Add new time entry
    And call Tracker.feature@GetProject
    And endpoint /v1/workspaces/{{workspaceId}}/time-entries
    And set value <billable> of key billable in body /jsons/bodies/addTimeEntry.json
    And set value <description> of key description in body /jsons/bodies/addTimeEntry.json
    And set value <end> of key end in body /jsons/bodies/addTimeEntry.json
    And set value {{projectId}} of key projectId in body /jsons/bodies/addTimeEntry.json
    And set value <start> of key start in body /jsons/bodies/addTimeEntry.json
    When execute method POST
    Then the status code should be 201
    And response should be description = <description>

    Examples:
      | billable | description         | end                  | start                |
      | true     | Meeting with client | 2024-06-09T16:00:00Z | 2024-06-09T15:30:00Z |

  @UpdateTime
  Scenario Outline: Update time entry
    And call Tracker.feature@GetTimeEntry
    And endpoint /v1/workspaces/{{workspaceId}}/time-entries/{{TimeEntryId}}
    And set value <billable> of key billable in body /jsons/bodies/updateTimeEntry.json
    And set value <description> of key description in body /jsons/bodies/updateTimeEntry.json
    And set value <start> of key start in body /jsons/bodies/updateTimeEntry.json
    When execute method PUT
    Then the status code should be 200
    And response should be description = <description>

    Examples:
      | billable | description          | start                |
      | true     | Meeting Time updated | 2024-06-09T15:00:00Z |

  @DeleteTime
  Scenario: Delete time entry
    And call Tracker.feature@GetTimeEntry
    And endpoint /v1/workspaces/{{workspaceId}}/time-entries/{{TimeEntryId}}
    When execute method DELETE
    Then the status code should be 204