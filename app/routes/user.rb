module Routes
  class User < Authenticable
    include UserController

    get "/check_user" do
      success( { msg: "Yes, you have authorization"})
    end

    get "/profile" do
      resolve get_profile
    end

    get "/signout" do
      resolve signout
    end


  end

end
