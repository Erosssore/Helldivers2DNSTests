echo "============================="
echo " Steam / Helldivers 2 CDN Test "
echo "============================="

DOMAINS=(
  "steamcontent.com" 
  "steamstatic.com" 
  "steamusercontent.com" 
  "akamaihd.net" 
  "playfabapi.com"
  )

for domain in "${DOMAINS[@]}"; do
  echo
  echo "Domain: $domain"
  echo "------------------------"

  # Resolve domain
  resolved_ip=$(dig +short "$domain" | grep -E '^[0-9.]+' | head -n 1)
  if [[ -z "$resolved_ip" ]]; then
    echo "DNS resolution failed"
    continue
  else
    echo "DNS resolves to: $resolved_ip"
  fi

  # Traceroute
  echo "Traceroute (first 20 hops):"
  traceroute -m 20 "$domain"

  # Test HTTPS connection
  echo "curl HTTPS connection:"
  curl -s -o /dev/null -w "%{http_code} %{remote_ip}\n" --connect-timeout 10 "https://$domain"
done
