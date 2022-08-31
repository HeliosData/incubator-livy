prepare:
	# python 2.7
	pyenv global 2.7.18
	pip install setuptools --upgrade
	pip install flake8 flaky pytest requests-kerberos requests cloudpickle
	mvn clean install -B -V -e -Pspark-2.4.8 -Pthriftserver -DskipTests -DskipITs -Dmaven.javadoc.skip=true -Drat.skip=true
	mvn clean package -B -V -e -Pspark-2.4.8 -Pthriftserver -DskipTests -DskipITs -Dmaven.javadoc.skip=true -Drat.skip=true -Dgenerate-third-party

python_library:
	#sudo vi /usr/local/lib/livy/conf/livy-env.sh
	#sudo systemctl restart livy
	#cat /var/log/livy/livy-livy-server.out
	vi requirements.txt
	pandas-profiling==3.2.0
	pip install -t dependencies -r requirements.txt
	cd dependencies
	zip -r ../dependencies.zip .
	cp dependencies.zip /tmp
	# spark magic properties
	{"conf": {"spark.yarn.dist.pyFiles": "/tmp/dependencies.zip"}}
