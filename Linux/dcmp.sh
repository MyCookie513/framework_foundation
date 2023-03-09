
#set -x 

workspace=$(cd $(dirname $0) && pwd -P)


echo "$workspace"


for b in {1..1000}
 do
curl 'https://www.7youxi.com/user/security/phone/send_code' -H 'Cookie:7you_cookie="VUlEX0QzOTFDOEVBRUYxOTBDNTJCNzBGQkQzRUE0NUNFNkZEfHw=|9204a8e96c925c74436d5a1f14822bc71403400ac805dfa362215425195e4fad678d2a19139ef257ff15a78ee20101b68e3960fcf8f89700f7bfdf52bff50d4c"; homepage=.eJxNTsFugzAU-5Up5x5CED0g9cAUQGN6oUEhNLlU7WBAEqQKVm1L1X9fjjtYlm3Z8gOdP9dhm1D6td6HHTrPPUof6OWKUsSodEoUDoT6BdMYTZ0B0hJGM6zLyjLCEy3eYrbkOLAHb0PGYyg50SZ41Ppa9IaVgKHLiRIQAYWoFpNVIou1qazyk2ULRAGYefVT02JipHHMA1a-X2BhBny1gM-8pip0RlLTj4BqZv51BjoGLzug5w7dt2H9_186uTVy_G5Pt6PMdS6w7LirZHeagq5y4Zp3jpM9t31ziYp962QBeSKF1fUluhXaTvGRH8L28w-U7V6n.En8Grg.iWszBCCj-FdiJSHRHy_wm1HNMgA; Hm_lvt_9164911d8d66bd442232c026a0837945=1604154729; Hm_lpvt_9164911d8d66bd442232c026a0837945=1604154739'  --data-raw 'phone=15254883837&msg_type=verify'         

sleep 61s 



done




