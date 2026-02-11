/*
Folders to be created level wise - top to bottom from organization id, filling in respective level folder ids for child folders
Add folders here accordingly to keep an update of hierarchy
- Organization
  - Landing Zone  
    - Infrastructure  
      - Shared Services  
      - Network  
        - Prod  
        - Dev  
      - Security  
        - Dev  
        - Prod  
  - Sandbox  
    - Test  
  - Data Science Center  
    - Test  
    - Workload  
    - Dev  
  - Business Continuity  
    - Prod  
    - Dev  
*/

##################
#  GCP Folders   #
##################
folders = [
  {
    name   = "Landing Zone"
    parent = "organizations/<org-id>" # Organization id
  },
  {
    name   = "Business Continuity"
    parent = "organizations/<org-id>"
  },
  {
    name   = "Sandbox"
    parent = "organizations/<org-id>"
  },
  {
    name   = "Data Science Center"
    parent = "organizations/<org-id>"
  },
  {
    name   = "Infrastructure"
    parent = "folders/<folder-id-1>" # Landing Zone folder id
  },
  {
    name   = "Shared Services"
    parent = "folders/<folder-id-2>" # Infrastructure folder id
  },
  {
    name   = "Network"
    parent = "folders/<folder-id-2>"
  },
  {
    name   = "Security"
    parent = "folders/<folder-id-2>"
  },
  {
    name   = "Dev"
    parent = "folders/<folder-id-3>" # Network folder id
  },
  {
    name   = "Prod"
    parent = "folders/<folder-id-3>"
  },
  {
    name   = "Dev"
    parent = "folders/<folder-id-4>" # Security folder id
  },
  {
    name   = "Prod"
    parent = "folders/<folder-id-4>"
  },
  {
    name   = "Test"
    parent = "folders/<folder-id-5>" # Sandbox folder id
  },
  {
    name   = "Dev"
    parent = "folders/<folder-id-6>" # Data Science Center folder id
  },
  {
    name   = "Test"
    parent = "folders/<folder-id-6>"
  },
  {
    name   = "Workload"
    parent = "folders/<folder-id-6>"
  },
  {
    name   = "Dev"
    parent = "folders/<folder-id-7>" # Business Continuity folder id
  },
  {
    name   = "Prod"
    parent = "folders/<folder-id-7>"
  }
]