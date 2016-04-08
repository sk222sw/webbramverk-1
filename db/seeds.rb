# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u1 = User.create(:email => "user@user.com", :password => "hej", 
                 :password_confirmation => "hej")
                 
u2 = User.create(:email => "hej@user.com", :password => "test", 
                 :password_confirmation => "test")
                 
a1 = App.create(:name => "future app", :api_key => "89au4ps8")
a2 = App.create(:name => "app", :api_key => "at489paet8")
a3 = App.create(:name => "web app", :api_key => "fdgi484848")

u1.apps << a1
u1.apps << a2

u2.apps << a3