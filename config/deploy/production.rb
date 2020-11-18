# EC2サーバーのIP、EC2サーバーにログインするユーザー名、サーバーのロールを記述
server '52.197.170.143', user: 'keita', roles: %w{app db web}

# CircleCIのGUIで設定した環境変数を使ってSSH接続
set :ssh_options, {
  keys: [ENV.fetch('PRODUCTION_SSH_KEY').to_s],
  forward_agent: true,
  auth_methods: %w[publickey]
}
