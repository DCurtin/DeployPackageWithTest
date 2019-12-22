function DeployPackageWithTest
{
    param(
        $userName='',
        $package='',
        $checkOnly=$false,
        $generateCommand=$false
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
    [System.Collections.ArrayList] $testList = @();
<<<<<<< HEAD
    $packake_import.Package.types | ForEach-Object -Process (
    {
        if($_.name -eq 'ApexClass')
        {
            $_.members | ForEach-Object -Process (
            {
                if($_ -match "Test$")
                {
                    $null = $testList.add($_);
                    Write-Host "$_"
                }
            })
        }
    })
    $tests = $testList -join ",";
    
    $command = '';
=======
    $packake_import.Package.types | ForEach-Object -Process ({
        if($_.name -eq "ApexClass" -and $_.members -match "Test$")
        {
            $null = $testList.add($_.members);
        }
    })
    
    $tests = $testList -join ',';
>>>>>>> 9f1f229f284c508de044a52be468e70afedcc475

    if($checkOnly -eq "True")
    {
        $command = "sfdx force:source:deploy -x $package -l RunSpecifiedTests -r $tests -u $userName -c"
    }else{
        $command = "sfdx force:source:deploy -x $package -l RunSpecifiedTests -r $tests -u $userName"
    }

    if($generateCommand -eq "True")
    {
        echo $command
    }else{
        Invoke-expression -command $command
    }
}
Export-ModuleMember -Function DeployPackageWithTest