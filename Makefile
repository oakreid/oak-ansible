collections:
	mkdir -p ./.ansible/
	poetry run ansible-galaxy collection install -r ./requirements.yaml -p ./.ansible

clean:
	rm -r ./.ansible/
