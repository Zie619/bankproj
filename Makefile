postgres:	
	docker run --name postgres17 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=eliadad -d postgres:17-alpine
createdb:	
	docker exec -it postgres17 createdb --username=root --owner=root simple_bank

dropdb:	
	docker exec -it postgres17 dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:eliadad@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:eliadad@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...
.PHONY:	createdb	dropdb	postgres migrateup migratedown sqlc test