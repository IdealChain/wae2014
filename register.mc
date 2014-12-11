<div class="register">

  <h1>Register a new user</h1>

  <form action="user/register">
    <label for="username">Username:</label>
    <input name="username" type="text" value="<% $.username %>"/>
    <label for="password">Password:</label>
    <input name="password" type="password" value="<% $.password %>"/>
    <label for="email">Email Address:</label>
    <input name="email" type="text" value="<% $.email %>"/>
    <input name="register" type="submit" value="Register"/>
  </form>
</div>

<%class>
  has 'username';
  has 'password';
  has 'email';
</%class>
