$(PIP): $(PY)
	$@ install -U pip
$(PY):
	python3 -m venv .
