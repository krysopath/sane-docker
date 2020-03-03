run: release
	docker run --name insane_yoloist --rm sane:release &
	sleep 5
	docker exec insane_yoloist ps -o pid,pgid,comm,user
	sleep 5
	docker kill insane_yoloist


release:
	docker build --target $@ -t sane:$@ .
development:
	docker build --target $@ -t sane:$@ .
test:
	docker build --target $@ -t sane:$@ .

