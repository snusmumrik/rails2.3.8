<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
       "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
  <meta http-equiv="content-type" content="text/html;charset=UTF-8" />
  <title>Welcome: <%= controller.action_name %></title>
  <%= stylesheet_link_tag 'scaffold' %>
	<meta name="description" content="">
	<meta name="keywords" content="">
</head>
<body>

<ul>
	<li><%= link_to 'Signup', new_user_path %></li>
	<li><%= link_to 'Signin', new_session_path %></li>
</ul>

<p style="color: green"><%= flash[:notice] %></p>
<p style="color: red"><%= flash[:error] %></p>

<%= yield %>

</body>
</html>
