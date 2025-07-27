echo "========================================="
echo "        LOG ANALYZER REPORT              "
echo "========================================="


echo "TOP 5 IP ADDRESSES"
echo "========================================="
echo "Count      IP Address"
awk '{print $1}' nginx-access.log | sort | uniq -c | sort -nr | head -5 | awk '{printf "%-10s %s\n", $1, $2}'
echo ""
echo "TOP 5 most requested paths"
echo "========================================="
echo "Count      Path"
awk '{print $7}' nginx-access.log | sort | uniq -c | sort -nr | head -5 | awk '{printf "%-10s %s\n", $1, $2}'
echo ""
echo "TOP 5 HTTP Status Codes"
echo "========================================="
echo "Count      Status Code"
awk -F'"' '{print $3}' nginx-access.log | awk '{print $1}' | sort | uniq -c | sort -nr | head -5 | awk '{printf "%-10s %s\n", $1, $2}'
echo ""
echo "TOP 5 User Agents"
echo "========================================="
echo "Count      User Agent"
awk -F'"' '{print $6}' nginx-access.log | sort | uniq -c | sort -nr | head -5
echo ""
