#!/bin/bash
memorychecker(){
        owned_ip_address=($(/usr/sbin/iptables -L INPUT -v | egrep -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'| sort | uniq ))
}
dump_spam_users(){
        dump_spams=($(grep "SASL LOGIN authentication failed" /var/log/mail.log | egrep -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'| sort | uniq ))

}
memorychecker
dump_spam_users
