class ProcessLovePage
  def initialize(user, love_page_id, invitation_id, cookies)
    @user = user
    @love_page_id = love_page_id
    @invitation_id = invitation_id
    @cookies = cookies
  end

  def call
    if @user
      JoinPage.new(@user, @love_page_id).call
      Invitations::Remove.new(@invitation_id, @cookies).call
    else
      @cookies["invitation_id"] = @invitation_id
    end
  end
end
