windows_ad_domain 'test.local' do
  action :join
  domain_pass 'Passw=rd1234###!'
  domain_user 'Administrator'
end
