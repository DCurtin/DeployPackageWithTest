function DeployPackageWithTest
{
    param(
        $userName='',
        $package='',
        $checkOnly=$false
    )

    if($userName -eq '' -and $package -eq '')
    {
        Write-Host "Available paramters: `n* userName [required] `n* package [required] `n* checkOnly [optional]`n"
        Write-Host "e.g. DeployPackageWithTest -userName dcurtin@midlandira.com.dcurtin -package .\manifest\package.xml"
        Write-Host "e.g. DeployPackageWithTest -userName dcurtin@midlandira.com.dcurtin -package .\manifest\package.xml -checkOnly True"
        return
    }

    if($userName -eq '' -or $package -eq '')
    {
        Write-Host "userName and package required. `ne.g. DeployPackageWithTest -userName dcurtin@midlandira.com.dcurtin -package .\manifest\package.xml"
        return
    }
    
    [xml]$packake_import = Get-Content $package
    $tests = $($packake_import.Package.types.members -match "Test") -join ','
    
    if($checkOnly -eq "True")
    {
        sfdx force:source:deploy -x $package -l RunSpecifiedTests -r $tests -u $userName -c
    }else{
        sfdx force:source:deploy -x $package -l RunSpecifiedTests -r $tests -u $userName
    }
}
Export-ModuleMember -Function DeployPackageWithTest