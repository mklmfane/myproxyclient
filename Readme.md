<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=windows-1252">
<meta name=Generator content="Microsoft Word 15 (filtered)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"Arial Black";
	panose-1:2 11 10 4 2 1 2 2 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin-top:0in;
	margin-right:0in;
	margin-bottom:8.0pt;
	margin-left:0in;
	line-height:107%;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{font-family:"Calibri",sans-serif;}
.MsoPapDefault
	{margin-bottom:8.0pt;
	line-height:107%;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
-->
</style>

</head>

<body lang=EN-US>

<div class=WordSection1>

<p class=MsoNormal><b><u><span style='font-family:"Arial Black",sans-serif;
color:#0070C0'>#Ensure nginx is installed</span></u></b></p>

<p class=MsoNormal>node puppetclient {</p>

<p class=MsoNormal>  package{&quot;epel-release&quot;:</p>

<p class=MsoNormal>     ensure =&gt; Installed&quot;,</p>

<p class=MsoNormal>  }</p>

<p class=MsoNormal>  package {&quot;nginx&quot;:</p>

<p class=MsoNormal>     ensure =&gt; &quot;installed&quot;,</p>

<p class=MsoNormal>  }</p>

<p class=MsoNormal>  file
{lookup(&quot;['/usr/share/','usr/share/www','usr/share/www/html']&quot;):</p>

<p class=MsoNormal>     ensure =&gt; &quot;directory&quot;,</p>

<p class=MsoNormal>}</p>

<p class=MsoNormal>&nbsp;</p>

<p class=MsoNormal>file {&quot;/etc/nginx/nginx.conf&quot;:</p>

<p class=MsoNormal>     content =&gt;
epp(&quot;/etc/puppetlabs/code/environments/production/templates/nginx.conf.epp&quot;)</p>

<p class=MsoNormal>}</p>

<p class=MsoNormal>}</p>

<p class=MsoNormal>&nbsp;</p>

<p class=MsoNormal><b><u>#Create a proxy to redirect requests for
https://domain.com to 10.10.10.10 and redirect requests for #https://domain.com/resource2
to 20.20.20.20.</u></b></p>

<p class=MsoNormal>node /puppetclient/ {</p>

<p class=MsoNormal>  class {</p>

<p class=MsoNormal>    'nginx':;</p>

<p class=MsoNormal>  }</p>

<p class=MsoNormal>&nbsp;</p>

<p class=MsoNormal>  Nginx::Proxy {</p>

<p class=MsoNormal>    ensure =&gt; present,</p>

<p class=MsoNormal>    enable =&gt; true,</p>

<p class=MsoNormal>  }</p>

<p class=MsoNormal>&nbsp;</p>

<p class=MsoNormal>  nginx::proxy {</p>

<p class=MsoNormal>    'domain.com': server_name =&gt; 'domain.com', proxy_pass
=&gt; 'https://10.10.10.10';</p>

<p class=MsoNormal>    'domain.com': server_name =&gt; 'domain.com/resource2',
proxy_pass =&gt; 'https://20.20.20.20';</p>

<p class=MsoNormal>  }</p>

<p class=MsoNormal>&nbsp;</p>

<p class=MsoNormal>  nginx::resource::server { 'www.domain.com':</p>

<p class=MsoNormal>    listen_port =&gt; 80,</p>

<p class=MsoNormal>    ssl =&gt; false,</p>

<p class=MsoNormal>    proxy       =&gt; 'https://domain.com',</p>

<p class=MsoNormal>}</p>

<p class=MsoNormal>&nbsp;</p>

<p class=MsoNormal>nginx::resource::server { 'https://domain.com':</p>

<p class=MsoNormal>  listen_port =&gt; 443,</p>

<p class=MsoNormal>  ssl =&gt; true,</p>

<p class=MsoNormal>  ssl_cert  =&gt; '/etc/puppetlabs/puppet/ssl/public_keys',</p>

<p class=MsoNormal>  ssl_key =&gt; '/etc/puppetlabs/puppet/ssl/private_keys',</p>

<p class=MsoNormal>}</p>

<p class=MsoNormal>&nbsp;</p>

<p class=MsoNormal>nginx::resource::location  {'https://domain.com':</p>

<p class=MsoNormal>    ssl_redirect =&gt; '10.10.10.10',</p>

<p class=MsoNormal>  }</p>

<p class=MsoNormal>&nbsp;</p>

<p class=MsoNormal><b><span style='font-size:16.0pt;line-height:107%'>&nbsp;</span></b></p>

<p class=MsoNormal><b><span style='font-size:16.0pt;line-height:107%;
color:#0070C0'>#Redirect requests for https://domain.com/resource2 to
20.20.20.20</span></b></p>

<p class=MsoNormal>&nbsp;</p>

<p class=MsoNormal>nginx::resource::upstream { 'https://domain.com':</p>

<p class=MsoNormal>    members =&gt; ['20.20.20.20',],</p>

<p class=MsoNormal>  }</p>

<p class=MsoNormal>&nbsp;</p>

<p class=MsoNormal>  nginx::resource::server{ 'https://domain.com':</p>

<p class=MsoNormal>    www_root =&gt; '/usr/share/www/html',</p>

<p class=MsoNormal>  }</p>

<p class=MsoNormal>&nbsp;</p>

<p class=MsoNormal>  nginx::resource::location{'/resource2':</p>

<p class=MsoNormal>    proxy =&gt; 'http://domain.com/' ,</p>

<p class=MsoNormal>    server =&gt; 'https://domain.com',</p>

<p class=MsoNormal>  }</p>

<p class=MsoNormal>}</p>

<p class=MsoNormal>&nbsp;</p>

<p class=MsoNormal><b><span style='font-size:18.0pt;line-height:107%;
color:#0070C0'>&nbsp;</span></b></p>

<p class=MsoNormal><b><span style='font-size:18.0pt;line-height:107%;
color:#0070C0'>#Create a forward proxy to log HTTP requests going from the
internal network to the Internet including: #request protocol, remote IP and
time take to serve the request.</span></b></p>

<p class=MsoNormal>node /puppetclient/ {</p>

<p class=MsoNormal>  class { 'nginx':</p>

<p class=MsoNormal>     proxy_cache           = true,</p>

<p class=MsoNormal>     proxy_cache_dir       = '/cache',</p>

<p class=MsoNormal>     proxy_cache_path      = '/cache/static levels=1:2
keys_zone=staticfilecache:60m inactive=90m max_size=500m',</p>

<p class=MsoNormal>     proxy_connect_timeout = '30',</p>

<p class=MsoNormal>     proxy_read_timeout    = '120',</p>

<p class=MsoNormal>     proxy_send_timeout    = '120',</p>

<p class=MsoNormal>     proxy_temp_path       = '/cache/tmp',</p>

<p class=MsoNormal>  }</p>

<p class=MsoNormal>}</p>

</div>

</body>

</html>
