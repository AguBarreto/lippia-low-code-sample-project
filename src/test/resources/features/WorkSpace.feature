Feature: Workspace

  @AddNewWorkspace
  Scenario Outline: Add new workspace
    Given base url https://api.clockify.me/api/
    And endpoint v1/workspaces
    And header Content-type = application/json
    And header x-api-key = MTQ4ZTk2ZGEtMmRlNS00M2RlLWJlNDYtYzI3NDY0NmI1ZTYx
    And set value <nameWorkspace> of key name in body jsons/bodies/newWorkspace.json
    When execute method POST
    Then the status code should be 201


    Examples:
      | nameWorkspace |
      | space10       |


  @GetAllWorkspaces
  Scenario: Get all workspaces
    Given base url https://api.clockify.me/api/
    And endpoint v1/workspaces
    And header x-api-key = MTQ4ZTk2ZGEtMmRlNS00M2RlLWJlNDYtYzI3NDY0NmI1ZTYx
    When execute method GET
    Then the status code should be 200
    * define idWorkspace = response[0].id



