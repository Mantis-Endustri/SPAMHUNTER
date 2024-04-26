#!/bin/bash
memorychecker(){
        owned_ip_address=($(iptables -L INPUT -v | awk '{if ($0 ~ /[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/) {match($0, /[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/); print substr($0, RSTART, RLENGTH)}}'))
}
dump_spam_users(){
        dump_spams=($(grep "SASL LOGIN authentication failed" /var/log/mail.log | awk '{if ($0 ~ /[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/) {match($0, /[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/); print substr($0, RSTART, RLENGTH)}}'))
}
hunter(){
memorychecker
dump_spam_users
for hunt in "${dump_spams[@]}"
do
        for listed in "${owned_ip_address[@]}"
        do
                if [[ "$hunt" == "$listed" ]];then
                        echo "önceki kayıt tespit edildi: $listed" >> /home/burak/shlogs/logs
                else
                        echo "yeni kayıt bulundu : $hunt" >> /home/burak/shlogs/logs
                        iptables -A INPUT -s $hunt -j DROP

                fi
        done
done
}
hunter
