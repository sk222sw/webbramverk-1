
# admin
ad = User.create(:email => "admin@app.se", :password => "admin",
                 :password_confirmation => "admin", admin: true)

# regular users
u1 = User.create(:email => "so@nny.com", :password => "hej", 
                 :password_confirmation => "hej")
                 
u2 = User.create(:email => "hej@user.com", :password => "test", 
                 :password_confirmation => "test")

# user created apps
a1 = App.create(:name => "future app", :api_key => "89au4ps8") # CkaZGBvAKrKQ8tRgG3F6pQ
a2 = App.create(:name => "app", :api_key => "at489paet8")
a3 = App.create(:name => "web app", :api_key => "fdgi484848")

u1.apps << a1
u1.apps << a2

u2.apps << a3

# front-end users/creators
c1 = Creator.create(:email => "so@nny.com", :password => "hej", :name => "inget")

