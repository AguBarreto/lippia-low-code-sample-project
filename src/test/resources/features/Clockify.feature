Feature: Clockify

  @AddNewProject @TP8
  Scenario Outline: Add new project
    Given call Workspace.feature@GetAllWorkspaces
    And base url $(env.base_url)
    And endpoint v1/workspaces/{{idWorkspace}}/projects
    And header Content-type = application/json
    And header x-api-key = $(env.x_api_key)
    And set value <nameProject> of key name in body jsons/bodies/newProject.json
    When execute method POST
    Then the status code should be 201


    Examples:
      | nameProject |
      | PRUEBAS     |


  @GetAllProjects @TP8
  Scenario: Get all projects on workspace
    Given call Workspace.feature@GetAllWorkspaces
    And base url $(env.base_url)
    And endpoint v1/workspaces/{{idWorkspace}}/projects
    And header x-api-key = $(env.x_api_key)
    When execute method GET
    Then the status code should be 200
    * define idProject = response[0].id


  @GetProjectById @TP8
  Scenario: Get project by ID
    Given call Workspace.feature@GetAllWorkspaces
    And call Clockify.feature@GetAllProjects
    And base url $(env.base_url)
    And endpoint v1/workspaces/{{idWorkspace}}/projects/{{idProject}}
    And header x-api-key = $(env.x_api_key)
    When execute method GET
    Then the status code should be 200

  @GetProjectById @TP8
  Scenario: Get project by nonexistent ID
    Given call Workspace.feature@GetAllWorkspaces
    And call Clockify.feature@GetAllProjects
    And base url $(env.base_url)
    And endpoint v1/workspaces/{{idWorkspace}}/projects/654155613
    And header x-api-key = $(env.x_api_key)
    When execute method GET
    Then the status code should be 400

  @UpdateProject @TP8
  Scenario: Update project on workspace
    Given call Workspace.feature@GetAllWorkspaces
    And call Clockify.feature@GetAllProjects
    And base url $(env.base_url)
    And endpoint v1/workspaces/{{idWorkspace}}/projects/{{idProject}}
    And header Content-type = application/json
    And header x-api-key = $(env.x_api_key)
    And body jsons/bodies/EditProject.json
    When execute method PUT
    Then the status code should be 200