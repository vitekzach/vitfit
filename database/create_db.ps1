param (
    [Parameter(Mandatory=$true)][string]$Hostname,
    [Parameter(Mandatory=$true)][int]$Port,
    [string]$BaseDatabase = "postgres",
    [Parameter(Mandatory=$true)][string]$TargetDatabase,
    [Parameter(Mandatory=$true)][string]$AdminUsername,
    [Parameter(Mandatory=$true)][string]$AdminPassword,
    [Parameter(Mandatory=$true)][string]$Username,
    [Parameter(Mandatory=$true)][string]$Password
)


write-output "Creating database with following parameters: "
write-output "  Hostname:           $Hostname"
write-output "  Port:               $Port"
write-output "  BaseDatabase:       $BaseDatabase"
write-output "  TargetDatabase:     $TargetDatabase"
write-output "  AdminUsername:      $AdminUsername"
write-output "  Username:           $Username"

$00CreateDatabase = "00_create_database.sql"
$10CreateSchemas = "10_create_schemas.sql"
$20CreateUsers = "20_create_users_and_grants.sql"
$30CreateBaseStructure = "30_create_base_structure.sql"
$40CreateFunctions = "40_create_functions.sql"
$90InsertData = "90_insert_sample_data.sql"

write-output ""
write-output "00 Creating database... ($00CreateDatabase)"
$Env:PGPASSWORD = $AdminPassword
psql -h $Hostname -d $BaseDatabase -p $Port -U $AdminUsername -w -f $00CreateDatabase

$Env:PGPASSWORD = $Password

write-output ""
write-output "10 Creating schemas..."
psql -h $Hostname -d $TargetDatabase -p $Port -U $Username -w -f $10CreateSchemas

write-output ""
write-output "20 Creating users and granting privileges..."
psql -h $Hostname -d $TargetDatabase -p $Port -U $Username -w -f $20CreateUsers

write-output ""
write-output "30 creating tables ..."
psql -h $Hostname -d $TargetDatabase -p $Port -U $Username -w -f $30CreateBaseStructure

write-output ""
write-output "40 creating functions ..."
psql -h $Hostname -d $TargetDatabase -p $Port -U $Username -w -f $40CreateFunctions

write-output ""
write-output "90 Inserting data ..."
psql -h $Hostname -d $TargetDatabase -p $Port -U $Username -w -f $90InsertData