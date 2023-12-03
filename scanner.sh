#!/bin/bash

# Hoşgeldiniz mesajı
echo -e "\e[34m======Hoşgeldiniz======\e[0m"

# Menü seçenekleri
echo "1. Check My IP"
echo "2. Check My Mac"
echo "3. Proxy List"
echo "4. Scan My System"

# Kullanıcıdan seçim yapmasını iste
read -p "Lütfen bir seçenek numarası girin: " choice

# Seçime göre işlem yap
case $choice in
    1)
        # Check My IP
        my_ip=$(curl -s ifconfig.me)
        echo "IP Adresiniz: $my_ip"
        ;;
    2)
        # Check My Mac
        my_mac=$(ifconfig | awk '/ether/{print $2}')
        echo "MAC Adresiniz: $my_mac"
        ;;
    3)
        # Proxy List
        cat proxy.txt
        ;;
    4)
        # Scan My System
        echo -e "\e[36mScanning...\e[0m"
        
        # İp ve mac adresi
        my_ip=$(curl -s ifconfig.me)
        my_mac=$(ifconfig | awk '/ether/{print $2}')
        
        # Hız testi
        speed_test=$(speedtest-cli --simple | awk '/Ping:|Download:|Upload:/{print $2}')
        ping=$(echo "$speed_test" | awk 'NR==1{print}')
        download=$(echo "$speed_test" | awk 'NR==2{print}')
        upload=$(echo "$speed_test" | awk 'NR==3{print}')
        
        # Hız durumu (örnek değerler)
        speed_status=""
        if (( $(echo "$ping > 50" | bc -l) )); then
            speed_status="\e[31mYavaş\e[0m"
        else
            speed_status="\e[32mHızlı\e[0m"
        fi

        echo "Your IP: $my_ip"
        echo "Your MAC: $my_mac"
        echo -e "Ping: $ping ms, Download: $download Mbps, Upload: $upload Mbps (\e[36m$speed_status\e[0m)"
        
        # Firewall Durumu (örnek değer)
        firewall_status="On"
        echo "Firewall: $firewall_status"
        
        # Anti-Virus Durumu (örnek değer)
        antivirus_status="On"
        echo "Anti-Virus: $antivirus_status"
        
        echo -e "\e[36mScan completed\e[0m"
        ;;
    *)
        # Geçersiz seçenek
        echo "Geçersiz bir seçenek girdiniz."
        ;;
esac
