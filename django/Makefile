PY   = ../bin/python3
M    = $(PY) ./manage.py
APP ?=

.PHONY: runserver
runserver:
	$(M) $@

.PHONY: run
run: makemigrations migrate

.PHONY: makemigrations
makemigrations:
	$(M) $@ $(APP)

.PHONY: migrate
migrate:
	$(M) $@

.PHONY: createsuperuser
createsuperuser:
	$(M) $@

.PHONY: dbbackup
dbbackup:
	$(M) $@

DD = $(M) $@ --format json --indent 4
.PHONY: dumpdata
dumpdata:
	$(DD) auth.user    > backup/auth.user.json
	$(DD) auth.group   > backup/auth.group.json
#
	$(DD) task.project > backup/task.project.json
	$(DD) task.task    > backup/task.task.json
	$(DD) task.beacon  > backup/task.beacon.json
