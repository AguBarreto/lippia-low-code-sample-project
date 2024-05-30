Feature: Workspace

  @AddNewWorkspace @TP8
  Scenario Outline: Add new workspace
    Given base url $(env.base_url)
    And endpoint v1/workspaces
    And header Content-type = application/json
    And header x-api-key = $(env.x_api_key)
    And set value <nameWorkspace> of key name in body jsons/bodies/newWorkspace.json
    When execute method POST

    Examples:
      | nameWorkspace |
      | space12       |

  @GetAllWorkspaces @TP8
  Scenario: Get all workspaces
    Given base url $(env.base_url)
    And endpoint v1/workspaces
    And header x-api-key = $(env.x_api_key)
    When execute method GET
    Then the status code should be 200
    * define idWorkspace = response[0].id
