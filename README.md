Установка

1. Скопировать скрипт bash
sudo cp monitor_test.sh /usr/local/bin/
sudo chmod +x /usr/local/bin/monitor_test.sh


3. Создать файл лога bash
sudo touch /var/log/monitoring.log
sudo chmod 644 /var/log/monitoring.log


3. Установить systemd unit'ы bash
sudo cp monitor-test.service /etc/systemd/system/
sudo cp monitor-test.timer /etc/systemd/system/


5. Перезагрузить systemd и запустить таймер

sudo systemctl daemon-reload
sudo systemctl enable monitor-test.timer
sudo systemctl start monitor-test.timer


Деинсталляция

sudo systemctl stop monitor-test.timer
sudo systemctl disable monitor-test.timer
sudo rm /etc/systemd/system/monitor-test.service
sudo rm /etc/systemd/system/monitor-test.timer
sudo rm /usr/local/bin/monitor_test.sh
sudo systemctl daemon-reload
