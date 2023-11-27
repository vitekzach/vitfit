# .create_db.ps1

$scriptPath = '.\create_db.ps1'
. $scriptPath -Hostname localhost -Port 5432 -BaseDatabase postgres -TargetDatabase vitfit -Username admin -Password "Let me in!" -AdminUsername postgres -AdminPassword Password3000!!