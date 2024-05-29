Feature: Clockify

  @AddNewProject @TP8
  Scenario Outline: Add new project
    Given base url https://api.clockify.me/api/
    And endpoint v1/workspaces/665533508656ce02d331bf81/projects
    And header Content-type = application/json
    And header x-api-key = MTQ4ZTk2ZGEtMmRlNS00M2RlLWJlNDYtYzI3NDY0NmI1ZTYx
    And set value <nameWorkspace> of key name in body jsons/bodies/newProject.json
    When execute method POST
    Then the status code should be 201

    Examples:
    | nameWorkspace |
    | test001       |


  @GetAllProjects @TP8
  Scenario: Get all projects on workspace
    Given base url https://api.clockify.me/api/
    And endpoint v1/workspaces/665533508656ce02d331bf81/projects
    And header x-api-key = MTQ4ZTk2ZGEtMmRlNS00M2RlLWJlNDYtYzI3NDY0NmI1ZTYx
    When execute method GET
    Then the status code should be 200
    * define idProject = response[0].id


  @GetProjectById @TP8
  Scenario: Get project by ID
    Given call Clockify.feature@GetAllProjects
    And base url https://api.clockify.me/api/
    And endpoint v1/workspaces/665533508656ce02d331bf81/projects/{{idProject}}
    And header x-api-key = MTQ4ZTk2ZGEtMmRlNS00M2RlLWJlNDYtYzI3NDY0NmI1ZTYx
    When execute method GET
    Then the status code should be 200








