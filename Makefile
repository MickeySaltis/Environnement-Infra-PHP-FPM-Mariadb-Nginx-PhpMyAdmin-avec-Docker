dump:
	docker-compose exec mariadb sh -c "mysqldump -h mariadb -u user -pmickey --databases database" > app/sql/dump.sql

import:
	docker-compose exec -T mariadb sh -c "mysql -h mariadb -u user -pmickey" < app/sql/dump.sql
	
start:
	gnome-terminal -- bash -c "docker-compose up; bash"
	sleep 15s
	docker-compose exec -T mariadb sh -c "mysql -h mariadb -u user -pmickey" < app/sql/dump.sql
	
stop:
	docker-compose exec mariadb sh -c "mysqldump -h mariadb -u user -pmickey --databases database" > app/sql/dump.sql
	docker stop $$(docker ps -a -q)
	docker rm $$(docker ps -a -q)