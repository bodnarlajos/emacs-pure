param([string]$Directory) 
get-childitem $Directory | 
  % { $f = $_ ; 
    get-childitem -r $_.FullName | 
      measure-object -property length -sum | 			
        select @{Name="Namn";Expression={$f}},@{Name="Sum (Mb)"; Expression={"{0:N1}" -f ($_.sum / 1MB)}}}