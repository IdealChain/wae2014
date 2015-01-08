<div class="register">
  <h1 class="page_title">Register a new user</h1>

  <form action="user/register">
    <div class="form_field">
      <label for="username">Username:</label>
      <input name="username" type="text" value="<% $.username %>"/>
	</div>
	<div class="form_field">
      <label for="password">Password:</label>
      <input name="password" type="password" value="<% $.password %>"/>
    </div>
	<div class="form_field">
      <label for="email">Email Address:</label>
      <input name="email" type="text" value="<% $.email %>"/>
	</div>
    <input name="register" type="submit" value="Register"/>
  </form>
</div>

<%class>
  has 'username';
  has 'password';
  has 'email';
</%class>
