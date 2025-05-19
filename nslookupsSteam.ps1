# List of domains to check
$domains = @(
    "steamcontent.com",
    "steamstatic.com",
    "steamusercontent.com",
    "akamaihd.net",
    "playfabapi.com"
)

# List of resolvers
$resolvers = @{
    "Cloudflare"     = "1.1.1.1"
    "Google"         = "8.8.8.8"
    "Quad9"          = "9.9.9.9"
    "OpenDNS"        = "208.67.222.222"
    "CleanBrowsing"  = "185.228.168.9"
}

Write-Host "`n=== Steam CDN Domain Resolution Check ===`n"

foreach ($domain in $domains) {
    Write-Host "`n🔍 Checking domain: $domain"
    Write-Host "-----------------------------------"

    foreach ($resolver in $resolvers.Keys) {
        $ip = $resolvers[$resolver]
        Write-Host "`n[$resolver] ($ip):"

        try {
            $result = nslookup $domain $ip | Out-String

            if ($result -match "Address: (\d{1,3}(\.\d{1,3}){3})") {
                $address = $matches[1]
                Write-Host "✅ Resolved to: $address"
            }
            elseif ($result -match "Name:") {
                Write-Host "❌ No A record returned (domain exists)"
            } else {
                Write-Host "❌ DNS resolution failed"
            }
        } catch {
            Write-Host "❌ Error querying $domain via $resolver"
        }
    }

    Write-Host "`n-----------------------------------`n"
}
