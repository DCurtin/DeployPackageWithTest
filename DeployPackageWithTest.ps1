function DeployPackageWithTest
{
    param(
        $userName,
        $package,
        $checkOnly=$false
    )

    #$tests = $(Get-ChildItem -Recurse "*Test.cls").name.replace('.cls', '') -join ','
    [xml]$packake_import = Get-Content $package
    $tests = $($packake_import.Package.types.members -match "Test") -join ','
    
    if($checkOnly)
    {
        sfdx force:source:deploy -x $package -l RunSpecifiedTests -r $tests -u $userName -c
    }else{
        sfdx force:source:deploy -x $package -l RunSpecifiedTests -r $tests -u $userName
    }
}
