echo "go"
docker run -t sendgridjp/sendgridjp-example /bin/bash -l -c "/root/go/sendgridjp-go-example/bin/main"

echo "node.js"
docker run -t sendgridjp/sendgridjp-example /bin/bash -l -c "nodejs /root/nodejs/sendgridjp-nodejs-example/sendgrid-nodejs-example.js"

echo "php"
docker run -t sendgridjp/sendgridjp-example /bin/bash -l -c "php /root/php/sendgridjp-php-example/sendgrid-php-example.php"

echo "python"
docker run -t sendgridjp/sendgridjp-example /bin/bash -l -c "python3.2 /root/python/sendgridjp-python-example/sendgrid-python-example.py"

echo "ruby"
docker run -t sendgridjp/sendgridjp-example /bin/bash -l -c "ruby /root/ruby/sendgridjp-ruby-example/sendgridjp-ruby-example.rb"
