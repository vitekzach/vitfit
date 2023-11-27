# VitFit

# Project initialization
```powershell
docker volume create vitfit-pgdata
docker network create vitfit
cd database
.\create_db_docker.ps1
```

# Project structure
## Database
In this folder, scripts for database setup are present, including scripts to run to get to the latest version.