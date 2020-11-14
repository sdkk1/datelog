# EC2サーバーのIP、EC2サーバーにログインするユーザー名、サーバーのロールを記述
server ' 52.197.170.143', user: 'keita', roles: %w{app db web}

#デプロイするサーバーにsshログインする鍵の情報を記述
set :ssh_options, keys: '~/.ssh/date-match_key_rsa'
