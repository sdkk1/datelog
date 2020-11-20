# EC2サーバーのIP、EC2サーバーにログインするユーザー名、サーバーのロールを記述
server '52.197.170.143', user: 'keita', roles: %w{app db web}

set :ssh_options, auth_methods: ['publickey'],
                  keys: ["~/.ssh/date-match_rsa_896e209e6814d2072828f510fa6a0097"],
                  forward_agent: true
