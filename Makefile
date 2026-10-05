up:
	docker compose up --build 
db:
	docker exec -it event-sync-user-db-1  psql -U event-sync -d event-sync