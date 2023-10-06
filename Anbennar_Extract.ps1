param (
    [string]$filePath = $(Read-Host "Please, specify the JayBean-anbennar-eu4-fork-public-build...zip file (click and drag from file explorer)"),
    [string]$folder = $( Read-Host "Please, specify the destination folder name [.\Anbennar-PublicFork]" )
)

if (!$filePath) { throw "You must specify a .zip file" }
if (!$folder) { $folder = ".\Anbennar-PublicFork" }
$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition

$7zipPath = "$env:ProgramFiles\7-Zip\7z.exe"
if (-not (Test-Path -Path $7zipPath -PathType Leaf)) {
    throw "7 zip file '$7zipPath' not found"
}
Set-Alias 7z $7zipPath
$path = $filePath.Substring(0, $filePath.lastIndexOf('\'))
$inputFileName = Split-Path $filePath -Leaf
$outputPath = Convert-Path $folder.Substring(0, $folder.lastIndexOf('\'))
$command = "7z x '$filePath' -o'$outputPath'"
Invoke-Expression $command

$jaybeanPath = $outputPath + "\" + $inputFileName.Substring(0, $inputFileName.lastIndexOf('.'))
$jaybeanPath = $jaybeanPath.Replace("`"","")
$path = $path.Replace("`"","")
$outputPath = $outputPath.Replace("`"","")

Rename-Item -Path $jaybeanPath -NewName $folder
$TempFileName = "$outputPath\Anbennar-PublicFork.mod.tmp"

Copy-Item "$outputPath\$folder\Anbennar-PublicFork.mod" -Destination $TempFileName

$EU4ModPathGuess = [Environment]::GetFolderPath("MyDocuments").Replace("\","/")+"/Paradox Interactive/Europa Universalis IV/mod"

$prettyFolder = Split-Path $folder -Leaf
$dotmodpath = "path=`"$EU4ModPathGuess/$prettyFolder`""
$modname = "name=`"$prettyFolder`""

((Get-Content -path "$outputPath\Anbennar-PublicFork.mod.tmp" -Raw) -replace 'name="Anbennar-PublicFork"',$modname -replace 'path="mod/Anbennar-PublicFork"',$dotmodpath) | Set-Content -Path "$outputPath\$folder.mod"
((Get-Content -path "$outputPath\Anbennar-PublicFork.mod.tmp" -Raw) -replace 'name="Anbennar-PublicFork"',$modname -replace 'path="mod/Anbennar-PublicFork"',$dotmodpath) | Set-Content -Path "$outputPath\$folder\Anbennar-PublicFork.mod"

if (Test-Path $TempFileName) {
   Remove-Item $TempFileName -verbose
}
# SIG # Begin signature block
# MIIb0AYJKoZIhvcNAQcCoIIbwTCCG70CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUI7qRhDJWdAhm5Ms92EW1+P46
# 9BigghY1MIIDKDCCAhCgAwIBAgIQV/h2Wxyo14ZNRoLuaTzKMDANBgkqhkiG9w0B
# AQsFADAsMSowKAYDVQQDDCFodWZmLnN5c3RlbXMgU2NyaXB0IEF1dGhlbnRpY2F0
# b3IwHhcNMjMxMDA2MTc1NTIwWhcNMjQxMDA2MTgxNTIwWjAsMSowKAYDVQQDDCFo
# dWZmLnN5c3RlbXMgU2NyaXB0IEF1dGhlbnRpY2F0b3IwggEiMA0GCSqGSIb3DQEB
# AQUAA4IBDwAwggEKAoIBAQDcl3gDPyeWKaEb6vyhDssY4MAvogYfBQpef2kq963h
# bnlX8C1Pt6cq4z4tMpmX+eD7Bh2B847rJS8upXR3BOr26LPR3i5DHeGQDdh2XIpZ
# X2mWmsJW5GJouPvbl2qjR/dhhXVx1+1F14XM3wxM41W86JdC7SjsY7N1xiEoeyMs
# xqRBp2WuEf8hAMX4iPWR+HWiqahdcbmi23WrZuI3mTfRsBwWqLvztgQAVeVYYC38
# S5aErDb7/DYrz184bAPZrz3PEsfoxPpNzCqWdPscCeTeY2ZCnsJk8FmtV67LulGZ
# rd1V8nCn2HZ8qLG0MuNg9hyW5ii6e+F8+FbJM5zd90m9AgMBAAGjRjBEMA4GA1Ud
# DwEB/wQEAwIHgDATBgNVHSUEDDAKBggrBgEFBQcDAzAdBgNVHQ4EFgQUq+oHXEha
# BPAET5llwT13gzv+7OgwDQYJKoZIhvcNAQELBQADggEBAFSK1iaGPKijPvOkPCDx
# 3dlIHSKftApYfMO8eIKUdpwrDU79VeuCYlsUCWBI8oiBVSwqJAp22TmoGVK25JN8
# 4ihEw57QaQycE6k6/O1c4aAl7GXvMVJZrCQwm1ltXaYtadhh5JOhRZpbv7Rpn1lP
# DoQmPBd0TAp3t4xlNrTMVPX2gorIQyQRJfYMeZfaGz2Nh4ONHYk+opHP8+lfMk/c
# VLUiFX9Dlyvz9R3DsFIqah/WJFVXTortWJ/0UH6CjV+nHrm+0tiY+Keku6dgAUB3
# GsnTTua+pvkPJnw0trDiC3XvwGj3KhYCJ3zXKb73XSDO7OBwirMYAXPxV7leP7tt
# /1AwggWNMIIEdaADAgECAhAOmxiO+dAt5+/bUOIIQBhaMA0GCSqGSIb3DQEBDAUA
# MGUxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsT
# EHd3dy5kaWdpY2VydC5jb20xJDAiBgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQg
# Um9vdCBDQTAeFw0yMjA4MDEwMDAwMDBaFw0zMTExMDkyMzU5NTlaMGIxCzAJBgNV
# BAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdp
# Y2VydC5jb20xITAfBgNVBAMTGERpZ2lDZXJ0IFRydXN0ZWQgUm9vdCBHNDCCAiIw
# DQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAL/mkHNo3rvkXUo8MCIwaTPswqcl
# LskhPfKK2FnC4SmnPVirdprNrnsbhA3EMB/zG6Q4FutWxpdtHauyefLKEdLkX9YF
# PFIPUh/GnhWlfr6fqVcWWVVyr2iTcMKyunWZanMylNEQRBAu34LzB4TmdDttceIt
# DBvuINXJIB1jKS3O7F5OyJP4IWGbNOsFxl7sWxq868nPzaw0QF+xembud8hIqGZX
# V59UWI4MK7dPpzDZVu7Ke13jrclPXuU15zHL2pNe3I6PgNq2kZhAkHnDeMe2scS1
# ahg4AxCN2NQ3pC4FfYj1gj4QkXCrVYJBMtfbBHMqbpEBfCFM1LyuGwN1XXhm2Tox
# RJozQL8I11pJpMLmqaBn3aQnvKFPObURWBf3JFxGj2T3wWmIdph2PVldQnaHiZdp
# ekjw4KISG2aadMreSx7nDmOu5tTvkpI6nj3cAORFJYm2mkQZK37AlLTSYW3rM9nF
# 30sEAMx9HJXDj/chsrIRt7t/8tWMcCxBYKqxYxhElRp2Yn72gLD76GSmM9GJB+G9
# t+ZDpBi4pncB4Q+UDCEdslQpJYls5Q5SUUd0viastkF13nqsX40/ybzTQRESW+UQ
# UOsxxcpyFiIJ33xMdT9j7CFfxCBRa2+xq4aLT8LWRV+dIPyhHsXAj6KxfgommfXk
# aS+YHS312amyHeUbAgMBAAGjggE6MIIBNjAPBgNVHRMBAf8EBTADAQH/MB0GA1Ud
# DgQWBBTs1+OC0nFdZEzfLmc/57qYrhwPTzAfBgNVHSMEGDAWgBRF66Kv9JLLgjEt
# UYunpyGd823IDzAOBgNVHQ8BAf8EBAMCAYYweQYIKwYBBQUHAQEEbTBrMCQGCCsG
# AQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wQwYIKwYBBQUHMAKGN2h0
# dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RD
# QS5jcnQwRQYDVR0fBD4wPDA6oDigNoY0aHR0cDovL2NybDMuZGlnaWNlcnQuY29t
# L0RpZ2lDZXJ0QXNzdXJlZElEUm9vdENBLmNybDARBgNVHSAECjAIMAYGBFUdIAAw
# DQYJKoZIhvcNAQEMBQADggEBAHCgv0NcVec4X6CjdBs9thbX979XB72arKGHLOyF
# XqkauyL4hxppVCLtpIh3bb0aFPQTSnovLbc47/T/gLn4offyct4kvFIDyE7QKt76
# LVbP+fT3rDB6mouyXtTP0UNEm0Mh65ZyoUi0mcudT6cGAxN3J0TU53/oWajwvy8L
# punyNDzs9wPHh6jSTEAZNUZqaVSwuKFWjuyk1T3osdz9HNj0d1pcVIxv76FQPfx2
# CWiEn2/K2yCNNWAcAgPLILCsWKAOQGPFmCLBsln1VWvPJ6tsds5vIy30fnFqI2si
# /xK4VC0nftg62fC2h5b9W9FcrBjDTZ9ztwGpn1eqXijiuZQwggauMIIElqADAgEC
# AhAHNje3JFR82Ees/ShmKl5bMA0GCSqGSIb3DQEBCwUAMGIxCzAJBgNVBAYTAlVT
# MRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5j
# b20xITAfBgNVBAMTGERpZ2lDZXJ0IFRydXN0ZWQgUm9vdCBHNDAeFw0yMjAzMjMw
# MDAwMDBaFw0zNzAzMjIyMzU5NTlaMGMxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5E
# aWdpQ2VydCwgSW5jLjE7MDkGA1UEAxMyRGlnaUNlcnQgVHJ1c3RlZCBHNCBSU0E0
# MDk2IFNIQTI1NiBUaW1lU3RhbXBpbmcgQ0EwggIiMA0GCSqGSIb3DQEBAQUAA4IC
# DwAwggIKAoICAQDGhjUGSbPBPXJJUVXHJQPE8pE3qZdRodbSg9GeTKJtoLDMg/la
# 9hGhRBVCX6SI82j6ffOciQt/nR+eDzMfUBMLJnOWbfhXqAJ9/UO0hNoR8XOxs+4r
# gISKIhjf69o9xBd/qxkrPkLcZ47qUT3w1lbU5ygt69OxtXXnHwZljZQp09nsad/Z
# kIdGAHvbREGJ3HxqV3rwN3mfXazL6IRktFLydkf3YYMZ3V+0VAshaG43IbtArF+y
# 3kp9zvU5EmfvDqVjbOSmxR3NNg1c1eYbqMFkdECnwHLFuk4fsbVYTXn+149zk6ws
# OeKlSNbwsDETqVcplicu9Yemj052FVUmcJgmf6AaRyBD40NjgHt1biclkJg6OBGz
# 9vae5jtb7IHeIhTZgirHkr+g3uM+onP65x9abJTyUpURK1h0QCirc0PO30qhHGs4
# xSnzyqqWc0Jon7ZGs506o9UD4L/wojzKQtwYSH8UNM/STKvvmz3+DrhkKvp1KCRB
# 7UK/BZxmSVJQ9FHzNklNiyDSLFc1eSuo80VgvCONWPfcYd6T/jnA+bIwpUzX6ZhK
# WD7TA4j+s4/TXkt2ElGTyYwMO1uKIqjBJgj5FBASA31fI7tk42PgpuE+9sJ0sj8e
# CXbsq11GdeJgo1gJASgADoRU7s7pXcheMBK9Rp6103a50g5rmQzSM7TNsQIDAQAB
# o4IBXTCCAVkwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUuhbZbU2FL3Mp
# dpovdYxqII+eyG8wHwYDVR0jBBgwFoAU7NfjgtJxXWRM3y5nP+e6mK4cD08wDgYD
# VR0PAQH/BAQDAgGGMBMGA1UdJQQMMAoGCCsGAQUFBwMIMHcGCCsGAQUFBwEBBGsw
# aTAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29tMEEGCCsGAQUF
# BzAChjVodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRUcnVzdGVk
# Um9vdEc0LmNydDBDBgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3JsMy5kaWdpY2Vy
# dC5jb20vRGlnaUNlcnRUcnVzdGVkUm9vdEc0LmNybDAgBgNVHSAEGTAXMAgGBmeB
# DAEEAjALBglghkgBhv1sBwEwDQYJKoZIhvcNAQELBQADggIBAH1ZjsCTtm+YqUQi
# AX5m1tghQuGwGC4QTRPPMFPOvxj7x1Bd4ksp+3CKDaopafxpwc8dB+k+YMjYC+Vc
# W9dth/qEICU0MWfNthKWb8RQTGIdDAiCqBa9qVbPFXONASIlzpVpP0d3+3J0FNf/
# q0+KLHqrhc1DX+1gtqpPkWaeLJ7giqzl/Yy8ZCaHbJK9nXzQcAp876i8dU+6Wvep
# ELJd6f8oVInw1YpxdmXazPByoyP6wCeCRK6ZJxurJB4mwbfeKuv2nrF5mYGjVoar
# CkXJ38SNoOeY+/umnXKvxMfBwWpx2cYTgAnEtp/Nh4cku0+jSbl3ZpHxcpzpSwJS
# pzd+k1OsOx0ISQ+UzTl63f8lY5knLD0/a6fxZsNBzU+2QJshIUDQtxMkzdwdeDrk
# nq3lNHGS1yZr5Dhzq6YBT70/O3itTK37xJV77QpfMzmHQXh6OOmc4d0j/R0o08f5
# 6PGYX/sr2H7yRp11LB4nLCbbbxV7HhmLNriT1ObyF5lZynDwN7+YAN8gFk8n+2Bn
# FqFmut1VwDophrCYoCvtlUG3OtUVmDG0YgkPCr2B2RP+v6TR81fZvAT6gt4y3wSJ
# 8ADNXcL50CN/AAvkdgIm2fBldkKmKYcJRyvmfxqkhQ/8mJb2VVQrH4D6wPIOK+XW
# +6kvRBVK5xMOHds3OBqhK/bt1nz8MIIGwjCCBKqgAwIBAgIQBUSv85SdCDmmv9s/
# X+VhFjANBgkqhkiG9w0BAQsFADBjMQswCQYDVQQGEwJVUzEXMBUGA1UEChMORGln
# aUNlcnQsIEluYy4xOzA5BgNVBAMTMkRpZ2lDZXJ0IFRydXN0ZWQgRzQgUlNBNDA5
# NiBTSEEyNTYgVGltZVN0YW1waW5nIENBMB4XDTIzMDcxNDAwMDAwMFoXDTM0MTAx
# MzIzNTk1OVowSDELMAkGA1UEBhMCVVMxFzAVBgNVBAoTDkRpZ2lDZXJ0LCBJbmMu
# MSAwHgYDVQQDExdEaWdpQ2VydCBUaW1lc3RhbXAgMjAyMzCCAiIwDQYJKoZIhvcN
# AQEBBQADggIPADCCAgoCggIBAKNTRYcdg45brD5UsyPgz5/X5dLnXaEOCdwvSKOX
# ejsqnGfcYhVYwamTEafNqrJq3RApih5iY2nTWJw1cb86l+uUUI8cIOrHmjsvlmbj
# aedp/lvD1isgHMGXlLSlUIHyz8sHpjBoyoNC2vx/CSSUpIIa2mq62DvKXd4ZGIX7
# ReoNYWyd/nFexAaaPPDFLnkPG2ZS48jWPl/aQ9OE9dDH9kgtXkV1lnX+3RChG4PB
# uOZSlbVH13gpOWvgeFmX40QrStWVzu8IF+qCZE3/I+PKhu60pCFkcOvV5aDaY7Mu
# 6QXuqvYk9R28mxyyt1/f8O52fTGZZUdVnUokL6wrl76f5P17cz4y7lI0+9S769Sg
# LDSb495uZBkHNwGRDxy1Uc2qTGaDiGhiu7xBG3gZbeTZD+BYQfvYsSzhUa+0rRUG
# FOpiCBPTaR58ZE2dD9/O0V6MqqtQFcmzyrzXxDtoRKOlO0L9c33u3Qr/eTQQfqZc
# ClhMAD6FaXXHg2TWdc2PEnZWpST618RrIbroHzSYLzrqawGw9/sqhux7UjipmAmh
# cbJsca8+uG+W1eEQE/5hRwqM/vC2x9XH3mwk8L9CgsqgcT2ckpMEtGlwJw1Pt7U2
# 0clfCKRwo+wK8REuZODLIivK8SgTIUlRfgZm0zu++uuRONhRB8qUt+JQofM604qD
# y0B7AgMBAAGjggGLMIIBhzAOBgNVHQ8BAf8EBAMCB4AwDAYDVR0TAQH/BAIwADAW
# BgNVHSUBAf8EDDAKBggrBgEFBQcDCDAgBgNVHSAEGTAXMAgGBmeBDAEEAjALBglg
# hkgBhv1sBwEwHwYDVR0jBBgwFoAUuhbZbU2FL3MpdpovdYxqII+eyG8wHQYDVR0O
# BBYEFKW27xPn783QZKHVVqllMaPe1eNJMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6
# Ly9jcmwzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydFRydXN0ZWRHNFJTQTQwOTZTSEEy
# NTZUaW1lU3RhbXBpbmdDQS5jcmwwgZAGCCsGAQUFBwEBBIGDMIGAMCQGCCsGAQUF
# BzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wWAYIKwYBBQUHMAKGTGh0dHA6
# Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydFRydXN0ZWRHNFJTQTQwOTZT
# SEEyNTZUaW1lU3RhbXBpbmdDQS5jcnQwDQYJKoZIhvcNAQELBQADggIBAIEa1t6g
# qbWYF7xwjU+KPGic2CX/yyzkzepdIpLsjCICqbjPgKjZ5+PF7SaCinEvGN1Ott5s
# 1+FgnCvt7T1IjrhrunxdvcJhN2hJd6PrkKoS1yeF844ektrCQDifXcigLiV4JZ0q
# BXqEKZi2V3mP2yZWK7Dzp703DNiYdk9WuVLCtp04qYHnbUFcjGnRuSvExnvPnPp4
# 4pMadqJpddNQ5EQSviANnqlE0PjlSXcIWiHFtM+YlRpUurm8wWkZus8W8oM3NG6w
# QSbd3lqXTzON1I13fXVFoaVYJmoDRd7ZULVQjK9WvUzF4UbFKNOt50MAcN7MmJ4Z
# iQPq1JE3701S88lgIcRWR+3aEUuMMsOI5ljitts++V+wQtaP4xeR0arAVeOGv6wn
# LEHQmjNKqDbUuXKWfpd5OEhfysLcPTLfddY2Z1qJ+Panx+VPNTwAvb6cKmx5Adza
# ROY63jg7B145WPR8czFVoIARyxQMfq68/qTreWWqaNYiyjvrmoI1VygWy2nyMpqy
# 0tg6uLFGhmu6F/3Ed2wVbK6rr3M66ElGt9V/zLY4wNjsHPW2obhDLN9OTH0eaHDA
# dwrUAuBcYLso/zjlUlrWrBciI0707NMX+1Br/wd3H3GXREHJuEbTbDJ8WC9nR2Xl
# G3O2mflrLAZG70Ee8PBf4NvZrZCARK+AEEGKMYIFBTCCBQECAQEwQDAsMSowKAYD
# VQQDDCFodWZmLnN5c3RlbXMgU2NyaXB0IEF1dGhlbnRpY2F0b3ICEFf4dlscqNeG
# TUaC7mk8yjAwCQYFKw4DAhoFAKB4MBgGCisGAQQBgjcCAQwxCjAIoAKAAKECgAAw
# GQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEOMAwGCisG
# AQQBgjcCARUwIwYJKoZIhvcNAQkEMRYEFAYoSG/6AwED8xs8PPNDMroET8LmMA0G
# CSqGSIb3DQEBAQUABIIBAMFZfjzq0kJzSjiLTZiOGflk1XOFyPofVzC9o2XVIcY7
# cpxGFNOMXks6c7QMwJOko3JMrMq2opnItHwa907WL5u9LJmLAWsB55jbOunG4v6Y
# J5DKbduimKEAjzeQCBI8RdC4TKy4d2k7T9SPQ4+4Tae48h7XxLLEnHkmn8tZwgkf
# D1tAju4d7S2o4P2Dqg3kEklVL5qrQsNHrwW5rDKLuWwwCjxmWDKccOKj+oK/W8dk
# XFsd2BvFzVA4eUM79RSF0wdN67xgKXOJxiZ1Z0IJHOsSMPgcld7KsN/m+nPLiSyP
# FL7e9lo7uQc6Z2uiqEhLOFk4XgNoooa6f0UQBzolZUqhggMgMIIDHAYJKoZIhvcN
# AQkGMYIDDTCCAwkCAQEwdzBjMQswCQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNl
# cnQsIEluYy4xOzA5BgNVBAMTMkRpZ2lDZXJ0IFRydXN0ZWQgRzQgUlNBNDA5NiBT
# SEEyNTYgVGltZVN0YW1waW5nIENBAhAFRK/zlJ0IOaa/2z9f5WEWMA0GCWCGSAFl
# AwQCAQUAoGkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUx
# DxcNMjMxMDA2MTgwNzU1WjAvBgkqhkiG9w0BCQQxIgQgGYf3jkpget19BS9eSaKF
# B14Id9R6mmbAw03ucpqEH1QwDQYJKoZIhvcNAQEBBQAEggIAb3HRIu1EiQrCSMgK
# EuJc5j0SjiwS3bEa5WzSpjDiynOpXzzGWoDByVQMd1qJ/j7zgnG5iYQOKCqTo5IS
# gNiwMZLBSwXauvsnAk7uiNrLFW86PSZG4OuAKviBxK+awek85ZNSCwdkLSM6idQT
# 6CcpGXG0RTmg4Vkw58oeGab6yLBxgQ6XERrDGWhg3EeVGB7Mz31AdeCjuDYZnfDF
# Ke7xX2HEpqj+bN2zIAhjZy12WF1lTXfexN0akyWBrkKiMtASNWoydUQfY5DuMICR
# muXqWP9ouqwaXFNDlidxz6PDyScI/GRVOglfY7GnS14xfrWVpQO75Y9VrWZ1mq70
# LexPG0bVpn2RTBjRPR3yepMkDcvPEHZDUUFX0u/1n0h2ZPFPl+GRkcUTW1GMdhOc
# RrCRjvtaV8gpY61LdKE28+OTD/jJnjh9eNxK5sYqL7FVw1Tbc/pf47W8vxI7CTZK
# 0yWOt9UId31FOrIrIhhd/VqQRcbUnCjKeAV0xoiTLk5H+kPJ9IBYXB/zG4IqfpKk
# nKbeAJtLBmf71erwr58q+cKUIfy9eh9D0kNWxJhi7eIz9+JK8tn4QCjj3tfoAwpY
# 5iQAoNwxzidEjEVC9dAlSAMRfFnTZ7EMppPEZP6Qs0qamE3ZV0SFSCz7uzaXF4CR
# vgJ+s5rliiPlk9fYLxFu76Lgpys=
# SIG # End signature block
