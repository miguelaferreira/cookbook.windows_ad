default!['win_domain']['FirstDCInForest'] = 'db-cms'
default!['win_domain']['DomainDNSName']   = 'test.local'
default!['win_domain']['DNS1']            = '192.168.55.16'
default!['win_domain']['DNS2']            = '8.8.8.8'

default!['sql_server']['instance_name']      = 'SQLEXPRESS'
default!['sql_server']['sql_pwd']            = "sa_#{node['sql_server']['instance_name']}"
default!['sql_server']['sysadmins']          = 'Administrators'
default!['sql_server']['agent_account']      = 'NT AUTHORITY\NETWORK SERVICE'
default!['sql_server']['sql_account']        = 'NT AUTHORITY\NETWORK SERVICE'
default!['sql_server']['agent_has_password'] = false
default!['sql_server']['sql_has_password']   = false
default!['sql_server']['domain']             = 'local'
default!['sql_server']['instance_dir']       = 'C:\Microsoft SQL Server Instance'
default!['sql_server']['version']            = '2012'
default!['sql_server']['feature_list']       = 'SQLENGINE,REPLICATION,SNAC_SDK'

default!['sitecore']['retain_tmp_dir'] = true 

default!['sitecore']['database']['data_dir'] = 'C:\MSSQL\DATA' 
default!['sitecore']['database']['log_dir']  = 'C:\MSSQL\LOG' 

default!['sitecore']['database']['skip_license'] = true 

default!['sitecore']['databases']['core']['adgroup_name']        = 'SQL_GROUP'
default!['sitecore']['databases']['core']['adgroup_domain']      = 'TEST.local'
default!['sitecore']['databases']['core']['adgroup_path']        = 'AD/Groups'
default!['sitecore']['databases']['master']['adgroup_name']      = 'SQL_GROUP'
default!['sitecore']['databases']['master']['adgroup_domain']    = 'TEST.local'
default!['sitecore']['databases']['master']['adgroup_path']      = 'AD/Groups'
default!['sitecore']['databases']['web']['adgroup_name']         = 'SQL_GROUP'
default!['sitecore']['databases']['web']['adgroup_domain']       = 'TEST.local'
default!['sitecore']['databases']['web']['adgroup_path']         = 'AD/Groups'
default!['sitecore']['databases']['analytics']['adgroup_name']   = 'SQL_GROUP'
default!['sitecore']['databases']['analytics']['adgroup_domain'] = 'TEST.local'
default!['sitecore']['databases']['analytics']['adgroup_path']   = 'AD/Groups'

default!['sitecore']['sql_membership_provider']['min_required_password_length']  = 0
default!['sitecore']['sql_membership_provider']['requires_unique_email']         = 0
default!['sitecore']['sql_membership_provider']['max_invalid_password_attempts'] = 0

default!['sitecore']['skip_active_directory'] = false

default!['sitecore']['dirs']['data'] = 'C:\AppData'
default!['sitecore']['dirs']['log']  = 'C:\AppLog'
default!['sitecore']['dirs']['site'] = 'C:\AppSites'

default!['sitecore']['country']['__']['site']['CMS']['svc_username'] = 'SITECORE_ACCOUNT'
default!['sitecore']['country']['__']['site']['CMS']['svc_domain']   = 'TEST.local'

default!['sitecore']['country']['__']['site']['CMS']['core']['dbserver']          = %w( 192.168.55.16 )
default!['sitecore']['country']['__']['site']['CMS']['master']['dbserver']        = %w( 192.168.55.16 )
default!['sitecore']['country']['__']['site']['CMS']['web']['dbserver']           = %w( 192.168.55.16 )
default!['sitecore']['country']['__']['site']['CMS']['analytics']['dbserver']     = %w( 192.168.55.16 )

default!['sitecore']['CDS']['countries'] = [ 'dummy' ]

default!['sitecore']['country']['dummy']['site']['dummy.com']['svc_username'] = 'SITECORE_ACCOUNT'
default!['sitecore']['country']['dummy']['site']['dummy.com']['svc_domain']   = 'TEST.local'

default!['sitecore']['country']['dummy']['site']['dummy.com']['core']['dbserver']           = %w( 192.168.55.17 )
default!['sitecore']['country']['dummy']['site']['dummy.com']['core']['dbname']             = 'Sitecore_Core'

default!['sitecore']['country']['dummy']['site']['dummy.com']['analytics']['dbserver']      = %w( 192.168.55.16 )
default!['sitecore']['country']['dummy']['site']['dummy.com']['analytics']['dbname']        = 'Sitecore_Analytics'

default!['sitecore']['country']['dummy']['site']['dummy.com']['web']['dbserver']            = %w( 192.168.55.17 )
default!['sitecore']['country']['dummy']['site']['dummy.com']['web']['dbname']              = 'Sitecore_Web'
