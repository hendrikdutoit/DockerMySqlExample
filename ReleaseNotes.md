# Release 0.0.4

- Update ISSUE_TEMPLATEs
- Implement reusable workflows.
- Update secrets in workflow.
- Rpleaced some constants with environment variables.
- Update configuration files.
  - .flake8
  - .gitattribultes
  - .gitignore
  - docker-compose.yaml
  - Docker
  - LICENSE.txt
  - pyproject.toml
  -
- Add scripts
  - CreateDbSqlScripts.ps1
  - README.md
  - SetupDocker.ps1
  - SetupDotEnv.ps1
  - SetupGitHubAccess.ps1
  - SetupPrivateRepoAccess.ps1
- Delete
  - docker-compose-guthub.yaml
  - infra.yaml
  - Install.ps1

______________________________________________________________________

# Release 0.0.3

# Upgrade Configuration and Restructuring

- Add the following environment variables as secrets for Docker configuration:
  - INSTALLER_USER_ID
  - INSTALLER_USER_PWD
  - MYSQL_DATABASE
  - MYSQL_HOST
  - MYSQL_ROOT_PASSWORD
  - MYSQL_TCP_PORT
  - MYSQL_USER_ID
  - MYSQL_USER_PWD

______________________________________________________________________

# Release 0.0.2

# Upgrade Configuration and Restructuring

- Update ISSUE_TEMPLATE's.
- Update Workflow.
- Update the pre-commit hooks
- Fix the Workflows
- Update pyproject.toml.
- Spelling corrections.
- Add scripts\\init.dql script
- Fixed up the pytest's
- Updated .gitignore, pre-commit-config.yaml
- Add Docker configuration files
