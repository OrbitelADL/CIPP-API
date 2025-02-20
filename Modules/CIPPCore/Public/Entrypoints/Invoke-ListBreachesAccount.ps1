using namespace System.Net

Function Invoke-ListBreachesAccount {
    <#
    .FUNCTIONALITY
        Entrypoint
    .ROLE
        CIPP.Core.Read
    #>
    [CmdletBinding()]
    param($Request, $TriggerMetadata)

    $APIName = $Request.Params.CIPPEndpoint
    Write-LogMessage -headers $Request.Headers -API $APINAME -message 'Accessed this API' -Sev 'Debug'

    if ($request.query.account -like '*@*') {
        $Results = Get-HIBPRequest "breachedaccount/$($Request.query.account)?truncateResponse=false"
    } else {
        $Results = Get-BreachInfo -Domain $Request.query.account
    }

    # Associate values to output bindings by calling 'Push-OutputBinding'.
    Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
            StatusCode = [HttpStatusCode]::OK
            Body       = @($results)
        })

}
