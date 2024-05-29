Feature: Clockify

  Scenario: Add new project
    Given base url https://api.clockify.me/api/v1
    And endpoint /workspaces/665533508656ce02d331bf81/projects
    And header x-api-key = MTQ4ZTk2ZGEtMmRlNS00M2RlLWJlNDYtYzI3NDY0NmI1ZTYx
    And set value "Proyecto1" of key name in body jsons/bodies/newProject.json
    When execute method POST
    Then the status code should be 201

  Scenario: Get project by ID
    Given base url https://api.clockify.me/api/v1
    And endpoint workspaces/665533508656ce02d331bf81/projects/6656640326fd805d667a9a77
    When execute method GET
    Then the status code should be 201




